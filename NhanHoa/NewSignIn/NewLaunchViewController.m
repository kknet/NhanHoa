//
//  NewLaunchViewController.m
//  NhanHoa
//
//  Created by OS on 10/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewLaunchViewController.h"

@interface NewLaunchViewController (){
    float padding;
}
@end

@implementation NewLaunchViewController
@synthesize imgLogo, clvDesc, btnSignIn, btnSignUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
}

- (void)setupUIForView {
    padding = 15.0;
    
    UIImage *image = [UIImage imageNamed:@"logo"];
    float realWidth = SCREEN_WIDTH * 2/4;
    float realHeight = realWidth * image.size.height / image.size.width;
    
    [imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(realWidth);
        make.height.mas_equalTo(realHeight);
    }];
    
    float sizeButton = (SCREEN_WIDTH - 3*padding)/2;
    float hButton = 50.0;
    
    btnSignIn.layer.cornerRadius = btnSignUp.layer.cornerRadius = 7.0;
    
    btnSignIn.backgroundColor = BLUE_COLOR;
    btnSignIn.titleLabel.font = [UIFont fontWithName:RobotoMedium size:19.0];
    [btnSignIn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSignIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-padding-[AppDelegate sharedInstance].safeAreaBottomPadding);
        make.width.mas_equalTo(sizeButton);
        make.height.mas_equalTo(hButton);
    }];
    [AppUtils addBoxShadowForView:btnSignIn color:[UIColor colorWithRed:(150/255.0) green:(150/255.0)
                                                                   blue:(150/255.0) alpha:0.8]
                          opacity:1.0 offsetX:1.0 offsetY:1.0];
    
    btnSignUp.backgroundColor = UIColor.whiteColor;
    btnSignUp.titleLabel.font = [UIFont fontWithName:RobotoMedium size:19.0];
    [btnSignUp setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnSignUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnSignIn.mas_right).offset(padding);
        make.top.bottom.equalTo(btnSignIn);
        make.width.mas_equalTo(sizeButton);
    }];
    [AppUtils addBoxShadowForView:btnSignUp color:[UIColor colorWithRed:(200/255.0) green:(200/255.0)
                                                                   blue:(200/255.0) alpha:0.8]
                          opacity:1.0 offsetX:1.0 offsetY:1.0];
}

@end
