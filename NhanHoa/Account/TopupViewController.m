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

@synthesize viewInfo, imgWallet, btnWallet, imgBackground, lbTitle, lbMoney, lbDesc, btn500K, btn1000K, btn1500K, btnTopup, tfMoney;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Nạp tiền vào ví";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"TopupViewController"];
    
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
        [WriteLogsUtils writeLogContent:SFM(@"[%s] clear hash_key", __FUNCTION__)];
        
        [AppDelegate sharedInstance].hashKey = @"";
    }
}

- (IBAction)btn500KPress:(UIButton *)sender {
    topupMoney = 500000;
    tfMoney.text = @"";
    
    sender.backgroundColor = ORANGE_COLOR;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btn1000K.backgroundColor = btn1500K.backgroundColor = unselectedColor;
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
}

- (IBAction)btn1000KPress:(UIButton *)sender {
    topupMoney = 1000000;
    tfMoney.text = @"";
    
    sender.backgroundColor = ORANGE_COLOR;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btn500K.backgroundColor = btn1500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
}

- (IBAction)btn1500kPress:(UIButton *)sender {
    topupMoney = 1500000;
    tfMoney.text = @"";
    
    sender.backgroundColor = ORANGE_COLOR;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btn500K.backgroundColor = btn1000K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
}

- (IBAction)btnTopupPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startTopupMoney) withObject:nil afterDelay:0.05];
}

- (void)startTopupMoney{
    btnTopup.backgroundColor = BLUE_COLOR;
    [btnTopup setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    //  check topup money
    NSString *strMoney = tfMoney.text;
    strMoney = [strMoney stringByReplacingOccurrencesOfString:@"." withString:@""];
    strMoney = [strMoney stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    if (![AppUtils checkValidCurrency: strMoney]) {
        [self.view makeToast:@"Số tiền bạn muốn nạp không đúng định dạng. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    if (![AppUtils isNullOrEmpty: strMoney] && ![strMoney isEqualToString:@"0"]) {
        topupMoney = (long)[strMoney longLongValue];
    }
    
    if (topupMoney == 0) {
        [self.view makeToast:@"Vui lòng chọn hoặc nhập số tiền bạn muốn nạp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    if (topupMoney < MIN_MONEY_TOPUP) {
        NSString *strMinTopup = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%d", MIN_MONEY_TOPUP]];
        [self.view makeToast:[NSString stringWithFormat:@"Số tiền tối thiểu để nạp là %@VNĐ", strMinTopup] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    int curUnixTime = (int)[[NSDate date] timeIntervalSince1970];
    NSString *total = [NSString stringWithFormat:@"%@%d", PASSWORD, curUnixTime];
    [AppDelegate sharedInstance].hashKey = [AppUtils getMD5StringOfString: total];
    
    [self goToPaymentView];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float hInfo = 140.0;
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnScreen.delegate = self;
    [self.view addGestureRecognizer: tapOnScreen];
    
    //  view info
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hInfo);
    }];
    
    imgWallet.hidden = TRUE;
    imgWallet.layer.cornerRadius = 50.0/2;
    imgWallet.clipsToBounds = TRUE;
    [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    btnWallet.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    btnWallet.layer.cornerRadius = 50.0/2;
    btnWallet.layer.borderWidth = 1.0;
    btnWallet.layer.borderColor = UIColor.whiteColor.CGColor;
    btnWallet.backgroundColor = BLUE_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = BLUE_COLOR;
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnWallet.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.bottom.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontRegular;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgBackground.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
        make.height.mas_equalTo(25.0);
    }];
    
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:22.0];
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    //
    float hItem = 45.0;
    
    lbDesc.font = [AppDelegate sharedInstance].fontMedium;
    lbDesc.textColor = TITLE_COLOR;
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(35.0);
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
        make.top.equalTo(self.lbDesc.mas_bottom);
        make.width.mas_equalTo(wButton);
        make.height.mas_equalTo(hItem);
    }];
    
    btn500K.titleLabel.font = btn1000K.titleLabel.font;
    btn500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btn1000K);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.btn1000K.mas_left).offset(-5.0);
    }];
    
    btn1500K.titleLabel.font = btn1000K.titleLabel.font;
    btn1500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn1500K.backgroundColor = unselectedColor;
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btn1000K);
        make.left.equalTo(self.btn1000K.mas_right).offset(5.0);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    tfMoney.layer.borderWidth = 1.0;
    tfMoney.layer.borderColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0].CGColor;
    tfMoney.layer.cornerRadius = 5.0;
    
    tfMoney.keyboardType = UIKeyboardTypeNumberPad;
    tfMoney.textColor = TITLE_COLOR;
    tfMoney.font = [AppDelegate sharedInstance].fontRegular;
    [tfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1000K.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
    [tfMoney addTarget:self
                action:@selector(textfieldMoneyChanged:)
      forControlEvents:UIControlEventEditingChanged];
    
    UILabel *lbCurrency = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, hItem)];
    lbCurrency.clipsToBounds = TRUE;
    lbCurrency.backgroundColor = unselectedColor;
    lbCurrency.text = @"VNĐ";
    lbCurrency.textAlignment = NSTextAlignmentCenter;
    lbCurrency.font = [UIFont fontWithName:RobotoMedium size:14.0];
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
        make.bottom.equalTo(self.view).offset(-padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
}

- (void)textfieldMoneyChanged:(UITextField *)textField {
    btn500K.backgroundColor = btn1000K.backgroundColor = btn1500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    
    NSString *cleanValue = [[textField.text componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSString *result = [AppUtils convertStringToCurrencyFormat: cleanValue];
    textField.text = result;
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
