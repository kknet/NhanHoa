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

@end

@interface WebServiceUtils : NSObject<WebServicesDelegate>

+(WebServiceUtils *)getInstance;
@property (nonatomic, strong) WebServices *webService;
@property (nonatomic, weak) id<WebServiceUtilsDelegate> delegate;

- (void)loginWithUsername: (NSString *)username password: (NSString *)password;
- (void)updateTokenWithValue:(NSString *)token;
- (void)searchDomainWithName: (NSString *)domain type: (int)type;
- (void)getDomainsWasRegisteredWithType: (int)type;
- (void)getDomainsPricingList;
- (void)getDomainInfoWithOrdId: (NSString *)ord_id;
- (void)updateCMNDPhotoForDomainWithCMND_a: (NSString *)cmnd_a CMND_b: (NSString *)cmnd_b cusId: (NSString *)cusId;
- (void)getDNSValueForDomain: (NSString *)domain;
- (void)changeDNSForDomain: (NSString *)domain dns1: (NSString *)dns1 dns2: (NSString *)dns2 dns3: (NSString *)dns3 dns4: (NSString *)dns4;
- (void)getListProfilesForAccount: (NSString *)username;
- (void)addProfileWithContent: (NSDictionary *)data;
- (void)editProfileWithContent: (NSDictionary *)data;
- (void)sendMessageWithEmail:(NSString *)email content:(NSString *)content;
- (void)updatePhotoForCustomerWithURL: (NSString *)url;
- (void)changePasswordWithCurrentPass: (NSString *)currentPass newPass: (NSString *)newPass;
- (void)getHashKeyWithHash: (NSString *)hash;

@end

NS_ASSUME_NONNULL_END
