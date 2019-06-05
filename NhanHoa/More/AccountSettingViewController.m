//
//  AccountSettingViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "UpdateMyInfoViewController.h"
#import "ChangePasswordViewController.h"
#import "PECropViewController.h"
#import "AccountModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>
#import "UploadPicture.h"
#import "WebServices.h"

@interface AccountSettingViewController ()<UIActionSheetDelegate, PECropViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, WebServicesDelegate> {
    PECropViewController *PECropController;
    UIImagePickerController *imagePickerController;
    WebServices *webService;
}
@end

@implementation AccountSettingViewController

@synthesize btnAvatar, btnChoosePhoto, viewInfo, lbInfo, lbName, lbNameValue, lbID, lbIDValue, lbEmail, lbEmailValue, viewPassword, lbPasswordInfo, lbPassword, btnChangePassword, lbPasswordValue, btnUpdateInfo, avatarUploadURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"AccountSettingViewController"];
    
    self.title = @"Cài đặt tài khoản";
    [self displayInformationForAccount];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    if (self.isMovingFromParentViewController) {
        webService = nil;
        imagePickerController = nil;
        [AppDelegate sharedInstance].cropAvatar = nil;
        [AppDelegate sharedInstance].dataCrop = nil;
    }
}

- (void)displayInformationForAccount {
    lbNameValue.text = [AccountModel getCusRealName];
    lbIDValue.text = [AccountModel getCusIdOfUser];
    lbEmailValue.text = [AccountModel getCusEmail];
    
    //  Show avatar if updating
    if ([AppDelegate sharedInstance].dataCrop != nil) {
        [self startUpdateAvatarForUser];
        
    }else{
        NSString *avatarURL = [AccountModel getCusPhoto];
        if (![AppUtils isNullOrEmpty: avatarURL]) {
            [btnAvatar sd_setImageWithURL:[NSURL URLWithString:avatarURL] forState:UIControlStateNormal placeholderImage:DEFAULT_AVATAR];
        }else{
            [btnAvatar setImage:DEFAULT_AVATAR forState:UIControlStateNormal];
        }
    }
}

- (void)startUpdateAvatarForUser {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSString *imageName = [NSString stringWithFormat:@"avatar_%@.png", [AccountModel getCusIdOfUser]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UploadPicture *session = [[UploadPicture alloc] init];
        [session uploadData:[AppDelegate sharedInstance].dataCrop withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                {
                    [self.view makeToast:@"Tải ảnh không thành công." duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                }else{
                    self.avatarUploadURL = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    [self updatePhotoForCustomerWithURL: self.avatarUploadURL];
                }
            });
        }];
    });
}

- (void)setupUIForView {
    float padding = 15.0;
    float hItem = 40.0;
    
    btnAvatar.clipsToBounds = TRUE;
    btnAvatar.layer.cornerRadius = 100.0/2;
    [btnAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(20.0);
        make.width.height.mas_equalTo(100.0);
    }];
    
    [btnChoosePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.btnAvatar.mas_bottom).offset(-5.0);
        make.width.height.mas_equalTo(22.0);
    }];
    
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnAvatar.mas_bottom).offset(20.0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50.0);
    }];
    
    lbInfo.textColor = TITLE_COLOR;
    lbInfo.font = [UIFont fontWithName:RobotoMedium size:17.0];
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewInfo);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    float maxText = [AppUtils getSizeWithText:@"Nhân Hoà ID:" withFont:[UIFont fontWithName:RobotoRegular size:17.0]].width;
    //  name
    lbName.textColor = TITLE_COLOR;
    lbName.font = [UIFont fontWithName:RobotoRegular size:17.0];
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom).offset(10.0);
        make.left.equalTo(self.view).offset(padding);
        make.width.mas_equalTo(maxText);
        make.height.mas_equalTo(hItem);
    }];
    
    lbNameValue.textColor = TITLE_COLOR;
    lbNameValue.font = lbInfo.font;
    [lbNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbName);
        make.left.equalTo(self.lbName.mas_right).offset(5.0);
        make.right.equalTo(self.view).offset(-padding);

    }];
    
    //  Nhan Hoa ID
    lbID.textColor = TITLE_COLOR;
    lbID.font = lbName.font;
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbName);
        make.top.equalTo(self.lbName.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    lbIDValue.textColor = TITLE_COLOR;
    lbIDValue.font = lbNameValue.font;
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbID);
        make.left.right.equalTo(self.lbNameValue);
        
    }];
    
    //  Email
    lbEmail.textColor = TITLE_COLOR;
    lbEmail.font = lbName.font;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbID);
        make.top.equalTo(self.lbID.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    lbEmailValue.textColor = TITLE_COLOR;
    lbEmailValue.font = lbNameValue.font;
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbEmail);
        make.left.right.equalTo(self.lbIDValue);
    }];
    
    //  view password
    [viewPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmailValue.mas_bottom).offset(5.0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.viewInfo.mas_height);
    }];
    
    lbPasswordInfo.textColor = TITLE_COLOR;
    lbPasswordInfo.font = lbInfo.font;
    [lbPasswordInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewPassword);
        make.left.equalTo(self.viewPassword).offset(padding);
        make.right.equalTo(self.viewPassword).offset(-padding);
    }];
    
    //  password
    lbPassword.textColor = TITLE_COLOR;
    lbPassword.font = lbName.font;
    [lbPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbEmail);
        make.top.equalTo(self.viewPassword.mas_bottom).offset(5.0);
        make.height.mas_equalTo(hItem);
    }];
    
    lbPasswordValue.textColor = TITLE_COLOR;
    lbPasswordValue.font = lbNameValue.font;
    [lbPasswordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPassword);
        make.left.right.equalTo(self.lbEmailValue);
    }];
    
    [btnChangePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnUpdateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnChangePassword);
        make.bottom.equalTo(self.btnChangePassword.mas_top).offset(-padding);
        make.height.equalTo(self.btnChangePassword.mas_height);
    }];
    
    btnChangePassword.layer.cornerRadius = btnUpdateInfo.layer.cornerRadius = 45.0/2;
    btnChangePassword.titleLabel.font = btnUpdateInfo.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
}

