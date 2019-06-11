//
//  BankObject.m
//  NhanHoa
//
//  Created by Khai Leo on 6/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BankObject.h"

@implementation BankObject

@synthesize code, name;

- (BankObject *)initWithName: (NSString *)name code: (NSString *)code {
    BankObject *bank = [[BankObject alloc] init];
    bank.name = name;
    bank.code = code;
    return bank;
}

@end
