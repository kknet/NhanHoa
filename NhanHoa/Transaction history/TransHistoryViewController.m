//
//  TransHistoryViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "TransHistoryViewController.h"

@interface TransHistoryViewController ()<WebServiceUtilsDelegate>

@end

@implementation TransHistoryViewController
@synthesize lbNoData, lbBottomSepa;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"TransHistoryViewController"];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getTransactionsHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    lbBottomSepa.backgroundColor = LIGHT_GRAY_COLOR;
    [lbBottomSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(1.0);
    }];
    
    lbNoData.textColor = TITLE_COLOR;
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.lbBottomSepa.mas_top);
    }];
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToGetTransactionsHistoryWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error =  %@", __FUNCTION__, @[error]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    [self.view makeToast:@"Không thể lấy được lịch sử giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getTransactionsHistorySuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data =  %@", __FUNCTION__, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    NSLog(@"%@", data);
}

@end
