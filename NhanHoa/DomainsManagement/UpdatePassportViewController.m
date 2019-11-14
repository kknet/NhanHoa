//
//  UpdatePassportViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdatePassportViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>
#import "AccountModel.h"
#import "UploadPicture.h"

@interface UpdatePassportViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, WebServiceUtilsDelegate>
{
    AppDelegate *appDelegate;
    UIImagePickerController *imagePickerController;
    int type;
    float padding;
    float hLabel;
}
@end

@implementation UpdatePassportViewController
@synthesize viewHeader, icBack, lbHeader, icSave;
@synthesize btnCMND_a,imgWaitCMND_a, lbCMND_a, btnCMND_b, imgWaitCMND_b, lbCMND_b;
@synthesize linkCMND_a, linkCMND_b, cusId, curCMND_a, curCMND_b, linkBanKhai, curBanKhai, domain, domainId, domainType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Update passport"];
    lbCMND_a.text = [appDelegate.localization localizedStringForKey:@"Front"];
    lbCMND_b.text = [appDelegate.localization localizedStringForKey:@"Backside"];
    
    [self showCurrentPassportForDomain];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([self isMovingFromParentViewController])
    {
        imagePickerController = nil;
        [appDelegate enableSizeForBarButtonItem: FALSE];
        appDelegate.profileEdit = nil;
        appDelegate.editCMND_a = nil;
        appDelegate.editCMND_b = nil;
    }else {
        NSLog(@"New view controller was pushed");
    }
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icSaveClick:(UIButton *)sender {
    if (appDelegate.editCMND_a == nil && appDelegate.editCMND_b == nil) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Please choose photos to update"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cusId]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"The data is invalidate"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Updating..."] Interaction:NO];
    
    [self uploadPassportFrontPicture];
}

- (void)showCurrentPassportForDomain {
    if (appDelegate.editCMND_a != nil) {
        [btnCMND_a setImage:appDelegate.editCMND_a forState:UIControlStateNormal];
    }else{
        if (![AppUtils isNullOrEmpty: curCMND_a])
        {
            imgWaitCMND_a.hidden = FALSE;
            [imgWaitCMND_a startAnimating];
            
            [btnCMND_a sd_setImageWithURL:[NSURL URLWithString:curCMND_a] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
            {
                if (image == nil) {
                    [btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
                }
                imgWaitCMND_a.hidden = TRUE;
                [imgWaitCMND_a stopAnimating];
            }];
        }else{
            [btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
    
    if (appDelegate.editCMND_b != nil) {
        [btnCMND_b setImage:appDelegate.editCMND_b forState:UIControlStateNormal];
    }else{
        if (![AppUtils isNullOrEmpty: curCMND_b]) {
            imgWaitCMND_b.hidden = FALSE;
            [imgWaitCMND_b startAnimating];
            
            [btnCMND_b sd_setImageWithURL:[NSURL URLWithString:curCMND_b] forState:UIControlStateNormal completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL)
             {
                 if (image == nil) {
                     [btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
                 }
                 imgWaitCMND_b.hidden = TRUE;
                 [imgWaitCMND_b stopAnimating];
             }];
        }else{
            [btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
}

- (IBAction)btnCMND_a_Press:(UIButton *)sender {
    type = 1;
    
    if (appDelegate.editCMND_a == nil) {
        [self showActionSheetChooseWithRemove: FALSE withSender: sender];
    }else{
        [self showActionSheetChooseWithRemove: TRUE withSender: sender];
    }
}

- (IBAction)btnCMND_b_Press:(UIButton *)sender {
    type = 2;
    
    if (appDelegate.editCMND_b == nil) {
        [self showActionSheetChooseWithRemove: FALSE withSender: sender];
    }else{
        [self showActionSheetChooseWithRemove: TRUE withSender: sender];
    }
}

- (void)uploadPassportFrontPicture {
    if (appDelegate.editCMND_a != nil)
    {
        //  resize image to reduce quality
        appDelegate.editCMND_a = [AppUtils resizeImage: appDelegate.editCMND_a];
        NSData *uploadData = UIImagePNGRepresentation(appDelegate.editCMND_a);
        if (uploadData == nil) {
            [self uploadPassportBehindPicture];
        }else{
            NSString *imageName = [NSString stringWithFormat:@"%@_front_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UploadPicture *session = [[UploadPicture alloc] init];
                [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                            linkCMND_a = @"";
                            
                        }else{
                            linkCMND_a = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                        }
                        
                        [self uploadPassportBehindPicture];
                    });
                }];
            });
        }
    }else{
        linkCMND_a = curCMND_a;
        [self uploadPassportBehindPicture];
    }
}

- (void)uploadPassportBehindPicture {
    if (appDelegate.editCMND_b != nil) {
        appDelegate.editCMND_b = [AppUtils resizeImage: appDelegate.editCMND_b];
        NSData *uploadData = UIImagePNGRepresentation(appDelegate.editCMND_b);
        
        NSString *imageName = [NSString stringWithFormat:@"%@_behind_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                        linkCMND_b = @"";
                        
                    }else{
                        linkCMND_b = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    [self updateCMNDPhotoForDomain];
                });
            }];
        });
    }else{
        self.linkCMND_b = curCMND_b;
        [self updateCMNDPhotoForDomain];
    }
}

