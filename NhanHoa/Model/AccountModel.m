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

+ (NSString *)getCusTotalPoint {
    id totalPoint = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_total_point"];
    
    if (totalPoint != nil && [totalPoint isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%ld", [totalPoint longValue]];
        
    }else if (totalPoint != nil && [totalPoint isKindOfClass:[NSString class]]) {
        return totalPoint;
    }
    return @"";
}

+ (NSString *)getCusPassword {
    NSString *password = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_password"];
    return password;
}

@end
