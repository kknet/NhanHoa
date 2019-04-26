//
//  SignInViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController (){
    UIColor *signInColor;
    UIColor *textColor;
}

@end

@implementation SignInViewController
@synthesize viewTop, imgLogo, lbCompany, lbToBeTheBest, tfAccount, tfPassword, icShowPass, btnForgotPass, btnSignIn, viewBottom, lbNotAccount, btnRegister;
@synthesize hHeader, padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)icShowPassClicked:(UIButton *)sender {
}

- (IBAction)btnForgotPassPress:(UIButton *)sender {
}

- (IBAction)btnSignInPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:signInColor forState:UIControlStateNormal];
    [self performSelector:@selector(startSignIn) withObject:nil afterDelay:0.1];
}

- (void)startSignIn {
    btnSignIn.backgroundColor = signInColor;
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
}

- (void)closeKeyboard {
    [self.view endEditing: YES];
}

- (void)setupUIForView {
    hHeader = SCREEN_HEIGHT * 7/9;
    padding = 30.0;
    signInColor = [UIColor colorWithRed:(240/255.0) green:(138/255.0) blue:(38/255.0) alpha:1.0];
    textColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
    
    //  view top
    viewTop.backgroundColor = UIColor.clearColor;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.hHeader);
    }];
    
    float hTextfield = 44.0;
    float originY = (hHeader/2 - (hTextfield + 15 + hTextfield + hTextfield))/2;
    
    //  account textfield
    tfAccount.textColor = textColor;
    tfAccount.layer.cornerRadius = hTextfield/2;
    tfAccount.backgroundColor = [UIColor colorWithRed:(40/255.0) green:(123/255.0) blue:(229/255.0) alpha:1.0];
    tfAccount.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    [tfAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewTop).offset(self.padding);
        make.right.equalTo(self.viewTop).offset(-self.padding);
        make.top.equalTo(self.viewTop.mas_centerY).offset(originY);
        make.height.mas_equalTo(hTextfield);
    }];
    [AppUtils setPlaceholder:@"Tài khoản đăng nhập" textfield:tfAccount color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    tfAccount.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAccount.leftViewMode = UITextFieldViewModeAlways;
    
    tfAccount.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAccount.rightViewMode = UITextFieldViewModeAlways;
    
    //  password textfield
    tfPassword.textColor = textColor;
    tfPassword.secureTextEntry = YES;
    tfPassword.layer.cornerRadius = hTextfield/2;
    tfPassword.backgroundColor = tfAccount.backgroundColor;
    tfPassword.font = tfAccount.font;
    [tfPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfAccount);
        make.top.equalTo(self.tfAccount.mas_bottom).offset(15.0);
        make.height.mas_equalTo(hTextfield);
    }];
    [AppUtils setPlaceholder:@"Mật khẩu" textfield:tfPassword color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    
    tfPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassword.leftViewMode = UITextFieldViewModeAlways;
    
    tfPassword.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassword.rightViewMode = UITextFieldViewModeAlways;
    
    icShowPass.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icShowPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfPassword.mas_right);
        make.top.bottom.equalTo(self.tfPassword);
        make.width.mas_equalTo(hTextfield);
    }];
    
    //  forgot password
    btnForgotPass.backgroundColor = UIColor.clearColor;
    [btnForgotPass setTitleColor:textColor forState:UIControlStateNormal];
    [btnForgotPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfPassword);
        make.top.equalTo(self.tfPassword.mas_bottom);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //
    float paddingTop = (hHeader/2 - (100 + 15.0 + 30.0 + 25.0))/2;
    [imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewTop).offset(paddingTop + 30.0);
        make.centerX.equalTo(self.viewTop.mas_centerX);
        make.width.height.mas_equalTo(100.0);
    }];
    
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgLogo.mas_bottom).offset(15.0);
        make.left.equalTo(self.viewTop).offset(self.padding);
        make.right.equalTo(self.viewTop).offset(-self.padding);
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
    
    CGSize sizeText = [AppUtils getSizeWithText:@"Bạn chưa có tài khoản?" withFont:[UIFont systemFontOfSize:16.0]];
    CGSize sizeText2 = [AppUtils getSizeWithText:@"ĐĂNG KÝ" withFont:[UIFont systemFontOfSize:16.0]];
    
    float originX = (SCREEN_WIDTH - (sizeText.width + 10.0 + sizeText2.width))/2;
    float hHalfBottomView = (SCREEN_HEIGHT - hHeader + hCurve)/2;
    originY = hHalfBottomView + (hHalfBottomView - 30.0)/2;
    
    lbNotAccount.font = [UIFont systemFontOfSize:16.0];
    lbNotAccount.textColor = textColor;
    [lbNotAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBottom).offset(originY);
        make.left.equalTo(self.viewBottom).offset(originX);
        make.width.mas_equalTo(sizeText.width);
        make.height.mas_equalTo(30.0);
    }];
    
    btnRegister.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btnRegister setTitleColor:signInColor forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbNotAccount);
        make.left.equalTo(self.lbNotAccount.mas_right).offset(10.0);
        make.width.mas_equalTo(sizeText2.width);
    }];
    
    CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
    bottomGradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-hHeader+2*hCurve);
    bottomGradientLayer.startPoint = CGPointMake(0, 0);
    bottomGradientLayer.endPoint = CGPointMake(1, 1);
    bottomGradientLayer.colors = @[(id)[UIColor colorWithRed:(14/255.0) green:(91/255.0) blue:(181/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(10/255.0) green:(87/255.0) blue:(179/255.0) alpha:1.0].CGColor];
    
    [viewBottom.layer insertSublayer:bottomGradientLayer atIndex:0];
    
    //  sign in button
    float hButton = 48.0;
    btnSignIn.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSignIn.layer.borderColor = signInColor.CGColor;
    btnSignIn.layer.cornerRadius = hButton/2;
    btnSignIn.layer.borderWidth = 1.0;
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.hHeader-hButton/2-20.0);
        make.left.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(hButton);
    }];
}

@end