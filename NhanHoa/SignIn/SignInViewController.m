//
//  SignInViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SignInViewController.h"
#import "AppTabbarViewController.h"
#import "RegisterAccountViewController.h"
#import "OTPConfirmView.h"

@interface SignInViewController ()<UITextFieldDelegate, WebServiceUtilsDelegate, UIAlertViewDelegate, OTPConfirmViewDelegate>{
    UIColor *signInColor;
}
@end

@implementation SignInViewController
@synthesize viewTop, imgLogo, lbCompany, lbToBeTheBest, tfAccount, tfPassword, icShowPass, btnForgotPass, btnSignIn, viewBottom, lbNotAccount, btnRegister, scvContent, icClearAcc;
@synthesize hHeader, padding, activeAccView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [WriteLogsUtils writeForGoToScreen: @"SignInViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:login_state];
    if (loginState != nil && ![loginState isEqualToString:@"NO"] && ![AppUtils isNullOrEmpty: USERNAME] && ![AppUtils isNullOrEmpty:PASSWORD])
    {
        [self autoSignInWithSavedInformation];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:login_state];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    
    //  fill username
    if ([AppDelegate sharedInstance].registerAccSuccess) {
        if (![AppUtils isNullOrEmpty: [AppDelegate sharedInstance].registerAccount]) {
            tfAccount.text = [AppDelegate sharedInstance].registerAccount;
        }
        [AppDelegate sharedInstance].registerAccSuccess = FALSE;
        [AppDelegate sharedInstance].registerAccount = @"";
    }else{
        if (![AppUtils isNullOrEmpty: USERNAME]) {
            tfAccount.text = USERNAME;
        }
    }
    
    icClearAcc.hidden = (tfAccount.text.length > 0)? FALSE : TRUE;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)icClearAccClick:(UIButton *)sender {
    tfAccount.text = @"";
    sender.hidden = TRUE;
}

- (IBAction)icShowPassClicked:(UIButton *)sender {
    if (tfPassword.isSecureTextEntry) {
        tfPassword.secureTextEntry = FALSE;
        [icShowPass setImage:[UIImage imageNamed:@"hide_pass_white"] forState:UIControlStateNormal];
    }else{
        tfPassword.secureTextEntry = TRUE;
        [icShowPass setImage:[UIImage imageNamed:@"show_pass_white"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnForgotPassPress:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link_forgot_password]];
}

- (IBAction)btnSignInPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:signInColor forState:UIControlStateNormal];
    [self performSelector:@selector(startSignIn) withObject:nil afterDelay:0.1];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)startSignIn {
    btnSignIn.backgroundColor = signInColor;
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfAccount.text] || [AppUtils isNullOrEmpty: tfPassword.text]) {
        [self.view makeToast:@"Vui lòng nhập đầy đủ thông tin!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang đăng nhập..." Interaction:NO];
    
    NSString *password = [AppUtils getMD5StringOfString:tfPassword.text];
    [[WebServiceUtils getInstance] loginWithUsername:tfAccount.text password:password];
}

- (void)autoSignInWithSavedInformation {
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang đăng nhập..." Interaction:NO];
    
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__]];
    
    RegisterAccountViewController *registerVC = [[RegisterAccountViewController alloc] initWithNibName:@"RegisterAccountViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (void)closeKeyboard {
    [self.view endEditing: YES];
}

