//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "DomainProfileCell.h"
#import "ProfileDetailCell.h"
#import "PaymentMethodCell.h"
#import "CartModel.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource, SelectProfileViewDelegate, OnepayPaymentViewDelegate>{
    float hCell;
    float hSmallCell;
    PaymentMethod typePaymentMethod;
}

@end

@implementation PaymentViewController
@synthesize viewMenu, viewContent, tbContent, btnPayment, chooseProfileView, tbConfirmProfile, onepayView, paymentResultView;
@synthesize hMenu, hTbConfirm, padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký tên miền";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setupUIForView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [viewMenu removeFromSuperview];
    viewMenu = nil;
    
    [chooseProfileView removeFromSuperview];
    chooseProfileView = nil;
    
    [onepayView removeFromSuperview];
    onepayView = nil;
    
    [paymentResultView removeFromSuperview];
    paymentResultView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    btnPayment.layer.cornerRadius = hBTN/2;
    btnPayment.backgroundColor = BLUE_COLOR;
    btnPayment.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
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
    hTbConfirm = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + self.navigationController.navigationBar.frame.size.height + hMenu);
    
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
    
    float hFooter = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + self.navigationController.navigationBar.frame.size.height + hMenu + hTbConfirm);
    
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
    onepayView.hidden = FALSE;
    
    [onepayView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [onepayView setupUIForViewWithMenuHeight:hMenu heightNav:self.navigationController.navigationBar.frame.size.height padding:padding];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)setupChoosePaymentMethodView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OnepayPaymentView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[OnepayPaymentView class]]) {
            onepayView = (OnepayPaymentView *) currentObject;
            break;
        }
    }
    [self.view addSubview: onepayView];
    onepayView.delegate = self;
    [onepayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    onepayView.backgroundColor = UIColor.orangeColor;
    [onepayView setupUIForViewWithMenuHeight: hMenu heightNav: self.navigationController.navigationBar.frame.size.height padding: padding];
}

- (void)btnConfirmPaymentPress {
    [viewMenu updateUIForStep: ePaymentCharge];
    
    viewContent.hidden = tbConfirmProfile.hidden = TRUE;
    onepayView.hidden = FALSE;
    
    [onepayView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - SelectProfileViewDelegate

- (void)showProfileList: (BOOL)show withTag: (int)tag {
    chooseProfileView.cartIndexItemSelect = tag;
    
    if (show) {
        self.navigationController.navigationBarHidden = show;
        [chooseProfileView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            
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
    chooseProfileView.hHeader = [AppDelegate sharedInstance].hStatusBar + self.navigationController.navigationBar.frame.size.height;
    [self.view addSubview: chooseProfileView];
    [chooseProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.bottom.right.equalTo(self.view);
    }];
    [chooseProfileView setupUIForView];
    
    float wPassport = (SCREEN_WIDTH-3*15.0)/2;
    float hPassport = wPassport * 2/3;
    float hScrollView = 40 + 9*10.0 + 9*30 + 8*38 + hPassport + 2*15 + 40 + 2*15;
    chooseProfileView.scvAddProfile.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
}

- (void)onIconCloseClicked {
    [self showProfileList: FALSE withTag: -1];
}

-(void)onSelectedProfileForDomain {
    [self onIconCloseClicked];
    [tbContent reloadData];
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
    
    viewContent.hidden = onepayView.hidden = TRUE;
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

@end
