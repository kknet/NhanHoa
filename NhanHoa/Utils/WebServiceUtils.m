//
//  WebServiceUtils.m
//  NhanHoa
//
//  Created by Khai Leo on 6/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WebServiceUtils.h"
#import "AccountModel.h"

@implementation WebServiceUtils
@synthesize webService, delegate;

+(WebServiceUtils *)getInstance{
    static WebServiceUtils* webServiceUtil = nil;
    if(webServiceUtil == nil){
        webServiceUtil = [[WebServiceUtils alloc] init];
        webServiceUtil.webService = [[WebServices alloc] init];
        webServiceUtil.webService.delegate = webServiceUtil;
    }
    return webServiceUtil;
}

//  register functions
- (void)registerNewAccountWithInfo: (NSDictionary *)accInfo
{
    [webService callWebServiceWithLink:register_account_func withParams:accInfo inBackgroundMode:TRUE];
}

- (void)updateAccountProfileWithInfo: (NSMutableDictionary *)info
{
    [info setObject:edit_profile_mod forKey:@"mod"];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    [webService callWebServiceWithLink:edit_profile_func withParams:info inBackgroundMode:TRUE];
}

//  login function
- (void)loginWithUsername: (NSString *)username password: (NSString *)password
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@", __FUNCTION__, username)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    
    //  [webService callWebServiceWithLink:login_func withParams:jsonDict];
    [webService callWebServiceWithLink:login_func withParams:jsonDict inBackgroundMode:TRUE];
}

//  update token function
- (void)updateTokenWithValue:(NSString *)token {
    if (![AppUtils isNullOrEmpty: token]) {
        [WriteLogsUtils writeLogContent:SFM(@"[%s] token = %@", __FUNCTION__, token)];
    }else{
        [WriteLogsUtils writeLogContent:SFM(@"[%s] token = EMPTYYYYYYYYY", __FUNCTION__)];
    }
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:update_token_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:SFM(@"ios-%@", token) forKey:@"token"];
    [webService callWebServiceWithLink:update_token_func withParams:jsonDict inBackgroundMode:TRUE];
}

//  search whois domain
- (void)searchDomainWithName: (NSString *)domain type: (int)type
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@, type = %d", __FUNCTION__, domain, type)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:whois_mod forKey:@"mod"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:[AccountModel getCusIdOfUser] forKey:@"cus_id"];
    [jsonDict setObject:[NSNumber numberWithInt: type] forKey:@"type"];

    [webService callWebServiceWithLink:whois_func withParams:jsonDict inBackgroundMode:TRUE];
}

