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

@end
