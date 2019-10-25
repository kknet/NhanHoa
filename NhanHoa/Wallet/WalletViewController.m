//
//  WalletViewController.m
//  NhanHoa
//
//  Created by OS on 10/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WalletViewController.h"

@interface WalletViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    UIColor *disableColor;
}
@end

@implementation WalletViewController

@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvContent, viewTop, btnMainWallet, btnBonusWallet, lbBalance, lbCurrency, lbMoney, tbHistory, viewFooter, btnTopUp;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    float hBTN = 50.0;
    
    disableColor = [UIColor colorWithRed:(53/255.0) green:(123/255.0) blue:(214/255.0) alpha:1.0];
    
    textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    }
    //  header view
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height + 40.0);
    }];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
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
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = 18.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(18.0);
    }];
    
    //  content
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-hBTN - 20.0);
    }];
    
    float hTop = padding + hBTN + padding + 25.0 + hBTN + padding;
    viewTop.backgroundColor = UIColor.clearColor;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTop);
    }];
    [AppUtils addCurvePathForViewWithHeight:hTop forView:viewTop withColor:BLUE_COLOR heightCurve:15.0];

    btnMainWallet.layer.cornerRadius = btnBonusWallet.layer.cornerRadius = hBTN/2;
    btnMainWallet.titleLabel.font = btnBonusWallet.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];

    float sizeBTN = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Bonus wallet"]
                                     withFont:btnMainWallet.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 20.0;

    btnMainWallet.backgroundColor = UIColor.whiteColor;
    [btnMainWallet setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btnMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(padding);
        make.right.equalTo(viewTop.mas_centerX).offset(-padding);
        make.width.mas_equalTo(sizeBTN);
        make.height.mas_equalTo(hBTN);
    }];

    btnBonusWallet.backgroundColor = disableColor;
    [btnBonusWallet setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnMainWallet.mas_right).offset(padding);
        make.top.bottom.equalTo(btnMainWallet);
        make.width.mas_equalTo(sizeBTN);
    }];

    lbBalance.textColor = UIColor.whiteColor;
    lbBalance.font = btnBonusWallet.titleLabel.font;
    [lbBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnMainWallet.mas_bottom).offset(padding);
        make.left.right.equalTo(viewTop);
        make.height.mas_equalTo(25.0);
    }];

    lbMoney.textColor = UIColor.whiteColor;
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:30.0];
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBalance.mas_bottom);
        make.left.right.equalTo(lbBalance);
        make.height.mas_equalTo(hBTN);
    }];

    tbHistory.delegate = self;
    tbHistory.dataSource = self;
    [tbHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom);
        make.left.right.equalTo(viewTop);
        make.height.mas_equalTo(0);
    }];

    //  footer view
    viewFooter.backgroundColor = UIColor.clearColor;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hBTN + 20.0);
    }];

    btnTopUp.layer.cornerRadius = 8.0;
    btnTopUp.backgroundColor = BLUE_COLOR;
    btnTopUp.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    [btnTopUp setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnTopUp setTitle:[appDelegate.localization localizedStringForKey:@"Top up"]
              forState:UIControlStateNormal];
    [btnTopUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnMainWalletPress:(UIButton *)sender {
}

- (IBAction)btnBonusWalletPress:(UIButton *)sender {
}

- (IBAction)btnTopUpPress:(UIButton *)sender {
}
@end