- (void)setupUIForView {
    hHeader = SCREEN_HEIGHT * 7/9;
    padding = 30.0;
    signInColor = [UIColor colorWithRed:(240/255.0) green:(138/255.0) blue:(38/255.0) alpha:1.0];
    
    //  view top
    viewTop.backgroundColor = UIColor.clearColor;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.hHeader);
    }];
    
    float hTextfield = 44.0;
    float originY = (hHeader/2 - (hTextfield + 15 + hTextfield + hTextfield))/2;
    
    //
    float paddingTop = (hHeader/2 - (100 + 15.0 + 30.0 + 25.0))/2;
    imgLogo.layer.cornerRadius = 15.0;
    imgLogo.clipsToBounds = TRUE;
    [imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent).offset(paddingTop + 30.0);
        make.centerX.equalTo(self.scvContent.mas_centerX);
        make.width.height.mas_equalTo(100.0);
    }];
    
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgLogo.mas_bottom).offset(15.0);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(30.0);
    }];
    
    [lbToBeTheBest mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCompany.mas_bottom);
        make.left.right.equalTo(self.lbCompany);
        make.height.mas_equalTo(25.0);
    }];
    
    float hCurve = 30.0;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, hHeader-hCurve)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, hHeader-hCurve) controlPoint:CGPointMake(SCREEN_WIDTH/2, hHeader+hCurve)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    //  shapeLayer.fillColor = UIColor.clearColor.CGColor;

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, hHeader+2*hCurve);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(18/255.0) green:(101/255.0) blue:(203/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0].CGColor];

    [viewTop.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
    
    //  For bottom view
    
    viewBottom.backgroundColor = UIColor.clearColor;
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewTop.mas_bottom).offset(-hCurve);
        make.bottom.left.right.equalTo(self.view);
    }];
    
    CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
    bottomGradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-hHeader+2*hCurve);
    bottomGradientLayer.startPoint = CGPointMake(0, 0);
    bottomGradientLayer.endPoint = CGPointMake(1, 1);
    bottomGradientLayer.colors = @[(id)[UIColor colorWithRed:(14/255.0) green:(91/255.0) blue:(181/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(10/255.0) green:(87/255.0) blue:(179/255.0) alpha:1.0].CGColor];
    
    [viewBottom.layer insertSublayer:bottomGradientLayer atIndex:0];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  sign in button
    float hButton = 48.0;
    btnSignIn.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSignIn.layer.borderColor = signInColor.CGColor;
    btnSignIn.layer.cornerRadius = hButton/2;
    btnSignIn.layer.borderWidth = 1.0;
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent).offset(self.hHeader-hButton/2-20.0);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(hButton);
    }];
    
    btnForgotPass.backgroundColor = UIColor.clearColor;
    [btnForgotPass setTitleColor:BORDER_COLOR forState:UIControlStateNormal];
    [btnForgotPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnSignIn);
        make.bottom.equalTo(self.btnSignIn.mas_top).offset(-10.0);
        make.height.mas_equalTo(hTextfield);
    }];
    
    tfPassword.textColor = tfPassword.tintColor = BORDER_COLOR;
    tfPassword.secureTextEntry = YES;
    tfPassword.layer.cornerRadius = hTextfield/2;
    tfPassword.backgroundColor = [UIColor colorWithRed:(40/255.0) green:(123/255.0) blue:(229/255.0) alpha:1.0];
    tfPassword.font = [UIFont fontWithName:RobotoRegular size:17.0];
    [tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnForgotPass);
        make.bottom.equalTo(self.btnForgotPass.mas_top).offset(-10.0);
        make.height.mas_equalTo(hTextfield);
    }];
    [AppUtils setPlaceholder:@"Mật khẩu" textfield:tfPassword color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    
    tfPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassword.leftViewMode = UITextFieldViewModeAlways;
    
    tfPassword.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassword.rightViewMode = UITextFieldViewModeAlways;
    
    tfPassword.delegate = self;
    tfPassword.returnKeyType = UIReturnKeyDone;
    
    icShowPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfPassword.mas_right);
        make.top.bottom.equalTo(self.tfPassword);
        make.width.mas_equalTo(hTextfield);
    }];
    
    //  Account textfield
    [tfAccount addTarget:self
                  action:@selector(textfieldAccountChanged:)
        forControlEvents:UIControlEventEditingChanged];
    
    tfAccount.textColor = tfAccount.tintColor = BORDER_COLOR;
    tfAccount.layer.cornerRadius = hTextfield/2;
    tfAccount.backgroundColor = tfPassword.backgroundColor;
    tfAccount.font = tfPassword.font;
    [tfAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfPassword);
        make.bottom.equalTo(self.tfPassword.mas_top).offset(-15.0);
        make.height.mas_equalTo(hTextfield);
    }];
    [AppUtils setPlaceholder:@"Tài khoản đăng nhập" textfield:tfAccount color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    
    tfAccount.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAccount.leftViewMode = UITextFieldViewModeAlways;
    
    tfAccount.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfAccount.rightViewMode = UITextFieldViewModeAlways;
    
    tfAccount.delegate = self;
    tfAccount.returnKeyType = UIReturnKeyNext;
    tfAccount.keyboardType = UIKeyboardTypeEmailAddress;
    
    icClearAcc.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    [icClearAcc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfAccount);
        make.width.mas_equalTo(hTextfield);
    }];
    
    //  footer
    CGSize sizeText = [AppUtils getSizeWithText:@"Bạn chưa có tài khoản?" withFont:[UIFont fontWithName:RobotoRegular size:17.0]];
    CGSize sizeText2 = [AppUtils getSizeWithText:@"ĐĂNG KÝ" withFont:[UIFont fontWithName:RobotoRegular size:17.0]];
    
    float hFooter = (SCREEN_HEIGHT - hHeader - hCurve/2);
    
    float originX = (SCREEN_WIDTH - (sizeText.width + 10.0 + sizeText2.width))/2;
    originY = (hFooter - 30.0)/2;
    
    lbNotAccount.font = [UIFont fontWithName:RobotoRegular size:17.0];
    lbNotAccount.textColor = BORDER_COLOR;
    [lbNotAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnSignIn.mas_bottom).offset(originY);
        make.height.mas_equalTo(30.0);
        make.left.equalTo(self.scvContent).offset(originX);
        make.width.mas_equalTo(sizeText.width);
    }];
    
    btnRegister.titleLabel.font = [UIFont fontWithName:RobotoRegular size:17.0];
    [btnRegister setTitleColor:signInColor forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbNotAccount);
        make.left.equalTo(self.lbNotAccount.mas_right).offset(10.0);
        make.width.mas_equalTo(sizeText2.width);
    }];
}

