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
#import "OrderResultView.h"

@interface AddOrderViewController ()<UITableViewDelegate, UITableViewDataSource, SelectProfileViewDelegate, WebServiceUtilsDelegate, PaymentStepViewDelegate>
{
    float hCell;
    float hSmallCell;
    NSString *buyingDomain;             //  Tên miền đang được mua
    OrderResultView *orderResultView;
    
    float hMenu;
    float hTbConfirm;
    float padding;
    float hBTN;
}

@end

@implementation AddOrderViewController
@synthesize viewMenu, viewContent, tbContent, btnPayment, chooseProfileView, tbConfirmProfile;
@synthesize paymentResult;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_register_domains;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self setupUIForView];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [viewMenu removeFromSuperview];
    viewMenu = nil;
    
    [chooseProfileView removeFromSuperview];
    chooseProfileView = nil;
}

- (void)setupUIForView {
    hBTN = 45.0;
    padding = 15.0;
    hMenu = 60.0;
    hCell = 115.0;  //  10 + 35 + 60 + 10
    hSmallCell = 55; //  10 + 35 + 10;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hMenu = 85.0;   //  10 + 35.0 + 30.0 + 10;
        padding = 30.0;
        hCell = 175.0;  //  20 + 45 + 90.0 + 20.0;
        hSmallCell = 85.0;  //  20 + 45 + 20;
        hBTN = 55.0;
    }
    [self addStepMenuForView];
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [btnPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnPayment.layer.cornerRadius = hBTN/2;
    btnPayment.layer.borderWidth = 1.0;
    btnPayment.layer.borderColor = BLUE_COLOR.CGColor;
    btnPayment.backgroundColor = BLUE_COLOR;
    btnPayment.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnPayment setTitle:text_continue forState:UIControlStateNormal];
    [btnPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent).offset(padding);
        make.bottom.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent registerNib:[UINib nibWithNibName:@"DomainProfileCell" bundle:nil] forCellReuseIdentifier:@"DomainProfileCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewContent);
        make.bottom.equalTo(btnPayment.mas_top).offset(-padding);
    }];
    
    [self addListProfileForChoose];
    
    //  setup for confỉm profile table view
    hTbConfirm = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + hMenu);
    
    [self setupTableConfirmProfileForView];
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
    viewMenu.delegate = self;
    [self.view addSubview: viewMenu];
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hMenu);
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
        make.top.equalTo(viewMenu.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    float hFooter = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + hMenu + hTbConfirm);
    
    UIView *footerView;
    if (hFooter < 75) {
        hFooter = 75.0;
    }
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    footerView.backgroundColor = UIColor.whiteColor;
    
    //  UIButton *btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(padding, (hFooter - hBTN)/2, footerView.frame.size.width-2*padding, hBTN)];
    UIButton *btnConfirm = [[UIButton alloc] init];
    [btnConfirm setTitle:right_information_pay_now forState:UIControlStateNormal];
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirm.layer.cornerRadius = hBTN/2;
    btnConfirm.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [footerView addSubview: btnConfirm];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).offset(padding);
        make.right.equalTo(footerView).offset(-padding);
        make.centerY.equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
    [btnConfirm addTarget:self
                   action:@selector(btnConfirmProfilePress)
         forControlEvents:UIControlEventTouchUpInside];
    tbConfirmProfile.tableFooterView = footerView;
}

- (void)btnConfirmProfilePress {
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"No network connection. Please check again!"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [viewMenu updateUIForStep: ePaymentCharge];
    viewContent.hidden = tbConfirmProfile.hidden = TRUE;
    
    [self showPopupConfirmForPayment];
}

