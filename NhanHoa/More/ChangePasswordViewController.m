//
//  ChangePasswordViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SignInViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate, WebServiceUtilsDelegate>
@end

@implementation ChangePasswordViewController
@synthesize lbOldPass, tfOldPass, lbNewPass, tfNewPass, lbConfirm, tfConfirm, btnSave, btnCancel, lbWarning, icShowNewPass, icShowConfirmPass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    self.title = text_change_password;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"ChangePasswordViewController"];
}

- (void)setupUIForView {
   float padding = 15.0;
   float hLabel= 30.0;
   float mTop = 10.0;
   float hBTN = 45.0;
   icShowNewPass.imageEdgeInsets = icShowConfirmPass.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
   
   if ([DeviceUtils isScreen320]) {
      padding = 5.0;
   }
   
   if (!IS_IPHONE && !IS_IPOD) {
      padding = 30.0;
      hLabel = 50.0;
      mTop = 20.0;
      hBTN = 55.0;
      icShowNewPass.imageEdgeInsets = icShowConfirmPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
   }
   
   UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
   self.view.userInteractionEnabled = TRUE;
   [self.view addGestureRecognizer: tapOnScreen];
   
   //  Old password
   lbOldPass.font = lbNewPass.font = lbConfirm.font = [AppDelegate sharedInstance].fontMedium;
   tfOldPass.font = tfNewPass.font = tfConfirm.font = [AppDelegate sharedInstance].fontRegular;
   
   lbOldPass.textColor = lbNewPass.textColor = lbConfirm.textColor = TITLE_COLOR;
   
   lbOldPass.text = text_current_password;
   [lbOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.view).offset(padding);
      make.top.equalTo(self.view).offset(mTop);
      make.right.equalTo(self.view).offset(-padding);
      make.height.mas_equalTo(hLabel);
   }];
   
   tfOldPass.secureTextEntry = TRUE;
   [AppUtils setBorderForTextfield:tfOldPass borderColor:BORDER_COLOR];
   tfOldPass.placeholder = enter_current_password;
   [tfOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(lbOldPass.mas_bottom);
      make.left.right.equalTo(lbOldPass);
      make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
   }];
   tfOldPass.returnKeyType = UIReturnKeyNext;
   tfOldPass.delegate = self;
   
   //  New password
   lbNewPass.text = text_new_password;
   float widthText = [AppUtils getSizeWithText:lbNewPass.text withFont:lbNewPass.font].width + 10.0;
   [lbNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(tfOldPass.mas_bottom).offset(mTop);
      make.left.equalTo(tfOldPass);
      make.width.mas_equalTo(widthText);
      make.height.equalTo(lbOldPass.mas_height);
   }];
   
   lbWarning.font = [AppDelegate sharedInstance].fontItalic;
   lbWarning.text = SFM(text_at_least_characters, PASSWORD_MIN_CHARS);
   lbWarning.textColor = NEW_PRICE_COLOR;
   [lbWarning mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(lbNewPass);
      make.left.equalTo(lbNewPass.mas_right);
      make.right.equalTo(tfOldPass);
   }];
   
   tfNewPass.secureTextEntry = TRUE;
   [AppUtils setBorderForTextfield:tfNewPass borderColor:BORDER_COLOR];
   tfNewPass.placeholder = enter_new_password;
   [tfNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(lbNewPass.mas_bottom);
      make.left.right.equalTo(tfOldPass);
      make.height.equalTo(tfOldPass.mas_height);
   }];
   tfNewPass.returnKeyType = UIReturnKeyNext;
   tfNewPass.delegate = self;
   
   [icShowNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.right.bottom.equalTo(tfNewPass);
      make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield);
   }];
   
   //  Confirm password
   lbConfirm.text = text_confirm_password;
   [lbConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(tfNewPass.mas_bottom).offset(mTop);
      make.left.right.equalTo(tfNewPass);
      make.height.equalTo(lbOldPass.mas_height);
   }];
   
   tfConfirm.secureTextEntry = TRUE;
   [AppUtils setBorderForTextfield:tfConfirm borderColor:BORDER_COLOR];
   tfConfirm.placeholder = enter_confirm_password;
   [tfConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(lbConfirm.mas_bottom);
      make.left.right.equalTo(tfOldPass);
      make.height.equalTo(tfOldPass.mas_height);
   }];
   tfConfirm.returnKeyType = UIReturnKeyDone;
   tfConfirm.delegate = self;
   
   [icShowConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.right.bottom.equalTo(tfConfirm);
      make.width.mas_equalTo([AppDelegate sharedInstance].hTextfield);
   }];
   
   //  footer button
   btnCancel.titleLabel.font = btnSave.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
   btnCancel.layer.cornerRadius = btnSave.layer.cornerRadius = hBTN/2;
   btnCancel.layer.borderWidth = btnSave.layer.borderWidth = 1.0;
   
   btnCancel.backgroundColor = OLD_PRICE_COLOR;
   btnCancel.layer.borderColor = OLD_PRICE_COLOR.CGColor;
   [btnCancel setTitle:text_reset forState:UIControlStateNormal];
   [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self.view).offset(padding);
      make.bottom.equalTo(self.view).offset(-padding);
      make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
      make.height.mas_equalTo(hBTN);
   }];
   
   btnSave.backgroundColor = BLUE_COLOR;
   btnSave.layer.borderColor = BLUE_COLOR.CGColor;
   [btnSave setTitle:text_update forState:UIControlStateNormal];
   [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.bottom.equalTo(btnCancel);
      make.left.equalTo(btnCancel.mas_right).offset(padding);
      make.right.equalTo(self.view).offset(-padding);
   }];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:OLD_PRICE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startResetAllValue) withObject:nil afterDelay:0.05];
}

