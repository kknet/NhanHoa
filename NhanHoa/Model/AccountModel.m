//
//  AccountModel.m
//  NhanHoa
//
//  Created by admin on 5/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

+ (BOOL)isSignedAccount {
    if ([AppDelegate sharedInstance].userInfo != nil) {
        return TRUE;
    }
    return FALSE;
}

+ (NSString *)getCusIdOfUser {
    NSString *cusId = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_id"];
    if (![AppUtils isNullOrEmpty: cusId]) {
        return cusId;
    }
    return @"";
}

+ (NSString *)getCusUsernameOfUser {
    NSString *cusUsername = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_username"];
    if (![AppUtils isNullOrEmpty: cusUsername]) {
        return cusUsername;
    }
    return @"";
}

+ (NSString *)getCusTotalBalance {
    id totalBalance = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_total_balance"];
    
    if (totalBalance != nil && [totalBalance isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%ld", [totalBalance longValue]];
        
    }else if (totalBalance != nil && [totalBalance isKindOfClass:[NSString class]]) {
        return totalBalance;
    }
    return @"";
}

+ (NSString *)getCusBalance {
    id balance = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_balance"];
    
    if (balance != nil && [balance isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%ld", [balance longValue]];
        
    }else if (balance != nil && [balance isKindOfClass:[NSString class]]) {
        return balance;
    }
    return @"";
}

+ (NSString *)getCusTotalPoint {
    id totalPoint = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_total_point"];
    
    if (totalPoint != nil && [totalPoint isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%ld", [totalPoint longValue]];
        
    }else if (totalPoint != nil && [totalPoint isKindOfClass:[NSString class]]) {
        return totalPoint;
    }
    return @"";
}

+ (NSString *)getCusPoint {
    id point = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_point"];
    
    if (point != nil && [point isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%ld", [point longValue]];
        
    }else if (point != nil && [point isKindOfClass:[NSString class]]) {
        return point;
    }
    return @"";
}

+ (NSString *)getCusPassword {
    NSString *password = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_password"];
    return password;
}

+ (NSString *)getCusRealName {
    NSString *realName = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_realname"];
    if (![AppUtils isNullOrEmpty: realName]) {
        return realName;
    }
    return @"";
}

+ (NSString *)getCusEmail {
    NSString *email = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_email"];
    if (![AppUtils isNullOrEmpty: email]) {
        return email;
    }
    return @"";
}

+ (int)getCusOwnType {
    NSString *type = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_own_type"];
    if ([type isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: type]) {
        if ([type isEqualToString:@"0"]) {
            return type_personal;
        }else{
            return type_business;
        }
    }
    return type_personal;
}

+ (int)getCusGender {
    NSString *gender = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_gender"];
    if ([gender isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: gender]) {
        if ([gender isEqualToString:@"0"]) {
            return type_women;
        }else{
            return type_men;
        }
    }
    return type_men;
}

+ (NSString *)getCusBirthday {
    NSString *birthday = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_birthday"];
    if (![AppUtils isNullOrEmpty: birthday]) {
        return birthday;
    }
    return @"";
}

+ (NSString *)getCusPassport {
    NSString *passport = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_idcard_number"];
    if (![AppUtils isNullOrEmpty: passport]) {
        return passport;
    }
    return @"";
}

+ (NSString *)getCusPhone {
    NSString *phone = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_phone"];
    if (![AppUtils isNullOrEmpty: phone]) {
        return phone;
    }
    return @"";
}

+ (NSString *)getCusAddress {
    NSString *address = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_address"];
    if (![AppUtils isNullOrEmpty: address]) {
        return address;
    }
    return @"";
}

+ (NSString *)getCusCityCode {
    NSString *city = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_city"];
    if (![AppUtils isNullOrEmpty: city]) {
        return city;
    }
    return @"";
}

+ (NSString *)getCusPhoto {
    NSString *photo = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_photo"];
    if (![AppUtils isNullOrEmpty: photo]) {
        return photo;
    }
    return @"";
}

//  bussiness
+ (NSString *)getCusCompanyName {
    NSString *name = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_company"];
    if (![AppUtils isNullOrEmpty: name]) {
        return name;
    }
    return @"";
}

+ (NSString *)getCusCompanyTax {
    NSString *tax = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_taxcode"];
    if (![AppUtils isNullOrEmpty: tax]) {
        return tax;
    }
    return @"";
}

+ (NSString *)getCusCompanyAddress {
    NSString *address = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_company_address"];
    if (![AppUtils isNullOrEmpty: address]) {
        return address;
    }
    return @"";
}

+ (NSString *)getCusCompanyPhone {
    NSString *phone = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_company_phone"];
    if (![AppUtils isNullOrEmpty: phone]) {
        return phone;
    }
    return @"";
}

+ (NSString *)getCusCompanyPosition {
    NSString *position = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_position"];
    if (![AppUtils isNullOrEmpty: position]) {
        return position;
    }
    return @"";
}

+ (NSString *)getCusBankAccount {
    NSString *bankaccount = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_bankaccount"];
    if (![AppUtils isNullOrEmpty: bankaccount]) {
        return bankaccount;
    }
    return @"";
}

+ (NSString *)getCusBankName {
    NSString *bankname = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_bankname"];
    if (![AppUtils isNullOrEmpty: bankname]) {
        return bankname;
    }
    return @"";
}

+ (NSString *)getCusBankNumber {
    NSString *banknumber = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_banknumber"];
    if (![AppUtils isNullOrEmpty: banknumber]) {
        return banknumber;
    }
    return @"";
}

/*
{
    "careers_id" = 37;
    "cus_account_list" = "-1";
    "cus_activate" = 1;
    "cus_address" = "207A Tr\U1ea7n V\U0103n \U0110ang, P. 11, Q.3";
    "cus_adminnote" = "";
    "cus_aff" = "";
    "cus_aff_balance" = 0;
    "cus_aff_id" = 0;
    "cus_aff_method" = 0;
    "cus_age" = "<null>";
    "cus_algolia_object_id" = 0;
    "cus_api_domain_api_key" = "";
    "cus_api_domain_auth_userid" = 0;
    "cus_api_permission" = 1;
    "cus_azcontest" = 0;
    "cus_balance" = 1586750;
    "cus_balance_alert_time" = 0;
    "cus_bank_branch" = "<null>";
    "cus_bankaccount" = "";
    "cus_bankname" = "";
    "cus_banknumber" = "";
    "cus_bday" = 2;
    "cus_birthday" = "02/10/1984";
    "cus_bmonth" = 10;
    "cus_byear" = 1984;
    "cus_card_code" = "<null>";
    "cus_card_id" = "<null>";
    "cus_card_reason" = "<null>";
    "cus_card_time" = 0;
    "cus_city" = 1;
    "cus_code" = ACC127115;
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
    "cus_country" = 231;
    "cus_ctv_fixed" = 0;
    "cus_customer_count" = 3;
    "cus_debt_balance" = 0;
    "cus_deleted" = 0;
    "cus_disable_backorder_failed" = 1;
    "cus_display_name" = NULL;
    "cus_district" = 684;
    "cus_dns_default" = "<null>";
    "cus_dns_default_qt" = "<null>";
    "cus_email" = "lehoangson@gmail.com";
    "cus_email_notification" = "<null>";
    "cus_email_vat" = "";
    "cus_enable_api_domain" = 0;
    "cus_enable_view_order_expired" = 0;
    "cus_exist_info" = 0;
    "cus_facebook_login" = 0;
    "cus_fax" = "<null>";
    "cus_firstname" = "<null>";
    "cus_gender" = 1;
    "cus_id" = 127115;
    "cus_idcard_back_img" = "http://nhanhoa.com/uploads/declaration/ACC127115/1559470527.jpg";
    "cus_idcard_date" = 0;
    "cus_idcard_front_img" = "http://nhanhoa.com/uploads/declaration/ACC127115/1559470525.jpg";
    "cus_idcard_msg" = "<null>";
    "cus_idcard_name" = "L\U00ea Ho\U00e0ng S\U01a1n";
    "cus_idcard_number" = 271576011;
    "cus_idcard_status" = 0;
    "cus_is_api" = 0;
    "cus_is_api_domain" = 1;
    "cus_jobtitle" = "<null>";
    "cus_lastname" = "<null>";
    "cus_location" = hcm;
    "cus_own_type" = 0;
    "cus_partner_service" = "<null>";
    "cus_passport_name" = "";
    "cus_passport_number" = "";
    "cus_password" = 4b495739fe403ef23afd319f0eec95e0;
    "cus_paypal_email" = "<null>";
    "cus_phone" = 0917264679;
    "cus_phonehome" = "";
    "cus_photo" = "http://nhanhoa.com/uploads/declaration/ACC127115/photo_1559511433.jpg";
    "cus_point" = 500000;
    "cus_point_used" = 0;
    "cus_position" = "<null>";
    "cus_profile_list" = "-1,136070,136112,136113,139498,140398,140406,140407,140408,140409,140546,140548";
    "cus_profile_note" = "<null>";
    "cus_realname" = "L\U00ea Ho\U00e0ng S\U01a1n";
    "cus_register_time" = 1533519402;
    "cus_reseller_content" = "<null>";
    "cus_reseller_customed" = 0;
    "cus_reseller_domain" = "<null>";
    "cus_reseller_email" = "";
    "cus_reseller_fixed" = 0;
    "cus_reseller_id" = 0;
    "cus_reseller_overdraft" = 0;
    "cus_reseller_register" = 0;
    "cus_reseller_security_level" = 0;
    "cus_reseller_username" = "";
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
    "cus_subemail" = "";
    "cus_syn_algolia" = 0;
    "cus_taxcode" = "<null>";
    "cus_temp_email" = "<null>";
    "cus_token" = "";
    "cus_total_balance" = 4000000;
    "cus_total_point" = 0;
    "cus_town" = 10788;
    "cus_type" = 2;
    "cus_username" = "lehoangson@gmail.com";
    "cus_web_domain" = "<null>";
    "cus_website" = "";
    "cus_withdraw" = 500000;
    "cus_yahoo" = "";
    "cus_zonedns_domain" = "domain.websudo.xyz";
    "cus_zonedns_email_footer" = "";
    "cus_zonedns_logo" = "<null>";
    "cus_zonedns_value" = "a:4:{s:8:\"cus_dns1\";s:14:\"ns1.zonedns.vn\";s:8:\"cus_dns2\";s:14:\"ns2.zonedns.vn\";s:8:\"cus_dns3\";s:14:\"ns3.zonedns.vn\";s:8:\"cus_dns4\";s:14:\"ns4.zonedns.vn\";}";
    "dns_enable" = 0;
    "dns_enable_qt" = 0;
    "list_banner" =     (
                         {
                             image = "https://nhanhoa.com/uploads/logo/1550653015_1200.400.jpg";
                             url = "https://nhanhoa.com/khuyen-mai-server/";
                         },
                         {
                             image = "https://nhanhoa.com/uploads/logo/1549956238_domain50-1200x400.jpg";
                             url = "https://nhanhoa.com/ten-mien/dang-ky-moi-ten-mien.html";
                         },
                         {
                             image = "https://nhanhoa.com/uploads/logo/1554109685_banner-gsuite.jpg";
                             url = "https://nhanhoa.com/gsuite.html";
                         },
                         {
                             image = "https://nhanhoa.com/uploads/logo/1512723722_untitled-3-01.jpg";
                             url = "https://nhanhoa.com/khuyen-mai-email-server-2017.html";
                         },
                         {
                             image = "https://nhanhoa.com/uploads/logo/1483495406_1200-400.jpg";
                             url = "https://nhanhoa.com/ten-mien/dang-ky-moi-ten-mien.html";
                         }
                         );
    "list_price" =     (
                        {
                            name = ".xyz";
                            price = 280000;
                        },
                        {
                            name = ".vn";
                            price = 750000;
                        },
                        {
                            name = ".com";
                            price = 299000;
                        },
                        {
                            name = ".com.vn";
                            price = 630000;
                        },
                        {
                            name = ".net";
                            price = 299000;
                        }
                        );
    "lv_content" = "<null>";
    "lv_id" = 0;
    "member_id" = 0;
    "rel_id" = 0;
    "reseller_content" = "a:692:{i:2;s:6:\"209000\";i:3;s:6:\"219000\";i:4;s:6:\"205000\";i:5;s:6:\"195000\";i:6;s:6:\"195000\";i:7;s:6:\"195000\";i:8;s:6:\"195000\";i:9;s:6:\"575000\";i:10;s:6:\"325000\";i:11;s:6:\"305000\";i:12;s:6:\"170000\";i:13;s:6:\"425000\";i:14;s:6:\"675000\";i:15;s:6:\"425000\";i:16;s:6:\"575000\";i:17;s:6:\"875000\";i:18;s:6:\"305000\";i:19;s:6:\"425000\";i:20;s:6:\"170000\";i:21;s:3:\"30%\";i:22;s:3:\"30%\";i:23;s:6:\"209000\";i:24;s:6:\"219000\";i:25;s:6:\"205000\";i:26;s:6:\"195000\";i:27;s:6:\"195000\";i:28;s:6:\"195000\";i:29;s:6:\"195000\";i:30;s:6:\"575000\";i:31;s:6:\"325000\";i:32;s:6:\"305000\";i:33;s:6:\"170000\";i:34;s:6:\"425000\";i:35;s:6:\"675000\";i:36;s:6:\"425000\";i:37;s:6:\"575000\";i:38;s:6:\"875000\";i:39;s:6:\"305000\";i:40;s:6:\"425000\";i:41;s:6:\"170000\";i:42;s:3:\"30%\";i:43;s:3:\"30%\";i:65;s:3:\"30%\";i:66;s:3:\"30%\";i:67;s:3:\"30%\";i:68;s:3:\"30%\";i:69;s:3:\"30%\";i:70;s:3:\"30%\";i:71;s:3:\"30%\";i:72;s:3:\"30%\";i:73;s:3:\"30%\";i:74;s:3:\"30%\";i:75;s:3:\"30%\";i:76;s:3:\"30%\";i:77;s:3:\"30%\";i:78;s:3:\"30%\";i:79;s:3:\"30%\";i:80;s:3:\"30%\";i:81;s:3:\"30%\";i:82;s:3:\"30%\";i:83;s:3:\"30%\";i:84;s:3:\"30%\";i:85;s:3:\"30%\";i:86;s:3:\"30%\";i:87;s:3:\"30%\";i:88;s:3:\"30%\";i:89;s:3:\"30%\";i:90;s:3:\"30%\";i:91;s:3:\"30%\";i:92;s:3:\"30%\";i:93;s:3:\"30%\";i:94;s:3:\"30%\";i:103;s:3:\"30%\";i:104;s:3:\"30%\";i:105;s:3:\"30%\";i:106;s:3:\"30%\";i:107;s:3:\"30%\";i:108;s:3:\"30%\";i:109;s:3:\"30%\";i:110;s:3:\"30%\";i:111;s:3:\"30%\";i:112;s:3:\"30%\";i:113;s:3:\"12%\";i:114;s:3:\"12%\";i:115;s:3:\"12%\";i:116;s:3:\"12%\";i:117;s:2:\"3%\";i:118;s:2:\"3%\";i:119;s:2:\"3%\";i:120;s:2:\"3%\";i:121;s:2:\"3%\";i:122;s:2:\"3%\";i:124;s:2:\"3%\";i:125;s:2:\"3%\";i:126;s:3:\"12%\";i:127;s:3:\"12%\";i:128;s:3:\"12%\";i:129;s:3:\"12%\";i:130;s:2:\"3%\";i:131;s:2:\"3%\";i:132;s:2:\"3%\";i:133;s:2:\"3%\";i:134;s:2:\"3%\";i:135;s:2:\"3%\";i:136;s:2:\"3%\";i:137;s:2:\"3%\";i:138;s:2:\"3%\";i:143;s:3:\"30%\";i:144;s:3:\"30%\";i:145;s:3:\"30%\";i:146;s:3:\"30%\";i:147;s:3:\"30%\";i:148;s:3:\"30%\";i:149;s:3:\"30%\";i:150;s:3:\"30%\";i:151;s:3:\"30%\";i:152;s:3:\"30%\";i:153;s:3:\"30%\";i:154;s:3:\"30%\";i:155;s:3:\"30%\";i:156;s:3:\"30%\";i:157;s:3:\"30%\";i:158;s:3:\"30%\";i:159;s:3:\"30%\";i:160;s:3:\"30%\";i:161;s:3:\"30%\";i:162;s:3:\"30%\";i:163;s:3:\"30%\";i:164;s:3:\"30%\";i:165;s:3:\"30%\";i:166;s:3:\"30%\";i:167;s:3:\"30%\";i:168;s:3:\"30%\";i:169;s:3:\"30%\";i:170;s:3:\"30%\";i:171;s:3:\"30%\";i:172;s:3:\"30%\";i:173;s:3:\"30%\";i:174;s:3:\"30%\";i:175;s:3:\"30%\";i:176;s:3:\"30%\";i:177;s:3:\"30%\";i:178;s:3:\"30%\";i:179;s:3:\"30%\";i:180;s:3:\"30%\";i:181;s:3:\"30%\";i:182;s:3:\"30%\";i:183;s:3:\"30%\";i:184;s:3:\"30%\";i:221;s:2:\"3%\";i:222;s:6:\"575000\";i:223;s:6:\"575000\";i:233;s:2:\"3%\";i:234;s:2:\"3%\";i:260;s:2:\"3%\";i:261;s:2:\"3%\";i:263;s:2:\"3%\";i:265;s:2:\"3%\";i:269;s:2:\"3%\";i:270;s:2:\"3%\";i:271;s:2:\"3%\";i:272;s:2:\"3%\";i:280;s:2:\"3%\";i:281;s:2:\"3%\";i:282;s:2:\"3%\";i:283;s:2:\"3%\";i:284;s:2:\"3%\";i:285;s:2:\"3%\";i:286;s:2:\"3%\";i:290;s:6:\"325000\";i:291;s:6:\"325000\";i:293;s:3:\"30%\";i:294;s:3:\"30%\";i:301;s:6:\"195000\";i:302;s:6:\"195000\";i:304;s:6:\"195000\";i:305;s:6:\"195000\";i:307;s:2:\"3%\";i:308;s:2:\"3%\";i:309;s:2:\"3%\";i:310;s:2:\"3%\";i:311;s:2:\"3%\";i:312;s:2:\"3%\";i:315;s:3:\"30%\";i:316;s:3:\"30%\";i:321;s:2:\"3%\";i:322;s:2:\"3%\";i:323;s:2:\"3%\";i:328;s:2:\"3%\";i:331;s:2:\"3%\";i:332;s:2:\"3%\";i:333;s:3:\"35%\";i:335;s:2:\"3%\";i:352;s:7:\"2033000\";i:353;s:7:\"2036000\";i:355;s:2:\"3%\";i:360;s:3:\"30%\";i:361;s:3:\"30%\";i:362;s:3:\"30%\";i:363;s:3:\"30%\";i:364;s:3:\"30%\";i:365;s:3:\"30%\";i:366;s:2:\"3%\";i:368;s:2:\"3%\";i:369;s:2:\"3%\";i:370;s:2:\"3%\";i:371;s:2:\"3%\";i:372;s:2:\"3%\";i:373;s:2:\"3%\";i:374;s:2:\"3%\";i:375;s:2:\"3%\";i:376;s:2:\"3%\";i:377;s:2:\"3%\";i:378;s:2:\"3%\";i:379;s:2:\"3%\";i:380;s:2:\"3%\";i:381;s:2:\"3%\";i:382;s:2:\"3%\";i:383;s:2:\"3%\";i:384;s:3:\"12%\";i:385;s:3:\"12%\";i:386;s:3:\"12%\";i:387;s:3:\"12%\";i:388;s:3:\"12%\";i:389;s:3:\"12%\";i:390;s:3:\"12%\";i:391;s:3:\"12%\";i:392;s:3:\"12%\";i:393;s:3:\"12%\";i:396;s:3:\"35%\";i:407;s:2:\"3%\";i:408;s:2:\"3%\";i:409;s:3:\"10%\";i:410;s:3:\"10%\";i:411;s:3:\"10%\";i:412;s:3:\"10%\";i:413;s:3:\"10%\";i:414;s:3:\"10%\";i:415;s:3:\"10%\";i:416;s:3:\"10%\";i:417;s:3:\"10%\";i:418;s:3:\"10%\";i:419;s:2:\"3%\";i:420;s:2:\"3%\";i:421;s:2:\"3%\";i:422;s:2:\"3%\";i:423;s:2:\"3%\";i:424;s:2:\"3%\";i:429;s:2:\"3%\";i:430;s:2:\"3%\";i:431;s:2:\"3%\";i:432;s:2:\"3%\";i:437;s:3:\"30%\";i:438;s:3:\"30%\";i:440;s:2:\"3%\";i:442;s:2:\"3%\";i:443;s:6:\"325000\";i:444;s:6:\"325000\";i:449;s:3:\"30%\";i:450;s:3:\"30%\";i:451;s:3:\"30%\";i:452;s:3:\"30%\";i:453;s:3:\"30%\";i:454;s:3:\"30%\";i:455;s:3:\"30%\";i:456;s:3:\"30%\";i:457;s:3:\"30%\";i:458;s:3:\"30%\";i:459;s:3:\"30%\";i:460;s:3:\"30%\";i:461;s:2:\"3%\";i:462;s:2:\"3%\";i:463;s:3:\"30%\";i:464;s:3:\"30%\";i:465;s:3:\"30%\";i:466;s:3:\"30%\";i:467;s:3:\"30%\";i:468;s:3:\"30%\";i:469;s:3:\"30%\";i:470;s:3:\"30%\";i:471;s:3:\"30%\";i:472;s:3:\"30%\";i:473;s:3:\"30%\";i:474;s:3:\"30%\";i:475;s:3:\"30%\";i:476;s:3:\"30%\";i:477;s:3:\"30%\";i:478;s:3:\"30%\";i:479;s:3:\"30%\";i:480;s:3:\"30%\";i:481;s:3:\"30%\";i:482;s:3:\"30%\";i:483;s:3:\"30%\";i:484;s:3:\"30%\";i:485;s:3:\"30%\";i:487;s:3:\"30%\";i:488;s:3:\"30%\";i:489;s:3:\"30%\";i:490;s:3:\"30%\";i:491;s:3:\"30%\";i:492;s:3:\"30%\";i:493;s:3:\"30%\";i:494;s:3:\"30%\";i:495;s:3:\"30%\";i:496;s:3:\"30%\";i:497;s:3:\"30%\";i:498;s:3:\"30%\";i:499;s:3:\"30%\";i:500;s:3:\"30%\";i:501;s:3:\"30%\";i:502;s:3:\"30%\";i:503;s:3:\"30%\";i:505;s:3:\"30%\";i:506;s:3:\"30%\";i:507;s:3:\"30%\";i:508;s:3:\"30%\";i:509;s:3:\"30%\";i:510;s:3:\"30%\";i:511;s:3:\"30%\";i:512;s:3:\"30%\";i:521;s:7:\"2255000\";i:522;s:7:\"2255000\";i:525;s:6:\"195000\";i:526;s:6:\"195000\";i:539;s:3:\"30%\";i:540;s:3:\"30%\";i:541;s:3:\"30%\";i:542;s:3:\"30%\";i:543;s:3:\"30%\";i:544;s:3:\"30%\";i:570;s:7:\"1205000\";i:571;s:7:\"1205000\";i:632;s:3:\"10%\";i:645;s:6:\"689000\";i:646;s:6:\"592000\";i:647;s:6:\"592000\";i:648;s:6:\"592000\";i:649;s:6:\"592000\";i:650;s:6:\"592000\";i:651;s:6:\"592000\";i:652;s:6:\"592000\";i:653;s:6:\"592000\";i:654;s:6:\"592000\";i:655;s:6:\"592000\";i:656;s:6:\"592000\";i:657;s:6:\"592000\";i:658;s:6:\"592000\";i:659;s:6:\"592000\";i:660;s:6:\"592000\";i:661;s:6:\"592000\";i:662;s:6:\"592000\";i:663;s:6:\"592000\";i:664;s:6:\"592000\";i:665;s:6:\"592000\";i:666;s:6:\"592000\";i:667;s:6:\"592000\";i:668;s:6:\"936000\";i:669;s:6:\"936000\";i:670;s:6:\"936000\";i:671;s:6:\"936000\";i:672;s:6:\"936000\";i:673;s:6:\"388000\";i:674;s:6:\"388000\";i:675;s:6:\"388000\";i:676;s:6:\"388000\";i:677;s:6:\"388000\";i:678;s:6:\"388000\";i:679;s:6:\"388000\";i:680;s:6:\"388000\";i:681;s:6:\"388000\";i:682;s:6:\"388000\";i:683;s:6:\"388000\";i:684;s:6:\"592000\";i:685;s:6:\"592000\";i:686;s:6:\"592000\";i:687;s:6:\"592000\";i:688;s:6:\"592000\";i:689;s:6:\"592000\";i:690;s:6:\"592000\";i:691;s:6:\"592000\";i:692;s:6:\"592000\";i:693;s:6:\"592000\";i:694;s:6:\"592000\";i:695;s:6:\"592000\";i:696;s:6:\"936000\";i:697;s:6:\"936000\";i:698;s:6:\"936000\";i:699;s:6:\"936000\";i:700;s:6:\"936000\";i:701;s:6:\"936000\";i:702;s:6:\"309000\";i:703;s:7:\"2181000\";i:704;s:6:\"388000\";i:705;s:6:\"388000\";i:706;s:6:\"388000\";i:707;s:6:\"388000\";i:708;s:6:\"388000\";i:709;s:6:\"388000\";i:710;s:6:\"388000\";i:711;s:6:\"388000\";i:712;s:6:\"388000\";i:713;s:6:\"388000\";i:714;s:6:\"767000\";i:715;s:6:\"936000\";i:716;s:7:\"1255000\";i:717;s:6:\"507000\";i:718;s:7:\"1176000\";i:719;s:6:\"936000\";i:720;s:6:\"592000\";i:753;s:6:\"388000\";i:781;s:6:\"309000\";i:880;s:3:\"30%\";i:903;s:3:\"30%\";i:904;s:3:\"30%\";i:905;s:3:\"30%\";i:906;s:3:\"30%\";i:907;s:3:\"30%\";i:910;s:3:\"30%\";i:911;s:3:\"30%\";i:912;s:3:\"30%\";i:913;s:3:\"30%\";i:914;s:3:\"30%\";i:915;s:3:\"30%\";i:916;s:3:\"30%\";i:917;s:3:\"30%\";i:918;s:3:\"30%\";i:919;s:3:\"30%\";i:920;s:3:\"30%\";i:921;s:3:\"30%\";i:922;s:3:\"30%\";i:935;s:3:\"12%\";i:938;s:3:\"12%\";i:939;s:3:\"12%\";i:941;s:3:\"12%\";i:944;s:3:\"12%\";i:956;s:3:\"12%\";i:957;s:3:\"12%\";i:958;s:3:\"12%\";i:959;s:3:\"12%\";i:960;s:3:\"12%\";i:964;s:3:\"12%\";i:965;s:3:\"30%\";i:966;s:3:\"30%\";i:976;s:3:\"12%\";i:977;s:3:\"12%\";i:978;s:3:\"12%\";i:979;s:3:\"12%\";i:981;s:3:\"12%\";i:982;s:3:\"12%\";i:983;s:3:\"12%\";i:984;s:3:\"12%\";i:985;s:3:\"12%\";i:987;s:3:\"12%\";i:989;s:3:\"12%\";i:991;s:3:\"12%\";i:992;s:3:\"12%\";i:993;s:3:\"12%\";i:994;s:3:\"12%\";i:995;s:3:\"12%\";i:1007;s:3:\"30%\";i:1008;s:3:\"30%\";i:1009;s:3:\"30%\";i:1011;s:3:\"30%\";i:1012;s:3:\"30%\";i:1013;s:3:\"30%\";i:1014;s:3:\"30%\";i:1015;s:3:\"30%\";i:1017;s:3:\"30%\";i:1018;s:3:\"30%\";i:1019;s:3:\"30%\";i:1021;s:3:\"30%\";i:1039;s:3:\"30%\";i:1040;s:3:\"30%\";i:1041;s:3:\"30%\";i:1042;s:3:\"30%\";i:1043;s:3:\"30%\";i:1044;s:3:\"30%\";i:1045;s:3:\"30%\";i:1047;s:3:\"30%\";i:1049;s:3:\"30%\";i:1051;s:3:\"30%\";i:1053;s:3:\"30%\";i:1055;s:3:\"30%\";i:1071;s:7:\"2407000\";i:1073;s:7:\"2407000\";i:1097;s:7:\"2454000\";i:1099;s:7:\"2454000\";i:1123;s:7:\"1308000\";i:1124;s:7:\"1308000\";i:1126;s:6:\"219000\";i:1127;s:6:\"219000\";i:1183;s:7:\"2430000\";i:1185;s:7:\"2430000\";i:1206;s:7:\"2548000\";i:1207;s:7:\"2548000\";i:1227;s:7:\"5454000\";i:1228;s:7:\"5454000\";i:1235;s:6:\"559000\";i:1237;s:6:\"559000\";i:1239;s:7:\"2267000\";i:1240;s:7:\"2267000\";i:1251;s:7:\"7135000\";i:1253;s:7:\"7135000\";i:1271;s:7:\"7088000\";i:1273;s:7:\"7088000\";i:1281;s:6:\"219000\";i:1283;s:6:\"219000\";i:1322;s:6:\"559000\";i:1323;s:6:\"559000\";i:1335;s:7:\"5454000\";i:1336;s:7:\"5454000\";i:1370;s:7:\"1026000\";i:1371;s:7:\"1026000\";i:1400;s:6:\"816000\";i:1401;s:6:\"816000\";i:1453;s:6:\"252000\";i:1454;s:6:\"252000\";i:1521;s:6:\"266000\";i:1523;s:6:\"266000\";i:1548;s:3:\"30%\";i:1550;s:3:\"30%\";i:1552;s:3:\"30%\";i:1554;s:3:\"30%\";i:1556;s:3:\"30%\";i:1558;s:3:\"30%\";i:1643;s:3:\"30%\";i:1645;s:3:\"30%\";i:1647;s:3:\"30%\";i:1673;s:6:\"616000\";i:1674;s:6:\"616000\";i:1697;s:3:\"30%\";i:1698;s:3:\"30%\";i:1699;s:3:\"30%\";i:1700;s:3:\"30%\";i:1701;s:3:\"30%\";i:1702;s:3:\"30%\";i:1703;s:3:\"30%\";i:1704;s:3:\"30%\";i:1705;s:3:\"30%\";i:1709;s:3:\"30%\";i:1710;s:3:\"30%\";i:1711;s:3:\"30%\";i:1712;s:3:\"30%\";i:1713;s:3:\"30%\";i:1714;s:3:\"30%\";i:1715;s:3:\"30%\";i:1716;s:3:\"30%\";i:1717;s:3:\"30%\";i:1718;s:3:\"30%\";i:1719;s:3:\"30%\";i:1720;s:3:\"30%\";i:1721;s:3:\"30%\";i:1722;s:3:\"30%\";i:1724;s:3:\"30%\";i:1725;s:3:\"30%\";i:1726;s:3:\"30%\";i:1727;s:3:\"30%\";i:1728;s:3:\"30%\";i:1729;s:3:\"30%\";i:1730;s:3:\"30%\";i:1731;s:3:\"30%\";i:1732;s:3:\"30%\";i:1733;s:3:\"30%\";i:1734;s:3:\"30%\";i:1735;s:3:\"30%\";i:1736;s:3:\"30%\";i:1737;s:3:\"30%\";i:1738;s:3:\"30%\";i:1739;s:3:\"30%\";i:1744;s:3:\"30%\";i:1746;s:3:\"30%\";i:1749;s:3:\"30%\";i:1750;s:3:\"30%\";i:1751;s:3:\"30%\";i:1752;s:3:\"30%\";i:1753;s:3:\"30%\";i:1754;s:3:\"30%\";i:1780;s:3:\"30%\";i:1781;s:3:\"30%\";i:1782;s:3:\"30%\";i:1783;s:3:\"30%\";i:1784;s:3:\"12%\";i:1785;s:3:\"12%\";i:1786;s:3:\"12%\";i:1787;s:3:\"12%\";i:1788;s:3:\"12%\";i:1789;s:3:\"12%\";i:1838;s:3:\"30%\";i:1844;s:3:\"30%\";i:1848;s:3:\"12%\";i:1849;s:3:\"12%\";i:1850;s:3:\"12%\";i:1851;s:3:\"12%\";i:1859;s:3:\"12%\";i:1860;s:3:\"12%\";i:1862;s:3:\"12%\";i:1863;s:3:\"12%\";i:1864;s:3:\"12%\";i:1865;s:3:\"12%\";i:1866;s:3:\"12%\";i:1867;s:3:\"12%\";i:1877;s:3:\"12%\";i:1878;s:3:\"12%\";i:1879;s:3:\"12%\";i:1880;s:3:\"12%\";i:1881;s:3:\"12%\";i:1882;s:3:\"12%\";i:1883;s:3:\"12%\";i:1884;s:3:\"12%\";i:1885;s:3:\"12%\";i:1886;s:3:\"12%\";i:1887;s:3:\"12%\";i:1888;s:3:\"12%\";i:1889;s:7:\"1939000\";i:1890;s:7:\"1939000\";i:1891;s:7:\"1939000\";i:1892;s:7:\"1939000\";i:1893;s:7:\"1939000\";i:1894;s:7:\"1939000\";i:1898;s:3:\"30%\";i:1903;s:3:\"12%\";i:1904;s:3:\"12%\";i:1922;s:3:\"12%\";i:1923;s:3:\"12%\";i:1924;s:3:\"12%\";i:1952;s:3:\"12%\";i:1958;s:3:\"12%\";i:1959;s:3:\"12%\";i:1960;s:3:\"12%\";i:1961;s:3:\"12%\";i:1962;s:3:\"12%\";i:1963;s:3:\"12%\";i:1964;s:3:\"12%\";i:1965;s:3:\"12%\";i:1966;s:3:\"12%\";i:1967;s:3:\"12%\";i:1968;s:3:\"12%\";i:1969;s:3:\"12%\";i:1970;s:3:\"12%\";i:1971;s:3:\"12%\";i:1972;s:3:\"12%\";i:1973;s:3:\"12%\";i:1974;s:3:\"12%\";i:1975;s:3:\"12%\";i:1976;s:3:\"12%\";i:1977;s:3:\"12%\";i:1978;s:3:\"12%\";i:1979;s:3:\"12%\";i:1980;s:3:\"12%\";i:1981;s:3:\"30%\";i:1982;s:3:\"30%\";i:1983;s:3:\"30%\";i:1984;s:3:\"30%\";i:1985;s:3:\"30%\";i:1986;s:3:\"30%\";i:1987;s:3:\"30%\";i:1988;s:3:\"30%\";i:1989;s:3:\"30%\";i:1990;s:3:\"30%\";i:1991;s:3:\"30%\";i:1992;s:3:\"30%\";i:1993;s:3:\"12%\";i:1996;s:3:\"12%\";i:1997;s:3:\"12%\";i:1998;s:3:\"12%\";i:1999;s:3:\"12%\";i:2000;s:3:\"12%\";i:2001;s:3:\"30%\";i:2002;s:3:\"30%\";i:2021;s:3:\"30%\";i:2022;s:3:\"30%\";i:2023;s:3:\"30%\";i:2024;s:3:\"30%\";i:2025;s:3:\"30%\";i:2033;s:3:\"12%\";i:2034;s:3:\"12%\";i:2035;s:3:\"12%\";i:2036;s:3:\"12%\";i:2037;s:3:\"12%\";i:2038;s:3:\"12%\";i:2039;s:3:\"12%\";i:2040;s:3:\"30%\";i:2041;s:3:\"30%\";i:2042;s:3:\"30%\";i:2043;s:3:\"30%\";i:2044;s:3:\"30%\";i:2074;s:3:\"12%\";i:2077;s:3:\"12%\";i:2078;s:3:\"12%\";i:2079;s:3:\"12%\";i:2080;s:3:\"12%\";i:2081;s:3:\"12%\";}";
    "reseller_id" = 5;
    "reseller_type" = 0;
    "reseller_upload_folder" = "<null>";
    "user_id" = 0;
    "zonedns_enable" = 1;
}
*/

@end
