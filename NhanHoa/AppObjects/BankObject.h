//
//  BankObject.h
//  NhanHoa
//
//  Created by Khai Leo on 6/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankObject : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;
- (BankObject *)initWithName: (NSString *)name code: (NSString *)code;

@end

NS_ASSUME_NONNULL_END
