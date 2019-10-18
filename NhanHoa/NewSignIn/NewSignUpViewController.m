//
//  NewSignUpViewController.m
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewSignUpViewController.h"

@interface NewSignUpViewController (){
    AppDelegate *appDelegate;
    float padding;
    UIFont *boldFont;
    UIFont *textFont;
}
@end

@implementation NewSignUpViewController

@synthesize scvContent, lbTop, lbTitle, imgEmail, tfEmail, lbBotEmail, imgPassword, tfPassword, lbBotPass, icShowPass, imgConfirmPass, tfConfirmPass, lbBotConfirmPass, icShowConfirmPass, btnContinue, btnHaveAccount;
@synthesize viewType, lbWelcome, lbDescription, lbChooseType, viewPersonal, imgPersonal, lbPersonal, viewBusiness, imgBusiness, lbBusiness, btnChooseTypeContinue, imgBackground;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self showContentForCurrentLanguage];
    [self setupTextfieldForView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    //  [tfEmail becomeFirstResponder];
}

- (void)showContentForCurrentLanguage {
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Sign up new account"];
    tfEmail.placeholder = [appDelegate.localization localizedStringForKey:@"Enter email"];
    tfPassword.placeholder = [appDelegate.localization localizedStringForKey:@"Enter password"];
    tfConfirmPass.placeholder = [appDelegate.localization localizedStringForKey:@"Enter confirm password"];
    [btnContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"] forState:UIControlStateNormal];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:SFM(@"%@ %@", [appDelegate.localization localizedStringForKey:@"Do you already have an account?"], [appDelegate.localization localizedStringForKey:@"Sign In"])];
    [attr addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, attr.string.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:GRAY_80 range:NSMakeRange(0, attr.string.length)];
    
    NSRange range = [attr.string rangeOfString:[appDelegate.localization localizedStringForKey:@"Sign In"]];
    [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
    [btnHaveAccount setAttributedTitle:attr forState:UIControlStateNormal];
    
    //  choose type view
    lbWelcome.text = SFM(@"%@ Nhân Hòa!", [appDelegate.localization localizedStringForKey:@"Welcome to"]);
    lbDescription.text = [appDelegate.localization localizedStringForKey:@"Additional full records to experience the services"];
    [btnChooseTypeContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"] forState:UIControlStateNormal];
    
    lbPersonal.text = [appDelegate.localization localizedStringForKey:@"Personal"];
    lbBusiness.text = [appDelegate.localization localizedStringForKey:@"Business"];
    lbChooseType.text = [appDelegate.localization localizedStringForKey:@"Choose account type"];
}

- (void)setupUIForView {
    padding = 25.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:21.0];
    boldFont = [UIFont fontWithName:RobotoBold size:28.0];
    float hItem = 52.0;
    float hBTN = 55.0;
    float paddingY = 25.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        padding = 15.0;
        textFont = [UIFont fontWithName:RobotoBold size:17.0];
        boldFont = [UIFont fontWithName:RobotoBold size:24.0];
        hItem = 45.0;
        hBTN = 50.0;
        paddingY = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        padding = 15.0;
        textFont = [UIFont fontWithName:RobotoBold size:19.0];
        boldFont = [UIFont fontWithName:RobotoBold size:26.0];
        hItem = 45.0;
        hBTN = 50.0;
        paddingY = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        padding = 25.0;
        textFont = [UIFont fontWithName:RobotoBold size:21.0];
        boldFont = [UIFont fontWithName:RobotoBold size:28.0];
        hItem = 50.0;
        hBTN = 52.0;
        paddingY = 25.0;
    }
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = boldFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(100);
    }];
    
    //  email
    float sizeImage = 25.0;
    [imgEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTop).offset(padding);
        make.top.equalTo(lbTitle.mas_bottom).offset((hItem - sizeImage)/2);
        make.width.height.mas_equalTo(sizeImage);
    }];
    
    tfEmail.textColor = tfPassword.textColor = tfConfirmPass.textColor = GRAY_80;
    tfEmail.font = tfPassword.font = tfConfirmPass.font = textFont;
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    tfEmail.borderStyle = UITextBorderStyleNone;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgEmail.mas_right).offset(10.0);
        make.right.equalTo(lbTop).offset(-padding);
        make.centerY.equalTo(imgEmail.mas_centerY);
        make.height.mas_equalTo(hItem);
    }];
    [tfEmail addTarget:self
                action:@selector(setupTextfieldForView)
      forControlEvents:UIControlEventEditingChanged];
    
    lbBotEmail.backgroundColor = GRAY_200;
    [lbBotEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgEmail);
        make.right.equalTo(tfEmail);
        make.top.equalTo(tfEmail.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    //  password
    tfPassword.secureTextEntry = TRUE;
    tfPassword.borderStyle = UITextBorderStyleNone;
    [tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfEmail);
        make.top.equalTo(tfEmail.mas_bottom).offset(paddingY);
        make.right.equalTo(lbTop).offset(-padding - 30.0);
        make.height.mas_equalTo(hItem);
    }];
    [tfPassword addTarget:self
                   action:@selector(setupTextfieldForView)
         forControlEvents:UIControlEventEditingChanged];
    
    [imgPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTop).offset(padding);
        make.centerY.equalTo(tfPassword.mas_centerY);
        make.width.height.mas_equalTo(sizeImage);
    }];
    
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbTop).offset(-padding);
        make.centerY.equalTo(tfPassword.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbBotPass.backgroundColor = GRAY_200;
    [lbBotPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgPassword);
        make.right.equalTo(tfEmail);
        make.top.equalTo(tfPassword.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    //  confirm password
    tfConfirmPass.secureTextEntry = TRUE;
    tfConfirmPass.borderStyle = UITextBorderStyleNone;
    [tfConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfPassword);
        make.top.equalTo(tfPassword.mas_bottom).offset(paddingY);
        make.height.mas_equalTo(hItem);
    }];
    [tfConfirmPass addTarget:self
                      action:@selector(setupTextfieldForView)
            forControlEvents:UIControlEventEditingChanged];
    
    [imgConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTop).offset(padding);
        make.centerY.equalTo(tfConfirmPass.mas_centerY);
        make.width.height.mas_equalTo(sizeImage);
    }];
    
    [icShowConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbTop).offset(-padding);
        make.centerY.equalTo(tfConfirmPass.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbBotConfirmPass.backgroundColor = GRAY_200;
    [lbBotConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgConfirmPass);
        make.right.equalTo(tfEmail);
        make.top.equalTo(tfConfirmPass.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    //  continue button
    btnContinue.layer.cornerRadius = 8.0;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = textFont;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue setTitleColor:GRAY_100 forState:UIControlStateDisabled];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.top.equalTo(lbBotConfirmPass.mas_bottom).offset(2*paddingY);
        make.height.mas_equalTo(hBTN);
    }];
    [AppUtils addBoxShadowForView:btnContinue color:[UIColor colorWithRed:(150/255.0) green:(150/255.0)
                                                                     blue:(150/255.0) alpha:0.8]
                          opacity:1.0 offsetX:1.0 offsetY:1.0];
    
    [btnHaveAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnContinue);
        make.top.equalTo(btnContinue.mas_bottom).offset(paddingY);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  for choose type view
    float largePadding = 30.0;
    [viewType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewType);
    }];
    
    lbWelcome.textColor = GRAY_50;
    lbWelcome.font = [UIFont systemFontOfSize:boldFont.pointSize weight:UIFontWeightMedium];
    [lbWelcome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewType).offset(largePadding);
        make.left.equalTo(viewType).offset(largePadding);
        make.right.equalTo(viewType).offset(-largePadding);
        make.height.mas_equalTo(60.0);
    }];
    
    lbDescription.textColor = GRAY_100;
    lbDescription.font = [UIFont systemFontOfSize:textFont.pointSize weight:UIFontWeightRegular];
    [lbDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbWelcome.mas_bottom);
        make.left.right.equalTo(lbWelcome);
        make.height.mas_equalTo(80.0);
    }];
    
    lbChooseType.textColor = GRAY_50;
    lbChooseType.font = [UIFont fontWithName:RobotoBold size:boldFont.pointSize];
    [lbChooseType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDescription.mas_bottom).offset(largePadding);
        make.left.right.equalTo(lbWelcome);
        make.height.mas_equalTo(80.0);
    }];
    
    float sizeItem = (SCREEN_WIDTH - 2*largePadding - largePadding/2)/2;
    
    viewPersonal.layer.cornerRadius = viewBusiness.layer.cornerRadius = 10.0;
    
    viewPersonal.layer.borderColor = BLUE_COLOR.CGColor;
    viewPersonal.layer.borderWidth = 2.0;
    [viewPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewType).offset(largePadding);
        make.top.equalTo(lbChooseType.mas_bottom);
        make.width.height.mas_equalTo(sizeItem);
    }];
    [AppUtils addBoxShadowForView:viewPersonal color:GRAY_220 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    UITapGestureRecognizer *tapPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPersonalView)];
    viewPersonal.userInteractionEnabled = TRUE;
    [viewPersonal addGestureRecognizer: tapPersonal];
    
    imgPersonal.backgroundColor = UIColor.redColor;
    [imgPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewPersonal).offset(10.0);
        make.centerX.equalTo(viewPersonal.mas_centerX);
        make.width.mas_equalTo(viewPersonal.mas_width).multipliedBy(1.0/2.0);
        make.height.mas_equalTo(viewPersonal.mas_height).multipliedBy(1.0/2.0);
    }];
    
    lbPersonal.textColor = GRAY_100;
    lbPersonal.font = [UIFont systemFontOfSize:textFont.pointSize+1 weight:UIFontWeightRegular];
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewPersonal);
        make.top.equalTo(imgPersonal.mas_bottom);
    }];
    
    
    //  BUSINESS VIEW
    viewBusiness.layer.borderColor = UIColor.clearColor.CGColor;
    viewBusiness.layer.borderWidth = 2.0;
    [viewBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewType).offset(-largePadding);
        make.top.equalTo(viewPersonal);
        make.width.height.mas_equalTo(sizeItem);
    }];
    [AppUtils addBoxShadowForView:viewBusiness color:GRAY_220 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    imgBusiness.backgroundColor = UIColor.redColor;
    [imgBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBusiness).offset(10.0);
        make.centerX.equalTo(viewBusiness.mas_centerX);
        make.width.mas_equalTo(viewBusiness.mas_width).multipliedBy(1.0/2.0);
        make.height.mas_equalTo(viewBusiness.mas_height).multipliedBy(1.0/2.0);
    }];
    
    lbBusiness.textColor = GRAY_100;
    lbBusiness.font = [UIFont systemFontOfSize:textFont.pointSize+1 weight:UIFontWeightRegular];
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewBusiness);
        make.top.equalTo(imgBusiness.mas_bottom);
    }];
    
    UITapGestureRecognizer *tapBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBusinessView)];
    viewBusiness.userInteractionEnabled = TRUE;
    [viewBusiness addGestureRecognizer: tapBusiness];
    
    
    
    btnChooseTypeContinue.layer.cornerRadius = 8.0;
    btnChooseTypeContinue.backgroundColor = BLUE_COLOR;
    btnChooseTypeContinue.titleLabel.font = textFont;
    [btnChooseTypeContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnChooseTypeContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewType).offset(largePadding/2);
        make.right.equalTo(viewType).offset(-largePadding/2);
        make.bottom.equalTo(viewType).offset(-largePadding-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(hBTN);
    }];
}

