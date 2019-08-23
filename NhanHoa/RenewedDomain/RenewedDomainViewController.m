//
//  RenewedDomainViewController.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RenewedDomainViewController.h"
#import "RenewDomainDetailViewController.h"
#import "ExpireDomainCell.h"
#import "AccountModel.h"

typedef enum TypeSelectDomain{
    eAllDomain,
    eExpireDomain,
}TypeSelectDomain;

@interface RenewedDomainViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate, UITextFieldDelegate>
{
    TypeSelectDomain type;
    
    NSMutableArray *listSearch;
    BOOL searching;
    NSTimer *searchTimer;
    
    float padding;
    float hCell;
}

@end

@implementation RenewedDomainViewController
@synthesize viewMenu, btnAllDomain, btnExpireDomain, tbDomain, lbNoData, tfSearch, icSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    self.title = @"Tên miền đã đăng ký";
    type = eAllDomain;
    lbNoData.hidden = TRUE;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"RenewedDomainViewController"];
    
    if (listSearch == nil) {
        listSearch = [[NSMutableArray alloc] init];
    }else{
        [listSearch removeAllObjects];
    }
    
    if (tfSearch.text.length > 0) {
        [self searchTextfieldChanged: tfSearch];
    }
    
    lbNoData.hidden = TRUE;
    type = eAllDomain;
    [self getDomainsWasRegisteredWithType: eAllDomain];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (IBAction)btnAllDomainPress:(UIButton *)sender {
    if (type == eAllDomain) {
        return;
    }
    
    tfSearch.text = @"";
    searching = FALSE;
    
    [WriteLogsUtils writeLogContent:SFM(@"Choose all domains tab")];
    
    [tbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.tfSearch.mas_bottom).offset(padding);
    }];
    
    type = eAllDomain;
    
    [btnAllDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = BLUE_COLOR;
    
    [btnExpireDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = UIColor.clearColor;
    
    if ([AppDelegate sharedInstance].listAllDomains != nil) {
        if ([AppDelegate sharedInstance].listAllDomains.count > 0) {
            lbNoData.hidden = TRUE;
            tbDomain.hidden = FALSE;
        }else{
            lbNoData.hidden = FALSE;
            tbDomain.hidden = TRUE;
        }
        [tbDomain reloadData];
    }else{
        [tbDomain reloadData];
        [self getDomainsWasRegisteredWithType: eAllDomain];
    }
}

- (IBAction)btnExpirePress:(UIButton *)sender {
    if (type == eExpireDomain) {
        return;
    }
    
    tfSearch.text = @"";
    searching = FALSE;
    
    [WriteLogsUtils writeLogContent:SFM(@"Choose expire domains tab")];
    
    [tbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tfSearch.mas_bottom).offset(padding);
        make.bottom.equalTo(self.view);
    }];
    
    type = eExpireDomain;
    [btnExpireDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = BLUE_COLOR;
    
    [btnAllDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = UIColor.clearColor;
    
    if ([AppDelegate sharedInstance].listExpireDomains != nil) {
        if ([AppDelegate sharedInstance].listExpireDomains.count > 0) {
            lbNoData.hidden = TRUE;
            tbDomain.hidden = FALSE;
        }else{
            lbNoData.hidden = FALSE;
            tbDomain.hidden = TRUE;
        }
        [tbDomain reloadData];
    }else{
        [tbDomain reloadData];
        [self getDomainsWasRegisteredWithType: eExpireDomain];
    }
}

- (IBAction)icSearchClick:(UIButton *)sender {
    tfSearch.text = @"";
    sender.hidden = TRUE;
    searching = FALSE;
    [listSearch removeAllObjects];
    
    lbNoData.hidden = TRUE;
    tbDomain.hidden = FALSE;
    [tbDomain reloadData];
}

- (void)setupUIForView {
    float hTextfield = [AppDelegate sharedInstance].hTextfield;
    btnAllDomain.titleLabel.font = btnExpireDomain.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    padding = 15.0;
    hCell = 65.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    float hMenu = 40.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        btnAllDomain.titleLabel.font = btnExpireDomain.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
        padding = 30.0;
        hMenu = 55.0;
        hTextfield = 45.0;
        hCell = 80.0;
    }
    
    viewMenu.layer.cornerRadius = hMenu/2;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15.0);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hMenu);
    }];
    
    [btnAllDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = BLUE_COLOR;
    btnAllDomain.layer.cornerRadius = hMenu/2;
    [btnAllDomain setTitle:text_all_domains forState:UIControlStateNormal];
    [btnAllDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(viewMenu);
        make.right.equalTo(viewMenu.mas_centerX);
    }];
    
    [btnExpireDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = UIColor.clearColor;
    btnExpireDomain.layer.cornerRadius = hMenu/2;
    [btnExpireDomain setTitle:text_about_to_expire forState:UIControlStateNormal];
    [btnExpireDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu.mas_centerX);
        make.right.top.bottom.equalTo(viewMenu);
    }];
    
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    tfSearch.placeholder = text_enter_to_search;
    tfSearch.font = [AppDelegate sharedInstance].fontRegular;
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.layer.cornerRadius = hTextfield/2;
    tfSearch.layer.borderColor = BLUE_COLOR.CGColor;
    tfSearch.layer.borderWidth = 1.0;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(15.0);
        make.left.right.equalTo(viewMenu);
        make.height.mas_equalTo(hTextfield);
    }];
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldChanged:)
       forControlEvents:UIControlEventEditingChanged];
    
    if (tfSearch.text.length == 0) {
        icSearch.hidden = TRUE;
    }else{
        icSearch.hidden = FALSE;
    }
    
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    icSearch.backgroundColor = BORDER_COLOR;
    icSearch.layer.cornerRadius = (hTextfield-6.0)/2;
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfSearch).offset(-3.0);
        make.top.equalTo(tfSearch).offset(3.0);
        make.bottom.equalTo(tfSearch).offset(-3.0);
        make.width.mas_equalTo(hTextfield-6.0);
    }];
    
    tbDomain.separatorStyle = UITableViewCellSelectionStyleNone;
    tbDomain.delegate = self;
    tbDomain.dataSource = self;
    tbDomain.showsVerticalScrollIndicator = FALSE;
    [tbDomain registerNib:[UINib nibWithNibName:@"ExpireDomainCell" bundle:nil] forCellReuseIdentifier:@"ExpireDomainCell"];
    [tbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
    }];
    
    lbNoData.text = text_no_data;
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
    lbNoData.textAlignment = NSTextAlignmentCenter;
    lbNoData.textColor = UIColor.grayColor;
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tbDomain);
        make.left.right.equalTo(self.view);
    }];
}

