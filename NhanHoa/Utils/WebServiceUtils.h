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
- (void)getDNSForDomainSuccessfulWithData: (NSString *)error;

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

@end

NS_ASSUME_NONNULL_END
