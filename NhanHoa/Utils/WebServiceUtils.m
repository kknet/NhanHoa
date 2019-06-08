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
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] -----> Function = %@ & responeCode = %d", __FUNCTION__, link, responeCode) toFilePath:[AppDelegate sharedInstance].logFilePath];
}



@end
