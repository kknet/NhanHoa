//
//  AppUtils.m
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppUtils.h"
#import "CustomTextAttachment.h"

@implementation AppUtils

+ (void)setPlaceholder: (NSString *)content textfield: (UITextField *)textField color: (UIColor *)color
{
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:content attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        textField.placeholder = content;
    }
}

+ (CGSize)getSizeWithText: (NSString *)text withFont: (UIFont *)font {
    CGSize tmpSize = [text sizeWithAttributes: @{NSFontAttributeName: font}];
    return CGSizeMake(ceilf(tmpSize.width), ceilf(tmpSize.height));
}

+ (CGSize)getSizeWithText: (NSString *)text withFont: (UIFont *)font andMaxWidth: (float )maxWidth {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGRect rect = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}

+ (NSString *)randomStringWithLength: (int)len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int iCount=0; iCount<len; iCount++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform((int)[letters length]) % [letters length]]];
    }
    return randomString;
}

+ (NSAttributedString *)generateTextWithContent: (NSString *)string font:(UIFont *)font color: (UIColor *)color image: (UIImage *)image size: (float)size imageFirst: (BOOL)imageFirst
{
    CustomTextAttachment *attachment = [[CustomTextAttachment alloc] init];
    attachment.image = image;
    [attachment setImageHeight: size];
    
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSMutableAttributedString *result;
    if (imageFirst) {
        NSString *content = [NSString stringWithFormat:@" %@", string];
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content];
        
        [contentString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, contentString.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, contentString.length)];
        
        result = [[NSMutableAttributedString alloc] initWithAttributedString: attachmentString];
        [result appendAttributedString: contentString];
        
    }else{
        NSString *content = [NSString stringWithFormat:@"%@ ", string];
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content];
        
        [contentString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, contentString.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, contentString.length)];
        
        result = [[NSMutableAttributedString alloc] initWithAttributedString: contentString];
        [result appendAttributedString: attachmentString];
    }
    
    return result;
}

@end
