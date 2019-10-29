//
//  EditProfileViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "EditProfileViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>

@interface EditProfileViewController ()<UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    UIImagePickerController *imagePickerController;
}

@end

@implementation EditProfileViewController
@synthesize personalProfileView, businessProfileView, profileType, type;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_update_profile;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"EditProfileViewController"];
    
    if ([AppDelegate sharedInstance].profileEdit == nil) {
        [WriteLogsUtils writeLogContent:@"DON'T KNOW WHY profileEdit = nil"];
        [self.navigationController popViewControllerAnimated: TRUE];
    }
    
    [self displayProfileInformation];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)displayProfileInformation {
    NSString *type = [[AppDelegate sharedInstance].profileEdit objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            profileType = type_personal;
            
            [self addUpdatePersonalProfileViewIfNeed];
            [personalProfileView displayInfoForPersonalProfileWithInfo: [AppDelegate sharedInstance].profileEdit];
            
        }else{
            profileType = type_business;
            
            [self addUpdateBusinessProfileViewIfNeed];
            [businessProfileView displayInfoForProfileWithInfo: [AppDelegate sharedInstance].profileEdit];
        }
    }
}

- (void)addUpdatePersonalProfileViewIfNeed {
    if (personalProfileView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewProfileView class]]) {
                personalProfileView = (NewProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: personalProfileView];
    }
    personalProfileView.tfName.enabled = FALSE;
    personalProfileView.tfName.backgroundColor = LIGHT_GRAY_COLOR;
    
    [personalProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    personalProfileView.delegate = self;
    [personalProfileView setupForAddProfileUIForAddNew: FALSE isUpdate: TRUE];
    //  [personalProfileView setupViewForAddNewProfileView];
}

- (void)addUpdateBusinessProfileViewIfNeed {
    if (businessProfileView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewBusinessProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewBusinessProfileView class]]) {
                businessProfileView = (NewBusinessProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: businessProfileView];
    }
    businessProfileView.tfBusinessName.enabled = FALSE;
    businessProfileView.tfBusinessName.backgroundColor = LIGHT_GRAY_COLOR;
    
    [businessProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    businessProfileView.delegate = self;
    [businessProfileView setupUIForViewForAddProfile:FALSE update:TRUE];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    if (personalProfileView != nil) {
        [personalProfileView reUpdateLayoutForView];
    }
    
    if (businessProfileView != nil) {
        [businessProfileView reUpdateLayoutForView];
    }
}


#pragma mark - Personal ProfileView Delegate
- (void)onPassportFrontPress {
    type = 1;
    
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

-(void)onPassportBehindPress {
    type = 2;
    
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

- (void)personalProfileWasUpdated {
    if (self.navigationController.viewControllers.count >= 2) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
}

#pragma mark - Business ProfileView Delegate
- (void)onBusinessPassportFrontPress {
    type = 1;
    
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}

-(void)onBusinessPassportBehindPress {
    type = 2;
    
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [self showActionSheetChooseWithRemove:TRUE];
    }else{
        [self showActionSheetChooseWithRemove: FALSE];
    }
}


//  Business Profile was updated
- (void)businessProfileWasUpdated {
    if (self.navigationController.viewControllers.count >= 2) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }
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

#pragma mark - ActionSheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [actionSheet buttonTitleAtIndex: buttonIndex];
    if ([title isEqualToString: text_capture]) {
        [self requestToAccessYourCamera];
        
    }else if ([title isEqualToString: text_gallery]) {
        [self onSelectPhotosGallery];
        
    }else if ([title isEqualToString: text_remove]) {
        [self removeCurrentPhotos];
    }
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

- (void)removeCurrentPhotos {
    if (profileType == type_personal) {
        if (type == 1) {
            [AppDelegate sharedInstance].editCMND_a = nil;
            [personalProfileView removePassportFrontPhoto];
        }else{
//            if (imgBehind != nil) {
//                imgBehind = nil;
//                [personalProfileView removePassportBehindPhoto];
//
//            }else if (![AppUtils isNullOrEmpty: personalProfileView.linkBehindPassport]) {
//                personalProfileView.linkBehindPassport = @"";
//                [personalProfileView removePassportBehindPhoto];
//
//            }
        }
    }else{
        if (type == 1) {
            [AppDelegate sharedInstance].editCMND_a = nil;
            [businessProfileView removePassportFrontPhoto];
        }else{
            if ([AppDelegate sharedInstance].editCMND_b != nil) {
                [AppDelegate sharedInstance].editCMND_b = nil;
                [businessProfileView removePassportBehindPhoto];
                
            }else if (![AppUtils isNullOrEmpty: businessProfileView.linkBehindPassport]) {
                businessProfileView.linkBehindPassport = @"";
                [businessProfileView removePassportBehindPhoto];
                
            }
        }
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
    if (self.profileType == type_personal) {
        if (self.type == 1) {
            NSData *pngData = UIImagePNGRepresentation(image);
            [AppDelegate sharedInstance].editCMND_a = [UIImage imageWithData:pngData];
            
            //  imgFront = image;
            //  self.personalProfileView.imgFront = [AppDelegate sharedInstance].editCMND_a;
            self.personalProfileView.imgPassportFront.image = [AppDelegate sharedInstance].editCMND_a;
        }else{
            NSData *pngData = UIImagePNGRepresentation(image);
            [AppDelegate sharedInstance].editCMND_b = [UIImage imageWithData:pngData];
            
            //  self.personalProfileView.imgBehind = [AppDelegate sharedInstance].editCMND_b;
            self.personalProfileView.imgPassportBehind.image = [AppDelegate sharedInstance].editCMND_b;
        }
        
    }else{
        if (self.type == 1) {
            NSData *pngData = UIImagePNGRepresentation(image);
            [AppDelegate sharedInstance].editCMND_a = [UIImage imageWithData:pngData];
            
            //  self.businessProfileView.imgFront = [AppDelegate sharedInstance].editCMND_a;
            self.businessProfileView.imgPassportFront.image = [AppDelegate sharedInstance].editCMND_a;
        }else{
            NSData *pngData = UIImagePNGRepresentation(image);
            [AppDelegate sharedInstance].editCMND_b = [UIImage imageWithData:pngData];
            
            //  self.businessProfileView.imgBehind = [AppDelegate sharedInstance].editCMND_b;
            self.businessProfileView.imgPassportBehind.image = [AppDelegate sharedInstance].editCMND_b;
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