//  get domain list which was registerd
- (void)getDomainsWasRegisteredWithType: (int)type
{
    //  type = 1: list domain sắp hết hạn
    //  type = 0: default [all]
    [WriteLogsUtils writeLogContent:SFM(@"[%s] type = %d", __FUNCTION__, type)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:list_domain_mod forKey:@"mod"];
    [jsonDict setObject:[AccountModel getCusUsernameOfUser] forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:[NSNumber numberWithInt: type] forKey:@"type"];
    
    [webService callWebServiceWithLink:list_domain_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)getDomainsPricingList {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:domain_pricing_mod forKey:@"mod"];

    [webService callWebServiceWithLink:domain_pricing_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)getDomainInfoWithOrdId: (NSString *)ord_id {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] ord_id = %@", __FUNCTION__, ord_id)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:info_domain_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:ord_id forKey:@"ord_id"];
    
    [webService callWebServiceWithLink:info_domain_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)updateCMNDPhotoForDomainWithCMND_a: (NSString *)cmnd_a CMND_b: (NSString *)cmnd_b cusId: (NSString *)cusId domainName: (NSString *)domainName domainType: (NSString *)domainType domainId: (NSString *)domainId banKhai: (NSString *)banKhai
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:update_cmnd_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:cusId forKey:@"cus_id"];
    [jsonDict setObject:domainName forKey:@"domain_name"];
    [jsonDict setObject:domainType forKey:@"domain_type"];
    [jsonDict setObject:domainId forKey:@"domain_id"];
    [jsonDict setObject:banKhai forKey:@"bankhai"];
    
    if (![AppUtils isNullOrEmpty: cmnd_a]) {
        [jsonDict setObject:cmnd_a forKey:@"cmnd_a"];
    }
    
    if (![AppUtils isNullOrEmpty: cmnd_a]) {
        [jsonDict setObject:cmnd_a forKey:@"cmnd_a"];
    }
    
    if (![AppUtils isNullOrEmpty: cmnd_b]) {
        [jsonDict setObject:cmnd_b forKey:@"cmnd_b"];
    }
    
    [webService callWebServiceWithLink:update_cmnd_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)getDNSValueForDomain: (NSString *)domain
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_dns_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    
    [webService callWebServiceWithLink:get_dns_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)changeDNSForDomain: (NSString *)domain dns1: (NSString *)dns1 dns2: (NSString *)dns2 dns3: (NSString *)dns3 dns4: (NSString *)dns4
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@, dn1 = %@, dn2 = %@, dns3 = %@, dns4 = %@", __FUNCTION__, domain, dns1, dns2, dns3, dns4)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:change_dns_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    
    if (![AppUtils isNullOrEmpty: dns1]) {
        [jsonDict setObject:dns1 forKey:@"ns1"];
    }
    
    if (![AppUtils isNullOrEmpty: dns2]) {
        [jsonDict setObject:dns2 forKey:@"ns2"];
    }
    
    if (![AppUtils isNullOrEmpty: dns3]) {
        [jsonDict setObject:dns3 forKey:@"ns3"];
    }
    
    if (![AppUtils isNullOrEmpty: dns4]) {
        [jsonDict setObject:dns4 forKey:@"ns4"];
    }
    [webService callWebServiceWithLink:change_dns_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)getListProfilesForAccount: (NSString *)username {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@", __FUNCTION__, username)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_profile_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:get_profile_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)addProfileWithContent: (NSDictionary *)data
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [webService callWebServiceWithLink:add_contact_func withParams:data inBackgroundMode:TRUE];
}

- (void)editProfileWithContent: (NSDictionary *)data
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [webService callWebServiceWithLink:edit_contact_func withParams:data inBackgroundMode:TRUE];
}

-(void)sendMessageWithContent:(NSString *)content
{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:question_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:content forKey:@"content"];
    
    [webService callWebServiceWithLink:send_question_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)updatePhotoForCustomerWithURL: (NSString *)url
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] url = %@", __FUNCTION__, url)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:profile_photo_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:url forKey:@"photo"];
    
    [webService callWebServiceWithLink:profile_photo_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)changePasswordWithCurrentPass: (NSString *)currentPass newPass: (NSString *)newPass
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] currentPass = %@, newPass = %@", __FUNCTION__, currentPass, newPass)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:change_password_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:currentPass forKey:@"old_password"];
    [jsonDict setObject:newPass forKey:@"new_password"];
    [jsonDict setObject:newPass forKey:@"re_new_password"];
    
    [webService callWebServiceWithLink:change_pass_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)checkOTPForUsername: (NSString *)username password: (NSString *)password andOTPCode: (NSString *)code {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@, password = %@, otpCode = %@", __FUNCTION__, username, password, code)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:check_otp_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    [jsonDict setObject:code forKey:@"code"];
    
    [webService callWebServiceWithLink:check_otp_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)resendOTPForUsername: (NSString *)username password: (NSString *)password {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@, password = %@", __FUNCTION__, username, password)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:resend_otp_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    
    [webService callWebServiceWithLink:resend_otp_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)confirmOTPCodeWithEmail:(NSString *)email password:(NSString *)password code:(NSString *)code {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:check_otp_mod forKey:@"mod"];
    [jsonDict setObject:email forKey:@"username"];
    [jsonDict setObject:[AppUtils getMD5StringOfString:password] forKey:@"password"];
    [jsonDict setObject:code forKey:@"code"];
    
    [webService callWebServiceWithLink:check_otp_func withParams:jsonDict inBackgroundMode:TRUE];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict])];
}

