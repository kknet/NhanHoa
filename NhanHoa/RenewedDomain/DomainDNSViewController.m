//
//  DomainDNSViewController.m
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainDNSViewController.h"
#import "DNSManagerCell.h"
#import "DNSDetailCell.h"
#import "DNSRecordManagerView.h"

@interface DomainDNSViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate, DNSRecordManagerViewDelegate> {
    float hCell;
    NSMutableArray *recordList;
    float wContent;
    DNSRecordManagerView *addDNSRecordView;
    DNSRecordManagerView *editDNSRecordView;
}
@end

@implementation DomainDNSViewController
@synthesize scvContent, tbRecords, domainName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Quản lý DNS";
    hCell = 50.0;
    
    scvContent.showsVerticalScrollIndicator = FALSE;
    scvContent.showsHorizontalScrollIndicator = FALSE;
    scvContent.pagingEnabled = TRUE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    float hContent = SCREEN_HEIGHT;
    wContent = UIScreen.mainScreen.bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    
    [tbRecords registerNib:[UINib nibWithNibName:@"DNSDetailCell" bundle:nil] forCellReuseIdentifier:@"DNSDetailCell"];
    tbRecords.separatorStyle = UITableViewCellSelectionStyleNone;
    tbRecords.scrollEnabled = FALSE;
    tbRecords.delegate = self;
    tbRecords.dataSource = self;
    [tbRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(wContent);
        make.height.mas_equalTo(hContent);
    }];
    
    scvContent.contentSize = CGSizeMake(wContent, hContent);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"DomainDNSViewController"];
    
    //  hide cart button to show icon add new dns record
    [AppDelegate sharedInstance].cartView.hidden = TRUE;
    [self addRightBarButtonForNavigationBar];
    
    [self getDNSRecordListForDomain];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification object:[UIDevice currentDevice]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [AppDelegate sharedInstance].cartView.hidden = FALSE;
}

- (void) orientationChanged:(NSNotification *)note
{
    UIDevice * device = note.object;
    self.view.backgroundColor = UIColor.whiteColor;
    if (device.orientation == UIDeviceOrientationLandscapeRight) {
        [UIView animateWithDuration:0.2 delay:0.0
                            options:0 animations:^{
                                scvContent.transform = CGAffineTransformMakeRotation(-M_PI/2);
                                scvContent.frame = self.view.bounds;
                                
                            }completion:^(BOOL finished){
                                NSLog(@"Done!");
                            }];
    }else if (device.orientation == UIDeviceOrientationLandscapeLeft){
        [UIView animateWithDuration:0.2 delay:0.0
                            options:0 animations:^{
                                scvContent.transform = CGAffineTransformMakeRotation(M_PI/2);
                                scvContent.frame = self.view.bounds;
                                
                            }completion:^(BOOL finished){
                                NSLog(@"Done!");
                            }];
    }else if (device.orientation == UIDeviceOrientationPortrait){
        [UIView animateWithDuration:0.2 delay:0.0
                            options:0 animations:^{
                                scvContent.transform = CGAffineTransformMakeRotation(0);
                                scvContent.frame = self.view.bounds;
                                
                            }completion:^(BOOL finished){
                                NSLog(@"Done!");
                            }];
    }else {
        
    }
}

- (void)addRightBarButtonForNavigationBar {
    UIView *viewAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    viewAdd.backgroundColor = UIColor.clearColor;
    
    UIButton *btnAdd =  [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btnAdd.frame = CGRectMake(15, 0, 40, 40);
    btnAdd.backgroundColor = UIColor.clearColor;
    [btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addNewDNSRecord) forControlEvents:UIControlEventTouchUpInside];
    [viewAdd addSubview: btnAdd];
    
    UIBarButtonItem *btnAddBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: viewAdd];
    self.navigationItem.rightBarButtonItems = @[btnAddBarButtonItem];
}

- (void)addNewDNSRecord {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (addDNSRecordView == nil) {
        [self addDNSRecordViewToMainView];
    }
    addDNSRecordView.delegate = self;
    addDNSRecordView.domain = domainName;
    [addDNSRecordView showContentForView];
    
    [self performSelector:@selector(showAddNewDNSRecordView) withObject:nil afterDelay:0.1];
}

- (void)showAddNewDNSRecordView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [addDNSRecordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.navigationController.navigationBarHidden = TRUE;
    }];
}

-(void)closeAddDNSRecordView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    self.navigationController.navigationBarHidden = FALSE;
    if (addDNSRecordView != nil) {
        [addDNSRecordView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    if (editDNSRecordView != nil) {
        [editDNSRecordView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)addNewRecordSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [self getDNSRecordListForDomain];
}

- (void)getDNSRecordListForDomain {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domainName = %@", __FUNCTION__, domainName)];
    
    if (recordList == nil) {
        recordList = [[NSMutableArray alloc] init];
    }else{
        [recordList removeAllObjects];
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang tải danh sách..." Interaction:NO];
    
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
    float hContent = hCell*recordList.count + hCell;
    [tbRecords mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(wContent);
        make.height.mas_equalTo(hContent);
    }];
    scvContent.contentSize = CGSizeMake(wContent, hContent);
    
    
    [tbRecords reloadData];
}

- (void)addDNSRecordViewToMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"DNSRecordManagerView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[DNSRecordManagerView class]]) {
            addDNSRecordView = (DNSRecordManagerView *) currentObject;
            break;
        }
    }
    [self.view addSubview: addDNSRecordView];
    [addDNSRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(0);
        
    }];
    [addDNSRecordView setupUIForViewWithType: DNSRecordAddNew];
}

- (void)addEditDNSRecordViewToMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"DNSRecordManagerView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[DNSRecordManagerView class]]) {
            editDNSRecordView = (DNSRecordManagerView *) currentObject;
            break;
        }
    }
    [self.view addSubview: editDNSRecordView];
    [editDNSRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(0);
        
    }];
    [editDNSRecordView setupUIForViewWithType: DNSRecordUpdate];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recordList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNSDetailCell *cell = (DNSDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"DNSDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [recordList objectAtIndex: indexPath.row];
    [cell showDNSRecordContentWithInfo: info];
    
    cell.icEdit.tag = indexPath.row;
    [cell.icEdit addTarget:self
                    action:@selector(clickOnEditDNSRecord:)
          forControlEvents:UIControlEventTouchUpInside];
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = UIColor.whiteColor;
    }else{
        cell.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    }
    
    return cell;
}

- (void)clickOnEditDNSRecord: (UIButton *)sender {
    NSDictionary *info = [recordList objectAtIndex: sender.tag];
    if (editDNSRecordView == nil) {
        [self addEditDNSRecordViewToMainView];
    }
    editDNSRecordView.delegate = self;
    editDNSRecordView.domain = domainName;
    [editDNSRecordView showDNSRecordContentWithInfo: info];
    [self performSelector:@selector(showEditDNSRecordView) withObject:nil afterDelay:0.1];
}

- (void)showEditDNSRecordView {
    [editDNSRecordView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.navigationController.navigationBarHidden = TRUE;
    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%d", (int)indexPath.row);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    float wHost = 90.0;
    float widthMX = 60.0;
    float widthTTL = 60.0;
    float widthValue = 120.0;
    float widthType = 40.0;
    float padding = 5.0;
    float widthBTN = 40.0;
    
    NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        wHost = 80.0;
        widthTTL = 40.0;
        widthMX = 25.0;
        widthType = 75.0;
        widthBTN = 25.0;
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        wHost = 80.0;
        widthTTL = 45.0;
        widthMX = 30.0;
        widthType = 90.0;
        widthBTN = 35.0;
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2] || [deviceMode isEqualToString: simulator])
    {
        //  for 6s plus
        widthTTL = 50.0;
        widthMX = 40.0;
        widthType = 95.0;
        widthBTN = 40.0;
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2])
    {
        widthMX = widthTTL = 50.0;
        widthType = 120.0;
        widthBTN = 60.0;
        
    }
    
    float wContent = UIScreen.mainScreen.bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height;
    
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wContent, 40.0)];
    viewSection.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    
    widthValue = wContent - (padding + wHost + padding + 1.0 + (padding + widthType + padding) + 1.0 + (padding + padding) + 1.0 + (padding + widthMX + padding) + 1.0 + (padding + widthTTL + padding) + 1.0 + (padding + widthBTN + padding) + 1.0 + (padding + widthBTN + padding));
    
    UILabel *lbHost = [[UILabel alloc] init];
    lbHost.text = @"Tên";
    [viewSection addSubview: lbHost];
    [lbHost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSection).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.width.mas_equalTo(wHost);
    }];
    
    UILabel *lbSepa1 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa1];
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbHost.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbType = [[UILabel alloc] init];
    lbType.text = @"Loại";
    [viewSection addSubview: lbType];
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa1.mas_right).offset(padding);
        make.width.height.mas_equalTo(widthType);
    }];
    
    UILabel *lbSepa2 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa2];
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbType.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbValue = [[UILabel alloc] init];
    lbValue.text = @"Giá trị";
    [viewSection addSubview: lbValue];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa2.mas_right).offset(padding);
        make.width.mas_equalTo(widthValue);
    }];
    
    UILabel *lbSepa3 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa3];
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbValue.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbMX = [[UILabel alloc] init];
    lbMX.text = @"MX";
    [viewSection addSubview: lbMX];
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa3.mas_right).offset(padding);
        make.width.mas_equalTo(widthMX);
    }];
    
    UILabel *lbSepa4 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa4];
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbMX.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbTTL = [[UILabel alloc] init];
    lbTTL.text = @"TTL";
    [viewSection addSubview: lbTTL];
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbSepa4.mas_right).offset(padding);
        make.width.mas_equalTo(widthTTL);
    }];
    
    UILabel *lbSepa5 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa5];
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbTTL.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbEdit = [[UILabel alloc] init];
    lbEdit.text = @"Sửa";
    [viewSection addSubview: lbEdit];
    [lbEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa5.mas_right).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.width.height.mas_equalTo(widthBTN);
    }];
    
    UILabel *lbSepa6 = [[UILabel alloc] init];
    [viewSection addSubview: lbSepa6];
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(lbEdit.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    UILabel *lbRemove = [[UILabel alloc] init];
    lbRemove.text = @"Xóa";
    [viewSection addSubview: lbRemove];
    [lbRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa6.mas_right).offset(padding);
        make.top.bottom.equalTo(viewSection);
        make.width.mas_equalTo(widthBTN);
    }];
    
    lbHost.textAlignment = lbType.textAlignment = lbValue.textAlignment = lbMX.textAlignment = lbTTL.textAlignment = lbEdit.textAlignment = lbRemove.textAlignment = NSTextAlignmentCenter;
    lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0];
    
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        lbHost.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = lbEdit.font = lbRemove.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightMedium];
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        lbHost.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = lbEdit.font = lbRemove.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
    {
        lbHost.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = lbEdit.font = lbRemove.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
    {
        lbHost.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = lbEdit.font = lbRemove.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
        
    }
    
    return viewSection;
}

#pragma mark - WebserviceUtil Delegate
-(void)failedToGetDNSRecordList:(id)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString *content = [AppUtils getErrorContentFromData: error];
        [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([error isKindOfClass:[NSString class]]) {
        [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)getDNSRecordsListSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    [self prepareDataToDisplay: data];
}

@end