- (void)searchTextfieldChanged: (UITextField *)textfield {
    if (textfield.text.length > 0) {
        icSearch.hidden = FALSE;
        searching = TRUE;
        
        if (searchTimer) {
            [searchTimer invalidate];
            searchTimer = nil;
        }
        searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(searchOnRegisteredDomains:) userInfo:textfield.text repeats:FALSE];
        
    }else{
        icSearch.hidden = TRUE;
        searching = FALSE;
        lbNoData.hidden = TRUE;
        tbDomain.hidden = FALSE;
        [tbDomain reloadData];
    }
}

- (void)searchOnRegisteredDomains: (NSTimer *)timer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"domain CONTAINS[cd] %@", timer.userInfo];
    if (type == eAllDomain) {
        NSArray *filter = [[AppDelegate sharedInstance].listAllDomains filteredArrayUsingPredicate: predicate];
        if (filter.count > 0) {
            [listSearch removeAllObjects];
            [listSearch addObjectsFromArray: filter];
            
            [tbDomain reloadData];
            lbNoData.hidden = TRUE;
            tbDomain.hidden = FALSE;
        }else{
            [listSearch removeAllObjects];
            lbNoData.hidden = FALSE;
            tbDomain.hidden = TRUE;
        }
    }
}

- (void)getDomainsWasRegisteredWithType: (int)type
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] type = %d", __FUNCTION__, type)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang tải.." Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getDomainsWasRegisteredWithType: type];
}

