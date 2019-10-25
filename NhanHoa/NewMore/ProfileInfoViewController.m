//
//  ProfileInfoViewController.m
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileInfoViewController.h"
#import "ProfileInfoTbvCell.h"
#import "PECropViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UploadPicture.h"
#import <Photos/PHAsset.h>
#import "UpdateNewPersonalProfileView.h"

#define PERSONAL_NUM_ROWS_SECTION_1     5
#define PERSONAL_NUM_ROWS_SECTION_2     3

#define BUSINESS_NUM_ROWS_SECTION_1     7
#define BUSINESS_NUM_ROWS_SECTION_2     3

@interface ProfileInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PECropViewControllerDelegate, WebServiceUtilsDelegate, UpdateNewPersonalProfileViewDelegate>
{
    AppDelegate *appDelegate;
    UIFont *textFont;
    
    UIView *viewHeaderTB;
    UIImageView *imgAvatar;
    UILabel *lbIDAcc;
    float hTbHeader;
    float padding;
    
    float hCell;
    float hAvatar;
    
    UIView *viewFooterTB;
    UIButton *btnUpdate;
    
    UIView *viewAvatars;
    UITableView *tbSelection;
    UIButton *btnClose;
    
    UIImagePickerController *imagePickerController;
    PECropViewController *PECropController;
    
    NSString *avatarUploadURL;
    
    UpdateNewPersonalProfileView *updatePersonalView;
    int cusOwnType;
    
    UIView *viewFooterBusinessInfo;
    UIButton *btnFooterBusinessInfo;
    float hMenu;
}
@end

@implementation ProfileInfoViewController
@synthesize viewHeader, icBack, lbHeader, tbInfo, viewMenu, btnRegistrant, btnBusiness, lbMenuActive, tbBusiness;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    cusOwnType = [AccountModel getCusOwnType];
    
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    cusOwnType = [AccountModel getCusOwnType];
    if (cusOwnType == type_personal) {
        [viewMenu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        [viewMenu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hMenu);
        }];
        
        [self activeRegistrantMenu: TRUE];
        tbInfo.hidden = FALSE;
        tbBusiness.hidden = TRUE;
    }
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Profile informations"];
    
    [btnUpdate setTitle:[appDelegate.localization localizedStringForKey:@"Update information"]
               forState:UIControlStateNormal];
    
    [btnFooterBusinessInfo setTitle:[appDelegate.localization localizedStringForKey:@"Update information"]
                           forState:UIControlStateNormal];
    
    [btnRegistrant setTitle:[appDelegate.localization localizedStringForKey:@"Registrant"]
                   forState:UIControlStateNormal];
    
    [btnBusiness setTitle:[appDelegate.localization localizedStringForKey:@"Business"]
                 forState:UIControlStateNormal];
    
    [self displayProfileInformations];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    if (updatePersonalView) {
        [updatePersonalView removeFromSuperview];
        updatePersonalView = nil;
    }
    
    if (tbSelection) {
        [tbSelection removeFromSuperview];
        tbSelection = nil;
    }
    
    if (btnClose) {
        [btnClose removeFromSuperview];
        btnClose = nil;
    }
    
    if (viewAvatars) {
        [viewAvatars removeFromSuperview];
        viewAvatars = nil;
    }
    
    if (self.isMovingFromParentViewController) {
        imagePickerController = nil;
        appDelegate.dataCrop = nil;
    }
}

- (void)activeRegistrantMenu: (BOOL)select {
    if (select) {
        [btnRegistrant setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        [btnBusiness setTitleColor:GRAY_150 forState:UIControlStateNormal];
        
        [lbMenuActive mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewMenu).offset(padding);
            make.bottom.equalTo(viewMenu);
            make.width.mas_equalTo((SCREEN_WIDTH - 4*padding)/2);
            make.height.mas_equalTo(4.0);
        }];
    }else{
        [btnRegistrant setTitleColor:GRAY_150 forState:UIControlStateNormal];
        [btnBusiness setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        
        [lbMenuActive mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btnBusiness).offset(padding);
            make.bottom.equalTo(viewMenu);
            make.width.mas_equalTo((SCREEN_WIDTH - 4*padding)/2);
            make.height.mas_equalTo(4.0);
        }];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)displayProfileInformations
{
    lbIDAcc.text = SFM(@"ID: %@", [AccountModel getCusIdOfUser]);
    float sizeText = [AppUtils getSizeWithText:lbIDAcc.text withFont:lbIDAcc.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
    [lbIDAcc mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeText);
    }];
    
    //  Show avatar if updating
    if (appDelegate.dataCrop != nil) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Updating..."] Interaction:FALSE];
        
        [self startUploadAvatarForUser];
        
    }else{
        NSString *avatarURL = [AccountModel getCusPhoto];
        if (![AppUtils isNullOrEmpty: avatarURL]) {
            [imgAvatar sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:DEFAULT_AVATAR];
        }else{
            imgAvatar.image = DEFAULT_AVATAR;
        }
    }
}

