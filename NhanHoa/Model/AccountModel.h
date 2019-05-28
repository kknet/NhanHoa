//
//  AccountModel.h
//  NhanHoa
//
//  Created by admin on 5/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountModel : NSObject

+ (NSString *)getCusIdOfUser;
+ (NSString *)getCusUsernameOfUser;
+ (NSString *)getCusTotalBalance;
+ (NSString *)getCusTotalPoint;
+ (NSString *)getCusPassword;

@end

NS_ASSUME_NONNULL_END
