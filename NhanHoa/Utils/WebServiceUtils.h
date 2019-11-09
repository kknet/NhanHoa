//
//  WebServiceUtils.h
//  NhanHoa
//
//  Created by Khai Leo on 6/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServices.h"

NS_ASSUME_NONNULL_BEGIN

@protocol WebServiceUtilsDelegate <NSObject>
@optional

- (void)failedToRegisterAccountWithError:(NSString *)error;
- (void)registerAccountSuccessfulWithData:(NSDictionary *)data;

- (void)failedToUpdateAccountInfoWithError:(NSString *)error;
- (void)updateAccountInfoSuccessfulWithData:(NSDictionary *)data;

- (void)failedToLoginWithError: (NSString *)error;
- (void)loginSucessfulWithData: (NSDictionary *)data;

- (void)updateTokenSuccessful;
- (void)failedToUpdateToken;

- (void)failedToSearchDomainWithError: (NSString *)error;
- (void)searchDomainSuccessfulWithData: (NSDictionary *)data;

- (void)failedGetDomainsWasRegisteredWithError: (NSString *)error;
- (void)getDomainsWasRegisteredSuccessfulWithData: (NSDictionary *)data;

- (void)failedGetPricingListWithError: (NSString *)error;
- (void)getPricingListSuccessfulWithData: (NSDictionary *)data;

- (void)failedGetDomainInfoWithError: (NSString *)error;
- (void)getDomainInfoSuccessfulWithData: (NSDictionary *)data;

- (void)failedUpdatePassportForDomainWithError: (NSString *)error;
- (void)updatePassportForDomainSuccessful;

- (void)failedToGetDNSForDomainWithError: (NSString *)error;
- (void)getDNSForDomainSuccessfulWithData: (NSDictionary *)data;

- (void)failedToChangeDNSForDomainWithError: (NSString *)error;
- (void)changeDNSForDomainSuccessful;

- (void)failedToGetProfilesForAccount: (NSString *)error;
- (void)getProfilesForAccountSuccessfulWithData: (NSDictionary *)data;

- (void)failedToAddProfileWithError: (NSString *)error;
- (void)addProfileSuccessful;

- (void)failedToEditProfileWithError: (NSString *)error;
- (void)editProfileSuccessful;

- (void)failedToSendMessage: (NSString *)error;
- (void)sendMessageToUserSuccessful;

- (void)failedToUpdateAvatarWithError: (NSString *)error;
- (void)updateAvatarForProfileSuccessful;

- (void)failedToChangePasswordWithError: (NSString *)error;
- (void)changePasswordSuccessful;

- (void)failedToGetHashKeyWithError: (NSString *)error;
- (void)getHashKeySuccessfulWithData: (NSDictionary *)data;

- (void)failedToCheckOTPWithError: (NSString *)error;
- (void)checkOTPSuccessfulWithData: (NSDictionary *)data;

- (void)failedToResendOTPWithError: (NSString *)error;
- (void)resendOTPSuccessfulWithData: (NSDictionary *)data;

- (void)failedToGetTransactionsHistoryWithError: (NSString *)error;
- (void)getTransactionsHistorySuccessfulWithData: (NSDictionary *)data;

- (void)failedToGetRenewInfoWithError: (NSString *)error;
- (void)getRenewInfoForDomainSuccessfulWithData: (NSDictionary *)data;

- (void)failedToReOrderDomainWithError: (NSString *)error;
- (void)reOrderDomainSuccessfulWithData: (NSDictionary *)data;

- (void)failedToUpdateBankInfoWithError: (NSString *)error;
- (void)updateBankInfoSuccessfulWithData: (NSDictionary *)data;

- (void)failedToWithdrawWithError: (NSString *)error;
- (void)withdrawSuccessfulWithData: (NSDictionary *)data;

- (void)failedToAddNewOrderWithError: (NSString *)error;
- (void)addNewOrderSuccessfulWithData: (NSDictionary *)data;

- (void)failedToGetAmoutWithError: (NSString *)error;
- (void)getAmoutSuccessfulWithData: (NSDictionary *)data;

- (void)failedToUpdateWhoisProtect: (NSString *)error;
- (void)updateWhoisProtectSuccessfulWithData: (NSDictionary *)data;

- (void)failedToGetDNSRecordList: (id)error;
- (void)getDNSRecordsListSuccessfulWithData: (NSDictionary *)data;

- (void)failedToAddDNSRecord: (id)error;
- (void)addDNSRecordsSuccessfulWithData: (NSDictionary *)data;

