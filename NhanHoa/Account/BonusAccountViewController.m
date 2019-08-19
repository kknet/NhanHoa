//
//  BonusAccountViewController.m
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BonusAccountViewController.h"
#import "BonusHistoryCell.h"
#import "AccountModel.h"
#import "WithdrawalBonusAccountViewController.h"

@interface BonusAccountViewController ()

@end

@implementation BonusAccountViewController
@synthesize viewInfo, imgBackground, btnWallet, lbTitle, lbMoney, btnWithdrawal;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_bonus_account;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self showBonusAccountInfo];
}

- (IBAction)btnWithdrawalPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startWithDraw) withObject:nil afterDelay:0.05];
}

- (void)startWithDraw {
    btnWithdrawal.backgroundColor = BLUE_COLOR;
    [btnWithdrawal setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    WithdrawalBonusAccountViewController *withdrawVC = [[WithdrawalBonusAccountViewController alloc] initWithNibName:@"WithdrawalBonusAccountViewController" bundle:nil];
    [self.navigationController pushViewController:withdrawVC animated:TRUE];
}

- (void)showBonusAccountInfo {
    NSString *cusPoint = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: cusPoint]) {
        cusPoint = [AppUtils convertStringToCurrencyFormat: cusPoint];
        lbMoney.text = [NSString stringWithFormat:@"%@VNĐ", cusPoint];
    }else{
        lbMoney.text = @"0VNĐ";
    }
}

- (void)setupUIForView {
    float padding = 15.0;
    float hIconWallet = 50.0;
    float hTitle = 25.0;
    float hMoney = 30.0;
    float hBTN = 45.0;
    
    btnWallet.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:22.0];
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        btnWallet.imageEdgeInsets = UIEdgeInsetsMake(18, 18, 18, 18);
        lbMoney.font = [UIFont fontWithName:RobotoMedium size:28.0];
        
        hIconWallet = 70.0;
        hTitle = 30.0;
        hMoney = 40.0;
        hBTN = 55.0;
        padding = 30.0;
    }
    
    //  view info
    float hInfo = padding + hIconWallet + 5.0 + hTitle + hMoney + 10.0;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hInfo);
    }];
    
    
    btnWallet.layer.cornerRadius = hIconWallet/2;
    btnWallet.layer.borderWidth = 1.0;
    btnWallet.layer.borderColor = UIColor.whiteColor.CGColor;
    btnWallet.backgroundColor = GREEN_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo).offset(padding);
        make.centerX.equalTo(viewInfo.mas_centerX);
        make.width.height.mas_equalTo(hIconWallet);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = GREEN_COLOR;
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWallet.mas_centerY);
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
        make.bottom.equalTo(viewInfo);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontRegular;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWallet.mas_bottom).offset(5.0);
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hMoney);
    }];
    
    btnWithdrawal.layer.cornerRadius = hBTN/2;
    btnWithdrawal.backgroundColor = BLUE_COLOR;
    btnWithdrawal.layer.borderColor = BLUE_COLOR.CGColor;
    btnWithdrawal.layer.borderWidth = 1.0;
    btnWithdrawal.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnWithdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
}

@end
