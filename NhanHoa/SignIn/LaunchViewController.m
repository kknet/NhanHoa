//
//  LaunchViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "LaunchViewController.h"
#import "SignInViewController.h"
#import "RegisterAccountViewController.h"

@interface LaunchViewController (){
    UIColor *signInColor;
    UIColor *registerColor;
}
@end

@implementation LaunchViewController
@synthesize viewTop, lbWelcome, imgLogo, lbDescription, imgInfo;
@synthesize viewBottom, btnSignIn, btnRegister, lbCompany;
@synthesize padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    
    if ([AppDelegate sharedInstance].registerAccSuccess) {
        SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
        [self.navigationController pushViewController:signInVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    float hCurve = 30.0;
    float hTopView = SCREEN_HEIGHT * 3/5 + 50.0;
    float hButton = 48.0;
    padding = 30.0;
    float paddingBTN = 7.5;
    float hBottom = 38.0;
    UIFont *slogentFont = [UIFont fontWithName:RobotoRegular size:21.0];
    UIFont *welcomeFont = [UIFont fontWithName:RobotoRegular size:21.0];
    
    float paddingTopView = 15.0;
    float wImgInfor = SCREEN_WIDTH/2 + 30.0;
    
    lbWelcome.text = text_welcome_to;
    
    if (!IS_IPHONE && !IS_IPOD) {
        wImgInfor = 300;
        hCurve = 80.0;
        hTopView = SCREEN_HEIGHT *4/6;
        hButton = 55.0;
        paddingBTN = 10.0;
        hBottom = 80.0;
        paddingTopView = 30.0;
        slogentFont = [UIFont fontWithName:RobotoLight size:30.0];
        welcomeFont = [UIFont fontWithName:RobotoLight size:35.0];
        
        //  set content
        lbWelcome.text = [text_welcome_to uppercaseString];
    }
    
    viewTop.backgroundColor = UIColor.clearColor;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hTopView);
    }];
    
    UIImage *imgGraphic = [UIImage imageNamed:@"graphic.png"];
    float hImage = wImgInfor * imgGraphic.size.height/imgGraphic.size.width;
    float originY = (hTopView/2 - hImage)/2;
    [imgInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewTop).offset(-originY);
        make.centerX.equalTo(viewTop.mas_centerX);
        make.width.mas_equalTo(wImgInfor);
        make.height.mas_equalTo(hImage);
    }];
    
    [lbDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.viewTop.mas_centerY).offset(-20.0);
        make.left.equalTo(self.viewTop).offset(15.0);
        make.right.equalTo(self.viewTop).offset(-15.0);
    }];
    
    UIImage *logo = [UIImage imageNamed:@"logo.png"];
    float hImageLogo = wImgInfor * logo.size.height/logo.size.width;
    
    [imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbDescription.mas_top).offset(-paddingTopView);
        make.centerX.equalTo(self.viewTop.mas_centerX);
        make.width.mas_equalTo(wImgInfor);
        make.height.mas_equalTo(hImageLogo);
    }];
    
    [lbWelcome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgLogo.mas_top).offset(-paddingTopView);
        make.left.right.equalTo(self.viewTop);
    }];
    
    lbDescription.textColor = lbWelcome.textColor = [UIColor colorWithRed:(83/255.0) green:(98/255.0) blue:(127/255.0) alpha:1.0];
    lbDescription.font = slogentFont;
    lbWelcome.font = welcomeFont;
    
    //  VIEW BOTTOm
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.viewTop.mas_bottom).offset(-hCurve);
    }];
    
    signInColor = [UIColor colorWithRed:(240/255.0) green:(138/255.0) blue:(38/255.0) alpha:1.0];
    btnSignIn.layer.borderColor = signInColor.CGColor;
    btnSignIn.backgroundColor = signInColor;
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewBottom).offset(self.padding);
        make.right.equalTo(self.viewBottom).offset(-self.padding);
        make.bottom.equalTo(self.viewBottom.mas_centerY).offset(-paddingBTN);
        make.height.mas_equalTo(hButton);
    }];
    
    registerColor = [UIColor colorWithRed:(11/255.0) green:(97/255.0) blue:(200/255.0) alpha:1.0];
    btnRegister.layer.borderColor = UIColor.whiteColor.CGColor;
    [btnRegister setTitleColor:registerColor forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewBottom).offset(self.padding);
        make.right.equalTo(self.viewBottom).offset(-self.padding);
        make.top.equalTo(self.viewBottom.mas_centerY).offset(paddingBTN);
        make.height.mas_equalTo(hButton);
    }];
    
    btnSignIn.layer.cornerRadius = btnRegister.layer.cornerRadius = hButton/2;
    btnSignIn.titleLabel.font = btnRegister.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnSignIn.layer.borderWidth = btnRegister.layer.borderWidth = 1.0;
    
    lbCompany.font = [AppDelegate sharedInstance].fontRegular;
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewBottom);
        make.height.mas_equalTo(hBottom);
    }];
    
    //  PATH
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, hTopView-hCurve)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, hTopView-hCurve) controlPoint:CGPointMake(SCREEN_WIDTH/2, hTopView+hCurve)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    //  shapeLayer.fillColor = UIColor.clearColor.CGColor;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, hTopView+2*hCurve);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(id)UIColor.whiteColor.CGColor, (id)UIColor.whiteColor.CGColor];
    
    [viewTop.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
    
    //  For bottom view
    CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
    bottomGradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-hTopView+2*hCurve);
    bottomGradientLayer.startPoint = CGPointMake(0, 0);
    bottomGradientLayer.endPoint = CGPointMake(1, 1);
    bottomGradientLayer.colors = @[(id)[UIColor colorWithRed:(11/255.0) green:(97/255.0) blue:(198/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(41/255.0) green:(121/255.0) blue:(218/255.0) alpha:1.0].CGColor];
    
    [viewBottom.layer insertSublayer:bottomGradientLayer atIndex:0];
}

- (IBAction)btnSignInPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:signInColor forState:UIControlStateNormal];
    [self performSelector:@selector(goToSignInView) withObject:nil afterDelay:0.1];
}

- (void)goToSignInView {
    btnSignIn.backgroundColor = signInColor;
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
    [self.navigationController pushViewController:signInVC animated:YES];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
    sender.backgroundColor = registerColor;
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self performSelector:@selector(goToRegisterView) withObject:nil afterDelay:0.1];
}

- (void)goToRegisterView {
    btnRegister.backgroundColor = UIColor.whiteColor;
    [btnRegister setTitleColor:registerColor forState:UIControlStateNormal];
    
    RegisterAccountViewController *registerVC = [[RegisterAccountViewController alloc] initWithNibName:@"RegisterAccountViewController" bundle:nil];
    [self.navigationController pushViewController:registerVC animated:YES];
}

@end