- (void)failedToUpdateDNSRecord: (id)error;
- (void)updateDNSRecordsSuccessfulWithData: (NSDictionary *)data;

- (void)failedToDeleteDNSRecord: (id)error;
- (void)deleteDNSRecordsSuccessfulWithData: (NSDictionary *)data;

- (void)failedToGetCustomersSupportList: (NSString *)error;
- (void)getCustomersSupportListSuccessfulWithData: (NSDictionary *)data;

- (void)failedToUpdateCallToken: (NSString *)error;
- (void)updateCallTokenSuccesful;

- (void)failedToGetVoipAccount: (NSString *)error;
- (void)getVoipAccountSuccessfulWithData: (NSDictionary *)data;

@end

@interface WebServiceUtils : NSObject<WebServicesDelegate>

+(WebServiceUtils *)getInstance;
@property (nonatomic, strong) WebServices *webService;
@property (nonatomic, weak) id<WebServiceUtilsDelegate> delegate;

- (void)registerNewAccountWithInfo: (NSDictionary *)accInfo;
- (void)updateAccountProfileWithInfo: (NSMutableDictionary *)info;
- (void)loginWithUsername: (NSString *)username password: (NSString *)password;
- (void)updateTokenWithValue:(NSString *)token;
- (void)searchDomainWithName: (NSString *)domain type: (int)type;
- (void)getDomainsWasRegisteredWithType: (int)type;
- (void)getDomainsPricingList;
- (void)getDomainInfoWithOrdId: (NSString *)ord_id;
- (void)updateCMNDPhotoForDomainWithCMND_a: (NSString *)cmnd_a CMND_b: (NSString *)cmnd_b cusId: (NSString *)cusId domainName: (NSString *)domainName domainType: (NSString *)domainType domainId: (NSString *)domainId banKhai: (NSString *)banKhai;
- (void)getDNSValueForDomain: (NSString *)domain;
- (void)changeDNSForDomain: (NSString *)domain dns1: (NSString *)dns1 dns2: (NSString *)dns2 dns3: (NSString *)dns3 dns4: (NSString *)dns4;
- (void)getListProfilesForAccount: (NSString *)username;
- (void)addProfileWithContent: (NSDictionary *)data;
- (void)editProfileWithContent: (NSDictionary *)data;
- (void)sendMessageWithContent:(NSString *)content;
- (void)updatePhotoForCustomerWithURL: (NSString *)url;
- (void)changePasswordWithCurrentPass: (NSString *)currentPass newPass: (NSString *)newPass;
- (void)checkOTPForUsername: (NSString *)username password: (NSString *)password andOTPCode: (NSString *)code;
- (void)resendOTPForUsername: (NSString *)username password: (NSString *)password;
- (void)confirmOTPCodeWithEmail:(NSString *)email password:(NSString *)password code:(NSString *)code;
- (void)getTransactionsHistory;
- (void)getRenewInfoForDomain: (NSString *)domain;
- (void)renewOrderForDomain: (NSString *)domain contactId: (NSString *)contact_id ord_id:(NSString *)ord_id years: (int)years;
- (void)updateBankInfoWithBankName: (NSString *)bankname bankaccount: (NSString *)bankaccount banknumber:(NSString *)banknumber;
- (void)withdrawWithAmout: (long)amount;
- (void)addOrderForDomain: (NSString *)domain contact_id: (NSString *)contact_id year: (int)year protect: (NSNumber *)protect;
- (void)getAddfunWithAmout: (NSString *)amount type: (int)type;
- (void)updateWhoisProtectForDomain: (NSString *)domain domainId: (NSString *)domainId protectValue: (BOOL)protect;

#pragma mark - Call API
- (void)updateTokenForCallWithToken: (NSString *)token;
- (void)getAccVoIPFree;
- (void)getListCustomersSupport;

#pragma mark - Api for DNS record of domain
- (void)getDNSRecordListOfDomain: (NSString *)domain;
- (void)addDNSRecordForDomain: (NSString *)domain name: (NSString *)name value: (NSString *)value type:(NSString *)type ttl:(NSString *)ttl mx: (NSString *)mx;
- (void)updateDNSRecordForDomain: (NSString *)domain name: (NSString *)name value: (NSString *)value type:(NSString *)type ttl:(NSString *)ttl mx: (NSString *)mx record_id: (NSString *)record_id;
- (void)deleteDNSRecordForDomain: (NSString *)domain record_id:(NSString *)record_id;

@end

NS_ASSUME_NONNULL_END
