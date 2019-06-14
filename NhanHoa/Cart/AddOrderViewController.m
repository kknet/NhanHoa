//
//  AddOrderViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddOrderViewController.h"
#import "DomainProfileCell.h"
#import "ProfileDetailCell.h"
#import "PaymentMethodCell.h"
#import "CartModel.h"
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Photos/PHAsset.h>
#import "AddProfileViewController.h"

@interface AddOrderViewController ()<UITableViewDelegate, UITableViewDataSource, SelectProfileViewDelegate, UIActionSheetDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    float hCell;
    float hSmallCell;
    PaymentMethod typePaymentMethod;
    int type;
    UIImage *imgFront;
    UIImage *imgBehind;
    UIImagePickerController *imagePickerController;
}

@end

@implementation AddOrderViewController
@synthesize viewMenu, viewContent, tbContent, btnPayment, chooseProfileView, tbConfirmProfile, paymentResultView;
@synthesize hMenu, hTbConfirm, padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký tên miền";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"AddOrderViewController"];
    
    type = 1;
    [self setupUIForView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [viewMenu removeFromSuperview];
    viewMenu = nil;
    
    [chooseProfileView removeFromSuperview];
    chooseProfileView = nil;
    
    [paymentResultView removeFromSuperview];
    paymentResultView = nil;
}

- (void)setupUIForView {
    padding = 15.0;
    hMenu = 60.0;
    hCell = 115.0;  //  10 + 35 + 60 + 10
    hSmallCell = 55; //  10 + 35 + 10;
    
    [self addStepMenuForView];
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    float hBTN = 45.0;
    [btnPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnPayment.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnPayment.backgroundColor = BLUE_COLOR;
    btnPayment.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewContent).offset(self.padding);
        make.bottom.right.equalTo(self.viewContent).offset(-self.padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent registerNib:[UINib nibWithNibName:@"DomainProfileCell" bundle:nil] forCellReuseIdentifier:@"DomainProfileCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.viewContent);
        make.bottom.equalTo(self.btnPayment.mas_top).offset(-self.padding);
    }];
    
    [self addListProfileForChoose];
    
    //  setup for confỉm profile table view
    hTbConfirm = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + hMenu);
    
    [self setupTableConfirmProfileForView];
    [self setupChoosePaymentMethodView];
}

- (float)getHeightTableView {
    return hCell + hSmallCell;
}

- (void)addStepMenuForView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PaymentStepView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PaymentStepView class]]) {
            viewMenu = (PaymentStepView *) currentObject;
            break;
        }
    }
    [self.view addSubview: viewMenu];
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hMenu);
    }];
    [viewMenu setupUIForView];
    [viewMenu updateUIForStep: ePaymentProfile];
}

- (void)setupTableConfirmProfileForView {
    tbConfirmProfile.hidden = TRUE;
    [tbConfirmProfile registerNib:[UINib nibWithNibName:@"ProfileDetailCell" bundle:nil] forCellReuseIdentifier:@"ProfileDetailCell"];
    tbConfirmProfile.delegate = self;
    tbConfirmProfile.dataSource = self;
    [tbConfirmProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        /*
         make.left.right.equalTo(self.view);
         make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
         make.height.mas_equalTo(self.hTbConfirm);   */
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    float hFooter = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + hMenu + hTbConfirm);
    
    UIView *footerView;
    if (hFooter < 75) {
        hFooter = 75.0;
    }
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    footerView.backgroundColor = UIColor.whiteColor;
    
    UIButton *btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(padding, footerView.frame.size.height-padding-45.0, footerView.frame.size.width-2*padding, 45.0)];
    [btnConfirm setTitle:@"Thông tin đúng, thanh toán ngay" forState:UIControlStateNormal];
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirm.layer.cornerRadius = 45.0/2;
    btnConfirm.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [footerView addSubview: btnConfirm];
    [btnConfirm addTarget:self
                   action:@selector(btnConfirmProfilePress)
         forControlEvents:UIControlEventTouchUpInside];
    tbConfirmProfile.tableFooterView = footerView;
}

- (void)btnConfirmProfilePress {
    [viewMenu updateUIForStep: ePaymentCharge];
    viewContent.hidden = tbConfirmProfile.hidden = TRUE;
    
    [self showPopupConfirmForPayment];
}

- (void)showPopupConfirmForPayment {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:@"Bạn chắc chắn muốn gia hạn tên miền này?"];
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:16.0] range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:@"Đóng" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSLog(@"Đóng");
                                                     }];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnRenew = [UIAlertAction actionWithTitle:@"Thanh toán" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         [ProgressHUD backgroundColor: ProgressHUD_BG];
                                                         [ProgressHUD show:@"Đang xử lý..." Interaction:NO];
                                                         
                                                         [[WebServiceUtils getInstance] renewOrderForDomain:self.domain contactId:self.cus_id ord_id:self.ord_id years:self.yearsForRenew];
                                                     }];
    [btnRenew setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnClose];
    [alertVC addAction:btnRenew];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupChoosePaymentMethodView {
    
}

