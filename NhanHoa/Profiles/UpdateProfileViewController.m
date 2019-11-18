//
//  UpdateProfileViewController.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateProfileViewController.h"
#import "UpdatePersonalProfileView.h"
#import "UpdateBusinessProfileView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>

@interface UpdateProfileViewController ()<UpdatePersonalProfileViewDelegate, UpdateBusinessProfileViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    AppDelegate *appDelegate;
    UIFont *textFont;
    UIImagePickerController *imagePickerController;
    
    int profileType;
    int type;
    UpdatePersonalProfileView *personalView;
    UpdateBusinessProfileView *businessView;
}
@end

@implementation UpdateProfileViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self displayProfileInformation];
    [self updateCartCountForView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    if ([self isMovingFromParentViewController])
    {
        imagePickerController = nil;
        [appDelegate enableSizeForBarButtonItem: FALSE];
        appDelegate.profileEdit = nil;
        appDelegate.editCMND_a = nil;
        appDelegate.editCMND_b = nil;
    }else {
        if (profileType == type_personal) {
            [personalView saveAllValueBeforeChangeView];
        }else{
            [businessView saveAllValueBeforeChangeView];
        }
    }
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)displayProfileInformation
{
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Edit profile"];
    
    NSString *type = [appDelegate.profileEdit objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            profileType = type_personal;
            
            [self addUpdatePersonalProfileViewIfNeed];
            [personalView displayInfoForPersonalProfileWithInfo: appDelegate.profileEdit];
            
            [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
        }else{
            profileType = type_business;

            [self addUpdateBusinessProfileViewIfNeed];
            [businessView displayInfoForProfileWithInfo: appDelegate.profileEdit];
            
            [AppUtils addBoxShadowForView:businessView.viewMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
        }
    }
}

- (void)addUpdatePersonalProfileViewIfNeed {
    if (personalView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdatePersonalProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdatePersonalProfileView class]]) {
                personalView = (UpdatePersonalProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: personalView];
    }
    personalView.typeOfView = eUpdatePersonalProfile;
    personalView.tfFullname.enabled = FALSE;
    personalView.tfFullname.textColor = GRAY_150;
    [personalView setupUIForView];
    
    [personalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    personalView.delegate = self;
}

- (void)addUpdateBusinessProfileViewIfNeed {
    if (businessView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdateBusinessProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdateBusinessProfileView class]]) {
                businessView = (UpdateBusinessProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: businessView];
        [businessView setupUIForView];
    }
    businessView.typeOfView = eUpdateBusinessProfile;
    businessView.tfBusinessName.enabled = FALSE;
    businessView.tfBusinessName.textColor = GRAY_150;

    [businessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    businessView.delegate = self;
}

