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

@interface ProfileManagerViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>{
    NSMutableArray *listProfiles;
}

@end

@implementation ProfileManagerViewController
@synthesize tbProfiles, lbNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Danh sách hồ sơ";
    [self setupUIForView];
    
    [AppDelegate sharedInstance].needReloadListProfile = FALSE;
    [self getListProfilesForAccount];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"ProfileManagerViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
    [self addRightBarButtonForNavigationBar];
    if ([AppDelegate sharedInstance].needReloadListProfile) {
        [AppDelegate sharedInstance].needReloadListProfile = FALSE;
        [self getListProfilesForAccount];
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
    UIView *viewAdd = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    viewAdd.backgroundColor = UIColor.clearColor;
    
    UIButton *btnAdd =  [UIButton buttonWithType:UIButtonTypeCustom];
    btnAdd.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btnAdd.frame = CGRectMake(15, 0, 40, 40);
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
    [tbProfiles registerNib:[UINib nibWithNibName:@"ProfileManagerCell" bundle:nil] forCellReuseIdentifier:@"ProfileManagerCell"];
    tbProfiles.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbProfiles.delegate = self;
    tbProfiles.dataSource = self;
    [tbProfiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    lbNoData.hidden = TRUE;
    lbNoData.textColor = [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1.0];
    lbNoData.font = [UIFont fontWithName:RobotoRegular size:20.0];
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

- (void)getListProfilesForAccount {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy danh sách hồ sơ..." Interaction:NO];
    
    [[WebServiceUtils getInstance] getListProfilesForAccount:[AccountModel getCusUsernameOfUser]];
}

- (void)displayInformationWithData: (id)data {
    if (listProfiles == nil) {
        listProfiles = [[NSMutableArray alloc] init];
    }
    [listProfiles removeAllObjects];
    
    if ([data isKindOfClass:[NSArray class]]) {
        if (data == nil || [(NSArray *)data count] == 0) {
            lbNoData.text = @"Không có dữ liệu";
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
    return listProfiles.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileManagerCell *cell = (ProfileManagerCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileManagerCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profileInfo = [listProfiles objectAtIndex: indexPath.row];
    
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
    detailVC.profileInfo = [listProfiles objectAtIndex: indexPath.row];
    [self.navigationController pushViewController:detailVC animated:TRUE];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *profileInfo = [listProfiles objectAtIndex: indexPath.row];
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            return 70.0;
        }
    }
    return 95.0;
}

@end
