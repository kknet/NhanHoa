//
//  NewProfileViewController.m
//  NhanHoa
//
//  Created by OS on 10/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewProfileViewController.h"
#import "UpdatePersonalProfileView.h"
#import "UpdateBusinessProfileView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>

@interface NewProfileViewController ()<UpdatePersonalProfileViewDelegate, UpdateBusinessProfileViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    float padding;
    UIFont *textFont;
    AppDelegate *appDelegate;
    int typeProfile;
    int type;
    
    UIImagePickerController *imagePickerController;
    UpdatePersonalProfileView *personalView;
    UpdateBusinessProfileView *businessView;
}
@end

@implementation NewProfileViewController
@synthesize viewHeader, icBack, lbHeader, viewType, bgIntro, lbTitle, viewPersonal, imgPersonal, lbPersonal, viewBusiness, imgBusiness, lbBusiness, btnContinue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    typeProfile = type_personal;
    
    [self showContentWithCurrentLanguage];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Add profile"];
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Choose profile's type"];
    lbPersonal.text = [appDelegate.localization localizedStringForKey:@"Personal"];
    lbBusiness.text = [appDelegate.localization localizedStringForKey:@"Business"];
    [btnContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"] forState:UIControlStateNormal];
}

- (void)setupUIForView {
    padding = 25.0;
    
    textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    float hItem = 52.0;
    float hBTN = 55.0;
    float paddingY = 25.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        padding = 15.0;
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
        hItem = 45.0;
        hBTN = 50.0;
        paddingY = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        padding = 15.0;
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        
        hItem = 45.0;
        hBTN = 50.0;
        paddingY = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        padding = 25.0;
        textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        
        hItem = 50.0;
        hBTN = 52.0;
        paddingY = 25.0;
    }
    //  header
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.textColor = GRAY_50;
    lbHeader.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];

    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(3.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];

    //  for choose type view
    float largePadding = 30.0;
    [viewType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.right.bottom.equalTo(self.view);
    }];

    [bgIntro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewType);
    }];

    float sizeItem = (SCREEN_WIDTH - 2*largePadding - largePadding/2)/2;

    viewPersonal.layer.cornerRadius = viewBusiness.layer.cornerRadius = 10.0;

    viewPersonal.layer.borderColor = BLUE_COLOR.CGColor;
    viewPersonal.layer.borderWidth = 2.5;
    [viewPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewType).offset(largePadding);
        make.bottom.equalTo(viewType.mas_centerY);
        make.width.height.mas_equalTo(sizeItem);
    }];
    [AppUtils addBoxShadowForView:viewPersonal color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];

    UITapGestureRecognizer *tapPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPersonalView)];
    viewPersonal.userInteractionEnabled = TRUE;
    [viewPersonal addGestureRecognizer: tapPersonal];

    imgPersonal.backgroundColor = UIColor.clearColor;
    [imgPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewPersonal).offset(10.0);
        make.centerX.equalTo(viewPersonal.mas_centerX);
        make.width.mas_equalTo(viewPersonal.mas_width).multipliedBy(2.0/3.0);
        make.height.mas_equalTo(viewPersonal.mas_height).multipliedBy(2.0/3.0);
    }];

    lbPersonal.textColor = GRAY_100;
    lbPersonal.font = textFont;
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewPersonal);
        make.top.equalTo(imgPersonal.mas_bottom);
    }];

    //  BUSINESS VIEW
    viewBusiness.layer.borderColor = UIColor.clearColor.CGColor;
    viewBusiness.layer.borderWidth = 2.5;
    [viewBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewType).offset(-largePadding);
        make.top.equalTo(viewPersonal);
        make.width.height.mas_equalTo(sizeItem);
    }];
    [AppUtils addBoxShadowForView:viewBusiness color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];

    imgBusiness.backgroundColor = UIColor.clearColor;
    [imgBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBusiness).offset(10.0);
        make.centerX.equalTo(viewBusiness.mas_centerX);
        make.width.mas_equalTo(viewBusiness.mas_width).multipliedBy(2.0/3.0);
        make.height.mas_equalTo(viewBusiness.mas_height).multipliedBy(2.0/3.0);
    }];

    lbBusiness.textColor = GRAY_100;
    lbBusiness.font = textFont;
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewBusiness);
        make.top.equalTo(imgBusiness.mas_bottom);
    }];

    UITapGestureRecognizer *tapBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBusinessView)];
    viewBusiness.userInteractionEnabled = TRUE;
    [viewBusiness addGestureRecognizer: tapBusiness];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewPersonal.mas_top);
        make.left.equalTo(viewType).offset(largePadding);
        make.right.equalTo(viewType).offset(-largePadding);
        make.height.mas_equalTo(80.0);
    }];
    
    btnContinue.layer.cornerRadius = 8.0;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = textFont;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    float bottomY = padding;
    if (appDelegate.safeAreaBottomPadding > 0) {
        bottomY = appDelegate.safeAreaBottomPadding;
    }
    
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewType).offset(padding);
        make.right.equalTo(viewType).offset(-padding);
        make.bottom.equalTo(viewType).offset(-bottomY);
        make.height.mas_equalTo(hBTN);
    }];
}