- (void)setupUIForView {
    //  self.view.backgroundColor = GRAY_235;
    self.view.backgroundColor = UIColor.whiteColor;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hBTN = 53.0;
    float padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hBTN = 45.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hBTN = 48.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hBTN = 53.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    //  view header
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(280.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(3.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

#pragma mark - UpdateBusinessProfileViewDelegate
-(void)clickOnFrontBusinessProfile {
    type = 1;
    
    if (appDelegate.editCMND_a != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

-(void)clickOnBacksideBusinessProfile {
    type = 2;
    
    if (appDelegate.editCMND_b != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

-(void)failedToUpdateBusinessProfileWithError:(NSString *)error {
    [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(gotoListProfiles) withObject:nil afterDelay:2.0];
}

-(void)updateBusinessProfileSuccessfully {
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Profile has been updated"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(gotoListProfiles) withObject:nil afterDelay:2.0];
}

#pragma mark - UpdatePersonalProfileViewDelegate
-(void)clickOnBacksidePersonalProfile {
    type = 2;
    
    if (appDelegate.editCMND_b != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

-(void)clickOnFrontPersonalProfile {
    type = 1;
    
    if (appDelegate.editCMND_a != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

-(void)failedToUpdatePersonalProfileWithError:(NSString *)error {
    [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(gotoListProfiles) withObject:nil afterDelay:2.0];
}

-(void)updatePersonalProfileSuccessfully {
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Profile has been updated"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(gotoListProfiles) withObject:nil afterDelay:2.0];
}

- (void)gotoListProfiles {
    appDelegate.needReloadListProfile = TRUE;
    
    if (self.navigationController.viewControllers.count >= 2) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

- (void)showActionSheetChooseWithRemove: (BOOL)remove
{
    if (remove) {
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
        popPresenter.sourceView = personalView.imgBackside;
        popPresenter.sourceRect = personalView.imgBackside.bounds;
        [self presentViewController:actionSheet animated:YES completion:nil];
        
    }else{
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
        popPresenter.sourceView = personalView.imgBackside;
        popPresenter.sourceRect = personalView.imgBackside.bounds;
        [self presentViewController:actionSheet animated:YES completion:nil];
    }
}

- (void)requestToAccessYourCamera {
    AVAuthorizationStatus cameraAuthStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    if (cameraAuthStatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted) {
                    [self goToCaptureImagePickerView];
                }else{
                    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not access to your camera. Please check again your app permision!"] duration:3.0 position:CSToastPositionCenter];
                }
            });
        }];
    }else{
        if (cameraAuthStatus == AVAuthorizationStatusAuthorized) {
            [self goToCaptureImagePickerView];
        }else{
            if (cameraAuthStatus != AVAuthorizationStatusAuthorized && cameraAuthStatus != AVAuthorizationStatusNotDetermined) {
                [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not access to your camera. Please check again your app permision!"] duration:3.0 position:CSToastPositionCenter];
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
                    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not access to your gallery. Please check again your app permision!"] duration:3.0 position:CSToastPositionCenter];
                }
            });
        }];
    }else{
        if (photoAuthStatus == PHAuthorizationStatusAuthorized) {
            [self goToGalleryPhotosView];
        }else{
            [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not access to your gallery. Please check again your app permision!"] duration:3.0 position:CSToastPositionCenter];
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

- (void)removeCurrentPhotos {
    if (profileType == type_personal) {
        if (type == 1) {
            appDelegate.editCMND_a = nil;
            [personalView removePassportFrontPhoto];
        }else{
            appDelegate.editCMND_b = nil;
            [personalView removePassportBacksidePhoto];
        }
    }else{
//        if (type == 1) {
//            appDelegate.editCMND_a = nil;
//            [businessProfileView removePassportFrontPhoto];
//        }else{
//            if (appDelegate.editCMND_b != nil) {
//                appDelegate.editCMND_b = nil;
//                [businessProfileView removePassportBehindPhoto];
//
//            }else if (![AppUtils isNullOrEmpty: businessProfileView.linkBehindPassport]) {
//                businessProfileView.linkBehindPassport = @"";
//                [businessProfileView removePassportBehindPhoto];
//
//            }
//        }
    }
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
    if (profileType == type_personal) {
        if (type == 1) {
            NSData *pngData = UIImagePNGRepresentation(image);
            appDelegate.editCMND_a = [UIImage imageWithData:pngData];
            
            personalView.imgFront.image = appDelegate.editCMND_a;
        }else{
            NSData *pngData = UIImagePNGRepresentation(image);
            appDelegate.editCMND_b = [UIImage imageWithData:pngData];
            
            personalView.imgBackside.image = appDelegate.editCMND_b;
        }
        
    }else{
        if (type == 1) {
            NSData *pngData = UIImagePNGRepresentation(image);
            appDelegate.editCMND_a = [UIImage imageWithData:pngData];

            businessView.imgFront.image = appDelegate.editCMND_a;
        }else{
            NSData *pngData = UIImagePNGRepresentation(image);
            appDelegate.editCMND_b = [UIImage imageWithData:pngData];

            businessView.imgBackside.image = appDelegate.editCMND_b;
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
