//
//  TopupViewController.m
//  NhanHoa
//
//  Created by admin on 5/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "TopupViewController.h"
#import "PaymentViewController.h"
#import "AccountModel.h"

@interface TopupViewController ()<WebServiceUtilsDelegate>{
    UIColor *unselectedColor;
    long topupMoney;
}

@end

@implementation TopupViewController

@synthesize viewInfo, btnWallet, imgBackground, lbTitle, lbMoney, lbDesc, btn500K, btn1000K, btn1500K, btnTopup, tfMoney;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Nạp tiền vào ví";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"TopupViewController"];
    
    self.navigationController.navigationBarHidden = FALSE;
    
    [self showUserWalletView];
    topupMoney = 0;
    
    
    tfMoney.text = @"";
    
    btn500K.backgroundColor = btn1000K.backgroundColor = btn1500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUserWalletView)
                                                 name:@"reloadBalanceInfo" object:nil];
}

- (void)showUserWalletView {
    NSString *totalBalance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: totalBalance]) {
        totalBalance = [AppUtils convertStringToCurrencyFormat: totalBalance];
        lbMoney.text = [NSString stringWithFormat:@"%@VNĐ", totalBalance];
    }else{
        lbMoney.text = @"0VNĐ";
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([self isMovingFromParentViewController]) {
        [AppDelegate sharedInstance].hashKey = @"";
    }
}

- (IBAction)btn500KPress:(UIButton *)sender {
}

- (IBAction)btn1000KPress:(UIButton *)sender {
}

- (IBAction)btn1500kPress:(UIButton *)sender {
}

- (IBAction)btnTopupPress:(UIButton *)sender {
}

- (void)startTopupMoney{
    
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hIconWallet = 50.0;
    float hTitle = 25.0;
    float hMoney = 30.0;
    float hDesc = 35.0;
    float hItem = 45.0;
    
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:22.0];
    btnWallet.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        btnWallet.imageEdgeInsets = UIEdgeInsetsMake(18, 18, 18, 18);
        lbMoney.font = [UIFont fontWithName:RobotoMedium size:28.0];
        padding = 30.0;
        hIconWallet = 70.0;
        hTitle = 30.0;
        hMoney = 40.0;
        hDesc = 60.0;
        hItem = 55.0;
    }
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnScreen.delegate = self;
    [self.view addGestureRecognizer: tapOnScreen];
    
    //  view info
    float hInfo = padding + hIconWallet + 5.0 + hTitle + hMoney + 10.0;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hInfo);
    }];
    
    btnWallet.enabled = FALSE;
    
    btnWallet.layer.cornerRadius = hIconWallet/2;
    btnWallet.layer.borderWidth = 1.0;
    btnWallet.layer.borderColor = UIColor.whiteColor.CGColor;
    btnWallet.backgroundColor = BLUE_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo).offset(padding);
        make.centerX.equalTo(viewInfo.mas_centerX);
        make.width.height.mas_equalTo(hIconWallet);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = BLUE_COLOR;
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWallet.mas_centerY);
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
        make.bottom.equalTo(viewInfo);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontRegular;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWallet.mas_bottom).offset(5.0);
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hMoney);
    }];
    
    //
    lbDesc.font = [AppDelegate sharedInstance].fontMedium;
    lbDesc.textColor = TITLE_COLOR;
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hDesc);
    }];
    
    unselectedColor = [UIColor colorWithRed:(236/255.0) green:(239/255.0) blue:(244/255.0) alpha:1.0];
    
    float wButton = (SCREEN_WIDTH - padding - 2*5.0)/3;
    btn1000K.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    if ([DeviceUtils isScreen320]) {
        btn1000K.titleLabel.font = [AppDelegate sharedInstance].fontDesc;
    }
    
    btn1000K.backgroundColor = unselectedColor;
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    btn1000K.layer.cornerRadius = 6.0;
    [btn1000K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(lbDesc.mas_bottom);
        make.width.mas_equalTo(wButton);
        make.height.mas_equalTo(hItem);
    }];
    
    btn500K.titleLabel.font = btn1000K.titleLabel.font;
    btn500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btn1000K);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(btn1000K.mas_left).offset(-5.0);
    }];
    
    btn1500K.titleLabel.font = btn1000K.titleLabel.font;
    btn1500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn1500K.backgroundColor = unselectedColor;
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btn1000K);
        make.left.equalTo(btn1000K.mas_right).offset(5.0);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    tfMoney.layer.borderWidth = 1.0;
    tfMoney.layer.borderColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0].CGColor;
    tfMoney.layer.cornerRadius = 5.0;
    
    tfMoney.keyboardType = UIKeyboardTypeNumberPad;
    tfMoney.textColor = TITLE_COLOR;
    tfMoney.font = [AppDelegate sharedInstance].fontRegular;
    [tfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1000K.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
    [tfMoney addTarget:self
                action:@selector(textfieldMoneyChanged:)
      forControlEvents:UIControlEventEditingChanged];
    
    UILabel *lbCurrency = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, hItem)];
    lbCurrency.clipsToBounds = TRUE;
    lbCurrency.backgroundColor = unselectedColor;
    lbCurrency.text = @"VNĐ";
    lbCurrency.textAlignment = NSTextAlignmentCenter;
    if (!IS_IPHONE && !IS_IPOD) {
        lbCurrency.font = [UIFont fontWithName:RobotoMedium size:16.0];
    }else{
        lbCurrency.font = [UIFont fontWithName:RobotoMedium size:14.0];
    }
    lbCurrency.textColor = TITLE_COLOR;
    lbCurrency.layer.cornerRadius = tfMoney.layer.cornerRadius;

    tfMoney.rightView = lbCurrency;
    tfMoney.rightViewMode = UITextFieldViewModeAlways;
    
    
    btnTopup.layer.cornerRadius = hItem/2;
    btnTopup.layer.borderWidth = 1.0;
    btnTopup.layer.borderColor = BLUE_COLOR.CGColor;
    btnTopup.backgroundColor = BLUE_COLOR;;
    btnTopup.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-padding-[AppDelegate sharedInstance].safeAreaBottomPadding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
}

- (void)textfieldMoneyChanged:(UITextField *)textField {
}

#pragma mark - PaymentDelegate
-(void)paymentResultWithInfo:(NSDictionary *)info {
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self.view makeToast:@"Bạn đã hủy bỏ giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
    }
    
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UITableViewCell class]] || [touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")])
    {
        return NO;
    }
    return YES;
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToGetHashKeyWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    [self.view makeToast:@"Không thể lấy hash_key. Vui lòng kiểm tra kết nối internet của bạn và thử lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [AppDelegate sharedInstance].hashKey = @"";
}

-(void)getHashKeySuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    [self goToPaymentView];
}

- (void)goToPaymentView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    PaymentViewController *paymentVC = [[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
    paymentVC.money = topupMoney;
    [self.navigationController pushViewController:paymentVC animated:TRUE];
}

@end
