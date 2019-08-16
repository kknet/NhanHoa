//
//  AccountModel.m
//  NhanHoa
//
//  Created by admin on 5/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

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

+ (void)storePasswordForAccount {
    NSString *password = [self getCusPassword];
    if (![AppUtils isNullOrEmpty: password]) {
        [[NSUserDefaults standardUserDefaults] setObject:[AccountModel getCusPassword] forKey:pass_for_backup];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:pass_for_backup];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getPasswordWasStoredForAccount {
    NSString *passWasStored = [[NSUserDefaults standardUserDefaults] objectForKey:pass_for_backup];
    if (![AppUtils isNullOrEmpty: passWasStored]) {
        return passWasStored;
    }
    return @"";
}

+ (UIImage *)getBannerPhotoFromUser {
    NSArray *arr = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_banner"];
    if (arr.count > 0) {
        NSDictionary *info = [arr firstObject];
        NSString *image = [info objectForKey:@"image"];
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        return [UIImage imageWithData: imgData];
    }else{
        return [UIImage imageNamed:@"banner.png"];
    }
}

@end