- (void)processForLoginSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:login_state];
    if (loginState == nil || [loginState isEqualToString:@"NO"])
    {
        NSString *password = [AppUtils getMD5StringOfString:tfPassword.text];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:login_state];
        [[NSUserDefaults standardUserDefaults] setObject:tfAccount.text forKey:key_login];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:key_password];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)goToHomeScreen {
    AppTabbarViewController *tabbarVC = [[AppTabbarViewController alloc] init];
    [self presentViewController:tabbarVC animated:YES completion:nil];
}

- (void)textfieldAccountChanged: (UITextField *)textfield {
    icClearAcc.hidden = (textfield.text.length > 0)? FALSE : TRUE;
}

- (void)showWarningWhenCurrentVersionNotAccept {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:@"Phiên bản quý khách đang sử dụng đã cũ.\nVui lòng cập nhật phiên bản mới để trải nghiệm tốt hơn."];
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:17.0] range:NSMakeRange(0, attrTitle.string.length)];
    [attrTitle addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:@"Đóng" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSLog(@"Đóng");
                                                     }];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnGoStore = [UIAlertAction actionWithTitle:@"Cập nhật" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           [self checkAndGotoAppStore];
                                                       }];
    [btnGoStore setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnClose];
    [alertVC addAction:btnGoStore];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)checkAndGotoAppStore {
    NSString *linkToAppStore = [self checkNewVersionOnAppStore];
    if (![AppUtils isNullOrEmpty: linkToAppStore]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkToAppStore]];
    }
    [WriteLogsUtils writeLogContent:SFM(@"[%s] linkToAppStore: %@", __FUNCTION__, linkToAppStore)];
}

