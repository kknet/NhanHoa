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
    UIImagePickerController *imagePickerController;
    int type;
    float padding;
    float hLabel;
}
@end

@implementation UpdatePassportViewController
@synthesize btnCMND_a,imgWaitCMND_a, lbCMND_a, btnCMND_b, imgWaitCMND_b, lbCMND_b;
@synthesize linkCMND_a, linkCMND_b, cusId, curCMND_a, curCMND_b, linkBanKhai, curBanKhai, domain, domainId, domainType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_update_passport;
    [self setupUIForView];
    [self addRightBarButtonForNavigationBar];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"UpdatePassportViewController"];
    
    lbCMND_a.text = text_front;
    lbCMND_b.text = text_backside;
    
    [self showCurrentPassportForDomain];
    [self orientationChanged];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([self isMovingFromParentViewController])
    {
        imagePickerController = nil;
        [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
        [AppDelegate sharedInstance].profileEdit = nil;
        [AppDelegate sharedInstance].editCMND_a = nil;
        [AppDelegate sharedInstance].editCMND_b = nil;
    }else {
        NSLog(@"New view controller was pushed");
    }
}

- (void)addRightBarButtonForNavigationBar {
    float hView = 45.0;
    if (!IS_IPHONE && !IS_IPOD) {
        hView = 50.0;
    }
    
    UIView *viewSave = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hView, hView)];
    viewSave.backgroundColor = UIColor.clearColor;
    
    UIButton *btnSave =  [UIButton buttonWithType:UIButtonTypeCustom];
    btnSave.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btnSave.frame = CGRectMake(15, 0, hView, hView);
    btnSave.backgroundColor = UIColor.clearColor;
    [btnSave setImage:[UIImage imageNamed:@"tick_white"] forState:UIControlStateNormal];
    [btnSave addTarget:self action:@selector(saveInfo) forControlEvents:UIControlEventTouchUpInside];
    [viewSave addSubview: btnSave];
    
    UIBarButtonItem *btnSaveBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: viewSave];
    self.navigationItem.rightBarButtonItem =  btnSaveBarButtonItem;
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 35.0; // or whatever you want
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.navigationItem.rightBarButtonItems = @[fixedItem, flexibleItem, btnSaveBarButtonItem];
}

- (void)saveInfo {
    if ([AppDelegate sharedInstance].editCMND_a == nil && [AppDelegate sharedInstance].editCMND_b == nil && [AppDelegate sharedInstance].editBanKhai == nil) {
        [self.view makeToast:pls_choose_photo_to_update duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cusId]) {
        [self.view makeToast:text_data_is_invalidate duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_updating Interaction:NO];
    
    [self uploadPassportFrontPicture];
}

- (void)showCurrentPassportForDomain {
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [btnCMND_a setImage:[AppDelegate sharedInstance].editCMND_a forState:UIControlStateNormal];
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
    
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [btnCMND_b setImage:[AppDelegate sharedInstance].editCMND_b forState:UIControlStateNormal];
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
    
    if ([AppDelegate sharedInstance].editCMND_a == nil) {
        [self showActionSheetChooseWithRemove: FALSE withSender: sender];
    }else{
        [self showActionSheetChooseWithRemove: TRUE withSender: sender];
    }
}

- (IBAction)btnCMND_b_Press:(UIButton *)sender {
    type = 2;
    
    if ([AppDelegate sharedInstance].editCMND_b == nil) {
        [self showActionSheetChooseWithRemove: FALSE withSender: sender];
    }else{
        [self showActionSheetChooseWithRemove: TRUE withSender: sender];
    }
}

- (IBAction)btnBanKhaiPress:(UIButton *)sender {
    type = 3;
    
    if ([AppDelegate sharedInstance].editBanKhai == nil) {
        [self showActionSheetChooseWithRemove: FALSE withSender: sender];
    }else{
        [self showActionSheetChooseWithRemove: TRUE withSender: sender];
    }
}

- (void)uploadPassportFrontPicture {
    if ([AppDelegate sharedInstance].editCMND_a != nil)
    {
        //  resize image to reduce quality
        [AppDelegate sharedInstance].editCMND_a = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_a];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_a);
        if (uploadData == nil) {
            [WriteLogsUtils writeLogContent:SFM(@"[%s] ERROR: >>>>>>>>>> Can not get data from CMND_a image, continue get data for CMND_b", __FUNCTION__)];
            
            [self uploadPassportBehindPicture];
        }else{
            NSString *imageName = [NSString stringWithFormat:@"%@_front_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                UploadPicture *session = [[UploadPicture alloc] init];
                [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                            [WriteLogsUtils writeLogContent:SFM(@"[%s] CMND_a was not uploaded successful", __FUNCTION__)];
                            linkCMND_a = @"";
                            
                        }else{
                            [WriteLogsUtils writeLogContent:SFM(@"[%s] CMND_a was uploaded successful", __FUNCTION__)];
                            linkCMND_a = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                        }
                        
                        [self uploadPassportBehindPicture];
                    });
                }];
            });
        }
    }else{
        self.linkCMND_a = curCMND_a;
        [self uploadPassportBehindPicture];
    }
}