- (void)setupUIForView
{
    self.view.backgroundColor = [UIColor colorWithRed:(241/255.0) green:(242/255.0) blue:(245/255.0) alpha:1.0];
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hCell = 65.0;
    hAvatar = 100.0;
    hMenu = 50.0;
    
    float hFooter = 100.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hAvatar = 80.0;
        hCell = 60.0;
        hFooter = 80.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hAvatar = 80.0;
        hCell = 60.0;
        hFooter = 80.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hAvatar = 100.0;
        hCell = 65.0;
        hFooter = 100.0;
    }
    
    //  view header
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    if (cusOwnType == type_personal) {
        [AppUtils addBoxShadowForView:viewMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:2.0];
    }
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  menu view
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    if (cusOwnType == type_business) {
        [AppUtils addBoxShadowForView:viewMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:2.0];
    }
    
    btnRegistrant.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [btnRegistrant setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btnRegistrant mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(viewMenu);
        make.right.equalTo(viewMenu.mas_centerX);
    }];
    
    btnBusiness.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [btnBusiness setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu.mas_centerX);
        make.top.right.bottom.equalTo(viewMenu);
    }];
    
    [self activeRegistrantMenu: TRUE];
    
    
    [lbMenuActive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(padding);
        make.bottom.equalTo(viewMenu);
        make.width.mas_equalTo((SCREEN_WIDTH - 4*padding)/2);
        make.height.mas_equalTo(4.0);
    }];
    
    //  header for tableview
    [tbInfo registerNib:[UINib nibWithNibName:@"ProfileInfoTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfileInfoTbvCell"];
    tbInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbInfo.delegate = self;
    tbInfo.dataSource = self;
    tbInfo.backgroundColor = UIColor.clearColor;
    [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(7.0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    
    [tbBusiness registerNib:[UINib nibWithNibName:@"ProfileInfoTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfileInfoTbvCell"];
    tbBusiness.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbBusiness.delegate = self;
    tbBusiness.dataSource = self;
    tbBusiness.backgroundColor = UIColor.clearColor;
    [tbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(7.0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    float hBusinessFooter = SCREEN_HEIGHT - (hStatus + self.navigationController.navigationBar.frame.size.height + 7.0 + hMenu + 6*hCell);
    
    viewFooterBusinessInfo = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hBusinessFooter)];
    
    btnFooterBusinessInfo = [UIButton buttonWithType: UIButtonTypeCustom];
    btnFooterBusinessInfo.backgroundColor = BLUE_COLOR;
    [btnFooterBusinessInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnFooterBusinessInfo.titleLabel.font = textFont;
    btnFooterBusinessInfo.layer.cornerRadius = 8.0;
    btnFooterBusinessInfo.clipsToBounds = TRUE;
    [btnFooterBusinessInfo addTarget:self
                              action:@selector(btnUpdateInformationPress)
                    forControlEvents:UIControlEventTouchUpInside];
    [viewFooterBusinessInfo addSubview: btnFooterBusinessInfo];
    [btnFooterBusinessInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewFooterBusinessInfo).offset(-padding);
        make.left.equalTo(viewFooterBusinessInfo).offset(padding);
        make.right.equalTo(viewFooterBusinessInfo).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    tbBusiness.tableFooterView = viewFooterBusinessInfo;
    
    hTbHeader = 2*padding + hAvatar + 1.5*padding + 30.0 + 2*padding;
    viewHeaderTB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hTbHeader)];
    viewHeaderTB.backgroundColor = self.view.backgroundColor;
    tbInfo.tableHeaderView = viewHeaderTB;
    
    imgAvatar = [[UIImageView alloc] init];
    [viewHeaderTB addSubview: imgAvatar];
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.cornerRadius = hAvatar/2;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeaderTB).offset(2*padding);
        make.centerX.equalTo(viewHeaderTB.mas_centerX);
        make.width.height.mas_equalTo(hAvatar);
    }];
    UITapGestureRecognizer *tapOnAvatar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnAvatar)];
    imgAvatar.userInteractionEnabled = TRUE;
    [imgAvatar addGestureRecognizer: tapOnAvatar];
    
    UIImageView *imgPhoto = [[UIImageView alloc] init];
    imgPhoto.image = [UIImage imageNamed:@"photo-camera"];
    [imgAvatar addSubview: imgPhoto];
    [imgPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imgAvatar).offset(-4.0);
        make.centerX.equalTo(imgAvatar.mas_centerX);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbIDAcc = [[UILabel alloc] init];
    lbIDAcc.textAlignment = NSTextAlignmentCenter;
    lbIDAcc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbIDAcc.backgroundColor = ORANGE_COLOR;
    lbIDAcc.textColor = UIColor.whiteColor;
    lbIDAcc.clipsToBounds = TRUE;
    lbIDAcc.layer.cornerRadius = 8.0;
    [viewHeaderTB addSubview: lbIDAcc];
    [lbIDAcc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgAvatar.mas_bottom).offset(1.5*padding);
        make.centerX.equalTo(viewHeaderTB.mas_centerX);
        make.height.mas_equalTo(30.0);
        make.width.mas_equalTo(0);
    }];
    
    //  footer for tableview
    viewFooterTB = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    viewFooterTB.backgroundColor = UIColor.whiteColor;
    tbInfo.tableFooterView = viewFooterTB;
    
    btnUpdate = [UIButton buttonWithType: UIButtonTypeCustom];
    btnUpdate.backgroundColor = BLUE_COLOR;
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnUpdate.titleLabel.font = textFont;
    btnUpdate.layer.cornerRadius = 8.0;
    btnUpdate.clipsToBounds = TRUE;
    [btnUpdate addTarget:self
                  action:@selector(btnUpdateInformationPress)
        forControlEvents:UIControlEventTouchUpInside];
    [viewFooterTB addSubview: btnUpdate];
    [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(viewFooterTB.mas_centerY);
        make.height.mas_equalTo(50.0);
        make.left.equalTo(viewFooterTB).offset(padding);
        make.right.equalTo(viewFooterTB).offset(-padding);
    }];
    
    tbInfo.tableFooterView = viewFooterTB;
}

