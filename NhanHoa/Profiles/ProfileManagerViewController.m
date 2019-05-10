//
//  ProfileManagerViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileManagerViewController.h"
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
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"ProfileManagerViewController"];
    
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

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    webService = nil;
    listProfiles = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
{
    "careers_id" = 0;
    "cus_account_list" = "<null>";
    "cus_activate" = 1;
    "cus_address" = "207A Tr\U1ea7n V\U0103n \U0110ang, Ph\U01b0\U1eddng 11, Qu\U1eadn 3";
    "cus_adminnote" = "<null>";
    "cus_aff" = "<null>";
    "cus_aff_balance" = 0;
    "cus_aff_id" = 0;
    "cus_aff_method" = 0;
    "cus_age" = "<null>";
    "cus_algolia_object_id" = 0;
    "cus_api_domain_api_key" = "<null>";
    "cus_api_domain_auth_userid" = 0;
    "cus_api_permission" = 0;
    "cus_azcontest" = 0;
    "cus_balance" = 2056450;
    "cus_balance_alert_time" = 0;
    "cus_bank_branch" = "<null>";
    "cus_bankaccount" = "<null>";
    "cus_bankname" = "<null>";
    "cus_banknumber" = "<null>";
    "cus_bday" = 2;
    "cus_birthday" = "02/10/1984";
    "cus_bmonth" = 10;
    "cus_byear" = 1984;
    "cus_card_code" = "<null>";
    "cus_card_id" = "<null>";
    "cus_card_reason" = "<null>";
    "cus_card_time" = 0;
    "cus_city" = 1;
    "cus_code" = ACC136070;
    "cus_company" = "<null>";
    "cus_company_address" = "<null>";
    "cus_company_delegate" = "<null>";
    "cus_company_delegate_2_bday" = 0;
    "cus_company_delegate_2_birthday" = "<null>";
    "cus_company_delegate_2_bmonth" = 0;
    "cus_company_delegate_2_byear" = 0;
    "cus_company_delegate_2_email" = "<null>";
    "cus_company_delegate_2_gender" = "<null>";
    "cus_company_delegate_2_id_date" = 0;
    "cus_company_delegate_2_id_number" = "<null>";
    "cus_company_delegate_2_name" = "<null>";
    "cus_company_delegate_bday" = 0;
    "cus_company_delegate_birthday" = "<null>";
    "cus_company_delegate_bmonth" = 0;
    "cus_company_delegate_byear" = 0;
    "cus_company_delegate_email" = "<null>";
    "cus_company_delegate_gender" = "<null>";
    "cus_company_delegate_id_date" = 0;
    "cus_company_delegate_id_number" = "<null>";
    "cus_company_phone" = "<null>";
    "cus_contract_address" = "207A Tr\U1ea7n V\U0103n \U0110ang, Ph\U01b0\U1eddng 11, Qu\U1eadn 3";
    "cus_contract_name" = "L\U00ea Ho\U00e0ng S\U01a1n";
    "cus_contract_phone" = 0917264679;
    "cus_country" = 231;
    "cus_ctv_fixed" = 0;
    "cus_customer_count" = 0;
    "cus_debt_balance" = 0;
    "cus_deleted" = 0;
    "cus_disable_backorder_failed" = 1;
    "cus_display_name" = NULL;
    "cus_district" = 0;
    "cus_dns_default" = "<null>";
    "cus_dns_default_qt" = "<null>";
    "cus_email" = "lehoangson@gmail.com";
    "cus_email_notification" = "<null>";
    "cus_email_vat" = "<null>";
    "cus_enable_api_domain" = 0;
    "cus_enable_view_order_expired" = 0;
    "cus_exist_info" = 0;
    "cus_facebook_login" = 0;
    "cus_fax" = "<null>";
    "cus_firstname" = "<null>";
    "cus_gender" = 1;
    "cus_id" = 136070;
    "cus_idcard_back_img" = "<null>";
    "cus_idcard_date" = 0;
    "cus_idcard_front_img" = "<null>";
    "cus_idcard_msg" = "<null>";
    "cus_idcard_name" = "";
    "cus_idcard_number" = 271576011;
    "cus_idcard_status" = 0;
    "cus_is_api" = 0;
    "cus_is_api_domain" = 0;
    "cus_jobtitle" = "<null>";
    "cus_lastname" = "<null>";
    "cus_location" = hcm;
    "cus_own_type" = 0;
    "cus_partner_service" = "<null>";
    "cus_passport_name" = "<null>";
    "cus_passport_number" = "<null>";
    "cus_password" = 74be16979710d4c4e7c6647856088456;
    "cus_paypal_email" = "<null>";
    "cus_phone" = 0917264679;
    "cus_phonehome" = "<null>";
    "cus_point" = 0;
    "cus_point_used" = 0;
    "cus_position" = "<null>";
    "cus_profile_list" = "<null>";
    "cus_profile_note" = "<null>";
    "cus_realname" = "L\U00ea Ho\U00e0ng S\U01a1n";
    "cus_register_time" = 1551320266;
    "cus_reseller_content" = "<null>";
    "cus_reseller_customed" = 0;
    "cus_reseller_domain" = "<null>";
    "cus_reseller_email" = "lehoangson@gmail.com";
    "cus_reseller_fixed" = 0;
    "cus_reseller_id" = 127115;
    "cus_reseller_overdraft" = 0;
    "cus_reseller_register" = 0;
    "cus_reseller_security_level" = 0;
    "cus_reseller_username" = "lehoangson@gmail.com";
    "cus_rl_email" = "nooplinux@gmail.com";
    "cus_security_answer" = "<null>";
    "cus_security_custom_question" = "<null>";
    "cus_security_method" = 0;
    "cus_security_question" = "<null>";
    "cus_seller" = 0;
    "cus_seller_update" = 0;
    "cus_send_email_to" = 0;
    "cus_send_subemail" = 0;
    "cus_social" = 0;
    "cus_status" = 0;
    "cus_subemail" = "<null>";
    "cus_syn_algolia" = 0;
    "cus_taxcode" = "<null>";
    "cus_temp_email" = "<null>";
    "cus_total_balance" = 4000000;
    "cus_total_point" = 0;
    "cus_town" = 0;
    "cus_type" = 1;
    "cus_username" = "lehoangson@gmail.com";
    "cus_web_domain" = "<null>";
    "cus_website" = "<null>";
    "cus_yahoo" = "<null>";
    "cus_zonedns_domain" = "<null>";
    "cus_zonedns_email_footer" = "";
    "cus_zonedns_logo" = "<null>";
    "cus_zonedns_value" = "<null>";
    "dns_enable" = 0;
    "dns_enable_qt" = 0;
    "lv_content" = "<null>";
    "lv_id" = 0;
    "member_id" = 0;
    "rel_id" = 0;
    "reseller_content" = "<null>";
    "reseller_id" = 0;
    "reseller_type" = 0;
    "reseller_upload_folder" = "<null>";
    "user_id" = 0;
    "zonedns_enable" = 0;
}
*/
@end
