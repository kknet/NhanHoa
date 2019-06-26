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
@synthesize viewInfo, imgBackground, imgWallet, btnWallet, lbTitle, lbMoney, lbDesc, lbNoti, btn500K, btn1000K, btn1500K, tfMoney, btnWithdrawal, withdrawMoney;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Rút tiền thưởng";
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeLogContent:@"WithdrawalBonusAccountViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
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
        lbMoney.text = [NSString stringWithFormat:@"%@VNĐ", points];
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
    float hInfo = 140.0;
    float padding = 15.0;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
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
    btnWallet.backgroundColor = GREEN_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = GREEN_COLOR;
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnWallet.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.bottom.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
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
    
    lbDesc.text = @"Nhập số tiền muốn rút";
    lbDesc.textColor = TITLE_COLOR;
    lbDesc.font = [AppDelegate sharedInstance].fontMedium;
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(35.0);
    }];
    
    lbNoti.textColor = UIColor.grayColor;
    lbNoti.numberOfLines = 3;
    lbNoti.font = [AppDelegate sharedInstance].fontDesc;
    [lbNoti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDesc.mas_bottom);
        make.left.right.equalTo(self.lbDesc);
        make.height.mas_equalTo(50.0);
    }];
    
    unselectedColor = [UIColor colorWithRed:(236/255.0) green:(239/255.0) blue:(244/255.0) alpha:1.0];
    
    float wButton = (SCREEN_WIDTH - 3*padding)/3;
    btn1000K.titleLabel.font = [AppDelegate sharedInstance].fontDesc;
    btn1000K.backgroundColor = unselectedColor;
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    btn1000K.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [btn1000K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.lbNoti.mas_bottom).offset(10.0);
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
        make.right.equalTo(self.btn1000K.mas_left).offset(-padding);
    }];
    
    btn1500K.titleLabel.font = btn1000K.titleLabel.font;
    btn1500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn1500K.backgroundColor = unselectedColor;
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btn1000K);
        make.left.equalTo(self.btn1000K.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfMoney borderColor:BORDER_COLOR];
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
