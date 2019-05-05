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

+ (NSString *)convertStringToCurrencyFormat: (NSString *)content {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.maximumFractionDigits = 2;
    formatter.positiveFormat = @"#,##0";
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithDouble:[content doubleValue]]];
    
    return result;
}

+ (NSAttributedString *)convertLineStringToCurrencyFormat: (NSString *)content {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.maximumFractionDigits = 2;
    formatter.positiveFormat = @"#,##0";
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithDouble:[content doubleValue]]];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Hello Good Morning"];
    [attributeString addAttribute:NSUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:1]
                            range:(NSRange){0,[attributeString length]}];
    
    
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 40.0;
    
    NSDictionary *infoAttr = [NSDictionary dictionaryWithObjectsAndKeys:paragraph, NSParagraphStyleAttributeName, nil];
    NSMutableAttributedString* attrString = [[NSMutableAttributedString  alloc] initWithString:result];
    [attrString addAttributes:infoAttr range:NSMakeRange(0, attrString.length)];
    
    return attrString;
}

+ (void)addDashedLineForView: (UIView *)view color: (UIColor *)color {
    CAShapeLayer *viewBorder = [CAShapeLayer layer];
    viewBorder.strokeColor = color.CGColor;
    viewBorder.fillColor = nil;
    viewBorder.lineDashPattern = @[@2, @2];
    viewBorder.frame = CGRectMake(0, 0, SCREEN_WIDTH-30, 365-35);
    viewBorder.path = [UIBezierPath bezierPathWithRect: CGRectMake(0, 0, SCREEN_WIDTH-30, 365-35)].CGPath;
    [view.layer addSublayer:viewBorder];
}

+(BOOL)isNullOrEmpty:(NSString*)string{
    return string == nil || string==(id)[NSNull null] || [string isEqualToString: @""];
}

+ (NSString *)getCurrentDate{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getCurrentDateTimeToString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (BOOL)checkNetworkAvailable {
    NetworkStatus internetStatus = [[AppDelegate sharedInstance].internetReachable currentReachabilityStatus];
    if (internetStatus == ReachableViaWiFi || internetStatus == ReachableViaWWAN) {
        return TRUE;
    }
    return FALSE;
}

@end
