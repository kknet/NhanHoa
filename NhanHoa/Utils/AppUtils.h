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
@end
