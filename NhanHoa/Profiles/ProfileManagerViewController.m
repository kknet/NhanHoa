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
#import "WebServices.h"

@interface ProfileManagerViewController ()<UITableViewDelegate, UITableViewDataSource, WebServicesDelegate>{
    WebServices *webService;
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
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    if (listProfiles == nil) {
        listProfiles = [[NSMutableArray alloc] init];
    }
    [listProfiles removeAllObjects];
    
    [self getListProfilesForAccount];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"ProfileManagerViewController"];
    
    [self addRightBarButtonForNavigationBar];
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
    
    UIBarButtonItem *btnAddBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: viewAdd];
    self.navigationItem.rightBarButtonItem =  btnAddBarButtonItem;
}

- (void)addNewProfile {
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
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [ProgressHUD show:@"Đang lấy danh sách hồ sơ..." Interaction:NO];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_profile_mod forKey:@"mod"];
    [jsonDict setObject:[AccountModel getCusUsernameOfUser] forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:get_profile_func withParams:jsonDict];
}

- (void)displayInformationWithData: (id)data {
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

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    lbNoData.text = @"Đã có lỗi xảy ra. Vui lòng thử lại!";
    lbNoData.hidden = FALSE;
    tbProfiles.hidden = TRUE;
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:get_profile_func]) {
        [self displayInformationWithData: data];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    
    if ([link isEqualToString: get_profile_func]) {
        if (responeCode != 200) {
            [self.view makeToast:@"Đã có lỗi xảy ra. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
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