- (NSString *)checkNewVersionOnAppStore {
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
    if (appID.length > 0) {
        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
        NSData* data = [NSData dataWithContentsOfURL:url];
        
        if (data) {
            NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            if ([lookup[@"resultCount"] integerValue] == 1){
                // app needs to be updated
                return lookup[@"results"][0][@"trackViewUrl"] ? lookup[@"results"][0][@"trackViewUrl"] : @"";
            }
        }
    }
    return @"";
}


#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfAccount) {
        [tfPassword becomeFirstResponder];
        
    }else if (textField == tfPassword) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

#pragma mark - WebServiceUtilDelegate

-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString *errorCode = [(NSDictionary *)error objectForKey:@"errorCode"];
        if ([errorCode isEqualToString:@"005"]) {
            UIAlertView *alv = [[UIAlertView alloc] initWithTitle:nil message:@"Tài khoản của bạn chưa được kích hoạt?" delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:@"Kích hoạt", nil];
            [alv show];
        }else{
            NSString *message = [AppUtils getErrorContentFromData: error];
            [self.view makeToast:message duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    NSString *min_ios_version = [data objectForKey:@"min_ios_version"];
    if (![AppUtils isNullOrEmpty: min_ios_version]) {
        BOOL versionReady = [self checkVersionAppToAcceptLogin: min_ios_version];
        if (!versionReady) {
            [ProgressHUD dismiss];
            [self showWarningWhenCurrentVersionNotAccept];
            
            return;
        }
    }
    
    [self processForLoginSuccessful];
    if (![AppUtils isNullOrEmpty:[AppDelegate sharedInstance].token]) {
        [[WebServiceUtils getInstance] updateTokenWithValue: [AppDelegate sharedInstance].token];
    }else{
        [ProgressHUD dismiss];
        [self goToHomeScreen];
    }
}

- (BOOL)checkVersionAppToAcceptLogin: (NSString *)requireVersion {
    NSArray *requireArr = [requireVersion componentsSeparatedByString:@"."];
    
    NSString *curVersion = [AppUtils getAppVersionWithBuildVersion: FALSE];
    NSArray *currentArr = [curVersion componentsSeparatedByString:@"."];
    
    if (requireArr.count == currentArr.count) {
        for (int i=0; i<currentArr.count; i++) {
            NSString *require = [requireArr objectAtIndex: i];
            NSString *current = [currentArr objectAtIndex: i];
            
            if ([require intValue] > [current intValue]) {
                return FALSE;
                
            }else if ([current intValue] > [require intValue]) {
                return TRUE;
            }
        }
        //  version hiện tại giống version tối thiểu đc yêu cầu
        return TRUE;
        
    }else if (requireArr.count > currentArr.count) {
        for (int i=0; i<currentArr.count; i++) {
            NSString *require = [requireArr objectAtIndex: i];
            NSString *current = [currentArr objectAtIndex: i];
            
            if ([require intValue] > [current intValue]) {
                return FALSE;
                
            }else if ([current intValue] > [require intValue]) {
                return TRUE;
            }
        }
        //  version hiện tại nhỏ hơn version được yêu cầu
        return FALSE;
    }else {
        for (int i=0; i<requireArr.count; i++) {
            NSString *require = [requireArr objectAtIndex: i];
            NSString *current = [currentArr objectAtIndex: i];
            
            if ([require intValue] > [current intValue]) {
                return FALSE;
                
            }else if ([current intValue] > [require intValue]){
                return TRUE;
            }
        }
        //  version hiện tại lớn hơn version được yêu cầu
        return TRUE;
    }
}

-(void)failedToUpdateToken {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    [self goToHomeScreen];
}

-(void)updateTokenSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD dismiss];
    [self goToHomeScreen];
}

#pragma mark - Alertview delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self addViewActiveAccountIfNeed];
    }
}