- (void)displayDomainsListWithData: (NSArray *)domains {
    if (type == eAllDomain) {
        
        if (domains != nil && domains.count > 0) {
            [AppDelegate sharedInstance].listAllDomains = [[NSMutableArray alloc] initWithArray: domains];
            
            tbDomain.hidden = FALSE;
            lbNoData.hidden = TRUE;
        }else{
            [AppDelegate sharedInstance].listAllDomains = [[NSMutableArray alloc] init];
            
            tbDomain.hidden = TRUE;
            lbNoData.hidden = FALSE;
        }
        [tbDomain reloadData];
    }else{
        if (domains != nil && domains.count > 0) {
            [AppDelegate sharedInstance].listExpireDomains = [[NSMutableArray alloc] initWithArray: domains];
            tbDomain.hidden = FALSE;
            lbNoData.hidden = TRUE;
            
        }else{
            [AppDelegate sharedInstance].listExpireDomains = [[NSMutableArray alloc] init];
            
            tbDomain.hidden = TRUE;
            lbNoData.hidden = FALSE;
        }
        [tbDomain reloadData];
    }
}

#pragma mark - WebServiceUtils delegate

-(void)failedGetDomainsWasRegisteredWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"Không thể lấy danh sách tên miền. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

- (void)getDomainsWasRegisteredSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [ProgressHUD dismiss];
    if (data != nil && [data isKindOfClass:[NSArray class]]) {
        [self displayDomainsListWithData: (NSArray *)data];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (type == eAllDomain) {
        if (searching) {
            return listSearch.count;
        }else{
            return [AppDelegate sharedInstance].listAllDomains.count;
        }
    }else{
        if (searching) {
            return listSearch.count;
        }else{
            return [AppDelegate sharedInstance].listExpireDomains.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpireDomainCell *cell = (ExpireDomainCell *)[tableView dequeueReusableCellWithIdentifier:@"ExpireDomainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *domain;
    if (type == eAllDomain) {
        if (searching) {
            domain = [listSearch objectAtIndex: indexPath.row];
        }else{
            domain = [[AppDelegate sharedInstance].listAllDomains objectAtIndex: indexPath.row];
        }
        
        [cell showContentWithDomainInfo:domain withExpire:FALSE];
    }else{
        if (searching) {
            domain = [listSearch objectAtIndex: indexPath.row];
        }else{
            domain = [[AppDelegate sharedInstance].listExpireDomains objectAtIndex: indexPath.row];
        }
        
        [cell showContentWithDomainInfo:domain withExpire:TRUE];
    }
    cell.lbNum.text = SFM(@"%d.", (int)indexPath.row + 1);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *domain;
    if (type == eAllDomain) {
        if (searching) {
            domain = [listSearch objectAtIndex: indexPath.row];
        }else{
            domain = [[AppDelegate sharedInstance].listAllDomains objectAtIndex: indexPath.row];
        }
    }else{
        if (searching) {
            domain = [listSearch objectAtIndex: indexPath.row];
        }else{
            domain = [[AppDelegate sharedInstance].listExpireDomains objectAtIndex: indexPath.row];
        }
    }
    NSString *ord_id = [domain objectForKey:@"ord_id"];
    NSString *cus_id = [domain objectForKey:@"cus_id"];
    
    if (![AppUtils isNullOrEmpty: ord_id] && ![AppUtils isNullOrEmpty: cus_id]) {
        [WriteLogsUtils writeLogContent:SFM(@"View domain ưith ordId = %@, cusId = %@", ord_id, cus_id)];
        
        RenewDomainDetailViewController *domainDetailVC = [[RenewDomainDetailViewController alloc] initWithNibName:@"RenewDomainDetailViewController" bundle:nil];
        domainDetailVC.ordId = ord_id;
        domainDetailVC.cusId = cus_id;
        [self.navigationController pushViewController: domainDetailVC animated:YES];
    }else{
        [self.view makeToast:@"ord_id không tồn tại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

@end