- (void)updateCMNDPhotoForDomain {
    if ([AppUtils isNullOrEmpty: linkCMND_a] && [AppUtils isNullOrEmpty: linkCMND_b] && [AppUtils isNullOrEmpty: linkBanKhai]) {
        [self.view makeToast:failed_to_upload_passport_photo duration:3.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    if (linkCMND_a == nil) {
        linkCMND_a = @"";
    }
    if (linkCMND_b == nil) {
        linkCMND_b = @"";
    }
    if (linkBanKhai == nil) {
        linkBanKhai = @"";
    }
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateCMNDPhotoForDomainWithCMND_a:linkCMND_a CMND_b:linkCMND_b cusId:cusId domainName:domain domainType:domainType domainId:domainId banKhai:linkBanKhai];
}

- (void)showActionSheetChooseWithRemove: (BOOL)remove withSender: (UIButton *)sender {
    if (remove) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Close"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:TRUE completion:nil];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Capture new photo"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self requestToAccessYourCamera];
                                    }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Choose from gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self onSelectPhotosGallery];
                                    }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Remove"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self removeCurrentPhotos];
                                    }]];
            
            // Present action sheet.
            [actionSheet setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [actionSheet popoverPresentationController];
            popPresenter.sourceView = sender;
            popPresenter.sourceRect = sender.bounds;
            [self presentViewController:actionSheet animated:YES completion:nil];
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Close"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:TRUE completion:nil];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Capture new photo"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self requestToAccessYourCamera];
                                    }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Choose from gallery"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self onSelectPhotosGallery];
                                    }]];
            
            // Present action sheet.
            [actionSheet setModalPresentationStyle:UIModalPresentationPopover];
            
            UIPopoverPresentationController *popPresenter = [actionSheet popoverPresentationController];
            popPresenter.sourceView = sender;
            popPresenter.sourceRect = sender.bounds;
            [self presentViewController:actionSheet animated:YES completion:nil];
        });
    }
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    hLabel = 35.0;
    padding = 15.0;
    
    btnCMND_a.imageEdgeInsets = btnCMND_b.imageEdgeInsets = UIEdgeInsetsMake(7.5, 20, 7.5, 20);
    btnCMND_a.imageView.contentMode = btnCMND_b.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icSave.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        hLabel = 25.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icSave.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        hLabel = 30.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icSave.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hLabel = 35.0;
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+7.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    float hBTN = (SCREEN_HEIGHT - (hStatus + self.navigationController.navigationBar.frame.size.height + 2*padding + 2*hLabel + appDelegate.safeAreaBottomPadding))/2;
    
    imgWaitCMND_a.backgroundColor = imgWaitCMND_b.backgroundColor = UIColor.whiteColor;
    imgWaitCMND_a.alpha = imgWaitCMND_b.alpha = 0.5;
    imgWaitCMND_a.hidden = imgWaitCMND_b.hidden = TRUE;
    
    //  CMND_a
    btnCMND_a.layer.borderWidth = btnCMND_b.layer.borderWidth = 1.0;
    btnCMND_a.layer.borderColor = btnCMND_b.layer.borderColor = BORDER_COLOR.CGColor;
    
    [btnCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(2*padding);
        make.right.equalTo(self.view).offset(-2*padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [imgWaitCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(btnCMND_a);
    }];
    
    [lbCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnCMND_a.mas_bottom);
        make.left.right.equalTo(btnCMND_a);
        make.height.mas_equalTo(hLabel);
    }];

    //  CMND_b
    [btnCMND_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCMND_a.mas_bottom).offset(padding);
        make.left.right.equalTo(lbCMND_a);
        make.height.mas_equalTo(hBTN);
    }];

    [imgWaitCMND_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(btnCMND_b);
    }];

    [lbCMND_b mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnCMND_b.mas_bottom);
        make.left.right.equalTo(btnCMND_b);
        make.height.mas_equalTo(hLabel);
    }];

    lbCMND_a.font = lbCMND_b.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbCMND_a.textColor = lbCMND_b.textColor = TITLE_COLOR;
}

