//
//  RegisterAccountViewController.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterAccountViewController.h"
#import "SignInViewController.h"
#import "AppUtils.h"
#import "RegisterAccountStep2ViewController.h"

@interface RegisterAccountViewController ()<UITextFieldDelegate>{
    float hMenu;
    float padding;
    float hBottom;
}

@end

@implementation RegisterAccountViewController
@synthesize viewMenu, viewAccInfo, lbAccount, lbNumOne, lbSepa, viewProfileInfo, lbProfile, lbNumTwo;
@synthesize scvAccInfo, lbStepOne, lbEmail, tfEmail, lbPassword, tfPassword, lbConfirmPass, tfConfirmPass, btnContinue, lbHaveAccount, btnSignIn, icShowPass, icShowConfirmPass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_account_info;
    [self setupUIForView];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
    [self setupMenuForStep: 1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    if ([tfEmail.text isEqualToString:@""] || [tfPassword.text isEqualToString:@""] || [tfConfirmPass.text isEqualToString:@""]) {
        [self.view makeToast:pls_fill_full_informations duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (![AppUtils validateEmailWithString: tfEmail.text]) {
        [self.view makeToast:email_format_is_incorrect duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }

    if (![tfPassword.text isEqualToString:tfConfirmPass.text]) {
        [self.view makeToast:confirm_pass_is_incorrect duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    RegisterAccountStep2ViewController *registerStep2VC = [[RegisterAccountStep2ViewController alloc] initWithNibName:@"RegisterAccountStep2ViewController" bundle:nil];
    registerStep2VC.email = tfEmail.text;
    registerStep2VC.password = tfPassword.text;
    [self.navigationController pushViewController:registerStep2VC animated:TRUE];
}

- (IBAction)btnSignInPress:(UIButton *)sender {
    SignInViewController *signInVC = [[SignInViewController alloc] init];
    [self.navigationController pushViewController:signInVC animated:YES];
}

- (IBAction)icShowPassPress:(UIButton *)sender {
    if (tfPassword.isSecureTextEntry) {
        tfPassword.secureTextEntry = FALSE;
        [icShowPass setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
    }else{
        tfPassword.secureTextEntry = TRUE;
        [icShowPass setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
    }
}

- (IBAction)icShowConfirmPassPress:(UIButton *)sender {
    if (tfConfirmPass.isSecureTextEntry) {
        tfConfirmPass.secureTextEntry = FALSE;
        [icShowConfirmPass setImage:[UIImage imageNamed:@"hide_pass"]
                           forState:UIControlStateNormal];
    }else{
        tfConfirmPass.secureTextEntry = TRUE;
        [icShowConfirmPass setImage:[UIImage imageNamed:@"show_pass"]
                           forState:UIControlStateNormal];
    }
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    hMenu = 60.0;
    padding = 15.0;
    float hSmallLB = 30.0;
    float mTop = 10.0;
    float sizeMenu = 20.0;
    float paddingX = 3.0;
    float hStepOne = 50.0;
    hBottom = 60.0;
    float hBTN = 45.0;
    
    lbAccount.font = lbProfile.font = lbNumOne.font = lbNumTwo.font = [AppDelegate sharedInstance].fontDesc;
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        sizeMenu = 30.0;
        paddingX = 10.0;
        hStepOne = 70.0;
        hSmallLB = 50.0;
        mTop = 20.0;
        hBottom = 80.0;
        hBTN = 55.0;
        
        lbAccount.font = lbProfile.font = lbNumOne.font = lbNumTwo.font = [AppDelegate sharedInstance].fontRegular;
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    lbSepa.textColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    if ([DeviceUtils isScreen320]) {
        lbSepa.text = @"--";
    }else{
        lbSepa.text = @"-----";
    }
    
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewMenu.mas_centerX);
        make.top.bottom.equalTo(viewMenu);
    }];
    
    [viewAccInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(viewMenu);
        make.right.equalTo(lbSepa.mas_left);
    }];
    
    lbAccount.text = text_account_info;
    [lbAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewAccInfo);
        make.right.equalTo(viewAccInfo).offset(-2.0);
    }];
    
    lbNumOne.clipsToBounds = TRUE;
    lbNumOne.layer.cornerRadius = sizeMenu/2;
    [lbNumOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbAccount.mas_left).offset(-paddingX);
        make.centerY.equalTo(lbAccount.mas_centerY);
        make.width.height.mas_equalTo(sizeMenu);
    }];
    
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(viewMenu);
        make.left.equalTo(lbSepa.mas_right);
    }];
    
    lbNumTwo.clipsToBounds = TRUE;
    lbNumTwo.layer.cornerRadius = sizeMenu/2;
    [lbNumTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewProfileInfo).offset(paddingX);
        make.centerY.equalTo(viewProfileInfo.mas_centerY);
        make.width.height.mas_equalTo(sizeMenu);
    }];
    
    lbProfile.text = text_profile_info;
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbNumTwo.mas_right).offset(paddingX);
        make.top.bottom.equalTo(viewProfileInfo);
    }];
    
    scvAccInfo.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-(hMenu + 10.0 + [AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav));
    [scvAccInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(10.0);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    lbStepOne.textColor = lbEmail.textColor = tfEmail.textColor = lbPassword.textColor = tfPassword.textColor = lbConfirmPass.textColor = tfConfirmPass.textColor = lbHaveAccount.textColor = [UIColor colorWithRed:(55/255.0) green:(67/255.0) blue:(83/255.0) alpha:1.0];
    
    lbStepOne.font = [AppDelegate sharedInstance].fontBold;
    
    lbStepOne.text = enter_account_info;
    [lbStepOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvAccInfo.mas_top);
        make.left.equalTo(scvAccInfo).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(hStepOne);
    }];
    
    //  Email
    lbEmail.font = [AppDelegate sharedInstance].fontMedium;
    lbEmail.text = text_email;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbStepOne.mas_bottom);
        make.left.right.equalTo(lbStepOne);
        make.height.mas_equalTo(hSmallLB);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    tfEmail.returnKeyType = UIReturnKeyNext;
    tfEmail.placeholder = enter_email_address;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom);
        make.left.right.equalTo(lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  Password
    lbPassword.font = [AppDelegate sharedInstance].fontMedium;
    lbPassword.text = text_password;
    [lbPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbEmail);
        make.height.mas_equalTo(hSmallLB);
    }];
    
    [AppUtils setBorderForTextfield:tfPassword borderColor:BORDER_COLOR];
    tfPassword.secureTextEntry = TRUE;
    tfPassword.returnKeyType = UIReturnKeyNext;
    tfPassword.placeholder = enter_password;
    [tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassword.mas_bottom);
        make.left.right.equalTo(lbPassword);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    icShowPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(tfPassword);
        make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  Confirm password
    lbConfirmPass.font = [AppDelegate sharedInstance].fontMedium;
    lbConfirmPass.text = text_confirm_password;
    [lbConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPassword.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbPassword);
        make.height.mas_equalTo(hSmallLB);
    }];
    
    [AppUtils setBorderForTextfield:tfConfirmPass borderColor:BORDER_COLOR];
    tfConfirmPass.secureTextEntry = TRUE;
    tfConfirmPass.returnKeyType = UIReturnKeyDone;
    tfConfirmPass.placeholder = enter_confirm_password;
    [tfConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbConfirmPass.mas_bottom);
        make.left.right.equalTo(lbConfirmPass);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    icShowConfirmPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icShowConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(tfConfirmPass);
        make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
   
    tfEmail.font = tfPassword.font = tfConfirmPass.font = [AppDelegate sharedInstance].fontRegular;
    tfEmail.delegate = tfPassword.delegate = tfConfirmPass.delegate = self;
    
    //  footer
    float hScv = SCREEN_HEIGHT - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height + hMenu + 10.0);
    
    float widthText = [AppUtils getSizeWithText:do_you_already_have_an_account withFont:[AppDelegate sharedInstance].fontRegular].width;
    
    float widthBTN = [AppUtils getSizeWithText:[text_sign_in uppercaseString] withFont:[AppDelegate sharedInstance].fontRegular].width;
    float originX = (SCREEN_WIDTH - (widthText + 5.0 + widthBTN))/2;
    lbHaveAccount.font = [AppDelegate sharedInstance].fontRegular;
    lbHaveAccount.text = do_you_already_have_an_account;
    [lbHaveAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvAccInfo).offset(originX);
        make.top.equalTo(scvAccInfo).offset(hScv-hBottom);
        make.width.mas_equalTo(widthText);
        make.height.mas_equalTo(hBottom);
    }];
    
    
    [btnSignIn setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    [btnSignIn setTitle:[text_sign_in uppercaseString] forState:UIControlStateNormal];
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbHaveAccount.mas_right).offset(5.0);
        make.top.bottom.equalTo(lbHaveAccount);
        make.width.mas_equalTo(widthBTN);
    }];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.cornerRadius = hBTN/2;
    [btnContinue setTitle:text_continue forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvAccInfo).offset(padding);
        make.bottom.equalTo(lbHaveAccount.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSignIn.titleLabel.font = btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
}

