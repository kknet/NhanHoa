//
//  AppUtils.h
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUtils : NSObject

+ (void)setPlaceholder: (NSString *)content textfield: (UITextField *)textField color: (UIColor *)color;
+ (CGSize)getSizeWithText: (NSString *)text withFont: (UIFont *)font;
+ (CGSize)getSizeWithText: (NSString *)text withFont: (UIFont *)font andMaxWidth: (float )maxWidth;
+ (NSString *)randomStringWithLength: (int)len;
+ (NSAttributedString *)generateTextWithContent: (NSString *)string font:(UIFont *)font color: (UIColor *)color image: (UIImage *)image size: (float)size imageFirst: (BOOL)imageFirst;
+ (NSString *)convertStringToCurrencyFormat: (NSString *)content;
+ (NSAttributedString *)convertLineStringToCurrencyFormat: (NSString *)content;
+ (void)addDashedLineForView: (UIView *)view color: (UIColor *)color;
+(BOOL)isNullOrEmpty:(NSString*)string;
+ (NSString *)getCurrentDate;
+ (NSString *)getCurrentDateTimeToString;
+ (BOOL)checkNetworkAvailable;

@end
