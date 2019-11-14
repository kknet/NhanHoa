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
#import "DNSRecordPopupView.h"

@interface DNSRecordsViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate, AddDNSRecordsViewDelegate, DNSRecordPopupViewDelegate>
{
    AppDelegate *appDelegate;
    UIFont *textFont;
    float padding;
    float hBTN;
    float hCell;
    
    NSMutableArray *recordList;
    
    AddDNSRecordsView *dnsRecordsView;
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
    hBTN = 53.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hBTN = 53.0;
    }
    
    self.view.backgroundColor = UIColor.whiteColor;
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
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    //  scrollview content
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hBTN + 2*padding);
    }];
    [AppUtils addBoxShadowForView:viewFooter color:GRAY_200 opacity:0.8 offsetX:0.0 offsetY:-4.0];
    
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
    tbRecords.backgroundColor = GRAY_240;
    tbRecords.delegate = self;
    tbRecords.dataSource = self;
    [tbRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(3.0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top).offset(-3.0);
    }];
    
    //  no support view
    viewNotSupport.hidden = TRUE;
    [viewNotSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(3.0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    lbInfo.numberOfLines = 15;
    lbInfo.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
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
    btnChange.layer.cornerRadius = 10.0;
    btnChange.titleLabel.font = lbInfo.font;
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
    if (dnsRecordsView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"AddDNSRecordsView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[AddDNSRecordsView class]]) {
                dnsRecordsView = (AddDNSRecordsView *) currentObject;
                break;
            }
        }
        dnsRecordsView.delegate = self;
        [self.view addSubview: dnsRecordsView];
    }
    dnsRecordsView.typeView = eDNSRecordAddNew;
    dnsRecordsView.domain = domainName;
    [dnsRecordsView setupUIForViewWithHeighNav: self.navigationController.navigationBar.frame.size.height];
    
    [dnsRecordsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self performSelector:@selector(showAddDNSRecordsView) withObject:nil afterDelay:0.2];
}

- (IBAction)btnChangePress:(UIButton *)sender {
}

- (void)showAddDNSRecordsView {
    [dnsRecordsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - AddDNSRecordViewDelegate
-(void)closeAddDNSRecordView {
    [dnsRecordsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [dnsRecordsView removeFromSuperview];
        dnsRecordsView = nil;
    }];
}

- (void)addNewDNSRecordSuccessful {
    [self closeAddDNSRecordView];
    [self getDNSRecordListForDomain];
}

#pragma mark - WebserviceUtil Delegate
-(void)failedToDeleteDNSRecord:(id)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)deleteDNSRecordsSuccessfulWithData:(NSDictionary *)data
{
    [ProgressHUD dismiss];
    
    [self getDNSRecordListForDomain];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *message = [data objectForKey:@"message"];
        if (![AppUtils isNullOrEmpty: message]) {
            [self.view makeToast:message duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
            return;
        }
    }
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Record has been deleted successful"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
}

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
    
    cell.icDetail.tag = (int)indexPath.row;
    [cell.icDetail addTarget:self
                      action:@selector(showDNSRecordDetailsView:)
            forControlEvents:UIControlEventTouchUpInside];
    
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
        make.left.equalTo(viewSection).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.right.equalTo(viewSection.mas_centerX);
    }];
    
    UILabel *lbRecords = [[UILabel alloc] init];
    lbRecords.text = SFM(@"%d %@", (int)recordList.count, [appDelegate.localization localizedStringForKey:@"records"]);
    lbRecords.textAlignment = NSTextAlignmentRight;
    lbRecords.textColor = GRAY_150;
    [viewSection addSubview: lbRecords];
    [lbRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewSection).offset(-padding);
        make.top.bottom.equalTo(viewSection);
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

- (void)showDNSRecordDetailsView: (UIButton *)sender {
    if ((int)sender.tag < recordList.count) {
        NSDictionary *info = [recordList objectAtIndex: sender.tag];
        
        DNSRecordPopupView *popupView = [[DNSRecordPopupView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        popupView.delegate = self;
        [popupView displayRecordContentWithInfo: info];
        [popupView showInView:appDelegate.window animated:TRUE];
    }
}

#pragma mark - DNSRecordPopupViewDelegate
-(void)onButtonEditDNSRecordPressWithRecordId:(NSString *)recordId {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"record_id = %@", recordId];
    NSArray *filter = [recordList filteredArrayUsingPredicate: predicate];
    if (filter.count > 0) {
        if (dnsRecordsView == nil) {
            NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"AddDNSRecordsView" owner:nil options:nil];
            for(id currentObject in toplevelObject){
                if ([currentObject isKindOfClass:[AddDNSRecordsView class]]) {
                    dnsRecordsView = (AddDNSRecordsView *) currentObject;
                    break;
                }
            }
            dnsRecordsView.delegate = self;
            [self.view addSubview: dnsRecordsView];
        }
        dnsRecordsView.typeView = eDNSRecordEdit;
        dnsRecordsView.domain = domainName;
        [dnsRecordsView setupUIForViewWithHeighNav: self.navigationController.navigationBar.frame.size.height];
        [dnsRecordsView displayContentWithDNSInfo: (NSDictionary *)[filter firstObject]];
        
        [dnsRecordsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(SCREEN_HEIGHT);
        }];
        
        [self performSelector:@selector(showAddDNSRecordsView) withObject:nil afterDelay:0.2];
    }
}

-(void)onButtonDeleteDNSRecordPressWithRecordId:(NSString *)recordId {
    if (![AppUtils isNullOrEmpty: recordId])
    {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[appDelegate.localization localizedStringForKey:@"Do you want to delete this record?"]];
        [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize-2] range:NSMakeRange(0, attrTitle.string.length)];
        [alertVC setValue:attrTitle forKey:@"attributedTitle"];
        
        UIAlertAction *btnClose = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Close"] style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             
                                                         }];
        [btnClose setValue:BLUE_COLOR forKey:@"titleTextColor"];
        
        UIAlertAction *btnDelete = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Remove"] style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action){
                                                              [ProgressHUD backgroundColor: ProgressHUD_BG];
                                                              [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Deleting..."] Interaction:NO];
                                                              
                                                              [[WebServiceUtils getInstance] deleteDNSRecordForDomain:domainName record_id: recordId];
                                                          }];
        [btnDelete setValue:UIColor.redColor forKey:@"titleTextColor"];
        
        [alertVC addAction:btnClose];
        [alertVC addAction:btnDelete];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

@end