- (void)startResetAllValue {
    btnCancel.backgroundColor = OLD_PRICE_COLOR;
    [btnCancel setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    tfOldPass.text = tfNewPass.text = tfConfirm.text = @"";
}

- (void)startUpdatePassword {
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfOldPass.text]) {
        [self.view makeToast:pls_enter_current_password duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfNewPass.text]) {
        [self.view makeToast:pls_enter_new_password duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (tfNewPass.text.length < PASSWORD_MIN_CHARS) {
        [self.view makeToast:SFM(password_must_be_at_least, PASSWORD_MIN_CHARS) duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfConfirm.text]) {
        [self.view makeToast:pls_enter_confirm_password duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    
    if (![tfNewPass.text isEqualToString: tfConfirm.text]) {
        [self.view makeToast:confirm_pass_is_incorrect duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    NSString *oldMd5Pass = [AppUtils getMD5StringOfString: tfOldPass.text];
    if (![oldMd5Pass isEqualToString: PASSWORD]) {
        [self.view makeToast:current_pass_is_incorrect duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_updating Interaction:FALSE];
    
    NSString *newPass = [AppUtils getMD5StringOfString: tfNewPass.text];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] changePasswordWithCurrentPass:PASSWORD newPass:newPass];
}

- (IBAction)btnSavePress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startUpdatePassword) withObject:nil afterDelay:0.05];
}

- (IBAction)icShowConfirmPassPress:(UIButton *)sender {
    if (tfConfirm.secureTextEntry) {
        tfConfirm.secureTextEntry = FALSE;
        [sender setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
    }else{
        tfConfirm.secureTextEntry = TRUE;
        [sender setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
    }
}

- (IBAction)icShowNewPassPress:(UIButton *)sender {
    if (tfNewPass.secureTextEntry) {
        tfNewPass.secureTextEntry = FALSE;
        [sender setImage:[UIImage imageNamed:@"hide_pass"] forState:UIControlStateNormal];
    }else{
        tfNewPass.secureTextEntry = TRUE;
        [sender setImage:[UIImage imageNamed:@"show_pass"] forState:UIControlStateNormal];
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

-(void)failedToChangePasswordWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)changePasswordSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD dismiss];
    [self.view makeToast:password_has_been_updated duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(startLogoutAfterUpdatePassword) withObject:nil afterDelay:4.0];
}

@end
