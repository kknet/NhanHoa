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

//  login function
- (void)loginWithUsername: (NSString *)username password: (NSString *)password
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@, password = %@", __FUNCTION__, username, password) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    [webService callWebServiceWithLink:login_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

//  update token function
- (void)updateTokenWithValue:(NSString *)token {
    if (![AppUtils isNullOrEmpty: token]) {
        [WriteLogsUtils writeLogContent:SFM(@"[%s] token = %@", __FUNCTION__, token) toFilePath:[AppDelegate sharedInstance].logFilePath];
    }else{
        [WriteLogsUtils writeLogContent:SFM(@"[%s] token = EMPTYYYYYYYYY", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    }
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:update_token_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:token forKey:@"token"];
    
    [webService callWebServiceWithLink:update_token_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

//  search whois domain
- (void)searchDomainWithName: (NSString *)domain type: (int)type
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@, type = %d", __FUNCTION__, domain, type) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:whois_mod forKey:@"mod"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:[AccountModel getCusIdOfUser] forKey:@"cus_id"];
    [jsonDict setObject:[NSNumber numberWithInt: type] forKey:@"type"];
    [webService callWebServiceWithLink:whois_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

//  get domain list which was registerd
- (void)getDomainsWasRegisteredWithType: (int)type
{
    //  type = 1: list domain sắp hết hạn
    //  type = 0: default [all]
    [WriteLogsUtils writeLogContent:SFM(@"[%s] type = %d", __FUNCTION__, type) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:list_domain_mod forKey:@"mod"];
    [jsonDict setObject:[AccountModel getCusUsernameOfUser] forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:[NSNumber numberWithInt: type] forKey:@"type"];
    
    [webService callWebServiceWithLink:list_domain_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getDomainsPricingList {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:domain_pricing_mod forKey:@"mod"];
    [webService callWebServiceWithLink:domain_pricing_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getDomainInfoWithOrdId: (NSString *)ord_id {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] ord_id = %@", __FUNCTION__, ord_id) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:info_domain_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:ord_id forKey:@"ord_id"];
    
    [webService callWebServiceWithLink:info_domain_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jsonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)updateCMNDPhotoForDomainWithCMND_a: (NSString *)cmnd_a CMND_b: (NSString *)cmnd_b cusId: (NSString *)cusId
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] cmnd_a = %@, cmnd_b = %@", __FUNCTION__, cmnd_a, cmnd_b) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:update_cmnd_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:cusId forKey:@"cus_id"];
    
    if (![AppUtils isNullOrEmpty: cmnd_a]) {
        [jsonDict setObject:cmnd_a forKey:@"cmnd_a"];
    }
    
    if (![AppUtils isNullOrEmpty: cmnd_b]) {
        [jsonDict setObject:cmnd_b forKey:@"cmnd_b"];
    }
    
    [webService callWebServiceWithLink:update_cmnd_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jsonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getDNSValueForDomain: (NSString *)domain
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_dns_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    
    [webService callWebServiceWithLink:get_dns_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jsonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)changeDNSForDomain: (NSString *)domain dns1: (NSString *)dns1 dns2: (NSString *)dns2 dns3: (NSString *)dns3 dns4: (NSString *)dns4
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@, dn1 = %@, dn2 = %@, dns3 = %@, dns4 = %@", __FUNCTION__, domain, dns1, dns2, dns3, dns4) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
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
    [webService callWebServiceWithLink:change_dns_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jsonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getListProfilesForAccount: (NSString *)username {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@", __FUNCTION__, username) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_profile_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [webService callWebServiceWithLink:get_profile_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jsonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)addProfileWithContent: (NSDictionary *)data
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [webService callWebServiceWithLink:add_contact_func withParams:data];
}

- (void)editProfileWithContent: (NSDictionary *)data
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [webService callWebServiceWithLink:edit_contact_func withParams:data];
}

-(void)sendMessageWithEmail:(NSString *)email content:(NSString *)content
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] email = %@, content = %@", __FUNCTION__, email, content) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:question_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:email forKey:@"email"];
    [jsonDict setObject:content forKey:@"content"];
    [webService callWebServiceWithLink:send_question_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jsonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)updatePhotoForCustomerWithURL: (NSString *)url
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] url = %@", __FUNCTION__, url) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:profile_photo_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:url forKey:@"photo"];
    
    [webService callWebServiceWithLink:profile_photo_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)changePasswordWithCurrentPass: (NSString *)currentPass newPass: (NSString *)newPass
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] currentPass = %@, newPass = %@", __FUNCTION__, currentPass, newPass) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:change_password_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:currentPass forKey:@"old_password"];
    [jsonDict setObject:newPass forKey:@"new_password"];
    [jsonDict setObject:newPass forKey:@"re_new_password"];
    [webService callWebServiceWithLink:change_pass_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getHashKeyWithHash: (NSString *)hash {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] hash = %@", __FUNCTION__, hash) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:hash_key_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:hash forKey:@"hash"];
    [webService callWebServiceWithLink:hash_key_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)checkOTPForUsername: (NSString *)username password: (NSString *)password andOTPCode: (NSString *)code {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@, password = %@, otpCode = %@", __FUNCTION__, username, password, code) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:check_otp_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    [jsonDict setObject:code forKey:@"code"];
    [webService callWebServiceWithLink:check_otp_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)resendOTPForUsername: (NSString *)username password: (NSString *)password {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] username = %@, password = %@", __FUNCTION__, username, password) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:resend_otp_mod forKey:@"mod"];
    [jsonDict setObject:username forKey:@"username"];
    [jsonDict setObject:password forKey:@"password"];
    [webService callWebServiceWithLink:resend_otp_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getTransactionsHistory {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_history_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [webService callWebServiceWithLink:get_history_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getRenewInfoForDomain: (NSString *)domain {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:renew_domain_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [webService callWebServiceWithLink:renew_domain_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)renewOrderForDomain: (NSString *)domain contactId: (NSString *)contact_id ord_id:(NSString *)ord_id years: (int)years {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:renew_order_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:contact_id forKey:@"contact_id"];
    [jsonDict setObject:ord_id forKey:@"ord_id"];
    [jsonDict setObject:[NSNumber numberWithInt: years] forKey:@"year"];
    [webService callWebServiceWithLink:renew_order_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict]) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] -----> Function: %@.\n Error: %@", __FUNCTION__, link, @[error]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString:login_func]) {
        if ([delegate respondsToSelector:@selector(failedToLoginWithError:)]) {
            [delegate failedToLoginWithError: error];
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
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] -----> Function = %@.\n Response data: %@", __FUNCTION__, link, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString:login_func]) {
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
        }
        
        if ([delegate respondsToSelector:@selector(loginSucessfulWithData:)]) {
            [delegate loginSucessfulWithData: data];
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
        }
    }else if ([link isEqualToString: renew_domain_func]) {
        if ([delegate respondsToSelector:@selector(getRenewInfoForDomainSuccessfulWithData:)]) {
            [delegate getRenewInfoForDomainSuccessfulWithData: data];
        }
    }else if ([link isEqualToString: renew_order_func]) {
        if ([delegate respondsToSelector:@selector(reOrderDomainSuccessfulWithData:)]) {
            [delegate reOrderDomainSuccessfulWithData: data];
        }
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] -----> Function = %@ & responeCode = %d", __FUNCTION__, link, responeCode) toFilePath:[AppDelegate sharedInstance].logFilePath];
}



@end
