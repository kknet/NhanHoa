//
//  ChangePassViewController.m
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChangePassViewController.h"

@interface ChangePassViewController ()<UITextFieldDelegate, WebServiceUtilsDelegate>
{
    AppDelegate *appDelegate;
    float hTextfield;
    UIFont *textFont;
    float padding;
}

@end

@implementation ChangePassViewController
@synthesize viewHeader, icBack, lbHeader, tfCurPass, imgCurPass, icShowPass, btnForgotPass, btnContinue, lbSepa;
@synthesize viewNewPass, imgNewPass, tfNewPass, icShowNewPass, lbBotNewPass, imgConfirmPass, tfConfirmPass, icShowConfirm, lbBotConfirmPass, btnSaveNewPass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [tfCurPass becomeFirstResponder];
    [self showContentWithCurrentLanguage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Change password"];
    tfCurPass.placeholder = [appDelegate.localization localizedStringForKey:@"Enter current password"];
    [btnForgotPass setTitle:[appDelegate.localization localizedStringForKey:@"Forgot password?"]
                   forState:UIControlStateNormal];
    [btnContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"]
                 forState:UIControlStateNormal];
    
    tfNewPass.placeholder = [appDelegate.localization localizedStringForKey:@"Enter new password"];
    tfConfirmPass.placeholder = [appDelegate.localization localizedStringForKey:@"Enter confirm new password"];
    [btnSaveNewPass setTitle:[appDelegate.localization localizedStringForKey:@"Save new password"]
                    forState:UIControlStateNormal];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    [btnContinue mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight-2*padding);
    }];
    
    [btnSaveNewPass mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewNewPass).offset(-keyboardHeight-2*padding);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [btnSaveNewPass mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewNewPass).offset(-2*padding);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)setupUIForView
{
    hTextfield = 50.0;
    padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    }
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //  header view
    self.view.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.textColor = GRAY_100;
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    float sizeLock = 24.0;
    
    //  textfield
    tfCurPass.secureTextEntry = TRUE;
    tfCurPass.font = textFont;
    [tfCurPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(2*padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    tfCurPass.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeLock + padding, hTextfield)];
    tfCurPass.leftViewMode = UITextFieldViewModeAlways;
    
    tfCurPass.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfCurPass.rightViewMode = UITextFieldViewModeAlways;
    
    
    [imgCurPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfCurPass);
        make.centerY.equalTo(tfCurPass.mas_centerY);
        make.width.height.mas_equalTo(sizeLock);
    }];
    
    icShowPass.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfCurPass);
        make.right.equalTo(tfCurPass).offset(7.0);
        make.width.height.mas_equalTo(hTextfield);
    }];
    
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfCurPass);
        make.bottom.equalTo(tfCurPass);
        make.height.mas_equalTo(1.0);
    }];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.cornerRadius = 8.0;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnContinue.titleLabel.font = textFont;
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbSepa);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [btnForgotPass setTitleColor:NEW_PRICE_COLOR forState:UIControlStateNormal];
    btnForgotPass.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnForgotPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnContinue);
        make.bottom.equalTo(btnContinue.mas_top).offset(-2*padding);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  view new pass
    [viewNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.equalTo(self.view).offset(SCREEN_WIDTH);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view);
    }];
    
    //  new password
    tfNewPass.secureTextEntry = TRUE;
    tfNewPass.font = textFont;
    tfNewPass.returnKeyType = UIReturnKeyNext;
    tfNewPass.delegate = self;
    [tfNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewNewPass).offset(2*padding);
        make.left.equalTo(viewNewPass).offset(padding);
        make.right.equalTo(viewNewPass).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    tfNewPass.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeLock + padding, hTextfield)];
    tfNewPass.leftViewMode = UITextFieldViewModeAlways;
    
    tfNewPass.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfNewPass.rightViewMode = UITextFieldViewModeAlways;
    
    
    [imgNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfNewPass);
        make.centerY.equalTo(tfNewPass.mas_centerY);
        make.width.height.mas_equalTo(sizeLock);
    }];
    
    icShowNewPass.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icShowNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfNewPass);
        make.right.equalTo(tfNewPass).offset(7.0);
        make.width.height.mas_equalTo(hTextfield);
    }];
    
    lbBotNewPass.backgroundColor = GRAY_230;
    [lbBotNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfNewPass);
        make.bottom.equalTo(tfNewPass);
        make.height.mas_equalTo(1.0);
    }];
    
    //  confirm password
    tfConfirmPass.secureTextEntry = TRUE;
    tfConfirmPass.font = textFont;
    [tfConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfNewPass.mas_bottom).offset(2*padding);
        make.left.right.equalTo(tfNewPass);
        make.height.mas_equalTo(hTextfield);
    }];
    tfConfirmPass.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeLock + padding, hTextfield)];
    tfConfirmPass.leftViewMode = UITextFieldViewModeAlways;
    
    tfConfirmPass.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfConfirmPass.rightViewMode = UITextFieldViewModeAlways;
    
    
    [imgConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfConfirmPass);
        make.centerY.equalTo(tfConfirmPass.mas_centerY);
        make.width.height.mas_equalTo(sizeLock);
    }];
    
    icShowConfirm.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icShowConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfConfirmPass);
        make.right.equalTo(tfConfirmPass).offset(7.0);
        make.width.height.mas_equalTo(hTextfield);
    }];
    
    lbBotConfirmPass.backgroundColor = GRAY_230;
    [lbBotConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfConfirmPass);
        make.bottom.equalTo(tfConfirmPass);
        make.height.mas_equalTo(1.0);
    }];
    
    btnSaveNewPass.backgroundColor = BLUE_COLOR;
    btnSaveNewPass.layer.cornerRadius = 8.0;
    [btnSaveNewPass setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSaveNewPass.titleLabel.font = textFont;
    [btnSaveNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfNewPass);
        make.bottom.equalTo(viewNewPass).offset(-2*padding);
        make.height.mas_equalTo(hTextfield);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    if (viewNewPass.frame.origin.x == 0) {
        [viewNewPass mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(SCREEN_WIDTH);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }else{
        [self.navigationController popViewControllerAnimated: TRUE];
    }
}

- (IBAction)icShowPassClick:(UIButton *)sender {
    if (tfCurPass.secureTextEntry) {
        tfCurPass.secureTextEntry = FALSE;
        [icShowPass setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
        
    }else{
        tfCurPass.secureTextEntry = TRUE;
        [icShowPass setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
    }
}

- (IBAction)btnForgotPassPress:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link_forgot_password] options:[[NSDictionary alloc] init] completionHandler:nil];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    if (tfCurPass.text.length == 0) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Please enter current password"] duration:1.0 position:CSToastPositionCenter style:appDelegate.warningStyle];
        return;
    }
    
    NSString *oldMd5Pass = [AppUtils getMD5StringOfString: tfCurPass.text];
    if (![oldMd5Pass isEqualToString: PASSWORD]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"The current password is incorrect"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    [tfNewPass becomeFirstResponder];
    [viewNewPass mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)icShowNewPassClick:(UIButton *)sender {
    if (tfNewPass.secureTextEntry) {
        tfNewPass.secureTextEntry = FALSE;
        [icShowNewPass setImage:[UIImage imageNamed:@"hide_pass"]
                       forState:UIControlStateNormal];
    }else{
        tfNewPass.secureTextEntry = TRUE;
        [icShowNewPass setImage:[UIImage imageNamed:@"show_pass"]
                       forState:UIControlStateNormal];
    }
}

- (IBAction)icShowConfirmPassClick:(UIButton *)sender {
    if (tfConfirmPass.secureTextEntry) {
        tfConfirmPass.secureTextEntry = FALSE;
        [icShowConfirm setImage:[UIImage imageNamed:@"hide_pass"]
                       forState:UIControlStateNormal];
    }else{
        tfConfirmPass.secureTextEntry = TRUE;
        [icShowConfirm setImage:[UIImage imageNamed:@"show_pass"]
                       forState:UIControlStateNormal];
    }
}

- (IBAction)btnSaveNewPassPress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfNewPass.text]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Please enter new password"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    if (tfNewPass.text.length < PASSWORD_MIN_CHARS) {
        NSString *content = SFM(@"%@ %d %@", [appDelegate.localization localizedStringForKey:@"Password must be at least"], PASSWORD_MIN_CHARS, [appDelegate.localization localizedStringForKey:@"characters"]);
        [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfConfirmPass.text]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Please enter confirm new password"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    if (![tfNewPass.text isEqualToString: tfConfirmPass.text]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"The confirm password is incorrect"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [self.view endEditing: TRUE];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Updating..."] Interaction:FALSE];
    
    NSString *newPass = [AppUtils getMD5StringOfString: tfNewPass.text];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] changePasswordWithCurrentPass:PASSWORD newPass:newPass];
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfNewPass) {
        [tfConfirmPass becomeFirstResponder];
    }
    return TRUE;
}

#pragma mark - Webservice delegate

-(void)failedToChangePasswordWithError:(NSString *)error {
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)changePasswordSuccessful {
    NSString *password = [AppUtils getMD5StringOfString:tfNewPass.text];
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:key_password];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

- (void)dismissController {
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Your password has been updated"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissController) withObject:nil afterDelay:2.0];
}

-(void)failedToLoginWithError:(NSString *)error {
    [ProgressHUD dismiss];
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not refresh info after change password"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
}

@end
