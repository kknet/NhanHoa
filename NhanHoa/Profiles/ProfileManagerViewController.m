//
//  ProfileManagerViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileManagerViewController.h"
#import "ProfileDetailsViewController.h"
#import "AddProfileViewController.h"
#import "ProfileManagerCell.h"
#import "AccountModel.h"

@interface ProfileManagerViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate, UITextFieldDelegate>{
    NSMutableArray *listProfiles;
    NSMutableArray *listSearch;
    BOOL searching;
    NSTimer *searchTimer;
}

@end

@implementation ProfileManagerViewController
@synthesize tbProfiles, lbNoData, tfSearch, icClear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_profiles_list;
    [self setupUIForView];
    
    [AppDelegate sharedInstance].needReloadListProfile = FALSE;
    [self getListProfilesForAccount];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"ProfileManagerViewController"];
    
    self.navigationController.navigationBarHidden = FALSE;
    
    if (listSearch == nil) {
        listSearch = [[NSMutableArray alloc] init];
    }else{
        [listSearch removeAllObjects];
    }
    
    [self addRightBarButtonForNavigationBar];
    if ([AppDelegate sharedInstance].needReloadListProfile) {
        [AppDelegate sharedInstance].needReloadListProfile = FALSE;
        [self getListProfilesForAccount];
        
        tfSearch.text = @"";
        icClear.hidden = TRUE;
    }else{
        if (tfSearch.text.length > 0) {
            [self searchTextfieldChanged: tfSearch];
            icClear.hidden = FALSE;
        }else{
            icClear.hidden = TRUE;
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addRightBarButtonForNavigationBar {
    float hView = 45.0;
    if (!IS_IPHONE && !IS_IPOD) {
        hView = 50.0;
    }
    
    UIView *viewAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hView, hView)];
    viewAdd.backgroundColor = UIColor.clearColor;
    
    UIButton *btnAdd =  [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btnAdd.frame = CGRectMake(15, 0, hView, hView);
    btnAdd.backgroundColor = UIColor.clearColor;
    [btnAdd setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btnAdd addTarget:self action:@selector(addNewProfile) forControlEvents:UIControlEventTouchUpInside];
    [viewAdd addSubview: btnAdd];
    
    UIBarButtonItem *fixedItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedItem.width = 35.0; // or whatever you want
    
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *btnAddBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: viewAdd];
    //self.navigationItem.rightBarButtonItem =  btnAddBarButtonItem;
    self.navigationItem.rightBarButtonItems = @[fixedItem, flexibleItem, btnAddBarButtonItem];
}

- (void)addNewProfile {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    AddProfileViewController *addProfileVC = [[AddProfileViewController alloc] initWithNibName:@"AddProfileViewController" bundle:nil];
    [self.navigationController pushViewController:addProfileVC animated:TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hSearch = [AppDelegate sharedInstance].hTextfield;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hSearch = 45.0;
    }
    
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hSearch)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    tfSearch.placeholder = text_enter_to_search;
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.font = [AppDelegate sharedInstance].fontRegular;
    tfSearch.layer.cornerRadius = hSearch/2;
    tfSearch.layer.borderColor = BLUE_COLOR.CGColor;
    tfSearch.layer.borderWidth = 1.0;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hSearch);
    }];
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldChanged:)
       forControlEvents:UIControlEventEditingChanged];
    
    icClear.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    icClear.backgroundColor = BORDER_COLOR;
    icClear.layer.cornerRadius = (hSearch-6.0)/2;
    [icClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfSearch).offset(-3.0);
        make.top.equalTo(tfSearch).offset(3.0);
        make.bottom.equalTo(tfSearch).offset(-3.0);
        make.width.mas_equalTo(hSearch-6.0);
    }];
    
    
    [tbProfiles registerNib:[UINib nibWithNibName:@"ProfileManagerCell" bundle:nil] forCellReuseIdentifier:@"ProfileManagerCell"];
    tbProfiles.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbProfiles.delegate = self;
    tbProfiles.dataSource = self;
    tbProfiles.showsVerticalScrollIndicator = FALSE;
    [tbProfiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    lbNoData.hidden = TRUE;
    lbNoData.textColor = [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1.0];
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tbProfiles);
    }];
}

- (void)getListProfilesForAccount {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy danh sách hồ sơ..." Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getListProfilesForAccount:[AccountModel getCusUsernameOfUser]];
}

