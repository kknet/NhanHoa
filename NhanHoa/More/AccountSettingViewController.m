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

@interface AccountSettingViewController ()<PECropViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, WebServiceUtilsDelegate> {
    PECropViewController *PECropController;
    UIImagePickerController *imagePickerController;
}
@end

@implementation AccountSettingViewController

@synthesize btnAvatar, btnChoosePhoto, viewInfo, lbInfo, lbName, lbNameValue, lbID, lbIDValue, lbEmail, lbEmailValue, viewPassword, lbPasswordInfo, lbPassword, btnChangePassword, lbPasswordValue, btnUpdateInfo, avatarUploadURL;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    self.title = text_account_settings;
    self.edgesForExtendedLayout = UIRectEdgeBottom;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"AccountSettingViewController"];
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    lbID.text = SFM(@"%@ ID:", appName);
    
    NSString *avatarName = SFM(@"%@.PNG", [AccountModel getCusIdOfUser]);
    NSString *localFile = SFM(@"/avatars/%@", avatarName);
    NSData *avatarData = [AppUtils getFileDataFromDirectoryWithFileName:localFile];
    if (avatarData != nil) {
        [btnAvatar setImage:[UIImage imageWithData:avatarData] forState:UIControlStateNormal];
    }
    [self displayInformationForAccount];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    if (self.isMovingFromParentViewController) {
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
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:text_updating Interaction:FALSE];
        
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSString *imageName = SFM(@"avatar_%@.png", [AccountModel getCusIdOfUser]);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UploadPicture *session = [[UploadPicture alloc] init];
        [session uploadData:[AppDelegate sharedInstance].dataCrop withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                {
                    [self.view makeToast:text_failed_to_upload_avatar duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                }else{
                    self.avatarUploadURL = SFM(@"%@/%@", link_upload_photo, uploadSession.namePicture);
                    [self updatePhotoForCustomerWithURL: self.avatarUploadURL];
                }
                [AppDelegate sharedInstance].dataCrop = nil;
            });
        }];
    });
}

- (void)setupUIForView {
    float padding = 15.0;
    float hItem = 40.0;
    float wAvatar = 100.0;
    float hBTN = 45.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
        wAvatar = 80.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        wAvatar = 120.0;
        hItem = 60.0;
        hBTN = 55.0;
    }
    
    btnAvatar.clipsToBounds = TRUE;
    btnAvatar.layer.cornerRadius = wAvatar/2;
    [btnAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(20.0);
        make.width.height.mas_equalTo(wAvatar);
    }];
    
    [btnChoosePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(btnAvatar.mas_bottom).offset(-5.0);
        make.width.height.mas_equalTo(22.0);
    }];
    
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnAvatar.mas_bottom).offset(20.0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hItem);
    }];
    
    lbInfo.textColor = lbName.textColor = lbNameValue.textColor = lbID.textColor = lbIDValue.textColor = lbEmail.textColor = lbEmailValue.textColor = lbPasswordInfo.textColor = lbPassword.textColor = lbPasswordValue.textColor = TITLE_COLOR;
    lbInfo.font = lbNameValue.font = lbIDValue.font = lbEmailValue.font = lbPasswordInfo.font = lbPasswordValue.font = [AppDelegate sharedInstance].fontMedium;
    lbName.font = lbID.font = lbEmail.font = lbPassword.font = [AppDelegate sharedInstance].fontRegular;
    
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewInfo);
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
    }];
    
    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    float maxText = [AppUtils getSizeWithText:SFM(@"%@ ID:", appName) withFont:[AppDelegate sharedInstance].fontRegular].width + 10.0;
    //  name
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo.mas_bottom).offset(10.0);
        make.left.equalTo(self.view).offset(padding);
        make.width.mas_equalTo(maxText);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbName);
        make.left.equalTo(lbName.mas_right).offset(5.0);
        make.right.equalTo(self.view).offset(-padding);

    }];
    
    //  Nhan Hoa ID
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.equalTo(lbName.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbID);
        make.left.right.equalTo(lbNameValue);
        
    }];
    
    //  Email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbID);
        make.top.equalTo(lbID.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmail);
        make.left.right.equalTo(lbIDValue);
    }];
    
    //  view password
    [viewPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmailValue.mas_bottom).offset(5.0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(viewInfo.mas_height);
    }];
    
    [lbPasswordInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewPassword);
        make.left.equalTo(viewPassword).offset(padding);
        make.right.equalTo(viewPassword).offset(-padding);
    }];
    
    //  password
    [lbPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbEmail);
        make.top.equalTo(viewPassword.mas_bottom).offset(5.0);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbPasswordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPassword);
        make.left.right.equalTo(lbEmailValue);
    }];
    
    [btnChangePassword setTitle:text_change_password forState:UIControlStateNormal];
    [btnChangePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnUpdateInfo setTitle:text_update_my_info forState:UIControlStateNormal];
    [btnUpdateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnChangePassword);
        make.bottom.equalTo(btnChangePassword.mas_top).offset(-15.0);
        make.height.equalTo(btnChangePassword.mas_height);
    }];
    
    btnChangePassword.layer.borderColor = btnUpdateInfo.layer.borderColor = BLUE_COLOR.CGColor;
    btnChangePassword.layer.borderWidth = btnUpdateInfo.layer.borderWidth = 1.0;
    btnChangePassword.backgroundColor = btnUpdateInfo.backgroundColor = BLUE_COLOR;
    btnChangePassword.layer.cornerRadius = btnUpdateInfo.layer.cornerRadius = hBTN/2;
    btnChangePassword.titleLabel.font = btnUpdateInfo.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
}

