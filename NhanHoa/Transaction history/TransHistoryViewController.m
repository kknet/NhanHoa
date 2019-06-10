//
//  TransHistoryViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "TransHistoryViewController.h"
#import "TransHistoryCell.h"

@interface TransHistoryViewController ()<WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *historyList;
}
@end

@implementation TransHistoryViewController
@synthesize lbNoData, lbBottomSepa, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"TransHistoryViewController"];
    
    lbNoData.hidden = TRUE;
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getTransactionsHistory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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
    
    [tbContent registerNib:[UINib nibWithNibName:@"TransHistoryCell" bundle:nil] forCellReuseIdentifier:@"TransHistoryCell"];
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.lbNoData);
    }];
}

- (void)prepareToDisplayWithData: (NSArray *)data {
    if (historyList == nil) {
        historyList = [[NSMutableArray alloc] init];
    }else{
        [historyList removeAllObjects];
    }
    [historyList addObjectsFromArray: data];
    lbNoData.hidden = TRUE;
    tbContent.hidden = FALSE;
    [tbContent reloadData];
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToGetTransactionsHistoryWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error =  %@", __FUNCTION__, @[error]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    [self.view makeToast:@"Không thể lấy được lịch sử giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getTransactionsHistorySuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data =  %@", __FUNCTION__, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    if (data != nil && [data isKindOfClass:[NSArray class]] ) {
        [self prepareToDisplayWithData: (NSArray *)data];
    }
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return historyList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransHistoryCell"];
    
    NSDictionary *info = [historyList objectAtIndex: indexPath.row];
    [cell displayDataWithInfo: info];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

@end