- (void)btnUpdateInformationPress
{
    if (cusOwnType == type_personal) {
        icBack.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [icBack setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        lbHeader.text = [appDelegate.localization localizedStringForKey:@"Update profile"];
        
        if (updatePersonalView == nil) {
            NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdateNewPersonalProfileView" owner:nil options:nil];
            for(id currentObject in toplevelObject){
                if ([currentObject isKindOfClass:[UpdateNewPersonalProfileView class]]) {
                    updatePersonalView = (UpdateNewPersonalProfileView *) currentObject;
                    break;
                }
            }
            [self.view addSubview: updatePersonalView];
            updatePersonalView.delegate = self;
            [updatePersonalView setupUIForView];
            [updatePersonalView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(viewHeader.mas_bottom).offset(2.0);
                make.left.right.bottom.equalTo(self.view);
            }];
        }
        [updatePersonalView displayPersonalProfileInfo];
        updatePersonalView.hidden = FALSE;
    }else{
        
    }
}

- (IBAction)icBackClick:(UIButton *)sender {
    if (sender.currentImage == [UIImage imageNamed:@"close_gray"]) {
        lbHeader.text = [appDelegate.localization localizedStringForKey:@"Profile informations"];
        
        sender.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        [sender setImage:[UIImage imageNamed:@"back_gray"] forState:UIControlStateNormal];
    
        updatePersonalView.hidden = TRUE;
    }else{
        [self.navigationController popViewControllerAnimated: TRUE];
    }
}

- (IBAction)btnRegistrantPress:(UIButton *)sender {
    tbBusiness.hidden = TRUE;
    tbInfo.hidden = FALSE;
    
    [self activeRegistrantMenu: TRUE];
}

- (IBAction)btnBusinessPress:(UIButton *)sender {
    tbBusiness.hidden = FALSE;
    tbInfo.hidden = TRUE;
    
    [self activeRegistrantMenu: FALSE];
}