- (void)getTransactionsHistory {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_history_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];

    [webService callWebServiceWithLink:get_history_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)getRenewInfoForDomain: (NSString *)domain {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:renew_domain_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    
    [webService callWebServiceWithLink:renew_domain_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)renewOrderForDomain: (NSString *)domain contactId: (NSString *)contact_id ord_id:(NSString *)ord_id years: (int)years {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:renew_order_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:contact_id forKey:@"contact_id"];
    [jsonDict setObject:ord_id forKey:@"ord_id"];
    [jsonDict setObject:[NSNumber numberWithInt: years] forKey:@"year"];
    
    [webService callWebServiceWithLink:renew_order_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)updateBankInfoWithBankName: (NSString *)bankname bankaccount: (NSString *)bankaccount banknumber:(NSString *)banknumber {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] bankname = %@, bankaccount = %@, banknumber = %@", __FUNCTION__, bankname, bankaccount, banknumber)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:info_bank_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:bankname forKey:@"bankname"];
    [jsonDict setObject:bankaccount forKey:@"bankaccount"];
    [jsonDict setObject:banknumber forKey:@"banknumber"];
    
    [webService callWebServiceWithLink:info_bank_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)withdrawWithAmout: (long)amount {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] amount = %ld", __FUNCTION__, amount)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:withdraw_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:[NSNumber numberWithLong: amount] forKey:@"amount"];
    
    [webService callWebServiceWithLink:withdraw_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)addOrderForDomain: (NSString *)domain contact_id: (NSString *)contact_id year: (int)year protect: (NSNumber *)protect {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@, contact_id = %@, year = %d", __FUNCTION__, domain, contact_id, year)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:add_order_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:contact_id forKey:@"contact_id"];
    [jsonDict setObject:[NSNumber numberWithInt: year] forKey:@"year"];
    [jsonDict setObject:protect forKey:@"protect"];
    
    [webService callWebServiceWithLink:add_order_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)getAddfunWithAmout: (NSString *)amount type: (int)type {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] amount = %@, type = %d", __FUNCTION__, amount, type)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:addfun_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:amount forKey:@"amount"];
    [jsonDict setObject:[NSNumber numberWithInt:type] forKey:@"type"];
    
    [webService callWebServiceWithLink:addfun_func withParams:jsonDict inBackgroundMode:TRUE];
}

- (void)updateWhoisProtectForDomain: (NSString *)domain domainId: (NSString *)domainId protectValue: (BOOL)protect {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domainId = %d, protect = %d", __FUNCTION__, [domainId intValue], protect)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:whois_protect_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domainId forKey:@"domain_id"];
    [jsonDict setObject:domain forKey:@"domain_name"];
    [jsonDict setObject:[NSNumber numberWithBool: protect] forKey:@"protect"];
    
    [webService callWebServiceWithLink:WhoisProtect_func withParams:jsonDict inBackgroundMode:TRUE];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    if ([link isEqualToString:login_func]) {
        if ([delegate respondsToSelector:@selector(failedToLoginWithError:)]) {
            [delegate failedToLoginWithError: error];
        }
        
    }else if ([link isEqualToString: register_account_func]) {
        if ([delegate respondsToSelector:@selector(failedToRegisterAccountWithError:)]) {
            [delegate failedToRegisterAccountWithError: error];
        }
    }else if ([link isEqualToString: edit_profile_func]) {
        if ([delegate respondsToSelector:@selector(failedToUpdateAccountInfoWithError:)]) {
            [delegate failedToUpdateAccountInfoWithError: error];
        }
    }else if ([link isEqualToString: update_token_func]) {
        if ([delegate respondsToSelector:@selector(failedToUpdateToken)]) {
            [delegate failedToUpdateToken];
        }
        
    }else if ([link isEqualToString: whois_func]) {
        if ([delegate respondsToSelector:@selector(failedToSearchDomainWithError:)]) {
            [delegate failedToSearchDomainWithError: error];
        }
    }else if ([link isEqualToString: list_domain_func]) {
        if ([delegate respondsToSelector:@selector(failedGetDomainsWasRegisteredWithError:)]) {
            [delegate failedGetDomainsWasRegisteredWithError: error];
        }
    }else if ([link isEqualToString: domain_pricing_func]) {
        if ([delegate respondsToSelector:@selector(failedGetPricingListWithError:)]) {
            [delegate failedGetPricingListWithError: error];
        }
    }else if ([link isEqualToString: info_domain_func]) {
        if ([delegate respondsToSelector:@selector(failedGetDomainInfoWithError:)]) {
            [delegate failedGetDomainInfoWithError: error];
        }
    }else if ([link isEqualToString: update_cmnd_func]) {
        if ([delegate respondsToSelector:@selector(failedUpdatePassportForDomainWithError:)]) {
            [delegate failedUpdatePassportForDomainWithError: error];
        }
    }else if ([link isEqualToString: get_dns_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetDNSForDomainWithError:)]) {
            [delegate failedToGetDNSForDomainWithError: error];
        }
    }else if ([link isEqualToString: change_dns_func]) {
        if ([delegate respondsToSelector:@selector(failedToChangeDNSForDomainWithError:)]) {
            [delegate failedToChangeDNSForDomainWithError: error];
        }
    }else if ([link isEqualToString: get_profile_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetProfilesForAccount:)]) {
            [delegate failedToGetProfilesForAccount: error];
        }
    }else if ([link isEqualToString: add_contact_func]) {
        if ([delegate respondsToSelector:@selector(failedToAddProfileWithError:)]) {
            [delegate failedToAddProfileWithError: error];
        }
    }else if ([link isEqualToString: edit_contact_func]) {
        if ([delegate respondsToSelector:@selector(failedToEditProfileWithError:)]) {
            [delegate failedToEditProfileWithError: error];
        }
    }else if ([link isEqualToString: send_question_func]) {
        if ([delegate respondsToSelector:@selector(failedToSendMessage:)]) {
            [delegate failedToSendMessage: error];
        }
    }else if ([link isEqualToString: profile_photo_func]) {
        if ([delegate respondsToSelector:@selector(failedToUpdateAvatarWithError:)]) {
            [delegate failedToUpdateAvatarWithError: error];
        }
    }else if ([link isEqualToString: change_pass_func]) {
        if ([delegate respondsToSelector:@selector(failedToChangePasswordWithError:)]) {
            [delegate failedToChangePasswordWithError: error];
        }
    }else if ([link isEqualToString: hash_key_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetHashKeyWithError:)]) {
            [delegate failedToGetHashKeyWithError: error];
        }
    }else if ([link isEqualToString: resend_otp_func]) {
        if ([delegate respondsToSelector:@selector(failedToResendOTPWithError:)]) {
            [delegate failedToResendOTPWithError: error];
        }
    }else if ([link isEqualToString: check_otp_func]) {
        if ([delegate respondsToSelector:@selector(failedToCheckOTPWithError:)]) {
            [delegate failedToCheckOTPWithError: error];
        }
    }else if ([link isEqualToString: get_history_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetTransactionsHistoryWithError:)]) {
            [delegate failedToGetTransactionsHistoryWithError: error];
        }
    }else if ([link isEqualToString: renew_domain_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetRenewInfoWithError:)]) {
            [delegate failedToGetRenewInfoWithError: error];
        }
    }else if ([link isEqualToString: renew_order_func]) {
        if ([delegate respondsToSelector:@selector(failedToReOrderDomainWithError:)]) {
            [delegate failedToReOrderDomainWithError: error];
        }
    }else if ([link isEqualToString: info_bank_func]) {
        if ([delegate respondsToSelector:@selector(failedToUpdateBankInfoWithError:)]) {
            [delegate failedToUpdateBankInfoWithError: error];
        }
    }else if ([link isEqualToString: withdraw_func]) {
        if ([delegate respondsToSelector:@selector(failedToWithdrawWithError:)]) {
            [delegate failedToWithdrawWithError: error];
        }
    }else if ([link isEqualToString: add_order_func]) {
        if ([delegate respondsToSelector:@selector(failedToAddNewOrderWithError:)]) {
            [delegate failedToAddNewOrderWithError: error];
        }
    }else if ([link isEqualToString: addfun_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetAmoutWithError:)]) {
            [delegate failedToGetAmoutWithError: error];
        }
    }else if ([link isEqualToString: WhoisProtect_func]) {
        if ([delegate respondsToSelector:@selector(failedToUpdateWhoisProtect:)]) {
            [delegate failedToUpdateWhoisProtect: error];
        }
    }else if ([link isEqualToString: DNSRecord_func]) {
        if ([delegate respondsToSelector:@selector(failedToGetDNSRecordList:)]) {
            [delegate failedToGetDNSRecordList: error];
        }
    }
    else if ([link isEqualToString: GetListCSKHAction]){
        if ([delegate respondsToSelector:@selector(failedToGetCustomersSupportList:)]) {
            [delegate failedToGetCustomersSupportList: error];
        }
    }else if ([link isEqualToString: GetAccVoipAction]){
        if ([delegate respondsToSelector:@selector(failedToGetVoipAccount:)]) {
            [delegate failedToGetVoipAccount: error];
        }
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    if ([link isEqualToString:login_func]) {
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
        }
        
        if ([delegate respondsToSelector:@selector(loginSucessfulWithData:)]) {
            [delegate loginSucessfulWithData: data];
        }
    }else if ([link isEqualToString: register_account_func]) {
        if ([delegate respondsToSelector:@selector(registerAccountSuccessfulWithData:)]) {
            [delegate registerAccountSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: edit_profile_func]) {
        if ([delegate respondsToSelector:@selector(updateAccountInfoSuccessfulWithData:)]) {
            [delegate updateAccountInfoSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: update_token_func]) {
        if ([delegate respondsToSelector:@selector(updateTokenSuccessful)]) {
            [delegate updateTokenSuccessful];
            
        }
    }else if ([link isEqualToString: whois_func]) {
        if ([delegate respondsToSelector:@selector(searchDomainSuccessfulWithData:)]) {
            [delegate searchDomainSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: list_domain_func]) {
        if ([delegate respondsToSelector:@selector(getDomainsWasRegisteredSuccessfulWithData:)]) {
            [delegate getDomainsWasRegisteredSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: domain_pricing_func]) {
        if ([delegate respondsToSelector:@selector(getPricingListSuccessfulWithData:)]) {
            [delegate getPricingListSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: info_domain_func]) {
        if ([delegate respondsToSelector:@selector(getDomainInfoSuccessfulWithData:)]) {
            [delegate getDomainInfoSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: update_cmnd_func]) {
        if ([delegate respondsToSelector:@selector(updatePassportForDomainSuccessful)]) {
            [delegate updatePassportForDomainSuccessful];
        }
    }else if ([link isEqualToString: get_dns_func]) {
        if ([delegate respondsToSelector:@selector(getDNSForDomainSuccessfulWithData:)]) {
            [delegate getDNSForDomainSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: change_dns_func]) {
        if ([delegate respondsToSelector:@selector(changeDNSForDomainSuccessful)]) {
            [delegate changeDNSForDomainSuccessful];
        }
    }else if ([link isEqualToString: get_profile_func]) {
        if ([delegate respondsToSelector:@selector(getProfilesForAccountSuccessfulWithData:)]) {
            [delegate getProfilesForAccountSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: add_contact_func]) {
        if ([delegate respondsToSelector:@selector(addProfileSuccessful)]) {
            [delegate addProfileSuccessful];
        }
    }else if ([link isEqualToString: edit_contact_func]) {
        if ([delegate respondsToSelector:@selector(editProfileSuccessful)]) {
            [delegate editProfileSuccessful];
        }
    }else if ([link isEqualToString: send_question_func]) {
        if ([delegate respondsToSelector:@selector(sendMessageToUserSuccessful)]) {
            [delegate sendMessageToUserSuccessful];
        }
    }else if ([link isEqualToString: profile_photo_func]) {
        if ([delegate respondsToSelector:@selector(updateAvatarForProfileSuccessful)]) {
            [delegate updateAvatarForProfileSuccessful];
        }
    }else if ([link isEqualToString: change_pass_func]) {
        if ([delegate respondsToSelector:@selector(changePasswordSuccessful)]) {
            [delegate changePasswordSuccessful];
        }
    }else if ([link isEqualToString: hash_key_func]) {
        if ([delegate respondsToSelector:@selector(getHashKeySuccessfulWithData:)]) {
            [delegate getHashKeySuccessfulWithData: data];
        }
    }else if ([link isEqualToString: resend_otp_func]) {
        if ([delegate respondsToSelector:@selector(resendOTPSuccessfulWithData:)]) {
            [delegate resendOTPSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: check_otp_func]) {
        if ([delegate respondsToSelector:@selector(checkOTPSuccessfulWithData:)]) {
            [delegate checkOTPSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: get_history_func]) {
        if ([delegate respondsToSelector:@selector(getTransactionsHistorySuccessfulWithData:)]) {
            [delegate getTransactionsHistorySuccessfulWithData: data];
        }else{
            NSLog(@"HERE");
        }
    }else if ([link isEqualToString: renew_domain_func]) {
        if ([delegate respondsToSelector:@selector(getRenewInfoForDomainSuccessfulWithData:)]) {
            [delegate getRenewInfoForDomainSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: renew_order_func]) {
        if ([delegate respondsToSelector:@selector(reOrderDomainSuccessfulWithData:)]) {
            [delegate reOrderDomainSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: info_bank_func]) {
        if ([delegate respondsToSelector:@selector(updateBankInfoSuccessfulWithData:)]) {
            [delegate updateBankInfoSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: withdraw_func]) {
        if ([delegate respondsToSelector:@selector(withdrawSuccessfulWithData:)]) {
            [delegate withdrawSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: add_order_func]) {
        if ([delegate respondsToSelector:@selector(addNewOrderSuccessfulWithData:)]) {
            [delegate addNewOrderSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: addfun_func]) {
        if ([delegate respondsToSelector:@selector(getAmoutSuccessfulWithData:)]) {
            [delegate getAmoutSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: WhoisProtect_func]) {
        if ([delegate respondsToSelector:@selector(updateWhoisProtectSuccessfulWithData:)]) {
            [delegate updateWhoisProtectSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: GetListCSKHAction]){
        if ([delegate respondsToSelector:@selector(getCustomersSupportListSuccessfulWithData:)]) {
            [delegate getCustomersSupportListSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: GetAccVoipAction]){
        if ([delegate respondsToSelector:@selector(getVoipAccountSuccessfulWithData:)]) {
            [delegate getVoipAccountSuccessfulWithData: data];
        }
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] link = %@, responeCode = %d", __FUNCTION__, link, responeCode)];
}

#pragma mark - Update token for call

- (void)updateTokenForCallWithToken: (NSString *)token {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    [info setObject:USERNAME forKey:@"id"];
    
    NSString *password = [AccountModel getCusPassword];
    [info setObject:password forKey:@"hash"];
    
    [info setObject:UpdateTokenAction forKey:@"action"];
    [info setObject:token forKey:@"token"];
    
    NSString *total = SFM(@"/cskhvoip%@", password);
    NSString *key = [AppUtils getMD5StringOfString: total];
    [info setObject:key forKey:@"key"];
    
    [webService apiWebServiceForCallWithParams: info];
}

- (void)getAccVoIPFree {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    [info setObject:USERNAME forKey:@"id"];
    
    NSString *password = [AccountModel getCusPassword];
    [info setObject:password forKey:@"hash"];
    
    [info setObject:GetAccVoipAction forKey:@"action"];
    
    NSString *total = SFM(@"/cskhvoip%@", password);
    NSString *key = [AppUtils getMD5StringOfString: total];
    [info setObject:key forKey:@"key"];
    
    [webService apiWebServiceForCallWithParams: info];
}
//  25d55ad283aa400af464c76d713c07ad
- (void)getListCustomersSupport {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    [info setObject:USERNAME forKey:@"id"];
    
    NSString *password = [AccountModel getCusPassword];
    [info setObject:password forKey:@"hash"];
    
    [info setObject:GetListCSKHAction forKey:@"action"];
    
    NSString *total = SFM(@"/cskhvoip%@", password);
    NSString *key = [AppUtils getMD5StringOfString: total];
    [info setObject:key forKey:@"key"];
    
    [webService apiWebServiceForCallWithParams: info];
}

#pragma mark - API for DNS Record of domain

-(void)dnsRecordResultWithData:(NSDictionary *)data action:(NSString *)action {
    if ([action isEqualToString:@"list"]) {
        if ([delegate respondsToSelector:@selector(getDNSRecordsListSuccessfulWithData:)]) {
            [delegate getDNSRecordsListSuccessfulWithData: data];
        }
    }else if ([action isEqualToString:@"add"]){
        if ([delegate respondsToSelector:@selector(addDNSRecordsSuccessfulWithData:)]) {
            [delegate addDNSRecordsSuccessfulWithData: data];
        }
    }else if ([action isEqualToString:@"edit"]){
        if ([delegate respondsToSelector:@selector(updateDNSRecordsSuccessfulWithData:)]) {
            [delegate updateDNSRecordsSuccessfulWithData: data];
        }
    }else if ([action isEqualToString:@"delete"]){
        if ([delegate respondsToSelector:@selector(deleteDNSRecordsSuccessfulWithData:)]) {
            [delegate deleteDNSRecordsSuccessfulWithData: data];
        }
    }
}

-(void)dnsRecordFailedWithData:(NSDictionary *)data action:(NSString *)action {
    if ([action isEqualToString:@"list"]) {
        if ([delegate respondsToSelector:@selector(failedToGetDNSRecordList:)]) {
            [delegate failedToGetDNSRecordList: data];
        }
    }else if ([action isEqualToString:@"add"]){
        if ([delegate respondsToSelector:@selector(failedToAddDNSRecord:)]) {
            [delegate failedToAddDNSRecord: data];
        }
    }else if ([action isEqualToString:@"edit"]){
        if ([delegate respondsToSelector:@selector(failedToUpdateDNSRecord:)]) {
            [delegate failedToUpdateDNSRecord: data];
        }
    }else if ([action isEqualToString:@"delete"]){
        if ([delegate respondsToSelector:@selector(failedToDeleteDNSRecord:)]) {
            [delegate failedToDeleteDNSRecord: data];
        }
    }
}


- (void)getDNSRecordListOfDomain: (NSString *)domain {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain)];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:dns_record_mod forKey:@"mod"];
    [jsonDict setObject:@"list" forKey:@"action"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    
    [webService apiWSForRecordDNSWithParams:jsonDict andAction:@"list"];
}

- (void)addDNSRecordForDomain: (NSString *)domain name: (NSString *)name value: (NSString *)value type:(NSString *)type ttl:(NSString *)ttl mx: (NSString *)mx {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:dns_record_mod forKey:@"mod"];
    [jsonDict setObject:@"add" forKey:@"action"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:name forKey:@"record_name"];
    [jsonDict setObject:value forKey:@"record_value"];
    [jsonDict setObject:type forKey:@"record_type"];
    [jsonDict setObject:ttl forKey:@"record_ttl"];
    [jsonDict setObject:ttl forKey:@"record_ttl"];
    [jsonDict setObject:mx forKey:@"record_mx"];
    
    [webService apiWSForRecordDNSWithParams:jsonDict andAction:@"add"];
}

- (void)updateDNSRecordForDomain: (NSString *)domain name: (NSString *)name value: (NSString *)value type:(NSString *)type ttl:(NSString *)ttl mx: (NSString *)mx record_id: (NSString *)record_id {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:dns_record_mod forKey:@"mod"];
    [jsonDict setObject:@"edit" forKey:@"action"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:name forKey:@"record_name"];
    
    [jsonDict setObject:value forKey:@"record_value"];
    [jsonDict setObject:type forKey:@"record_type"];
    [jsonDict setObject:ttl forKey:@"record_ttl"];
    [jsonDict setObject:ttl forKey:@"record_ttl"];
    [jsonDict setObject:mx forKey:@"record_mx"];
    [jsonDict setObject:record_id forKey:@"record_id"];
    
    [webService apiWSForRecordDNSWithParams:jsonDict andAction:@"edit"];
}

- (void)deleteDNSRecordForDomain: (NSString *)domain record_id:(NSString *)record_id {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:dns_record_mod forKey:@"mod"];
    [jsonDict setObject:@"delete" forKey:@"action"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:record_id forKey:@"record_id"];
    
    [webService apiWSForRecordDNSWithParams:jsonDict andAction:@"delete"];
}

@end
