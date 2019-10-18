//
//  NewSignInViewController.m
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewSignInViewController.h"

@interface NewSignInViewController (){
    AppDelegate *appDelegate;
    float padding;
    UIFont *boldFont;
}
@end

@implementation NewSignInViewController
@synthesize scvContent, lbTop, icClose, imgBanner, tfEmail, imgEmail, imgEmailState, lbBotEmail, imgPassword, tfPassword, icShowPass, lbBotPassword, btnForgotPassword, btnSignIn, btnSignUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    tfPassword.secureTextEntry = TRUE;
    [self showContentWithCurrentLanguage];
    
    [self setupTextfieldForView];
    
    [self registerObservers];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}


- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [scvContent setContentOffset:CGPointMake(0, SCREEN_HEIGHT/4) animated:TRUE];
    }];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showContentWithCurrentLanguage {
    [btnSignIn setTitle:[appDelegate.localization localizedStringForKey:@"Sign In"] forState:UIControlStateNormal];
    
    [btnForgotPassword setTitle:[appDelegate.localization localizedStringForKey:@"Forgot password?"] forState:UIControlStateNormal];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:SFM(@"%@ %@", [appDelegate.localization localizedStringForKey:@"Haven't you had an account yet?"], [appDelegate.localization localizedStringForKey:@"Sign Up"])];
    [attr addAttribute:NSFontAttributeName value:boldFont range:NSMakeRange(0, attr.string.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:GRAY_80 range:NSMakeRange(0, attr.string.length)];
    
    NSRange range = [attr.string rangeOfString:[appDelegate.localization localizedStringForKey:@"Sign Up"]];
    [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
    [btnSignUp setAttributedTitle:attr forState:UIControlStateNormal];
    
    tfEmail.placeholder = [appDelegate.localization localizedStringForKey:@"Enter email"];
    tfPassword.placeholder = [appDelegate.localization localizedStringForKey:@"Enter password"];
}

- (void)setupTextfieldForView {
    if (![AppUtils isNullOrEmpty: tfEmail.text]) {
        imgEmail.image = [UIImage imageNamed:@"ic_email_active"];
        imgEmailState.image = [UIImage imageNamed:@"ic_active"];
        lbBotEmail.backgroundColor = BLUE_COLOR;
    }else{
        imgEmail.image = [UIImage imageNamed:@"ic_email"];
        imgEmailState.image = [UIImage imageNamed:@"ic_unactive"];
        lbBotEmail.backgroundColor = GRAY_200;
    }
    
    if (![AppUtils isNullOrEmpty: tfPassword.text]) {
        imgPassword.image = [UIImage imageNamed:@"ic_password_active"];
        lbBotPassword.backgroundColor = BLUE_COLOR;
    }else{
        imgPassword.image = [UIImage imageNamed:@"ic_password"];
        lbBotPassword.backgroundColor = GRAY_200;
    }
    
    if (![AppUtils isNullOrEmpty: tfEmail.text] && ![AppUtils isNullOrEmpty: tfPassword.text]) {
        btnSignIn.backgroundColor = BLUE_COLOR;
        btnSignIn.enabled = TRUE;
    }else{
        btnSignIn.backgroundColor = GRAY_230;
        btnSignIn.enabled = FALSE;
    }
}


- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    padding = 15.0;
    float hItem = 52.0;
    float hBTN = 55.0;
    float originYEmail = (SCREEN_HEIGHT - hStatus)/2;
    float wPhoto = (SCREEN_WIDTH/2) + 50.0;
    float tfPadding = 25.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:21.0];
    boldFont = [UIFont fontWithName:RobotoBold size:21.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:17.0];
        boldFont = [UIFont fontWithName:RobotoBold size:17.0];
        tfPadding = 15.0;
        hItem = 45.0;
        hBTN = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:19.0];
        boldFont = [UIFont fontWithName:RobotoBold size:19.0];
        tfPadding = 15.0;
        hItem = 45.0;
        hBTN = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        padding = 25.0;
        
        textFont = [UIFont fontWithName:RobotoRegular size:21.0];
        boldFont = [UIFont fontWithName:RobotoBold size:21.0];
        tfPadding = 25.0;
        
        hItem = 50.0;
        hBTN = 52.0;
        
        originYEmail = (SCREEN_HEIGHT - hStatus)/2 + 50.0;
        wPhoto = SCREEN_WIDTH * 2/3;
    }
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus);
        make.left.equalTo(scvContent).offset(padding-7.0);
        make.width.height.mas_equalTo(40.0);
    }];
    
    
    float originY = ((SCREEN_HEIGHT - hStatus)/2 - wPhoto)/2;
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(originY);
        make.centerX.equalTo(lbTop.mas_centerX);
        make.width.height.mas_equalTo(wPhoto);
    }];
    
    //  Email
    float sizeImage = 25.0;
    
    [imgEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTop).offset(padding);
        make.top.equalTo(scvContent).offset((SCREEN_HEIGHT - hStatus)/2);
        make.width.height.mas_equalTo(sizeImage);
    }];
    
    [imgEmailState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbTop).offset(-padding);
        make.centerY.equalTo(imgEmail.mas_centerY);
        make.width.mas_equalTo(sizeImage);
    }];
    
    tfEmail.textColor = tfPassword.textColor = GRAY_80;
    
    tfEmail.text = @"lehoangson.gmail";
    tfEmail.font = boldFont;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgEmail.mas_right).offset(padding);
        make.right.equalTo(imgEmailState.mas_left).offset(-padding);
        make.centerY.equalTo(imgEmail.mas_centerY);
        make.height.mas_equalTo(hItem);
    }];
    [tfEmail addTarget:self
                action:@selector(onTextfieldDidChanged)
      forControlEvents:UIControlEventEditingChanged];
    
    lbBotEmail.backgroundColor = GRAY_200;
    [lbBotEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgEmail);
        make.right.equalTo(imgEmailState);
        make.top.equalTo(tfEmail.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    //  password
    tfPassword.font = boldFont;
    [tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfEmail.mas_bottom).offset(tfPadding);
        make.left.right.equalTo(tfEmail);
        make.height.mas_equalTo(hItem);
    }];
    [tfPassword addTarget:self
                   action:@selector(onTextfieldDidChanged)
         forControlEvents:UIControlEventEditingChanged];
    
    [imgPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgEmail);
        make.centerY.equalTo(tfPassword.mas_centerY);
        make.width.height.mas_equalTo(sizeImage);
    }];
    
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbTop).offset(-padding);
        make.centerY.equalTo(tfPassword.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbBotPassword.backgroundColor = GRAY_200;
    [lbBotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbBotEmail);
        make.top.equalTo(tfPassword.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    //  forgot password
    [btnForgotPassword setTitleColor:YELLOW_COLOR forState:UIControlStateNormal];
    btnForgotPassword.titleLabel.font = textFont;
    [btnForgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbBotPassword);
        make.top.equalTo(lbBotPassword.mas_bottom).offset(padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSignIn.layer.cornerRadius = 8.0;
    btnSignIn.titleLabel.font = boldFont;
    btnSignIn.backgroundColor = BLUE_COLOR;
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSignIn setTitleColor:GRAY_100 forState:UIControlStateDisabled];
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnForgotPassword.mas_bottom).offset(2*tfPadding);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    [AppUtils addBoxShadowForView:btnSignIn color:[UIColor colorWithRed:(200/255.0) green:(200/255.0)
                                                                   blue:(200/255.0) alpha:1.0]
                          opacity:0.8 offsetX:1 offsetY:1];
    
    
    //  attribute title for sign up button
    [btnSignUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbTop);
        make.top.equalTo(scvContent).offset(SCREEN_HEIGHT - hItem - padding);
        make.height.mas_equalTo(hItem);
    }];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icShowPassClick:(UIButton *)sender {
    if (tfPassword.secureTextEntry) {
        tfPassword.secureTextEntry = FALSE;
        [icShowPass setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        
    }else{
        tfPassword.secureTextEntry = TRUE;
        [icShowPass setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnForgotPasswordPress:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link_forgot_password] options:[[NSDictionary alloc] init] completionHandler:nil];
}

- (IBAction)btnSignInPress:(UIButton *)sender {
}

- (IBAction)btnSignUpPress:(UIButton *)sender {
}

- (void)onTextfieldDidChanged {
    [self setupTextfieldForView];
}

@end
