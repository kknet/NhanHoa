//
//  ChangePasswordViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SignInViewController.h"

#import "WebServices.h"

@interface ChangePasswordViewController ()<WebServicesDelegate, UITextFieldDelegate> {
    WebServices *webService;
}
@end

@implementation ChangePasswordViewController
@synthesize lbOldPass, tfOldPass, lbNewPass, tfNewPass, lbConfirm, tfConfirm, btnSave, btnCancel, lbWarning, icShowNewPass, icShowConfirmPass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [WriteLogsUtils writeForGoToScreen:@"ChangePasswordViewController"];
    
    [super viewWillAppear: animated];
    self.title = @"Đổi mật khẩu";
}

- (void)setupUIForView {
    float padding = 15.0;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    self.view.userInteractionEnabled = TRUE;
    [self.view addGestureRecognizer: tapOnScreen];
    
    //  Old password
    lbOldPass.font = lbNewPass.font = lbConfirm.font = [AppDelegate sharedInstance].fontMedium;
    tfOldPass.font = tfNewPass.font = tfConfirm.font = [AppDelegate sharedInstance].fontRegular;
    
    lbOldPass.textColor = lbNewPass.textColor = lbConfirm.textColor = TITLE_COLOR;
    
    [lbOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.view).offset(10.0);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    tfOldPass.secureTextEntry = TRUE;
    [AppUtils setBorderForTextfield:tfOldPass borderColor:BORDER_COLOR];
    [tfOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOldPass.mas_bottom);
        make.left.right.equalTo(self.lbOldPass);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfOldPass.returnKeyType = UIReturnKeyNext;
    tfOldPass.delegate = self;
    
    //  New password
    float widthText = [AppUtils getSizeWithText:lbNewPass.text withFont:lbNewPass.font].width + 10.0;
    [lbNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfOldPass.mas_bottom).offset(10.0);
        make.left.equalTo(self.tfOldPass);
        make.width.mas_equalTo(widthText);
        make.height.equalTo(self.lbOldPass.mas_height);
    }];
    
    lbWarning.font = [AppDelegate sharedInstance].fontItalic;
    lbWarning.textColor = NEW_PRICE_COLOR;
    [lbWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbNewPass);
        make.left.equalTo(self.lbNewPass.mas_right);
        make.right.equalTo(self.tfOldPass);
    }];
    
    tfNewPass.secureTextEntry = TRUE;
    [AppUtils setBorderForTextfield:tfNewPass borderColor:BORDER_COLOR];
    [tfNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbNewPass.mas_bottom);
        make.left.right.equalTo(self.tfOldPass);
        make.height.equalTo(self.tfOldPass.mas_height);
    }];
    tfNewPass.returnKeyType = UIReturnKeyNext;
    tfNewPass.delegate = self;
    
    icShowNewPass.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [icShowNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfNewPass);
        make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  Confirm password
    [lbConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfNewPass.mas_bottom).offset(10.0);
        make.left.right.equalTo(self.tfNewPass);
        make.height.equalTo(self.lbOldPass.mas_height);
    }];
    
    tfConfirm.secureTextEntry = TRUE;
    [AppUtils setBorderForTextfield:tfConfirm borderColor:BORDER_COLOR];
    [tfConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbConfirm.mas_bottom);
        make.left.right.equalTo(self.tfOldPass);
        make.height.equalTo(self.tfOldPass.mas_height);
    }];
    tfConfirm.returnKeyType = UIReturnKeyDone;
    tfConfirm.delegate = self;
    
    icShowConfirmPass.imageEdgeInsets = icShowNewPass.imageEdgeInsets;
    [icShowConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfConfirm);
        make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  footer button
    float hBTN = 45.0;
    btnCancel.titleLabel.font = btnSave.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnCancel.layer.cornerRadius = btnSave.layer.cornerRadius = hBTN/2;
    
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btnCancel);
        make.left.equalTo(self.btnCancel.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    tfOldPass.text = tfNewPass.text = tfConfirm.text = @"";
}

- (IBAction)btnSavePress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfOldPass.text]) {
        [self.view makeToast:@"Bạn chưa nhập mật khẩu hiện tại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfNewPass.text]) {
        [self.view makeToast:@"Bạn chưa nhập mật khẩu mới!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (tfNewPass.text.length < PASSWORD_MIN_CHARS) {
        [self.view makeToast:[NSString stringWithFormat:@"Mật khẩu phải có độ dài tối thiểu %d kí tự", PASSWORD_MIN_CHARS] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfConfirm.text]) {
        [self.view makeToast:@"Bạn chưa nhập mật khẩu xác nhận!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    
    if (![tfNewPass.text isEqualToString: tfConfirm.text]) {
        [self.view makeToast:@"Xác nhận mật khẩu không chính xác. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    NSString *oldMd5Pass = [AppUtils getMD5StringOfString: tfOldPass.text];
    if (![oldMd5Pass isEqualToString: PASSWORD]) {
        [self.view makeToast:@"Mật khẩu hiện tại bạn nhập không chính xác. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [ProgressHUD show:@"Đang cập nhật..." Interaction:NO];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    NSString *newPass = [AppUtils getMD5StringOfString: tfNewPass.text];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:change_password_mod forKey:@"mod"];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"old_password"];
    [info setObject:newPass forKey:@"new_password"];
    [info setObject:newPass forKey:@"re_new_password"];
    [webService callWebServiceWithLink:change_pass_func withParams:info];
 
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] info = %@", __FUNCTION__, @[info]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (IBAction)icShowConfirmPassPress:(UIButton *)sender {
    if (tfConfirm.secureTextEntry) {
        tfConfirm.secureTextEntry = FALSE;
    }else{
        tfConfirm.secureTextEntry = TRUE;
    }
}

- (IBAction)icShowNewPassPress:(UIButton *)sender {
    if (tfNewPass.secureTextEntry) {
        tfNewPass.secureTextEntry = FALSE;
    }else{
        tfNewPass.secureTextEntry = TRUE;
    }
}

- (void)startLogoutAfterUpdatePassword {
    [AppDelegate sharedInstance].userInfo = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:login_state];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:key_password];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    [self presentViewController:signInVC animated:TRUE completion:nil];
}

#pragma mark - UITextfield delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfOldPass) {
        [tfNewPass becomeFirstResponder];
        
    }else if (textField == tfNewPass) {
        [tfConfirm becomeFirstResponder];
        
    }else if (textField == tfConfirm) {
        [self closeKeyboard];
    }
    return TRUE;
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString:change_pass_func]) {
        [ProgressHUD dismiss];
        
        if (![AppUtils checkNetworkAvailable]) {
            [self.view makeToast:no_internet duration:2.0 position:CSToastPositionTop style:[AppDelegate sharedInstance].errorStyle];
        }else{
            [self.view makeToast:@"Cập nhật mật khẩu thất bại. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:change_pass_func]) {
        [self.view makeToast:@"Mật khẩu đã được cập nhật thành công. Vui lòng đăng nhập lại với mật khẩu bạn vừa cập nhật." duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        [self performSelector:@selector(startLogoutAfterUpdatePassword) withObject:nil afterDelay:3.0];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

@end