- (void)setupTextfieldForView {
    if (![AppUtils isNullOrEmpty: tfEmail.text]) {
        imgEmail.image = [UIImage imageNamed:@"ic_email_active"];
        lbBotEmail.backgroundColor = BLUE_COLOR;
    }else{
        imgEmail.image = [UIImage imageNamed:@"ic_email"];
        lbBotEmail.backgroundColor = GRAY_200;
    }
    
    if (![AppUtils isNullOrEmpty: tfPassword.text]) {
        imgPassword.image = [UIImage imageNamed:@"ic_password_active"];
        lbBotPass.backgroundColor = BLUE_COLOR;
    }else{
        imgPassword.image = [UIImage imageNamed:@"ic_password"];
        lbBotPass.backgroundColor = GRAY_200;
    }
    
    if (![AppUtils isNullOrEmpty: tfPassword.text]) {
        imgConfirmPass.image = [UIImage imageNamed:@"ic_password_active"];
        lbBotConfirmPass.backgroundColor = BLUE_COLOR;
    }else{
        imgConfirmPass.image = [UIImage imageNamed:@"ic_password"];
        lbBotConfirmPass.backgroundColor = GRAY_200;
    }
    
    if (![AppUtils isNullOrEmpty: tfEmail.text] && ![AppUtils isNullOrEmpty: tfPassword.text] && ![AppUtils isNullOrEmpty: tfConfirmPass.text])
    {
        btnContinue.backgroundColor = BLUE_COLOR;
        btnContinue.enabled = TRUE;
    }else{
        btnContinue.backgroundColor = GRAY_230;
        btnContinue.enabled = FALSE;
    }
}

- (void)whenTapOnPersonalView {
    viewPersonal.layer.borderWidth = 2.0;
    viewPersonal.layer.borderColor = BLUE_COLOR.CGColor;
    
    viewBusiness.layer.borderWidth = 0;
    viewBusiness.layer.borderColor = UIColor.clearColor.CGColor;
}

- (void)whenTapOnBusinessView {
    viewPersonal.layer.borderWidth = 0;
    viewPersonal.layer.borderColor = UIColor.clearColor.CGColor;
    
    viewBusiness.layer.borderWidth = 2.0;
    viewBusiness.layer.borderColor = BLUE_COLOR.CGColor;
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

- (IBAction)icShowConfirmPassClick:(UIButton *)sender {
    if (tfConfirmPass.secureTextEntry) {
        tfConfirmPass.secureTextEntry = FALSE;
        [icShowConfirmPass setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
    }else{
        tfConfirmPass.secureTextEntry = TRUE;
        [icShowConfirmPass setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    
}

- (IBAction)btnHaveAccountPress:(UIButton *)sender {
}

- (IBAction)btnChooseTypeContinuePress:(UIButton *)sender {
}
@end