- (void)searchTextfieldChanged: (UITextField *)textfield {
    if (textfield.text.length > 0) {
        icClear.hidden = FALSE;
        searching = TRUE;
        
        if (searchTimer) {
            [searchTimer invalidate];
            searchTimer = nil;
        }
        searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(searchOnRegisteredDomains:) userInfo:textfield.text repeats:FALSE];
        
    }else{
        icClear.hidden = TRUE;
        searching = FALSE;
        lbNoData.hidden = TRUE;
        tbProfiles.hidden = FALSE;
        [tbProfiles reloadData];
    }
}

- (void)searchOnRegisteredDomains: (NSTimer *)timer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cus_company CONTAINS[cd] %@ OR cus_realname CONTAINS[cd] %@", timer.userInfo, timer.userInfo];
    NSArray *filter = [listProfiles filteredArrayUsingPredicate: predicate];
    if (filter.count > 0) {
        [listSearch removeAllObjects];
        [listSearch addObjectsFromArray: filter];
        
        [tbProfiles reloadData];
        lbNoData.hidden = TRUE;
        tbProfiles.hidden = FALSE;
    }else{
        [listSearch removeAllObjects];
        lbNoData.hidden = FALSE;
        tbProfiles.hidden = TRUE;
    }
}

- (void)displayInformationWithData: (id)data {
    if (listProfiles == nil) {
        listProfiles = [[NSMutableArray alloc] init];
    }
    [listProfiles removeAllObjects];
    
    if ([data isKindOfClass:[NSArray class]]) {
        if (data == nil || [(NSArray *)data count] == 0) {
            lbNoData.text = text_no_data;
            lbNoData.hidden = FALSE;
            tbProfiles.hidden = TRUE;
            
        }else{
            listProfiles = [[NSMutableArray alloc] initWithArray: data];
            
            lbNoData.hidden = TRUE;
            tbProfiles.hidden = FALSE;
            [tbProfiles reloadData];
        }
    }
}

#pragma mark - Webservice delegate
-(void)failedToGetProfilesForAccount:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    
    lbNoData.text = @"Đã có lỗi xảy ra. Vui lòng thử lại!";
    lbNoData.hidden = FALSE;
    tbProfiles.hidden = TRUE;
}

-(void)getProfilesForAccountSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    [self displayInformationWithData: data];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching) {
        return listSearch.count;
    }else{
        return listProfiles.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileManagerCell *cell = (ProfileManagerCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileManagerCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profileInfo;
    if (searching) {
        profileInfo = [listSearch objectAtIndex: indexPath.row];
    }else{
        profileInfo = [listProfiles objectAtIndex: indexPath.row];
    }
    
    //  Show profile type
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            cell.lbTypeValue.text = text_personal;
            [cell setupUIForBusiness: FALSE];
        }else{
            cell.lbTypeValue.text = text_business;
            [cell setupUIForBusiness: TRUE];
            
            NSString *cus_company = [profileInfo objectForKey:@"cus_company"];
            if (cus_company != nil) {
                cell.lbCompanyValue.text = cus_company;
            }
        }
    }
    
    //  Show profile name
    NSString *name = [profileInfo objectForKey:@"cus_realname"];
    if (name != nil && [name isKindOfClass:[NSString class]]) {
        cell.lbProfileValue.text = name;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileDetailsViewController *detailVC = [[ProfileDetailsViewController alloc] initWithNibName:@"ProfileDetailsViewController" bundle:nil];
    if (searching) {
        detailVC.profileInfo = [listSearch objectAtIndex: indexPath.row];
    }else{
        detailVC.profileInfo = [listProfiles objectAtIndex: indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:TRUE];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *profileInfo = [listProfiles objectAtIndex: indexPath.row];
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            if (IS_IPHONE || IS_IPOD) {
                return 70.0;
            }
            return 75.0;
        }
    }
    if (IS_IPHONE || IS_IPOD) {
        return 95.0;
    }else{
        return 110.0;
    }
}

- (IBAction)icClearClick:(UIButton *)sender {
    tfSearch.text = @"";
    sender.hidden = TRUE;
    searching = FALSE;
    [listSearch removeAllObjects];
    
    lbNoData.hidden = TRUE;
    tbProfiles.hidden = FALSE;
    [tbProfiles reloadData];
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

@end