- (IBAction)btnChangePasswordPress:(UIButton *)sender {
    ChangePasswordViewController *changePassVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changePassVC animated:TRUE];
}

- (IBAction)btnAvatarPress:(UIButton *)sender {
    if (![AppUtils isNullOrEmpty: [AccountModel getCusPhoto]]) {
        UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:text_capture, text_gallery, text_remove, nil];
        act.tag = 2;
        [act showInView: self.view];
    }else{
        UIActionSheet *act = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:text_capture, text_gallery, nil];
        act.tag = 1;
        [act showInView: self.view];
    }
//    *Send request (Post / Get) [Auto]
//mod: profile_photo
//username: string
//password: MD5
//photo: URL (Link hình profile photo)
//    *Kết quả trả về: anh em send test để xem kết quả
//    *Lưu ý: profile photo là thông số cus_photo trả về của api login.
}

- (IBAction)btnChoosePhotoPress:(UIButton *)sender {
}

- (IBAction)btnUpdateInfoPress:(UIButton *)sender {
    UpdateMyInfoViewController *updateInfoVC = [[UpdateMyInfoViewController alloc] initWithNibName:@"UpdateMyInfoViewController" bundle:nil];
    [self.navigationController pushViewController:updateInfoVC animated:TRUE];
}

- (void)openEditor {
    PECropController = [[PECropViewController alloc] init];
    PECropController.delegate = self;
    PECropController.image = [AppDelegate sharedInstance].cropAvatar;
    
    UIImage *image = [AppDelegate sharedInstance].cropAvatar;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    PECropController.imageCropRect = CGRectMake((width - length) / 2, (height - length) / 2,
                                                length, length);
    PECropController.keepingCropAspectRatio = true;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController: PECropController];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    [self.navigationController pushViewController:PECropController animated:TRUE];
    //  [self presentViewController:navigationController animated:YES completion:NULL];
}

#pragma mark - ContactDetailsImagePickerDelegate Functions

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [AppDelegate sharedInstance].cropAvatar = image;
    [picker dismissViewControllerAnimated:YES completion:^{
        [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
        [self openEditor];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ActionSheet Delegate
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
    
}

- (void)updatePhotoForCustomerWithURL: (NSString *)url {
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:profile_photo_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:self.avatarUploadURL forKey:@"photo"];
    
    [webService callWebServiceWithLink:profile_photo_func withParams:jsonDict];
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

#pragma mark - Webservice Delegate
- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:profile_photo_func]) {
        [self.view makeToast:@"Tạo hồ sơ thất bại. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([link isEqualToString: login_func]) {
        [self.view makeToast:@"Không thể lấy lại được thông tin bạn vừa cập nhật." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    if ([link isEqualToString:profile_photo_func]) {
        [self tryLoginToUpdateInformation];
        
    }else if ([link isEqualToString: login_func]) {
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
        }
        [self.view makeToast:@"Ảnh đại diện đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        [self displayInformationForAccount];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)tryLoginToUpdateInformation {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [webService callWebServiceWithLink:login_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}


@end