- (void)whenTapOnPersonalView {
    typeProfile = type_personal;
    
    viewPersonal.layer.borderWidth = 2.0;
    viewPersonal.layer.borderColor = BLUE_COLOR.CGColor;
    
    viewBusiness.layer.borderWidth = 0;
    viewBusiness.layer.borderColor = UIColor.clearColor.CGColor;
}

- (void)whenTapOnBusinessView {
    typeProfile = type_business;
    
    viewPersonal.layer.borderWidth = 0;
    viewPersonal.layer.borderColor = UIColor.clearColor.CGColor;
    
    viewBusiness.layer.borderWidth = 2.0;
    viewBusiness.layer.borderColor = BLUE_COLOR.CGColor;
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    if (typeProfile == type_personal) {
        [self addAddNewPersonalProfileViewIfNeed];
    }else{
        [self addAddnewBusinessProfileViewIfNeed];
    }
}

- (void)addAddNewPersonalProfileViewIfNeed {
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
    personalView.typeOfView = eAddNewPersonalProfile;
    [personalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.bottom.right.equalTo(self.view);
    }];
    [personalView setupUIForView];
    personalView.delegate = self;
}

- (void)addAddnewBusinessProfileViewIfNeed {
    if (businessView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdateBusinessProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdateBusinessProfileView class]]) {
                businessView = (UpdateBusinessProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: businessView];
    }
    businessView.typeOfView = eAddNewBusinessProfile;
    [businessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    [businessView setupUIForView];
    businessView.delegate = self;
}

- (void)dismissViewController {
    appDelegate.needReloadListProfile = TRUE;
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - UpdateBusinessProfileViewDelegate
-(void)failedToAddBusinessProfileWithError:(NSString *)error {
    [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:2.0];
}

-(void)addBusinessProfileSuccessfully {
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Your profile has been added successful"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:2.0];
}

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

#pragma mark - UpdatePersonalProfileViewDelegate
-(void)failedToAddPersonalProfileWithError:(NSString *)error {
    [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:2.0];
}

-(void)addPersonalProfileSuccessfully {
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Your profile has been added successful"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:2.0];
}

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
                                    //  [self onSelectPhotosGallery];
                                }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Remove"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                {
                                    //  [self removeCurrentPhotos];
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
                                    //  [self onSelectPhotosGallery];
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
    if (typeProfile == type_personal) {
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
//        if (type == 1) {
//            NSData *pngData = UIImagePNGRepresentation(image);
//            appDelegate.editCMND_a = [UIImage imageWithData:pngData];
//
//            businessView.imgFront.image = appDelegate.editCMND_a;
//        }else{
//            NSData *pngData = UIImagePNGRepresentation(image);
//            appDelegate.editCMND_b = [UIImage imageWithData:pngData];
//
//            businessView.imgBackside.image = appDelegate.editCMND_b;
//        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
