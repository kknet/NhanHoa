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

+ (BOOL)isSignedAccount;
+ (NSString *)getCusIdOfUser;
+ (NSString *)getCusUsernameOfUser;
+ (NSString *)getCusTotalBalance;
+ (NSString *)getCusBalance;
+ (NSString *)getCusTotalPoint;
+ (NSString *)getCusPoint;
+ (NSString *)getCusPassword;
+ (NSString *)getCusRealName;
+ (NSString *)getCusEmail;
+ (int)getCusOwnType;
+ (int)getCusGender;
+ (NSString *)getCusBirthday;
+ (NSString *)getCusPassport;
+ (NSString *)getCusPhone;
+ (NSString *)getCusAddress;
+ (NSString *)getCusCityCode;
+ (NSString *)getCusPhoto;

//  bussiness
+ (NSString *)getCusCompanyName;
+ (NSString *)getCusCompanyTax;
+ (NSString *)getCusCompanyAddress;
+ (NSString *)getCusCompanyPhone;
+ (NSString *)getCusCompanyPosition;
+ (NSString *)getCusBankAccount;
+ (NSString *)getCusBankName;
+ (NSString *)getCusBankNumber;

@end

NS_ASSUME_NONNULL_END
