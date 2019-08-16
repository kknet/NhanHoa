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
    NSMutableArray *listKey;
}
@end

@implementation TransHistoryViewController
@synthesize lbNoData, lbBottomSepa, tbContent, dataDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Lịch sử giao dịch";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"TransHistoryViewController"];
    
    lbNoData.hidden = TRUE;
    
    if (dataDict == nil) {
        dataDict = [[NSMutableDictionary alloc] init];
    }else{
        [dataDict removeAllObjects];
    }
    
    if (listKey == nil) {
        listKey = [[NSMutableArray alloc] init];
    }else{
        [listKey removeAllObjects];
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_loading Interaction:NO];
    
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
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self prepareDataWithInfo: data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.lbNoData.hidden = TRUE;
            self.tbContent.hidden = FALSE;
            [self.tbContent reloadData];
        });
    });
}

- (void)prepareDataWithInfo: (NSArray *)array {
    NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
                                                                ascending: FALSE];
    array = [array sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
    for (int index=0; index<array.count; index++) {
        NSDictionary *info = [array objectAtIndex: index];
        NSString *time = [info objectForKey:@"time"];
        NSString *date = [AppUtils getDateStringFromTimerInterval:[time longLongValue]];
        
        if (![listKey containsObject: date]) {
            [listKey addObject: date];
        }
        
        if (![AppUtils isNullOrEmpty: date]) {
            if (![[dataDict allKeys] containsObject: date]) {
                NSMutableArray *data = [[NSMutableArray alloc] init];
                [data addObject: info];
                [dataDict setObject:data forKey:date];
            }else{
                NSMutableArray *data = [dataDict objectForKey: date];
                if (data != nil && [data isKindOfClass:[NSMutableArray class]] && ![data containsObject: info]) {
                    [data addObject: info];
                    [dataDict setObject:data forKey:date];
                }
            }
        }
    }
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToGetTransactionsHistoryWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error =  %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getTransactionsHistorySuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data =  %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSArray class]] ) {
        [self prepareToDisplayWithData: (NSArray *)data];
    }else{
        lbNoData.hidden = FALSE;
        tbContent.hidden = TRUE;
    }
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return listKey.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = [listKey objectAtIndex: section];
    return [(NSArray *)[dataDict objectForKey: key] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TransHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransHistoryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = [listKey objectAtIndex: indexPath.section];
    NSDictionary *info = [[dataDict objectForKey: key] objectAtIndex: indexPath.row];
    [cell displayDataWithInfo: info];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *curDate = [listKey objectAtIndex: section];
    
    UIView *viewHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30.0)];
    viewHeader.backgroundColor = LIGHT_GRAY_COLOR;
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0, viewHeader.frame.size.width-30.0, viewHeader.frame.size.height)];
    lbTitle.font = [AppDelegate sharedInstance].fontMedium;
    lbTitle.textColor = TITLE_COLOR;
    [viewHeader addSubview: lbTitle];
    
    if ([curDate isEqualToString:[AppUtils getCurrentDate]]) {
        lbTitle.text = text_today;
        
    }else if ([curDate isEqualToString:[AppUtils getYesterdayDateString]]) {
        lbTitle.text = text_yesterday;
        
    }else{
        lbTitle.text = curDate;
    }
    
    return viewHeader;
}

@end
