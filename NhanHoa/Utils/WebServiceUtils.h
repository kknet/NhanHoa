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

@end

NS_ASSUME_NONNULL_END