- (void)uploadPassportBehindPicture {
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [AppDelegate sharedInstance].editCMND_b = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_b];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_b);
        
        NSString *imageName = [NSString stringWithFormat:@"%@_behind_%@.PNG", [AccountModel getCusIdOfUser], [AppUtils getCurrentDateTime]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] CMND_b was not uploaded successful", __FUNCTION__)];
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if ([AppUtils isNullOrEmpty: linkCMND_a] && [AppUtils isNullOrEmpty: linkCMND_b] && [AppUtils isNullOrEmpty: linkBanKhai]) {
        [self.view makeToast:failed_to_upload_passport_photo duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
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
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:TRUE completion:nil];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_capture style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self requestToAccessYourCamera];
                                    }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_gallery style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self onSelectPhotosGallery];
                                    }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_remove style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
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
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [self dismissViewControllerAnimated:TRUE completion:nil];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_capture style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                    {
                                        [self requestToAccessYourCamera];
                                    }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:text_gallery style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
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

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    padding = 15.0;
    hLabel = 25.0;
    btnCMND_a.imageEdgeInsets = btnCMND_b.imageEdgeInsets = UIEdgeInsetsMake(7.5, 20, 7.5, 20);
    btnCMND_a.imageView.contentMode = btnCMND_b.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (!IS_IPHONE && !IS_IPOD) {
        btnCMND_a.imageEdgeInsets = btnCMND_b.imageEdgeInsets = UIEdgeInsetsMake(45, 120, 45, 120);
        hLabel = 50.0;
    }
    
    float hBTN = (SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + 2*padding + 2*hLabel))/2;
    
    imgWaitCMND_a.backgroundColor = imgWaitCMND_b.backgroundColor = UIColor.whiteColor;
    imgWaitCMND_a.alpha = imgWaitCMND_b.alpha = 0.5;
    imgWaitCMND_a.hidden = imgWaitCMND_b.hidden = TRUE;
    
    //  CMND_a
    btnCMND_a.layer.borderWidth = btnCMND_b.layer.borderWidth = 1.0;
    btnCMND_a.layer.borderColor = btnCMND_b.layer.borderColor = BORDER_COLOR.CGColor;
    
    [btnCMND_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(padding);
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

    lbCMND_a.font = lbCMND_b.font = [AppDelegate sharedInstance].fontRegular;
    lbCMND_a.textColor = lbCMND_b.textColor = TITLE_COLOR;
}

- (void)requestToAccessYourCamera {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
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
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: TRUE];
    
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
        [AppDelegate sharedInstance].editCMND_a = nil;
        if (![AppUtils isNullOrEmpty: curCMND_a]) {
            [btnCMND_a sd_setImageWithURL:[NSURL URLWithString:curCMND_a] forState:UIControlStateNormal placeholderImage:FRONT_EMPTY_IMG];
        }else{
            [btnCMND_a setImage:FRONT_EMPTY_IMG forState:UIControlStateNormal];
        }
    }else if (type == 2){
        [AppDelegate sharedInstance].editCMND_b = nil;
        if (![AppUtils isNullOrEmpty: curCMND_b]) {
            [btnCMND_b sd_setImageWithURL:[NSURL URLWithString:curCMND_b] forState:UIControlStateNormal placeholderImage:BEHIND_EMPTY_IMG];
        }else{
            [btnCMND_b setImage:BEHIND_EMPTY_IMG forState:UIControlStateNormal];
        }
    }
}

- (void)popupToPreviousView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [AppDelegate sharedInstance].editCMND_a = [AppDelegate sharedInstance].editCMND_b = nil;
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    
    float heightScreen = [DeviceUtils getHeightOfScreen];
    if ([DeviceUtils isLandscapeMode]) {
        float hBTN = heightScreen - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + padding + hLabel);
        
        [btnCMND_a mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(padding);
            make.left.equalTo(self.view).offset(2*padding);
            make.right.equalTo(self.view.mas_centerX).offset(-padding);
            make.height.mas_equalTo(hBTN);
        }];
        
        [btnCMND_b mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(btnCMND_a);
            make.left.equalTo(btnCMND_a.mas_right).offset(2*padding);
            make.right.equalTo(self.view).offset(-padding);
        }];
    }else{
        float hBTN = (heightScreen - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + 2*padding + 2*hLabel))/2;
        
        [btnCMND_a mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(padding);
            make.left.equalTo(self.view).offset(2*padding);
            make.right.equalTo(self.view).offset(-2*padding);
            make.height.mas_equalTo(hBTN);
        }];
        
        [btnCMND_b mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbCMND_a.mas_bottom).offset(padding);
            make.left.right.equalTo(btnCMND_a);
            make.height.mas_equalTo(hBTN);
        }];
    }
}

#pragma mark - UIImagePickerViewDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (type == 1) {
        NSData *pngData = UIImagePNGRepresentation(image);
        [AppDelegate sharedInstance].editCMND_a = [UIImage imageWithData:pngData];
        
        [btnCMND_a setImage:[AppDelegate sharedInstance].editCMND_a forState:UIControlStateNormal];
        
    }else if (type == 2){
        NSData *pngData = UIImagePNGRepresentation(image);
        [AppDelegate sharedInstance].editCMND_b = [UIImage imageWithData:pngData];
        [btnCMND_b setImage:[AppDelegate sharedInstance].editCMND_b forState:UIControlStateNormal];
        
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Webservice Delegate
-(void)failedUpdatePassportForDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)updatePassportForDomainSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"CMND đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(popupToPreviousView) withObject:nil afterDelay:2.0];
}

@end
