//
//  ProfileDetailsViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailsViewController.h"
#import "EditProfileViewController.h"

@interface ProfileDetailsViewController ()

@end

@implementation ProfileDetailsViewController

@synthesize scvContent, lbType, lbTypeValue, lbFullname, lbFullnameValue, lbBOD, lbBODValue, lbPassport, lbPassportValue, lbAddress, lbAddressValue, lbPhone, lbPhoneValue, lbEmail, lbEmailValue, imgPassport, lbPassportTitle, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehid, btnUpdate;
@synthesize profileInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.title = @"Chi tiết hồ sơ";
    [self displayProfileInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUpdatePress:(UIButton *)sender {
    EditProfileViewController *editVC = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
    editVC.profileInfo = profileInfo;
    [self.navigationController pushViewController:editVC animated:TRUE];
}

- (void)displayProfileInformation {
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            lbTypeValue.text = text_personal;
        }else{
            lbTypeValue.text = text_business;
        }
    }
    
    NSString *fullname = [profileInfo objectForKey:@"cus_realname"];
    if (![AppUtils isNullOrEmpty: fullname]) {
        lbFullnameValue.text = fullname;
    }else{
        lbFullnameValue.text = @"";
    }
    
    NSString *birthday = [profileInfo objectForKey:@"cus_birthday"];
    if (![AppUtils isNullOrEmpty: birthday]) {
        lbBODValue.text = birthday;
    }else{
        lbBODValue.text = @"";
    }
    
    
    
   
    
    
    NSString *email = @"";
    NSString *address = @"";
    NSString *phone = @"";
    
    if ([type isEqualToString:@"1"]) {
        email = [profileInfo objectForKey:@"cus_company_delegate_email"];
        address = [profileInfo objectForKey:@"cus_company_address"];
        phone = [profileInfo objectForKey:@"cus_company_phone"];
        
    }else{
        email = [profileInfo objectForKey:@"cus_email"];
        address = [profileInfo objectForKey:@"cus_address"];
        phone = [profileInfo objectForKey:@"cus_phone"];
    }
    
    if ([AppUtils isNullOrEmpty: email]) {
        email = @"";
    }
    
    if ([AppUtils isNullOrEmpty: address]) {
        address = @"";
    }
    
    if ([AppUtils isNullOrEmpty: phone]) {
        phone = @"";
    }
    
    lbEmailValue.text = email;
    lbAddressValue.text = address;
    lbPhoneValue.text = phone;
    
    NSString *frontImg = [profileInfo objectForKey:@"cus_idcard_front_img"];
    if (![AppUtils isNullOrEmpty: frontImg]) {
        
    }else{
        imgPassportFront.image = [UIImage imageNamed:@"passport_empty_front"];
    }
    
    NSString *backImg = [profileInfo objectForKey:@"cus_idcard_back_img"];
    if (![AppUtils isNullOrEmpty: backImg]) {
        
    }else{
        imgPassportBehind.image = [UIImage imageNamed:@"passport_empty_behind"];
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
}

