//
//  LaunchViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    self.view.backgroundColor = UIColor.blueColor;
    
    padding = 40.0;
    viewTop.backgroundColor = UIColor.clearColor;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(self.view.mas_height).multipliedBy(0.6);
    }];
    
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.viewTop.mas_bottom);
    }];
    
    float hButton = 45.0;
    btnSignIn.layer.cornerRadius = hButton/2;
    btnSignIn.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewBottom).offset(self.padding);
        make.right.equalTo(self.viewBottom).offset(-self.padding);
        make.bottom.equalTo(self.viewBottom.mas_centerY).offset(-7.5);
        make.height.mas_equalTo(hButton);
    }];
    
    btnRegister.layer.cornerRadius = hButton/2;
    btnRegister.titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewBottom).offset(self.padding);
        make.right.equalTo(self.viewBottom).offset(-self.padding);
        make.top.equalTo(self.viewBottom.mas_centerY).offset(7.5);
        make.height.mas_equalTo(hButton);
    }];
    
    lbCompany.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.viewBottom);
        make.height.mas_equalTo(hButton);
    }];
    
    float hHeader = SCREEN_HEIGHT * 3/5;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, hHeader-40)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, hHeader-40) controlPoint:CGPointMake(SCREEN_WIDTH/2, hHeader+40)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    //  shapeLayer.fillColor = UIColor.clearColor.CGColor;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, hHeader+80);
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.colors = @[(id)UIColor.whiteColor.CGColor, (id)UIColor.whiteColor.CGColor];
    
    //Add gradient layer to view
    [viewTop.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
}

- (IBAction)btnSignInPress:(UIButton *)sender {
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
}
@end