- (void)requestToAccessYourCamera {
    AVAuthorizationStatus cameraAuthStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    if (cameraAuthStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self goToCaptureImagePickerView];
                }else{
                    [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
                }
            });
        }];
    }else{
        if (cameraAuthStatus == AVAuthorizationStatusAuthorized) {
            [self goToCaptureImagePickerView];
        }else{
            if (cameraAuthStatus != AVAuthorizationStatusAuthorized && cameraAuthStatus != AVAuthorizationStatusNotDetermined) {
                [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
            }
        }
    }
}

- (void)goToCaptureImagePickerView {
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = NO;
    }
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)onSelectPhotosGallery {
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    if (photoAuthStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^() {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self goToGalleryPhotosView];
                }else{
                    [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
                }
            });
        }];
    }else{
        if (photoAuthStatus == PHAuthorizationStatusAuthorized) {
            [self goToGalleryPhotosView];
        }else{
            [self.view makeToast:not_access_camera duration:3.0 position:CSToastPositionCenter];
        }
    }
}

- (void)goToGalleryPhotosView {
    [appDelegate enableSizeForBarButtonItem: TRUE];
    
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = FALSE;
    }
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)removeCurrentPhotos {
    if (type == 1) {
        appDelegate.editCMND_a = nil;
        if (![AppUtils isNullOrEmpty: curCMND_a]) {
            [btnCMND_a sd_setImageWithURL:[NSURL URLWithString:curCMND_a] forState:UIControlStateNormal placeholderImage:FRONT_EMPTY_IMG];
        }else{
            [btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
        }
    }else if (type == 2){
        appDelegate.editCMND_b = nil;
        if (![AppUtils isNullOrEmpty: curCMND_b]) {
            [btnCMND_b sd_setImageWithURL:[NSURL URLWithString:curCMND_b] forState:UIControlStateNormal placeholderImage:BEHIND_EMPTY_IMG];
        }else{
            [btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
}

- (void)popupToPreviousView {
    appDelegate.editCMND_a = appDelegate.editCMND_b = nil;
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - UIImagePickerViewDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [appDelegate enableSizeForBarButtonItem: FALSE];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [appDelegate enableSizeForBarButtonItem: FALSE];
    
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (type == 1) {
        NSData *pngData = UIImagePNGRepresentation(image);
        appDelegate.editCMND_a = [UIImage imageWithData:pngData];
        
        [btnCMND_a setImage:appDelegate.editCMND_a forState:UIControlStateNormal];
        
    }else if (type == 2){
        NSData *pngData = UIImagePNGRepresentation(image);
        appDelegate.editCMND_b = [UIImage imageWithData:pngData];
        [btnCMND_b setImage:appDelegate.editCMND_b forState:UIControlStateNormal];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Webservice Delegate
-(void)failedUpdatePassportForDomainWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)updatePassportForDomainSuccessful {
    [ProgressHUD dismiss];
    [self.view makeToast:@"CMND đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(popupToPreviousView) withObject:nil afterDelay:2.0];
}

@end
