//
//  HomeViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController (){
    
}

@end

@implementation HomeViewController
@synthesize viewSearch, tfSearch, icNotify, icClear, imgSearch;
@synthesize viewBanner;
@synthesize viewWallet,viewMainWallet, imgMainWallet, lbMainWallet, lbMoney;
@synthesize viewRewards, imgRewards, lbRewards, lbRewardsPoints, clvMenu;
@synthesize hMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)icNotifyClick:(UIButton *)sender {
}

- (IBAction)icClearClick:(UIButton *)sender {
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float padding = 10.0;
    float hWallet = 70.0;
    float hSearch = 70.0;
    
    [viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hSearch);
    }];
    
    hMenu = 100;
    [clvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(3*self.hMenu);
    }];
    
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.clvMenu.mas_top).offset(-padding);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hWallet);
    }];
    
    viewBanner.backgroundColor = UIColor.lightGrayColor;
    [viewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.viewSearch.mas_bottom);
        make.bottom.equalTo(self.viewWallet.mas_top).offset(-padding);
    }];
}



@end