- (void)setupUIForView {
    float hItem = 32.0;
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:16.0];
    UIFont *mediumFont = [UIFont fontWithName:RobotoMedium size:16.0];
    
    float smallSize = [AppUtils getSizeWithText:@"Họ tên đầy đủ" withFont:textFont].width + 10.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  domain type
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent).offset(padding);
        make.left.equalTo(self.scvContent).offset(padding);
        make.width.mas_equalTo(smallSize);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbType);
        make.left.equalTo(self.lbType.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding-smallSize);
    }];
    
    //  fullname
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbType.mas_bottom);
        make.left.right.equalTo(self.lbType);
        make.height.equalTo(self.lbType.mas_height);
    }];
    
    [lbFullnameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbFullname);
        make.left.right.equalTo(self.lbTypeValue);
    }];
    
    //  birth of date
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbFullname.mas_bottom);
        make.left.right.equalTo(self.lbFullname);
        make.height.equalTo(self.lbFullname.mas_height);
    }];
    
    [lbBODValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.right.equalTo(self.lbFullnameValue);
    }];
    
    //  passport
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.equalTo(self.lbBOD.mas_height);
    }];
    
    [lbPassportValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPassport);
        make.left.right.equalTo(self.lbBODValue);
    }];
    
    //  Adress
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.equalTo(self.lbPassport.mas_height);
    }];
    
    [lbAddressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress);
        make.left.right.equalTo(self.lbPassportValue);
        make.height.mas_equalTo(2*hItem);
    }];
    
    //  Phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddressValue.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.equalTo(self.lbAddress.mas_height);
    }];
    
    [lbPhoneValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPhone);
        make.left.right.equalTo(self.lbAddressValue);
    }];
    
    //  Email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.equalTo(self.lbPhone.mas_height);
    }];
    
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbEmail);
        make.left.right.equalTo(self.lbPhoneValue);
    }];
    
    //  Passport info
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom).offset((hItem-20)/2);
        make.left.equalTo(self.lbEmail);
        make.width.height.mas_equalTo(20);
    }];
    
    [lbPassportTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgPassport.mas_centerY);
        make.left.equalTo(self.imgPassport.mas_right).offset(5.0);
        make.right.equalTo(self.lbEmailValue.mas_right);
        make.height.mas_equalTo(hItem);
    }];
    
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassportTitle.mas_bottom);
        make.left.equalTo(self.lbEmail);
        make.width.mas_equalTo(wPassport);
        make.height.mas_equalTo(hPassport);
    }];
    
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgPassportFront.mas_bottom);
        make.left.right.equalTo(self.imgPassportFront);
        make.height.mas_equalTo(hItem);
    }];
    
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imgPassportFront);
        make.left.equalTo(self.imgPassportFront.mas_right).offset(padding);
        make.width.mas_equalTo(wPassport);
    }];
    
    [lbPassportBehid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgPassportBehind.mas_bottom);
        make.left.right.equalTo(self.imgPassportBehind);
        make.height.mas_equalTo(hItem);
    }];
    
    lbType.font = lbFullname.font = lbBOD.font = lbPassport.font = lbAddress.font = lbPhone.font = lbEmail.font = lbPassportFront.font = lbPassportBehid.font = textFont;
    
    lbTypeValue.font = lbFullnameValue.font = lbBODValue.font = lbPassportValue.font = lbAddressValue.font = lbPhoneValue.font = lbEmailValue.font = mediumFont;
    
    lbType.textColor = lbTypeValue.textColor = lbFullname.textColor = lbFullnameValue.textColor = lbBOD.textColor = lbBODValue.textColor = lbPassport.textColor = lbPassportValue.textColor = lbAddress.textColor = lbAddressValue.textColor = lbPhone.textColor = lbPhoneValue.textColor = lbEmail.textColor = lbEmailValue.textColor = lbPassportTitle.textColor = lbPassportFront.textColor = lbPassportBehid.textColor = TITLE_COLOR;
    
    float curHeight = 10*hItem + padding + hPassport;
    float maxHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    
    btnUpdate.layer.cornerRadius = 45.0/2;
    btnUpdate.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    if (curHeight + padding + 45.0 + padding < maxHeight) {
        [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.scvContent).offset(maxHeight - padding - 45.0);
            make.left.equalTo(self.scvContent).offset(padding);
            make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
            make.height.mas_equalTo(45.0);
        }];
    }else{
        [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lbPassportBehid.mas_bottom).offset(padding);
            make.left.equalTo(self.scvContent).offset(padding);
            make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
            make.height.mas_equalTo(45.0);
        }];
    }
}