- (void)whenTapOnAvatar {
    if (viewAvatars == nil) {
        viewAvatars = [[UIView alloc] init];
        viewAvatars.clipsToBounds = TRUE;
        viewAvatars.hidden = TRUE;
        viewAvatars.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0)
                                                       blue:(0/255.0) alpha:0.3];
        [self.view addSubview: viewAvatars];
        [viewAvatars mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
        
        tbSelection = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 5*hCell)];
        tbSelection.delegate = self;
        tbSelection.dataSource = self;
        tbSelection.layer.cornerRadius = 12.0;
        tbSelection.scrollEnabled = FALSE;
        tbSelection.separatorInset = UIEdgeInsetsMake(0, padding, 0, padding);
        [viewAvatars addSubview: tbSelection];
        
        btnClose = [[UIButton alloc] init];
        [btnClose setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        btnClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [btnClose addTarget:self
                     action:@selector(closeViewChooseAvatar)
           forControlEvents:UIControlEventTouchUpInside];
        [tbSelection addSubview: btnClose];
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(tbSelection);
            make.top.equalTo(tbSelection).offset((hCell - 40.0)/2);
            make.width.height.mas_equalTo(40.0);
        }];
    }
    
    viewAvatars.hidden = FALSE;
    [UIView animateWithDuration:0.2 animations:^{
        tbSelection.frame = CGRectMake(0, SCREEN_HEIGHT - 4*hCell, SCREEN_WIDTH, 5*hCell);
    }];
}

- (void)closeViewChooseAvatar {
    [UIView animateWithDuration:0.2 animations:^{
        tbSelection.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 5*hCell);
        
    }completion:^(BOOL finished) {
        viewAvatars.hidden = TRUE;
    }];
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
                [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not access to your camera. Please check again your app permision!"] duration:3.0 position:CSToastPositionCenter];
            }
        }
    }
}

- (void)goToCaptureImagePickerView {
    if (imagePickerController == nil) {
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = FALSE;
    }
    imagePickerController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:TRUE completion:nil];
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

- (void)startUploadAvatarForUser
{
    //  upload avatar first to get link
    NSString *imageName = SFM(@"avatar_%@.png", [AccountModel getCusIdOfUser]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UploadPicture *session = [[UploadPicture alloc] init];
        [session uploadData:appDelegate.dataCrop withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                {
                    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Sorry. Can not upload photo at this time!"] duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                }else{
                    avatarUploadURL = SFM(@"%@/%@", link_upload_photo, uploadSession.namePicture);
                    [self updatePhotoForCustomerWithURL: avatarUploadURL];
                }
                appDelegate.dataCrop = nil;
            });
        }];
    });
}