- (void)showPopupConfirmForPayment {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:confirm_payment_when_register_domains];
    [attrTitle addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         [self startPaymentDomains];
                                                     }];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnAccept = [UIAlertAction actionWithTitle:text_confirm style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         [ProgressHUD backgroundColor: ProgressHUD_BG];
                                                         [ProgressHUD show:text_processing Interaction:FALSE];
                                                         
                                                         self.paymentResult = [[NSMutableDictionary alloc] init];
                                                         
                                                         [self startToAddAllDomainInYourCart];
                                                     }];
    [btnAccept setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnClose];
    [alertVC addAction:btnAccept];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)startToAddAllDomainInYourCart {
    if ([CartModel getInstance].listDomain.count > 0) {
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain firstObject];
        [[CartModel getInstance].listDomain removeObjectAtIndex: 0];
        
        if (domainInfo != nil && [domainInfo isKindOfClass:[NSDictionary class]]) {
            NSString *years = [domainInfo objectForKey:year_for_domain];
            NSString *whoisProtect = [domainInfo objectForKey:whois_protect];
            NSNumber *protect;
            if ([AppUtils isNullOrEmpty: whoisProtect]) {
                protect = [NSNumber numberWithInt: 1];
            }else{
                protect = [NSNumber numberWithInt: [whoisProtect intValue]];
            }
            
            NSString *domainName = [domainInfo objectForKey:@"domain"];
            NSDictionary *profile = [domainInfo objectForKey:profile_cart];
            NSString *profileCusId = [profile objectForKey:@"cus_id"];
            
            buyingDomain = domainName;
            
            if (![AppUtils isNullOrEmpty: profileCusId] && ![AppUtils isNullOrEmpty: domainName] && ![AppUtils isNullOrEmpty: years]) {
                
                [WebServiceUtils getInstance].delegate = self;
                [[WebServiceUtils getInstance] addOrderForDomain:domainName contact_id:profileCusId year:[years intValue] protect: protect];
            }else{
                [paymentResult setObject:@"failed" forKey:buyingDomain];
                [self startToAddAllDomainInYourCart];
            }
        }else{
            [paymentResult setObject:@"failed" forKey:buyingDomain];
            [self startToAddAllDomainInYourCart];
        }
    }else{
        [self finishAddOrderDomains];
    }
}

- (void)finishAddOrderDomains {
    [ProgressHUD dismiss];
    [viewMenu updateUIForStep: ePaymentDone];
    
    if (orderResultView != nil) {
        [orderResultView removeFromSuperview];
        orderResultView = nil;
    }
    
    if (orderResultView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OrderResultView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OrderResultView class]]) {
                orderResultView = (OrderResultView *) currentObject;
                break;
            }
        }
        [self.view addSubview: orderResultView];
        [orderResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.viewMenu.mas_bottom);
            make.left.bottom.right.equalTo(self.view);
        }];
        [orderResultView setupUIForView];
        [orderResultView.btnClose addTarget:self
                                     action:@selector(afterPaymentSuccessfully)
                           forControlEvents:UIControlEventTouchUpInside];
    }
    [orderResultView setContentViewWithInfo: paymentResult];
    
    //  reglogin again
    [self tryToLoginAfterRegisteredDomains];
}

- (void)tryToLoginAfterRegisteredDomains {
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}


- (void)afterPaymentSuccessfully {
    [[AppDelegate sharedInstance] hideCartView];
    [[CartModel getInstance] removeAllDomainFromCart];
    [[AppDelegate sharedInstance] updateShoppingCartCount];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"afterAddOrderSuccessfully" object:nil];
}

- (void)btnConfirmPaymentPress {
    [viewMenu updateUIForStep: ePaymentCharge];
    
    viewContent.hidden = tbConfirmProfile.hidden = TRUE;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    
    float widthScreen = [DeviceUtils getWidthOfScreen];
    [viewMenu mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen);
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
        NSDictionary *profile = [domainInfo objectForKey:profile_cart];
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
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(0);
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
        //  make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(0);
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
        
        NSDictionary *profile = [domainInfo objectForKey:profile_cart];
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
        [cell tryToUpdateUIWithAddress];
        
        NSDictionary *profile = [domainInfo objectForKey:profile_cart];
        [cell displayProfileInfo: profile];
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == tbContent) {
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
        NSDictionary *profile = [domainInfo objectForKey:profile_cart];
        if (profile == nil) {
            return hSmallCell;
        }else{
            return hCell;
        }
    }else {
        return [self getHeightProfileTableViewCell: indexPath];
    }
}

