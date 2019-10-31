//
//  DNSRecordsViewController.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSRecordsViewController.h"
#import "DNSRecordsTbvCell.h"
#import "AddDNSRecordsView.h"

@interface DNSRecordsViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>{
    AppDelegate *appDelegate;
    UIFont *textFont;
    float padding;
    float hBTN;
    float hCell;
    
    NSMutableArray *recordList;
    
    AddDNSRecordsView *addRecordsView;
}
@end

@implementation DNSRecordsViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, viewFooter, btnAddRecord, tbRecords, viewNotSupport, lbInfo, btnChange;
@synthesize supportDNSRecords, domainName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [btnAddRecord setTitle:[appDelegate.localization localizedStringForKey:@"Add New Record"] forState:UIControlStateNormal];
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"DNS Records management"];
    [btnChange setTitle:[appDelegate.localization localizedStringForKey:@"Change Name Server"] forState:UIControlStateNormal];
    
    if (supportDNSRecords) {
        viewNotSupport.hidden = TRUE;
        //  [self addRightBarButtonForNavigationBar];
        [self getDNSRecordListForDomain];
    }else{
        viewNotSupport.hidden = FALSE;
    }
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 45.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    self.view.backgroundColor = GRAY_240;
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
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
    
    //  scrollview content
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hBTN + 2*padding);
    }];
    [AppUtils addBoxShadowForView:viewFooter color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:-1.0];
    
    //  footer buttons
    btnAddRecord.backgroundColor = BLUE_COLOR;
    btnAddRecord.layer.cornerRadius = 8.0;
    btnAddRecord.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    btnAddRecord.clipsToBounds = TRUE;
    [btnAddRecord setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnAddRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  table content
    hCell = 10.0 + 18.0 + 28.0 + 28.0 + 18.0 + 10.0 + 10.0;
    [tbRecords registerNib:[UINib nibWithNibName:@"DNSRecordsTbvCell" bundle:nil] forCellReuseIdentifier:@"DNSRecordsTbvCell"];
    tbRecords.separatorStyle = UITableViewCellSelectionStyleNone;
    tbRecords.backgroundColor = UIColor.clearColor;
    tbRecords.delegate = self;
    tbRecords.dataSource = self;
    [tbRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(3.0);
        make.left.equalTo(self.view).offset(padding/2);
        make.right.equalTo(self.view).offset(-padding/2);
        make.bottom.equalTo(viewFooter.mas_top).offset(-3.0);
    }];
    
    //  no support view
    viewNotSupport.hidden = TRUE;
    [viewNotSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(3.0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    lbInfo.numberOfLines = 15;
    lbInfo.font = [AppDelegate sharedInstance].fontBTN;
    lbInfo.textAlignment = NSTextAlignmentCenter;
    lbInfo.textColor = TITLE_COLOR;
    lbInfo.text = @"Tên miền của bạn đang sử dụng name server không thuộc hệ thống Nhân Hòa, bạn cần đổi name server theo thông tin bên dưới sau đó vào lại mục này.\n\nns1.zonedns.vn\nns2.zonedns.vn\nns3.zonedns.vn\nns4.zonedns.vn";
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewNotSupport.mas_centerY).offset(-10.0);
        make.left.equalTo(viewNotSupport).offset(5.0);
        make.right.equalTo(viewNotSupport).offset(-5.0);
    }];
    
    btnChange.backgroundColor = BLUE_COLOR;
    btnChange.layer.borderWidth = 1.0;
    btnChange.layer.borderColor = BLUE_COLOR.CGColor;
    btnChange.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnChange.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnChange setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    
    float sizeBTN = [AppUtils getSizeWithText:btnChange.currentTitle withFont:btnChange.titleLabel.font].width + 20.0;
    [btnChange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewNotSupport.mas_centerY).offset(10.0);
        make.centerX.equalTo(viewNotSupport.mas_centerX);
        make.width.mas_equalTo(sizeBTN);
        make.height.mas_equalTo(45.0);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnAddRecordPress:(UIButton *)sender {
    if (addRecordsView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"AddDNSRecordsView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[AddDNSRecordsView class]]) {
                addRecordsView = (AddDNSRecordsView *) currentObject;
                break;
            }
        }
        [self.view addSubview: addRecordsView];
    }
    [addRecordsView setupUIForViewWithHeighNav: self.navigationController.navigationBar.frame.size.height];
    
    [addRecordsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self performSelector:@selector(showAddDNSRecordsView) withObject:nil afterDelay:0.2];
}

- (IBAction)btnChangePress:(UIButton *)sender {
}

- (void)showAddDNSRecordsView {
    [addRecordsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - WebserviceUtil Delegate
-(void)failedToGetDNSRecordList:(id)error {
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)getDNSRecordsListSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self prepareDataToDisplay: data];
}

- (void)getDNSRecordListForDomain {
    if (recordList == nil) {
        recordList = [[NSMutableArray alloc] init];
    }else{
        [recordList removeAllObjects];
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading..."] Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getDNSRecordListOfDomain: domainName];
}

- (void)prepareDataToDisplay: (NSDictionary *)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSArray *recordsArr = [data objectForKey:@"domain_record"];
        if (recordsArr != nil && [recordsArr isKindOfClass:[NSArray class]]) {
            [recordList addObjectsFromArray: recordsArr];
        }
    }
    
    [tbRecords reloadData];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recordList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNSRecordsTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DNSRecordsTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [recordList objectAtIndex: indexPath.row];
    [cell showDNSRecordContentWithInfo: info];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-padding, 50.0)];
    
    UILabel *lbCount = [[UILabel alloc] init];
    lbCount.text = SFM(@"%@:", [appDelegate.localization localizedStringForKey:@"Count"]);
    lbCount.textAlignment = NSTextAlignmentLeft;
    lbCount.textColor = GRAY_150;
    [viewSection addSubview: lbCount];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(viewSection);
        make.right.equalTo(viewSection.mas_centerX);
    }];
    
    UILabel *lbRecords = [[UILabel alloc] init];
    lbRecords.text = SFM(@"%d %@", (int)recordList.count, [appDelegate.localization localizedStringForKey:@"records"]);
    lbRecords.textAlignment = NSTextAlignmentRight;
    lbRecords.textColor = GRAY_150;
    [viewSection addSubview: lbRecords];
    [lbRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(viewSection);
        make.left.equalTo(viewSection.mas_centerX);
    }];
    
    lbCount.font = lbRecords.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-2];
    
    return viewSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0;
}

@end
