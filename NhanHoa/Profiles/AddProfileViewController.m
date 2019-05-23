//
//  AddProfileViewController.m
//  NhanHoa
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddProfileViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AddProfileViewController ()<NewProfileViewDelegate, UIActionSheetDelegate> {
    UIImage *imgFront;
    UIImage *imgBehind;
}
@end

@implementation AddProfileViewController
@synthesize addNewProfile;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen: @"SignInViewController"];
    
    self.title = @"Tạo hồ sơ";
    [self addNewProfileViewIfNeed];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [addNewProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [addNewProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)addNewProfileViewIfNeed {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (addNewProfile == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewProfileView class]]) {
                addNewProfile = (NewProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: addNewProfile];
    }
    [addNewProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    addNewProfile.delegate = self;
    [addNewProfile setupForAddProfileUI];
    [addNewProfile setupViewForAddNewProfileView];
}

#pragma New Profile view delegate
- (void)onSaveButtonClicked:(NSDictionary *)info {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] info = %@", __FUNCTION__, @[info]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
}

- (void)onCancelButtonClicked {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)onPassportBehindPress {
    
}

- (void)onPassportFrontPress {
    if (imgFront == nil) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Chụp ảnh", @"Thư viện ảnh", nil];
        actionSheet.tag = 1;
        [actionSheet showInView: self.view];
    }else{
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Đóng" destructiveButtonTitle:nil otherButtonTitles:@"Chụp ảnh", @"Thư viện ảnh", @"Xóa ảnh", nil];
        actionSheet.tag = 2;
        [actionSheet showInView: self.view];
    }
}

#pragma mark - ActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            [self requestToAccessYourCamera];
            
        }else if (buttonIndex == 1){
            
        }
        
    }else if (actionSheet.tag == 2){
        
    }
}

//  [Khai Le - 18/01/2019]
- (void)requestToAccessYourCamera {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    AVAuthorizationStatus cameraAuthStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    if (cameraAuthStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self goToImagePickerView];
                }else{
                    [DeviceUtils showWarningWhenRejectedRequiredPermissionWithAVSession: NO];
                }
            });
        }];
    }else{
        if (cameraAuthStatus == AVAuthorizationStatusAuthorized) {
            [self goToImagePickerView];
        }else{
            if (cameraAuthStatus != AVAuthorizationStatusAuthorized && cameraAuthStatus != AVAuthorizationStatusNotDetermined) {
                [[iMomeetAppDelegate sharedInstance] performSelectorOnMainThread:@selector(showPermissionCameraPopup) withObject:nil waitUntilDone:NO];
            }
        }
    }
}

- (void)goToImagePickerView {
    UIImagePickerController *imgagePickerVC = [[UIImagePickerController alloc] init];
    imgagePickerVC.delegate = self;
    imgagePickerVC.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imgagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    imgagePickerVC.allowsEditing = NO;
    [self presentViewController:imgagePickerVC animated:YES completion:nil];
}

- (void)didSelectImageButton {
    PHAuthorizationStatus photoAuthStatus = [PHPhotoLibrary authorizationStatus];
    if (photoAuthStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^() {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self goToGalleryPhotosView];
                }else{
                    [DeviceUtils showWarningWhenRejectedRequiredPermissionWithAVSession: NO];
                }
            });
        }];
    }else{
        if (photoAuthStatus == PHAuthorizationStatusAuthorized) {
            [self goToGalleryPhotosView];
        }else{
            [[iMomeetAppDelegate sharedInstance] performSelectorOnMainThread:@selector(showPermissionPhotosPopup) withObject:nil waitUntilDone:NO];
        }
    }
}

- (void)goToGalleryPhotosView {
    YMSPhotoPickerViewController *pickerViewController = [[YMSPhotoPickerViewController alloc] init];
    pickerViewController.numberOfPhotoToSelect = 5;
    pickerViewController.theme.tintColor = UIColor.whiteColor;
    pickerViewController.theme.titleLabelTextColor = UIColor.whiteColor;
    pickerViewController.theme.navigationBarBackgroundColor = [UIColor colorWithRed:0.169 green:0.53 blue:0.949 alpha:1.0];
    //      pickerViewController.theme.orderTintColor = customCameraColor;
    //      pickerViewController.theme.cameraVeilColor = customCameraColor;
    //      pickerViewController.theme.cameraIconColor = [UIColor whiteColor];
    pickerViewController.theme.statusBarStyle = UIStatusBarStyleLightContent;
    [self yms_presentCustomAlbumPhotoView:pickerViewController delegate:self];
    
    return;
    
    HMImagePickerController *imagePickerController = [[HMImagePickerController alloc] init];
    [imagePickerController setUpAppNavigation];
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


@end
