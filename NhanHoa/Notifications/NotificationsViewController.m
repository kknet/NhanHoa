//
//  NotificationsViewController.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NotificationsViewController.h"
#import "NotificationTbvCell.h"

@interface NotificationsViewController ()<WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    float padding;
    
    NSMutableArray *listNotifs;
}
@end

@implementation NotificationsViewController
@synthesize viewHeader, lbHeader, icTrash, tbContent, imgEmptyNotif;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self showContentWithCurrentLanguage];
    [self showEmptyView: FALSE];
    
    //  prepare array
    if (listNotifs == nil) {
        listNotifs = [[NSMutableArray alloc] init];
    }else{
        [listNotifs removeAllObjects];
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading..."] Interaction:FALSE];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getTransactionsHistory];
}

- (IBAction)icTrashClick:(UIButton *)sender {
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Notifications"];
    
    //  show empty image
    UIImage *imgEmpty = [UIImage imageNamed:SFM(@"no_notification_%@", [appDelegate.localization activeLanguage])];
    imgEmptyNotif.image = imgEmpty;
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    
    self.view.backgroundColor = GRAY_240;
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    }
    
    //  header
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icTrash.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icTrash mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  tbcontent
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"NotificationTbvCell" bundle:nil] forCellReuseIdentifier:@"NotificationTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(5.0);
        make.left.equalTo(self.view).offset(padding/2);
        make.right.equalTo(self.view).offset(-padding/2);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
    }];
    
    //  notif
    [imgEmptyNotif mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.width.height.mas_equalTo(250.0);
    }];
}

- (void)showEmptyView: (BOOL)show {
    imgEmptyNotif.hidden = !show;
    tbContent.hidden = show;
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listNotifs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NotificationTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotificationTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        cell.imgNotifUnread.hidden = FALSE;
        cell.lbTitle.textColor = GRAY_50;
        
    }else{
        cell.imgNotifUnread.hidden = TRUE;
        cell.lbTitle.textColor = GRAY_100;
    }
    
    
    NSDictionary *info = [listNotifs objectAtIndex: indexPath.row];
    NSString *content = [info objectForKey:@"content"];
    cell.lbTitle.text = content;
    
    [cell displayContentForCellWithInfo: info];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToGetTransactionsHistoryWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)getTransactionsHistorySuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSArray class]] ) {
        [self prepareToDisplayWithData: (NSArray *)data];
    }else{
        [self showEmptyView: TRUE];
    }
}

- (void)prepareToDisplayWithData: (NSArray *)data {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [self prepareDataWithInfo: data];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (listNotifs.count == 0) {
                [self showEmptyView: TRUE];
            }else{
                [self showEmptyView: FALSE];
            }
            [tbContent reloadData];
        });
    });
}

- (void)prepareDataWithInfo: (NSArray *)array {
    if (array.count > 0) {
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"time"
                                                                    ascending: FALSE];
        array = [array sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]];
        [listNotifs addObjectsFromArray: array];
    }
}

@end
