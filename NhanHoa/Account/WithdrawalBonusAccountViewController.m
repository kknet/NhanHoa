//
//  WithdrawalBonusAccountViewController.m
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WithdrawalBonusAccountViewController.h"
#import "AccountModel.h"

@interface WithdrawalBonusAccountViewController ()<WebServiceUtilsDelegate>{
    UIColor *unselectedColor;
}

@end

@implementation WithdrawalBonusAccountViewController
@synthesize viewInfo, imgBackground, btnWallet, lbTitle, lbMoney, lbDesc, lbNoti, btn500K, btn1000K, btn1500K, tfMoney, btnWithdrawal, withdrawMoney;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Rút tiền thưởng";
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeLogContent:@"WithdrawalBonusAccountViewController"];
    
     [self displayCusPoints];
}

- (IBAction)btn500KPress:(UIButton *)sender {
    withdrawMoney = 500000;
    tfMoney.text = @"";
    
    sender.backgroundColor = ORANGE_COLOR;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btn1000K.backgroundColor = btn1500K.backgroundColor = unselectedColor;
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
}

- (IBAction)btn1000KPress:(UIButton *)sender {
    withdrawMoney = 1000000;
    tfMoney.text = @"";
    
    sender.backgroundColor = ORANGE_COLOR;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btn500K.backgroundColor = btn1500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
}

- (IBAction)btn1500KPress:(UIButton *)sender {
    withdrawMoney = 1500000;
    tfMoney.text = @"";
    
    sender.backgroundColor = ORANGE_COLOR;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btn500K.backgroundColor = btn1000K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
}

- (IBAction)btnWithdrawalPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startWithdraw) withObject:nil afterDelay:0.05];
}

- (void)startWithdraw {
    btnWithdrawal.backgroundColor = BLUE_COLOR;
    [btnWithdrawal setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    //  check topup money
    NSString *strMoney = tfMoney.text;
    strMoney = [strMoney stringByReplacingOccurrencesOfString:@"." withString:@""];
    strMoney = [strMoney stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    if (![AppUtils checkValidCurrency: strMoney]) {
        [self.view makeToast:@"Số tiền bạn muốn rút không đúng định dạng. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    if (![AppUtils isNullOrEmpty: strMoney] && ![strMoney isEqualToString:@"0"]) {
        withdrawMoney = (long)[strMoney longLongValue];
    }
    
    if (withdrawMoney == 0) {
        [self.view makeToast:@"Vui lòng chọn hoặc nhập số tiền bạn muốn rút!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    //  get hash_key
    [self showAlertConfirmToWithDraw];
}

- (void)displayCusPoints {
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        points = [AppUtils convertStringToCurrencyFormat: points];
        lbMoney.text = SFM(@"%@VNĐ", points);
    }else{
        lbMoney.text = @"0VNĐ";
    }
}

- (void)showAlertConfirmToWithDraw {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:@"Bạn chắc chắn muốn rút tiền thưởng?"];
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:16.0] range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:@"Đóng" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSLog(@"Đóng");
                                                     }];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnRenew = [UIAlertAction actionWithTitle:@"Đồng ý" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         [ProgressHUD backgroundColor: ProgressHUD_BG];
                                                         [ProgressHUD show:@"Đang xử lý..." Interaction:NO];
                                                         
                                                         [WebServiceUtils getInstance].delegate = self;
                                                         [[WebServiceUtils getInstance] withdrawWithAmout: self.withdrawMoney];
                                                     }];
    [btnRenew setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnClose];
    [alertVC addAction:btnRenew];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hIconWallet = 50.0;
    float hTitle = 25.0;
    float hMoney = 30.0;
    float hBTN = 45.0;
    float hItem = 45.0;
    
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:22.0];
    btnWallet.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        btnWallet.imageEdgeInsets = UIEdgeInsetsMake(18, 18, 18, 18);
        lbMoney.font = [UIFont fontWithName:RobotoMedium size:28.0];
        
        hIconWallet = 70.0;
        hTitle = 30.0;
        hMoney = 40.0;
        hBTN = 55.0;
        padding = 30.0;
        hItem = 55.0;
    }
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
    
    //  view info
    float hInfo = padding + hIconWallet + 5.0 + hTitle + hMoney + 10.0;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hInfo);
    }];
    
    btnWallet.layer.cornerRadius = hIconWallet/2;
    btnWallet.layer.borderWidth = 1.0;
    btnWallet.layer.borderColor = UIColor.whiteColor.CGColor;
    btnWallet.backgroundColor = GREEN_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo).offset(padding);
        make.centerX.equalTo(viewInfo.mas_centerX);
        make.width.height.mas_equalTo(hIconWallet);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = GREEN_COLOR;
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
    lbDesc.text = @"Nhập số tiền muốn rút";
    lbDesc.textColor = TITLE_COLOR;
    lbDesc.font = [AppDelegate sharedInstance].fontMedium;
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(35.0);
    }];
    
    lbNoti.textColor = UIColor.grayColor;
    lbNoti.numberOfLines = 3;
    lbNoti.font = [AppDelegate sharedInstance].fontDesc;
    [lbNoti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDesc.mas_bottom);
        make.left.right.equalTo(lbDesc);
        make.height.mas_equalTo(50.0);
    }];
    
    unselectedColor = [UIColor colorWithRed:(236/255.0) green:(239/255.0) blue:(244/255.0) alpha:1.0];
    
    float wButton = (SCREEN_WIDTH - 3*padding)/3;
    btn1000K.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    if ([DeviceUtils isScreen320]) {
        btn1000K.titleLabel.font = [AppDelegate sharedInstance].fontDesc;
    }
    
    btn1000K.backgroundColor = unselectedColor;
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    btn1000K.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [btn1000K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(lbNoti.mas_bottom).offset(10.0);
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
        make.right.equalTo(btn1000K.mas_left).offset(-padding);
    }];
    
    btn1500K.titleLabel.font = btn1000K.titleLabel.font;
    btn1500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn1500K.backgroundColor = unselectedColor;
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btn1000K);
        make.left.equalTo(btn1000K.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfMoney borderColor:BORDER_COLOR];
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
    
    btnWithdrawal.layer.cornerRadius = hItem/2;
    btnWithdrawal.backgroundColor = BLUE_COLOR;;
    btnWithdrawal.layer.borderColor = BLUE_COLOR.CGColor;
    btnWithdrawal.layer.borderWidth = 1.0;
    btnWithdrawal.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnWithdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
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

- (void)tryToLoginToUpdateInfo {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

#pragma mark - WebServiceUtils Delegate
-(void)failedToWithdrawWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)withdrawSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [self tryToLoginToUpdateInfo];
}

-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    [self.view makeToast:@"Tiền thưởng đã được rút thành công.\nChúng tôi sẽ liên hệ lại với bạn sớm." duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
}

@end
