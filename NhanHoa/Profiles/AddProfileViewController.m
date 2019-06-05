//
//  AddProfileViewController.m
//  NhanHoa
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddProfileViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>

@interface AddProfileViewController ()<NewProfileViewDelegate, NewBusinessProfileViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    int type;
    
    UIImage *imgFront;
    UIImage *imgBehind;
    UIImagePickerController *imagePickerController;
}
@end

@implementation AddProfileViewController
@synthesize personalProfile, businessProfile;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen: @"AddProfileViewController"];
    
    self.title = @"Tạo hồ sơ";
    type = 1;
    
    [self addPersonalProfileIfNeed];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    if ([self isMovingFromParentViewController])
    {
        imagePickerController = nil;
        [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    }
    else
    {
        NSLog(@"New view controller was pushed");
    }
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [personalProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
    
    [businessProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [personalProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [businessProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)addPersonalProfileIfNeed {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (personalProfile == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewProfileView class]]) {
                personalProfile = (NewProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: personalProfile];
    }
    [personalProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    personalProfile.delegate = self;
    [personalProfile setupForAddProfileUIForAddNew:TRUE isUpdate:FALSE];
    [personalProfile setupViewForAddNewProfileView];
}

- (void)addBusinessProfileIfNeed {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (businessProfile == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewBusinessProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewBusinessProfileView class]]) {
                businessProfile = (NewBusinessProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: businessProfile];
    }
    [businessProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    businessProfile.delegate = self;
    [businessProfile setupUIForViewForAddProfile:TRUE update:FALSE];
}

#pragma NewProfileView delegate & buniness
- (void)onSelectBusinessProfile {
    if (businessProfile == nil) {
        [self addBusinessProfileIfNeed];
    }
    personalProfile.hidden = TRUE;
    businessProfile.hidden = FALSE;
}

- (void)profileWasCreated {
    [AppDelegate sharedInstance].needReloadListProfile = TRUE;
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)onCancelButtonClicked {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)onPassportBehindPress {
    type = 2;
    
    if (imgBehind == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
       [self showActionSheetChooseWithRemove: TRUE];
    }
}

- (void)onPassportFrontPress {
    type = 1;
    
    if (imgFront == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

-(void)onBusinessPassportBehindPress {
    type = 2;
    
    if (imgBehind == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

-(void)onBusinessPassportFrontPress {
    type = 1;
    
    if (imgFront == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

- (void)businessProfileWasCreated {
    [AppDelegate sharedInstance].needReloadListProfile = TRUE;
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)showActionSheetChooseWithRemove: (BOOL)remove {
    if (remove) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:text_close destructiveButtonTitle:nil otherButtonTitles:text_capture, text_gallery, text_remove, nil];
        actionSheet.tag = 2;
        [actionSheet showInView: self.view];
        
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:text_close destructiveButtonTitle:nil otherButtonTitles:text_capture, text_gallery, nil];
        actionSheet.tag = 1;
        [actionSheet showInView: self.view];
    }
}


#pragma mark - BusinessProfileDelegate
-(void)onSelectPersonalProfile {
    if (personalProfile == nil) {
        [self addPersonalProfileIfNeed];
    }
    personalProfile.hidden = FALSE;
    businessProfile.hidden = TRUE;
}

#pragma mark - ActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1)
    {
        if (buttonIndex == 0) {
            [self requestToAccessYourCamera];
            
        }else if (buttonIndex == 1){
            [self onSelectPhotosGallery];
        }
        
    }else if (actionSheet.tag == 2){
        if (buttonIndex == 0) {
            [self requestToAccessYourCamera];
            
        }else if (buttonIndex == 1){
            [self onSelectPhotosGallery];
            
        }else if (buttonIndex == 2) {
            [self removeCurrentPhotos];
        }
    }
}

- (void)removeCurrentPhotos {
    if (personalProfile != nil && !personalProfile.hidden) {
        if (type == 1) {
            imgFront = nil;
            [personalProfile removePassportFrontPhoto];
        }else{
            imgBehind = nil;
            [personalProfile removePassportBehindPhoto];
        }
    }else{
        if (type == 1) {
            imgFront = nil;
            [businessProfile removePassportFrontPhoto];
        }else{
            imgBehind = nil;
            [businessProfile removePassportBehindPhoto];
        }
    }
}

- (void)requestToAccessYourCamera {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
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

#pragma mark - UIImagePickerViewDelegate
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    if (personalProfile != nil && !personalProfile.hidden) {
        if (type == 1) {
            NSData *pngData = UIImagePNGRepresentation(image);
            imgFront = [UIImage imageWithData:pngData];
            
            //  imgFront = image;
            personalProfile.imgFront = imgFront;
            personalProfile.imgPassportFront.image = imgFront;
        }else{
            NSData *pngData = UIImagePNGRepresentation(image);
            imgBehind = [UIImage imageWithData:pngData];
            
            personalProfile.imgBehind = imgBehind;
            personalProfile.imgPassportBehind.image = imgBehind;
        }
    }else{
        if (type == 1) {
            NSData *pngData = UIImagePNGRepresentation(image);
            imgFront = [UIImage imageWithData:pngData];
            
            businessProfile.imgFront = imgFront;
            businessProfile.imgPassportFront.image = imgFront;
        }else{
            NSData *pngData = UIImagePNGRepresentation(image);
            imgBehind = [UIImage imageWithData:pngData];
            
            businessProfile.imgBehind = imgBehind;
            businessProfile.imgPassportBehind.image = imgBehind;
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