- (void)btnConfirmPaymentPress {
    [viewMenu updateUIForStep: ePaymentCharge];
    
    viewContent.hidden = tbConfirmProfile.hidden = TRUE;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - SelectProfileViewDelegate

- (void)showProfileList: (BOOL)show withTag: (int)tag {
    
    if ([AppDelegate sharedInstance].needReloadListProfile) {
        [chooseProfileView getListProfilesForAccount];
        [AppDelegate sharedInstance].needReloadListProfile = FALSE;
    }
    chooseProfileView.cartIndexItemSelect = tag;
    
    if (show) {
        NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: tag];
        NSDictionary *profile = [domainInfo objectForKey:@"profile"];
        if (profile != nil) {
            NSString *cusId = [profile objectForKey:@"cus_id"];
            chooseProfileView.cusIdSelected = cusId;
        }else{
            chooseProfileView.cusIdSelected = @"";
        }
        
        self.navigationController.navigationBarHidden = show;
        [chooseProfileView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            [self.chooseProfileView.tbProfile reloadData];
        }];
        
    }else{
        self.navigationController.navigationBarHidden = show;
        [chooseProfileView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
            make.left.bottom.right.equalTo(self.view);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)chooseProfile: (UIButton *)sender {
    int tag = (int)sender.tag;
    if (chooseProfileView.frame.origin.y == 0) {
        [self showProfileList: FALSE withTag: -1];
    }else{
        [self showProfileList: TRUE withTag: tag];
    }
}

- (void)addListProfileForChoose {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"SelectProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[SelectProfileView class]]) {
            chooseProfileView = (SelectProfileView *) currentObject;
            break;
        }
    }
    chooseProfileView.delegate = self;
    chooseProfileView.hHeader = [AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav;
    [self.view addSubview: chooseProfileView];
    [chooseProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.bottom.right.equalTo(self.view);
    }];
    [chooseProfileView setupUIForView];
}

- (void)onIconCloseClicked {
    [self showProfileList: FALSE withTag: -1];
}

-(void)onSelectedProfileForDomain {
    [self onIconCloseClicked];
    [tbContent reloadData];
}

-(void)onCreatNewProfileClicked {
    AddProfileViewController *addProfileVC = [[AddProfileViewController alloc] initWithNibName:@"AddProfileViewController" bundle:nil];
    [self.navigationController pushViewController:addProfileVC animated:TRUE];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[CartModel getInstance] countItemInCart];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
    NSString *domain = [domainInfo objectForKey:@"domain"];
    
    if (tableView == tbContent) {
        DomainProfileCell *cell = (DomainProfileCell *)[tableView dequeueReusableCellWithIdentifier:@"DomainProfileCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbDomain.text = domain;
        
        NSDictionary *profile = [domainInfo objectForKey:@"profile"];
        if (profile == nil) {
            [cell.btnChooseProfile setTitle:@"Chọn hồ sơ" forState:UIControlStateNormal];
            cell.btnChooseProfile.backgroundColor = BLUE_COLOR;
            
            [cell showProfileView:FALSE withBusiness:FALSE];
        }else{
            [cell.btnChooseProfile setTitle:@"Đã chọn" forState:UIControlStateNormal];
            cell.btnChooseProfile.backgroundColor = ORANGE_COLOR;
            
            NSString *type = [profile objectForKey:@"cus_own_type"];
            if ([type isEqualToString:@"0"]) {
                [cell showProfileView: TRUE withBusiness: FALSE];
            }else{
                [cell showProfileView: TRUE withBusiness: TRUE];
            }
            
            [cell showProfileContentWithInfo: profile];
        }
        
        cell.btnChooseProfile.tag = indexPath.row;
        [cell.btnChooseProfile addTarget:self
                                  action:@selector(chooseProfile:)
                        forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else{
        ProfileDetailCell *cell = (ProfileDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileDetailCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbDomain.text = domain;
        
        [cell showProfileDetailWithDomainView];
        
        NSDictionary *profile = [domainInfo objectForKey:@"profile"];
        [cell displayProfileInfo: profile];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == tbContent) {
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
        NSDictionary *profile = [domainInfo objectForKey:@"profile"];
        if (profile == nil) {
            return hSmallCell;
        }else{
            return hCell;
        }
    }else {
        return [self getHeightProfileTableViewCell];
    }
}

- (float)getHeightProfileTableViewCell {
    float hItem = 30.0;
    
    float wPassport = (SCREEN_WIDTH - 3*15.0)/2;
    float hPassport = wPassport * 2/3;
    float hDetailView = 15 + 9 * hItem + hPassport + hItem + 15;
    
    return 40 + hDetailView + 1;
}

- (IBAction)btnPaymentPress:(UIButton *)sender {
    BOOL ready = [[CartModel getInstance] checkAllProfileForCart];
    if (!ready) {
        [self.view makeToast:@"Vui lòng chọn đầy đủ hồ sơ cho tên miền!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [viewMenu updateUIForStep: ePaymentConfirm];
    
    viewContent.hidden = TRUE;
    tbConfirmProfile.hidden = FALSE;
    
    [tbConfirmProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
        //  make.height.mas_equalTo(self.hTbConfirm);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)quitCartView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - Onepay View Delegate
-(void)paymentResultWithInfo:(NSDictionary *)info {
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self.view makeToast:@"Bạn đã hủy bỏ giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(quitCartView) withObject:nil afterDelay:2.0];
            return;
        }
    }
    
    [viewMenu updateUIForStep: ePaymentDone];
    if (paymentResultView == nil) {
        [self addPaymentResultViewForMainView];
    }
}

- (void)addPaymentResultViewForMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PaymentResultView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PaymentResultView class]]) {
            paymentResultView = (PaymentResultView *) currentObject;
            break;
        }
    }
    [self.view addSubview: paymentResultView];
    [paymentResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [paymentResultView setupUIForView];
}

#pragma mark - SelectProfile Delegate
- (void)onPassportBehindPress {
    type = 2;
    
    if ([AppDelegate sharedInstance].editCMND_b == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
    }
}

- (void)onPassportFrontPress {
    type = 1;
    
    if ([AppDelegate sharedInstance].editCMND_a == nil) {
        [self showActionSheetChooseWithRemove: FALSE];
    }else{
        [self showActionSheetChooseWithRemove: TRUE];
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

- (void)removeCurrentPhotos {
    
}

- (void)requestToAccessYourCamera {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
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
@end
