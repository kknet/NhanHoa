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
#import "WebServices.h"
#import <CommonCrypto/CommonDigest.h>

@interface SignInViewController ()<WebServicesDelegate, UITextFieldDelegate>{
    UIColor *signInColor;
    WebServices *webService;
}
@end

@implementation NSString (MD5)
- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (int)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

@implementation SignInViewController
@synthesize viewTop, imgLogo, lbCompany, lbToBeTheBest, tfAccount, tfPassword, icShowPass, btnForgotPass, btnSignIn, viewBottom, lbNotAccount, btnRegister, scvContent;
@synthesize hHeader, padding;

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
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
    }
    webService.delegate = self;
    
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:login_state];
    if (loginState != nil && ![loginState isEqualToString:@"NO"] && ![AppUtils isNullOrEmpty: USERNAME] && ![AppUtils isNullOrEmpty:PASSWORD])
    {
        [self autoSignInWithSavedInformation];
    }else{
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    webService = nil;
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)autoSignInWithSavedInformation {
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [ProgressHUD show:@"Đang đăng nhập..." Interaction:NO];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [webService callWebServiceWithLink:login_func withParams:jsonDict];
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
    
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [ProgressHUD show:@"Đang đăng nhập..." Interaction:NO];
    
    NSString *password = [[tfPassword.text MD5String] lowercaseString];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:tfAccount.text forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    
    [webService callWebServiceWithLink:login_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
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
    
    tfPassword.textColor = BORDER_COLOR;
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
    tfAccount.textColor = BORDER_COLOR;
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
    
    tfAccount.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAccount.rightViewMode = UITextFieldViewModeAlways;
    
    tfAccount.delegate = self;
    tfAccount.returnKeyType = UIReturnKeyNext;
    tfAccount.keyboardType = UIKeyboardTypeEmailAddress;
    
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
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:login_state];
    if (loginState == nil || [loginState isEqualToString:@"NO"])
    {
        NSString *password = [[tfPassword.text MD5String] lowercaseString];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:login_state];
        [[NSUserDefaults standardUserDefaults] setObject:tfAccount.text forKey:key_login];
        [[NSUserDefaults standardUserDefaults] setObject:password forKey:key_password];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
        
    AppTabbarViewController *tabbarVC = [[AppTabbarViewController alloc] init];
    [self presentViewController:tabbarVC animated:YES completion:nil];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString:login_func]) {
        [ProgressHUD dismiss];
        
        if (![AppUtils checkNetworkAvailable]) {
            [self.view makeToast:no_internet duration:2.0 position:CSToastPositionTop style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString:login_func]) {
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
            [self processForLoginSuccessful];
        }
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString: login_func]) {
        [ProgressHUD dismiss];
        
        if (responeCode != 200) {
            [self.view makeToast:@"Thông tin đăng nhập không chính xác!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
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

@end