- (float)getHeightProfileTableViewCell: (NSIndexPath *)indexPath {
    NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
    NSDictionary *profile = [domainInfo objectForKey:profile_cart];
    if (profile != nil) {
        NSString *cus_contract_address = [profile objectForKey:@"cus_contract_address"];
        if ([AppUtils isNullOrEmpty: cus_contract_address]) {
            cus_contract_address = [profile objectForKey:@"cus_address"];
        }
        
        float wSmallItem = [AppUtils getSizeWithText:@"Họ tên đầy đủ:" withFont:[AppDelegate sharedInstance].fontRegular].width + 5;
        float hText = [AppUtils getSizeWithText:cus_contract_address withFont:[AppDelegate sharedInstance].fontMediumDesc andMaxWidth:(SCREEN_WIDTH - 2*padding - wSmallItem)].height + 10.0;
        
        float hItem = 30.0;
        float hHeader = 40.0;
        
        if (!IS_IPHONE && !IS_IPOD) {
            hItem = 40.0;
            hHeader = 60.0;
        }
        
        if (hText < hItem) {
            hText = hItem;
        }
        
        float wPassport = (SCREEN_WIDTH - 3*15.0)/2;
        float hPassport = wPassport * 2/3;
        float hDetailView = 15 + 7 * hItem + hText + hPassport + hItem + 15;
        
        return hHeader + hDetailView + 1;
    }
    return 0;
}

- (IBAction)btnPaymentPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startPaymentDomains) withObject:nil afterDelay:0.05];
}

- (void)startPaymentDomains {
    btnPayment.backgroundColor = BLUE_COLOR;
    [btnPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    BOOL ready = [[CartModel getInstance] checkAllProfileForCart];
    if (!ready) {
        [self.view makeToast:@"Vui lòng chọn đầy đủ hồ sơ cho tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [viewMenu updateUIForStep: ePaymentConfirm];
    viewContent.hidden = TRUE;
    tbConfirmProfile.hidden = FALSE;
    [tbConfirmProfile reloadData];
}

- (void)quitCartView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToAddNewOrderWithError:(NSString *)error {
    if (![AppUtils isNullOrEmpty: buyingDomain]) {
        [paymentResult setObject:@"failed" forKey:buyingDomain];
    }
    [self startToAddAllDomainInYourCart];
}

-(void)addNewOrderSuccessfulWithData:(NSDictionary *)data {
    if (![AppUtils isNullOrEmpty: buyingDomain]) {
        [paymentResult setObject:@"success" forKey:buyingDomain];
    }
    [self startToAddAllDomainInYourCart];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    
}

-(void)failedToLoginWithError:(NSString *)error {
    
}

#pragma mark - PaymentStepView Delegate
-(void)pressOnMenuButton:(PaymentStep)menu {
    if (menu == ePaymentProfile) {
        [viewMenu updateUIForStep: ePaymentProfile];
        viewContent.hidden = FALSE;
        tbConfirmProfile.hidden = TRUE;
        
    }else if (menu == ePaymentConfirm) {
        //  check all domains had profile in cart
        BOOL ready = [[CartModel getInstance] checkAllProfileForCart];
        if (!ready) {
            [self.view makeToast:@"Vui lòng chọn đầy đủ hồ sơ cho tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }else{
            [viewMenu updateUIForStep: ePaymentConfirm];
            viewContent.hidden = TRUE;
            tbConfirmProfile.hidden = FALSE;
            [tbConfirmProfile reloadData];
        }
    }else if (menu == ePaymentCharge) {
        if (!tbConfirmProfile.hidden) {
            [self btnConfirmProfilePress];
        }
    }
}

@end