- (void)addViewActiveAccountIfNeed {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (activeAccView == nil) {
        activeAccView = [[UIView alloc] init];
        [self.view addSubview: activeAccView];
        activeAccView.backgroundColor = UIColor.clearColor;
        [activeAccView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
        
        float hNav = self.navigationController.navigationBar.frame.size.height;
        
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = BLUE_COLOR;
        [activeAccView addSubview: headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.activeAccView);
            make.height.mas_equalTo([AppDelegate sharedInstance].hStatusBar + hNav);
        }];
        
        UIButton *icBack = [[UIButton alloc] init];
        icBack.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
        [icBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [headerView addSubview: icBack];
        [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView).offset([AppDelegate sharedInstance].hStatusBar);
            make.left.equalTo(headerView).offset(-11.0);
            make.bottom.equalTo(headerView);
            make.width.mas_equalTo(hNav);
        }];
        
        UILabel *lbHeader = [[UILabel alloc] init];
        lbHeader.textAlignment = NSTextAlignmentCenter;
        lbHeader.text = @"Kích hoạt tài khoản";
        lbHeader.font = [AppDelegate sharedInstance].fontBTN;
        lbHeader.textColor = UIColor.whiteColor;
        [headerView addSubview: lbHeader];
        [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icBack);
            make.centerX.equalTo(headerView.mas_centerX);
            make.width.mas_equalTo(200.0);
        }];
        
        //  OTP View
        OTPConfirmView *otpView;
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OTPConfirmView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OTPConfirmView class]]) {
                otpView = (OTPConfirmView *) currentObject;
                break;
            }
        }
        otpView.delegate = self;
        [activeAccView addSubview: otpView];
        
        [otpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headerView.mas_bottom);
            make.left.right.bottom.equalTo(self.activeAccView);
        }];
        [otpView setupUIForView];
    }
    
    if (![AppUtils isNullOrEmpty: tfAccount.text] && ![AppUtils isNullOrEmpty: tfPassword.text]) {
        [WriteLogsUtils writeLogContent:SFM(@"Resend OTP with username = %@, password = %@", tfAccount.text, [AppUtils getMD5StringOfString: tfPassword.text])];
        
        [[WebServiceUtils getInstance] resendOTPForUsername:tfAccount.text password:[AppUtils getMD5StringOfString: tfPassword.text]];
    }
}

- (void)afterActivedAccount {
    if (activeAccView != nil) {
        [activeAccView removeFromSuperview];
        activeAccView = nil;
    }
}

#pragma mark - OTPConfirmViewDelegate
-(void)onResendOTPPress {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (![AppUtils isNullOrEmpty: tfAccount.text] && ![AppUtils isNullOrEmpty: tfPassword.text]) {
        [[WebServiceUtils getInstance] resendOTPForUsername:tfAccount.text password:[AppUtils getMD5StringOfString: tfPassword.text]];
    }
}

-(void)confirmOTPWithCode:(NSString *)code {
    if (![AppUtils isNullOrEmpty: tfAccount.text] && ![AppUtils isNullOrEmpty: tfPassword.text]) {
        [[WebServiceUtils getInstance] checkOTPForUsername:tfAccount.text password:[AppUtils getMD5StringOfString: tfPassword.text] andOTPCode:code];
        
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:@"Tài khoản đang được kích hoạt..." Interaction:NO];
    }
}

#pragma mark - WebServiceUtil Delegate

-(void)failedToResendOTPWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [activeAccView makeToast:content duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)resendOTPSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    if (activeAccView != nil) {
        [activeAccView makeToast:@"Mã OTP đã được gửi đến số điện thoại của bạn" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
}

-(void)failedToCheckOTPWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [activeAccView makeToast:content duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)checkOTPSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"Tài khoản của bạn đã được kích hoạt thành công" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(afterActivedAccount) withObject:nil afterDelay:2.0];
}

@end