- (void)updatePhotoForCustomerWithURL: (NSString *)url {
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updatePhotoForCustomerWithURL: url];
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == tbInfo) {
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbInfo) {
        if (cusOwnType == type_personal) {
            return (section == 0)? PERSONAL_NUM_ROWS_SECTION_1  : PERSONAL_NUM_ROWS_SECTION_2;
        }else{
            return (section == 0)? BUSINESS_NUM_ROWS_SECTION_1  : BUSINESS_NUM_ROWS_SECTION_2;
        }
    }else if (tableView == tbBusiness){
        return 6;
    }else{
        return 5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbInfo) {
        ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Fullname"];
                    cell.lbValue.text = [AccountModel getCusRealName];
                    break;
                }
                case 1:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Gender"];
                    cell.lbValue.text = [AccountModel getCusGenderValue];
                    
                    break;
                }
                case 2:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Date of birth"];
                    cell.lbValue.text = [AccountModel getCusBirthday];
                    break;
                }
                case 3:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Passport"];
                    cell.lbValue.text = [AccountModel getCusPassport];
                    break;
                }
                case 4:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Phone number"];
                    cell.lbValue.text = [AccountModel getCusPhone];
                    break;
                }
                case 5:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Position"];
                    cell.lbValue.text = [AccountModel getCusCompanyPosition];
                    break;
                }
                case 6:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Email"];
                    cell.lbValue.text = [AccountModel getCusEmail];
                    break;
                }
            }
        }else{
            switch (indexPath.row) {
                case 0:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Permanent address"];
                    cell.lbValue.text = [AccountModel getCusAddress];
                    break;
                }
                case 1:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Province/ City"];
                    cell.lbValue.text = [AccountModel getCusCityName];
                    break;
                }
                case 2:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Country"];
                    cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Viet Nam"];
                    break;
                }
            }
        }
        
        [cell updateFrameWithContent];
        
        return cell;
        
    }else if (tableView == tbBusiness){
        ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = UIColor.clearColor;
        
        switch (indexPath.row) {
            case 0:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Business name"];
                cell.lbValue.text = [AccountModel getCusRealName];
                break;
            }
            case 1:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Tax code"];
                cell.lbValue.text = [AccountModel getCusGenderValue];
                
                break;
            }
            case 2:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Business address"];
                cell.lbValue.text = [AccountModel getCusBirthday];
                break;
            }
            case 3:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Business phone number"];
                cell.lbValue.text = [AccountModel getCusPassport];
                break;
            }
            case 4:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Province/ City"];
                cell.lbValue.text = [AccountModel getCusPhone];
                break;
            }
            case 5:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Country"];
                cell.lbValue.text = [AccountModel getCusCompanyPosition];
                break;
            }
        }
        [cell updateFrameWithContent];
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        
        if (indexPath.row == eTypeAvatarTitle) {
            cell.textLabel.text = [appDelegate.localization localizedStringForKey:@"Avatar"];
            cell.textLabel.textColor = GRAY_100;
            cell.textLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
            
        }else if (indexPath.row == eTypeViewAvatar){
            cell.textLabel.text = [appDelegate.localization localizedStringForKey:@"View avatar"];
            cell.textLabel.textColor = GRAY_50;
            cell.textLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
            
        }else if (indexPath.row == eTypeCapture){
            cell.textLabel.text = [appDelegate.localization localizedStringForKey:@"Capture new photo"];
            cell.textLabel.textColor = GRAY_50;
            cell.textLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
            
        }else if (indexPath.row == eTypeChooseGallery){
            cell.textLabel.text = [appDelegate.localization localizedStringForKey:@"Choose from gallery"];
            cell.textLabel.textColor = GRAY_50;
            cell.textLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbSelection) {
        [self closeViewChooseAvatar];
        if (indexPath.row == eTypeViewAvatar){
            
        }else if (indexPath.row == eTypeCapture) {
            [self requestToAccessYourCamera];
            
        }else if (indexPath.row == eTypeChooseGallery) {
            [self onSelectPhotosGallery];
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == tbInfo) {
        if (section == 0) {
            return nil;
        }else{
            UILabel *lbSection = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15.0)];
            lbSection.backgroundColor = self.view.backgroundColor;
            return lbSection;
        }
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == tbInfo) {
        if (section == 0) {
            return 0.1;
        }else{
            return 15.0;
        }
    }else{
        return 0.1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbInfo) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            return [self getHeightContentForCell];
        }
        return hCell;
    }else{
        return hCell;
    }
}

- (float)getHeightContentForCell {
    UIFont *font = [UIFont fontWithName:RobotoRegular size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        font = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        font = [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        font = [UIFont fontWithName:RobotoRegular size:19.0];
    }
    
    float maxLeftSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Permanent address"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 5.0;
    
    float maxSize = (SCREEN_WIDTH - 2*padding - maxLeftSize - 5.0);
    
    NSString *content = [AccountModel getCusAddress];
    float hContent = [AppUtils getSizeWithText:content withFont:font andMaxWidth:maxSize].height + 30.0;
    if (hContent >= hCell) {
        return hContent;
    }
    return hCell;
}

#pragma mark - UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

#pragma mark - ContactDetailsImagePickerDelegate Functions

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    //You can retrieve the actual UIImage
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self openEditorWithPhoto: image];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openEditorWithPhoto:(UIImage *)image
{
    PECropController = [[PECropViewController alloc] init];
    PECropController.delegate = self;
    PECropController.image = image;
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    PECropController.imageCropRect = CGRectMake((width - length) / 2, (height - length) / 2, length, length);
    PECropController.keepingCropAspectRatio = true;
    [self.navigationController pushViewController:PECropController animated:TRUE];
}

-(void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    //  store image cropped
    UIImage *cropImage = [AppUtils cropImageWithSize:CGSizeMake(300, 300) fromImage:croppedImage];
    appDelegate.dataCrop = UIImageJPEGRepresentation(cropImage, 1);
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)cropViewControllerDidCancel:(PECropViewController *)controller {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - Webservice Delegate
-(void)failedToUpdateAvatarWithError:(NSString *)error {
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)failedToLoginWithError:(NSString *)error {
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
}

- (void)updateAvatarForProfileSuccessful {
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

- (void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        appDelegate.userInfo = [[NSDictionary alloc] initWithDictionary: data];
    }
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Your avatar has been updated successfully"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    
    [self displayProfileInformations];
}

#pragma mark - UpdateNewPersonalProfileViewDelegate
-(void)updateProfileInfoFailed {
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)updateProfileInfoSuccessfully {
    [self.navigationController popViewControllerAnimated: TRUE];
}

@end
