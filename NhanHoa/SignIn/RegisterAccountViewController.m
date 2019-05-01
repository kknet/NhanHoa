//
//  RegisterAccountViewController.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterAccountViewController.h"
#import "SignInViewController.h"
#import "RegisterAccountStep2ViewController.h"

@interface RegisterAccountViewController ()<UITextFieldDelegate>{
    CGPoint svos;
}

@end

@implementation RegisterAccountViewController
@synthesize viewMenu, viewAccInfo, lbAccount, lbNumOne, lbSepa, viewProfileInfo, lbProfile, lbNumTwo;
@synthesize scvAccInfo, lbStepOne, lbEmail, tfEmail, lbPassword, tfPassword, lbConfirmPass, tfConfirmPass, btnContinue, lbHaveAccount, btnSignIn, icShowPass, icShowConfirmPass;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thông tin tài khoản";
    [self setupUIForView];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = NO;
    [self setupMenuForStep: 1];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    RegisterAccountStep2ViewController *registerStep2VC = [[RegisterAccountStep2ViewController alloc] initWithNibName:@"RegisterAccountStep2ViewController" bundle:nil];
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
    float hMenu = 60.0;
    float padding = 15.0;
    float hSmallLB = 30.0;
    float hTextfield = 38.0;
    float mTop = 10.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    lbSepa.textColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewMenu.mas_centerX);
        make.top.bottom.equalTo(self.viewMenu);
    }];
    
    [viewAccInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.viewMenu);
        make.right.equalTo(self.lbSepa.mas_left);
    }];
    
    lbAccount.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewAccInfo);
        make.right.equalTo(self.viewAccInfo).offset(-2.0);
    }];
    
    lbNumOne.clipsToBounds = TRUE;
    lbNumOne.layer.cornerRadius = 20.0/2;
    lbNumOne.font = lbAccount.font;
    [lbNumOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbAccount.mas_left).offset(-3.0);
        make.centerY.equalTo(self.lbAccount.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.viewMenu);
        make.left.equalTo(self.lbSepa.mas_right);
    }];
    
    lbNumTwo.clipsToBounds = TRUE;
    lbNumTwo.layer.cornerRadius = 20.0/2;
    lbNumTwo.font = lbAccount.font;
    [lbNumTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewProfileInfo).offset(2.0);
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    lbProfile.font = lbAccount.font;
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbNumTwo.mas_right).offset(3.0);
        make.top.bottom.equalTo(self.viewProfileInfo);
    }];
    
    [scvAccInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    lbStepOne.font = [UIFont fontWithName:RobotoBold size:16.0];
    lbStepOne.textColor = [UIColor colorWithRed:(55/255.0) green:(67/255.0) blue:(83/255.0) alpha:1.0];
    [lbStepOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvAccInfo.mas_top);
        make.left.equalTo(self.scvAccInfo).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(50.0);
    }];
    
    //  Email
    lbEmail.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbEmail.textColor = lbStepOne.textColor;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbStepOne.mas_bottom);
        make.left.right.equalTo(self.lbStepOne);
        make.height.mas_equalTo(hSmallLB);
    }];
    
    tfEmail.font = [UIFont fontWithName:RobotoRegular size:16.0];
    tfEmail.textColor = lbStepOne.textColor;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  Password
    lbPassword.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbPassword.textColor = lbStepOne.textColor;
    [lbPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo(hSmallLB);
    }];
    
    tfPassword.font = tfEmail.font;
    tfPassword.textColor = lbStepOne.textColor;
    tfPassword.secureTextEntry = TRUE;
    tfPassword.delegate = self;
    [tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassword.mas_bottom);
        make.left.right.equalTo(self.lbPassword);
        make.height.mas_equalTo(hTextfield);
    }];
    
    icShowPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfPassword);
        make.width.mas_equalTo(hTextfield);
    }];
    
    //  Confirm password
    lbConfirmPass.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbConfirmPass.textColor = lbStepOne.textColor;
    [lbConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassword.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbPassword);
        make.height.mas_equalTo(hSmallLB);
    }];
    
    tfConfirmPass.font = tfEmail.font;
    tfConfirmPass.textColor = lbStepOne.textColor;
    tfConfirmPass.secureTextEntry = TRUE;
    tfConfirmPass.delegate = self;
    [tfConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbConfirmPass.mas_bottom);
        make.left.right.equalTo(self.lbConfirmPass);
        make.height.mas_equalTo(hTextfield);
    }];
    
    icShowConfirmPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icShowConfirmPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfConfirmPass);
        make.width.mas_equalTo(hTextfield);
    }];
   
    //  footer
    float hScv = SCREEN_HEIGHT - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height + hMenu + 10.0);
    
    float widthText = [AppUtils getSizeWithText:@"Bạn đã có tài khoản?" withFont:[UIFont fontWithName:RobotoRegular size:16.0]].width;
    
    float widthBTN = [AppUtils getSizeWithText:@"ĐĂNG NHẬP" withFont:[UIFont fontWithName:RobotoMedium size:16.0]].width;
    float originX = (SCREEN_WIDTH - (widthText + 5.0 + widthBTN))/2;
    lbHaveAccount.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbHaveAccount.textColor = [UIColor colorWithRed:(55/255.0) green:(67/255.0) blue:(83/255.0) alpha:1.0];
    [lbHaveAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvAccInfo).offset(originX);
        make.top.equalTo(self.scvAccInfo).offset(hScv-60.0);
        make.width.mas_equalTo(widthText);
        make.height.mas_equalTo(60.0);
    }];
    
    btnSignIn.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    btnSignIn.titleLabel.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [btnSignIn setTitleColor:ORANGE_COLOR forState:UIControlStateNormal];
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbHaveAccount.mas_right).offset(5.0);
        make.top.bottom.equalTo(self.lbHaveAccount);
        make.width.mas_equalTo(widthBTN);
    }];
    
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoMedium size:18.0];
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.cornerRadius = 45.0/2;
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvAccInfo).offset(padding);
        make.bottom.equalTo(self.lbHaveAccount.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(45.0);
    }];
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

//implementation
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CGRect rc = [textField bounds];
    rc = [textField convertRect:rc toView:self.view];
    rc.origin.x = 0 ;
    rc.origin.y -= 60 ;
    
    rc.size.height = 400;
    [scvAccInfo scrollRectToVisible:rc animated:YES];
}

@end
