//
//  WithdrawalBonusAccountViewController.m
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WithdrawalBonusAccountViewController.h"

@interface WithdrawalBonusAccountViewController (){
    UIColor *unselectedColor;
}

@end

@implementation WithdrawalBonusAccountViewController
@synthesize viewInfo, imgBackground, imgWallet, btnWallet, lbTitle, lbMoney, lbDesc, lbNoti, btn500K, btn1000K, btn1500K, tfMoney, btnWithdrawal;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Rút tiền thưởng";
    [self setupUIForView];
}

- (IBAction)btn500KPress:(UIButton *)sender {
}

- (IBAction)btn1000KPress:(UIButton *)sender {
}

- (IBAction)btn1500KPress:(UIButton *)sender {
}

- (IBAction)btnWithdrawalPress:(UIButton *)sender {
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float hInfo = 140.0;
    float padding = 15.0;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
    
    //  view info
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hInfo);
    }];
    
    imgWallet.hidden = TRUE;
    imgWallet.layer.cornerRadius = 50.0/2;
    imgWallet.clipsToBounds = TRUE;
    [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    btnWallet.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    btnWallet.layer.cornerRadius = 50.0/2;
    btnWallet.layer.borderWidth = 1.0;
    btnWallet.layer.borderColor = UIColor.whiteColor.CGColor;
    btnWallet.backgroundColor = GREEN_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = GREEN_COLOR;
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnWallet.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.bottom.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgBackground.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
        make.height.mas_equalTo(25.0);
    }];
    
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:22.0];
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    //
    float hItem = 45.0;
    
    lbDesc.textColor = TITLE_COLOR;
    lbDesc.font = [UIFont fontWithName:RobotoMedium size:18.0];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(35.0);
    }];
    
    lbNoti.textColor = UIColor.grayColor;
    lbNoti.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbNoti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDesc.mas_bottom);
        make.left.right.equalTo(self.lbDesc);
        make.height.mas_equalTo(15.0);
    }];
    
    unselectedColor = [UIColor colorWithRed:(236/255.0) green:(239/255.0) blue:(244/255.0) alpha:1.0];
    
    float wButton = (SCREEN_WIDTH - 3*padding)/3;
    btn1000K.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    btn1000K.backgroundColor = unselectedColor;
    [btn1000K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    btn1000K.layer.cornerRadius = 6.0;
    [btn1000K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.lbNoti.mas_bottom).offset(10.0);
        make.width.mas_equalTo(wButton);
        make.height.mas_equalTo(hItem);
    }];
    
    btn500K.titleLabel.font = btn1000K.titleLabel.font;
    btn500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn500K.backgroundColor = unselectedColor;
    [btn500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btn1000K);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.btn1000K.mas_left).offset(-padding);
    }];
    
    btn1500K.titleLabel.font = btn1000K.titleLabel.font;
    btn1500K.layer.cornerRadius = btn1000K.layer.cornerRadius;
    btn1500K.backgroundColor = unselectedColor;
    [btn1500K setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btn1500K mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btn1000K);
        make.left.equalTo(self.btn1000K.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    tfMoney.keyboardType = UIKeyboardTypeNumberPad;
    tfMoney.textColor = TITLE_COLOR;
    tfMoney.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [tfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1000K.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
    
    btnWithdrawal.layer.cornerRadius = hItem/2;
    btnWithdrawal.backgroundColor = BLUE_COLOR;;
    btnWithdrawal.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnWithdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
}

@end
