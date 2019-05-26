//
//  AppUtils.m
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppUtils.h"
#import "CustomTextAttachment.h"
#import <sys/utsname.h>

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
    result = [result stringByReplacingOccurrencesOfString:@"," withString:@"."];
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

+ (void)addBoxShadowForView: (UIView *)view withColor: (UIColor *)color
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 0.4;
}

+ (float)getHeightOfWhoIsDomainViewWithContent: (NSString *)content font:(UIFont *)font heightItem: (float)hItem maxSize: (float)maxSize
{
    float padding = 15.0;
    float defaultHeight = 20 + 30 + 2*padding + hItem + 1.0 + 4*hItem + padding + hItem + 1.0 + 2*hItem + padding + hItem + 1.0 + hItem + padding;
    
    float textSize = hItem;
    if (![AppUtils isNullOrEmpty: content]) {
        textSize = [AppUtils getSizeWithText:content withFont:font andMaxWidth:maxSize].height;
        if (textSize < hItem) {
            textSize = hItem;
        }
    }
    return defaultHeight + textSize;
}

+ (NSString *)generateIDForTransaction {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    // or @"yyyy-MM-dd hh:mm:ss a" if you prefer the time with AM/PM
    NSString *curDate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    return [NSString stringWithFormat:@"%@_%f", curDate, time];
}

+ (NSString *)getPaymentResultWithResponseCode: (NSString *)responseCode
{
    NSString *result = @"";
    if ([responseCode isEqualToString: @"0"]) {
        result = @"Giao dịch thành công";   //  Approved
        
    }else if ([responseCode isEqualToString:@"1"]){
        result = @"Ngân hàng từ chối giao dịch";    //  Bank Declined
        
    }else if ([responseCode isEqualToString:@"3"]){
        result = @"Mã đơn vị không tồn tại";    //  Merchant not exist
        
    }else if ([responseCode isEqualToString:@"4"]){
        result = @"Không đúng access code";    //  Invalid access code
        
    }else if ([responseCode isEqualToString:@"5"]){
        result = @"Số tiền không hợp lệ";    //  Invalid amount
        
    }else if ([responseCode isEqualToString:@"6"]){
        result = @"Mã tiền tệ không tồn tại";    //  Invalid currency code
        
    }else if ([responseCode isEqualToString:@"7"]){
        result = @"Lỗi không xác định";    //  Unspecified Failure
        
    }else if ([responseCode isEqualToString:@"8"]){
        result = @"Số thẻ không đúng";    //  Invalid card Number
        
    }else if ([responseCode isEqualToString:@"9"]){
        result = @"Tên chủ thẻ không đúng";    //  Invalid card name
        
    }else if ([responseCode isEqualToString:@"10"]){
        result = @"Thẻ hết hạn/Thẻ bị khóa";    //  Expired Card
        
    }else if ([responseCode isEqualToString:@"11"]){
        result = @"Thẻ chưa đăng ký sử dụng dịch vụ";    //  Card Not Registed Service(internet banking)
        
    }else if ([responseCode isEqualToString:@"12"]){
        result = @"Ngày phát hành/Hết hạn không đúng";    //  Invalid card date
        
    }else if ([responseCode isEqualToString:@"13"]){
        result = @"Vượt quá hạn mức thanh toán";    //  Exist Amount
        
    }else if ([responseCode isEqualToString:@"21"]){
        result = @"Số tiền không đủ để thanh toán";    //  Insufficient fund
        
    }else if ([responseCode isEqualToString:@"99"]){
        result = @"Người sủ dụng hủy giao dịch";    //  User cancel
        
    }else{
        result = @"Giao dịch thất bại";    //  Failured
    }
    return result;
}

// Remove all special characters from string
+ (BOOL)checkValidCurrency: (NSString *)money {
    for (int index=0; index<money.length; index++) {
        char character = [money characterAtIndex: index];
        NSString *str = [NSString stringWithFormat:@"%c", character];
        if (![[AppDelegate sharedInstance].listNumber containsObject: str]) {
            return FALSE;
        }
    }
    return TRUE;
}

//  https://www.theiphonewiki.com/wiki/Models
+ (NSString *)getModelsOfCurrentDevice {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *modelType =  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return modelType;
}

+ (void)setBorderForTextfield: (UITextField *)textfield borderColor: (UIColor *)borderColor {
    textfield.layer.borderWidth = 1.0;
    textfield.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    textfield.layer.borderColor = borderColor.CGColor;
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7.5, textfield.frame.size.height)];
    textfield.leftView = leftView;
    textfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 7.5, textfield.frame.size.height)];
    textfield.rightView = rightView;
    textfield.rightViewMode = UITextFieldViewModeAlways;
}

@end