- (void)setupMenuForStep: (int)step {
    if (step == 1) {
        UIColor *disableColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
        lbProfile.textColor = disableColor;
        lbNumTwo.backgroundColor = disableColor;
        
        lbSepa.textColor = disableColor;
    }else{
        lbProfile.textColor = BLUE_COLOR;
        lbNumTwo.backgroundColor = BLUE_COLOR;
        lbSepa.textColor = BLUE_COLOR;
    }
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    float heightKeyboard = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvAccInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-heightKeyboard);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [scvAccInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfEmail) {
        [tfPassword becomeFirstResponder];
        
    }else if (textField == tfPassword) {
        [tfConfirmPass becomeFirstResponder];
        
    }else if (textField == tfConfirmPass){
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    
    float screenWidth = [DeviceUtils getWidthOfScreen];
    float screenHeight = [DeviceUtils getHeightOfScreen];
    
    scvAccInfo.contentSize = CGSizeMake(screenWidth, screenHeight-(hMenu + 10.0 + [AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav));
    [scvAccInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth);
    }];
    
    [lbStepOne mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth-2*padding);
    }];
    
    float hScv = screenHeight - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height + hMenu + 10.0);
    
    float originX = (screenWidth - (lbHaveAccount.frame.size.width + 5.0 + btnSignIn.frame.size.width))/2;
    [lbHaveAccount mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvAccInfo).offset(originX);
        make.top.equalTo(scvAccInfo).offset(hScv-hBottom);
    }];
    
    [btnContinue mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth-2*padding);
    }];
}


@end