- (IBAction)btnChangePasswordPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(goToChnagePassVC) withObject:nil afterDelay:0.05];
}

- (void)goToChnagePassVC {
    btnChangePassword.backgroundColor = BLUE_COLOR;
    [btnChangePassword setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    ChangePasswordViewController *changePassVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changePassVC animated:TRUE];
}

- (IBAction)btnAvatarPress:(UIButton *)sender {
    [self showViewChangeAvatar];
}

- (IBAction)btnChoosePhotoPress:(UIButton *)sender {
    [self showViewChangeAvatar];
}

- (IBAction)btnUpdateInfoPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(goToUpdateInfoVC) withObject:nil afterDelay:0.05];
}

- (void)goToUpdateInfoVC {
    btnUpdateInfo.backgroundColor = BLUE_COLOR;
    [btnUpdateInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
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

- (void)showViewChangeAvatar
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //  close button
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){}];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    //  capture button
    UIAlertAction *btnCapture = [UIAlertAction actionWithTitle:text_capture style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [self requestToAccessYourCamera];
                                                       }];
    [btnCapture setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    //  gallery button
    UIAlertAction *btnGallery = [UIAlertAction actionWithTitle:text_gallery style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [self onSelectPhotosGallery];
                                                       }];
    [btnGallery setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnGallery];
    [alertVC addAction:btnCapture];
    [alertVC addAction:btnClose];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - ContactDetailsImagePickerDelegate Functions

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    [[AppDelegate sharedInstance] enableSizeForBarButtonItem: FALSE];
    
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
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

- (void)onSelectPhotosGallery {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
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

- (void)updatePhotoForCustomerWithURL: (NSString *)url {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] url = %@", __FUNCTION__, url)];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updatePhotoForCustomerWithURL: url];
}

#pragma mark - Webservice Delegate
-(void)failedToUpdateAvatarWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)updateAvatarForProfileSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [self tryLoginToUpdateInformation];
}

-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
}

- (void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
    }
    [self.view makeToast:avatar_has_been_uploaded duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self displayInformationForAccount];
}

- (void)tryLoginToUpdateInformation
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}


@end
