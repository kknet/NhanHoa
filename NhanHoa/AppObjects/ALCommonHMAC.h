//
//  ALCommonHMAC.h
//  NhanHoa
//
//  Created by OS on 9/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ALCommonHMAC : NSObject

+ (NSString*)hmacSHA256:(NSString*)data withKey:(NSString *)key;
+ (NSString*)base64forData:(NSData*)theData;

@end

NS_ASSUME_NONNULL_END