/*
{
    "careers_id" = 0;
    "cmnd_a" = "http://nhanhoa.com/uploads/declaration/ACC140431/1559105989.jpg";
    "cmnd_b" = "http://nhanhoa.com/uploads/declaration/ACC140431/1559105989.jpg";
    "cus_account_list" = "<null>";
    "cus_activate" = 1;
    "cus_address" = "1020 Ph\U1ea1m V\U0103n \U0110\U1ed3ng, P.Hi\U1ec7p B\U00ecnh Ch\U00e1nh";
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
    "cus_balance" = 0;
    "cus_balance_alert_time" = 0;
    "cus_bank_branch" = "<null>";
    "cus_bankaccount" = "<null>";
    "cus_bankname" = "<null>";
    "cus_banknumber" = "<null>";
    "cus_bday" = 2;
    "cus_birthday" = "02/12/1991";
    "cus_bmonth" = 12;
    "cus_byear" = 1991;
    "cus_card_code" = "<null>";
    "cus_card_id" = "<null>";
    "cus_card_reason" = "<null>";
    "cus_card_time" = 0;
    "cus_city" = "<null>";
    "cus_code" = ACC140431;
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
    "cus_contract_address" = "1020 Ph\U1ea1m V\U0103n \U0110\U1ed3ng, P.Hi\U1ec7p B\U00ecnh Ch\U00e1nh";
    "cus_contract_name" = "Kh\U1ea3i L\U00ea";
    "cus_contract_phone" = 0363430737;
    "cus_country" = 0;
    "cus_ctv_fixed" = 0;
    "cus_customer_count" = 0;
    "cus_debt_balance" = 0;
    "cus_deleted" = 0;
    "cus_disable_backorder_failed" = 1;
    "cus_display_name" = NULL;
    "cus_district" = 0;
    "cus_dns_default" = "<null>";
    "cus_dns_default_qt" = "<null>";
    "cus_email" = "lekhai0212@gmail.com";
    "cus_email_notification" = "<null>";
    "cus_email_vat" = "<null>";
    "cus_enable_api_domain" = 0;
    "cus_enable_view_order_expired" = 0;
    "cus_exist_info" = 0;
    "cus_facebook_login" = 0;
    "cus_fax" = "<null>";
    "cus_firstname" = "<null>";
    "cus_gender" = 1;
    "cus_id" = 140431;
    "cus_idcard_back_img" = "1559105989.jpg";
    "cus_idcard_date" = 0;
    "cus_idcard_front_img" = "1559105989.jpg";
    "cus_idcard_msg" = "<null>";
    "cus_idcard_name" = "<null>";
    "cus_idcard_number" = 212987654;
    "cus_idcard_status" = 0;
    "cus_is_api" = 0;
    "cus_is_api_domain" = 0;
    "cus_jobtitle" = "<null>";
    "cus_lastname" = "<null>";
    "cus_location" = "";
    "cus_own_type" = 0;
    "cus_partner_service" = "<null>";
    "cus_passport_name" = "<null>";
    "cus_passport_number" = "<null>";
    "cus_password" = 550e1bafe077ff0b0b67f4e32f29d751;
    "cus_paypal_email" = "<null>";
    "cus_phone" = 0363430737;
    "cus_phonehome" = "<null>";
    "cus_point" = 0;
    "cus_point_used" = 0;
    "cus_position" = "<null>";
    "cus_profile_list" = "<null>";
    "cus_profile_note" = "<null>";
    "cus_realname" = "Kh\U1ea3i L\U00ea";
    "cus_register_time" = 1559105989;
    "cus_reseller_content" = "<null>";
    "cus_reseller_customed" = 0;
    "cus_reseller_domain" = "<null>";
    "cus_reseller_email" = "lekhai0212@gmail.com";
    "cus_reseller_fixed" = 0;
    "cus_reseller_id" = 138665;
    "cus_reseller_overdraft" = 0;
    "cus_reseller_register" = 0;
    "cus_reseller_security_level" = 0;
    "cus_reseller_username" = "lekhai0212@gmail.com";
    "cus_rl_email" = "";
    "cus_security_answer" = "<null>";
    "cus_security_custom_question" = "<null>";
    "cus_security_method" = 0;
    "cus_security_question" = "<null>";
    "cus_seller" = 0;
    "cus_seller_update" = 0;
    "cus_send_email_to" = 0;
    "cus_send_subemail" = 0;
    "cus_social" = 0;
    "cus_status" = 1;
    "cus_subemail" = "<null>";
    "cus_syn_algolia" = 0;
    "cus_taxcode" = "<null>";
    "cus_temp_email" = "<null>";
    "cus_total_balance" = 0;
    "cus_total_point" = 0;
    "cus_town" = 0;
    "cus_type" = 1;
    "cus_username" = "lekhai0212@gmail.com";
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
