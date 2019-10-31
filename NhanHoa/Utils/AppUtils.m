//
//  AppUtils.m
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppUtils.h"
#import "CustomTextAttachment.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (MD5)
- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (int)strlen(cstr), result);
    
    return SFM(@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3],
               result[4], result[5], result[6], result[7],
               result[8], result[9], result[10], result[11],
               result[12], result[13], result[14], result[15]);
}
@end

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
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:SFM(@" %@", string)];
        
        [contentString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, contentString.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, contentString.length)];
        
        result = [[NSMutableAttributedString alloc] initWithAttributedString: attachmentString];
        [result appendAttributedString: contentString];
        
    }else{
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:SFM(@"%@ ", string)];
        
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
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getCurrentDateForLogFolder{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getCurrentDateTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy_HH-mm-ss"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getDateTimeStringNotHaveSecondsFromDate: (NSDate *)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd/MM/yyyy HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (NSString *)getCurrentDateTimeToString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSDate *)convertStringToDate: (NSString *)dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Bangkok"]];
    NSDate *dateFromString = [dateFormatter dateFromString:dateString];
    return dateFromString;
}

+ (NSString *)convertDateToString: (NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

+ (NSString *)getDateStringFromTimerInterval: (long)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
    return [self convertDateToString: date];
}

+ (NSString *)getTimeStringFromTimerInterval: (long)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *stringDate = [dateFormatter stringFromDate:date];
    return stringDate;
}

+ (NSString *)getDateTimeStringFromTimerInterval: (long)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: timeInterval];
    return [self getDateTimeStringNotHaveSecondsFromDate: date];
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

+ (void)addBoxShadowForView: (UIView *)view color: (UIColor *)color opacity: (float)opacity offsetX: (float)x offsetY:(float)y
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(x, y);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = opacity;
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
    return SFM(@"%@_%f", curDate, time);
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
        NSString *str = SFM(@"%c", character);
        if (![[AppDelegate sharedInstance].listNumber containsObject: str]) {
            return FALSE;
        }
    }
    return TRUE;
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

+ (NSString *)getMD5StringOfString: (NSString *)string {
    return [[string MD5String] lowercaseString];
}

+(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 500.0;
    float maxWidth = 800.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image
{
    int kMaxResolution = image.size.width; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

// Hàm crop một ảnh với kích thước-
+ (UIImage*)cropImageWithSize:(CGSize)targetSize fromImage: (UIImage *)sourceImage
{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
        {
            scaleFactor = widthFactor; // scale to fit height
        }
        else
        {
            scaleFactor = heightFactor; // scale to fit width
        }
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 1;
        }
        else
        {
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 1;
            }
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
    {
        NSLog(@"could not scale image");
    }
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (NSString *)getAppVersionWithBuildVersion: (BOOL)showBuildVersion {
    NSString *version = @"";
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    
    if (!showBuildVersion) {
        version = [info objectForKey:@"CFBundleShortVersionString"];
    }else{
        version = SFM(@"%@ (%@)", [info objectForKey:@"CFBundleShortVersionString"], [info objectForKey:@"CFBundleVersion"]);
    }
    return version;
}

+ (NSString *)getBuildDate
{
    NSString *dateStr = SFM(@"%@ %@", [NSString stringWithUTF8String:__DATE__], [NSString stringWithUTF8String:__TIME__]);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"LLL d yyyy HH:mm:ss"];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *date1 = [dateFormatter dateFromString:dateStr];
    
    NSTimeInterval time = [date1 timeIntervalSince1970];
    NSString *dateResult = [AppUtils stringDateFromInterval: time];
    return dateResult;
}

+ (NSString *)stringDateFromInterval: (NSTimeInterval)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970: interval];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    
    NSString *dateString = [dateFormat stringFromDate:date];
    return dateString;
}

+ (void) createDirectoryAndSubDirectory:(NSString *)directory
{
    NSString* filePath = @"";
    NSArray* pathcoms= [directory componentsSeparatedByString:@"/"];
    if([pathcoms count]>1)
    {
        for(int i=0;i<[pathcoms count]-1;i++)
        {
            filePath=[filePath stringByAppendingPathComponent:[pathcoms objectAtIndex:i]];
            [self createDirectory:filePath];
        }
    }
    filePath = [filePath stringByAppendingPathComponent:[pathcoms objectAtIndex:[pathcoms count]-1]];
    [self createDirectory:filePath];
}

+ (void) createDirectory:(NSString*)directory
{
    NSString *path1;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    path1 = [[paths objectAtIndex:0] stringByAppendingPathComponent:directory];
    NSError *error;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path1])    //Does directory already exist?
    {
        if (![[NSFileManager defaultManager] createDirectoryAtPath:path1
                                       withIntermediateDirectories:NO
                                                        attributes:nil
                                                             error:&error])
        {
            NSLog(@"Create directory error: %@", error);
        }
    }
}

+ (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)saveFileToFolder: (NSData *)fileData withName: (NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *tempPath = [documentsDirectory stringByAppendingFormat:@"%@", fileName];
    BOOL success = [fileData writeToFile:tempPath atomically:NO];
    return success;
}

+ (NSData *)getFileDataFromDirectoryWithFileName: (NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathFile = [documentsDirectory stringByAppendingPathComponent:SFM(@"%@", fileName)];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath: pathFile];
    
    if (!fileExists) {
        return nil;
    }else{
        NSData *fileData = [NSData dataWithContentsOfFile: pathFile];
        return fileData;
    }
}

+ (NSString *)getErrorContentFromData: (id)data {
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *message = [data objectForKey:@"message"];
        if (![AppUtils isNullOrEmpty: message]) {
            return message;
        }
        
        NSString *errorCode = [data objectForKey:@"errorCode"];
        if (![AppUtils isNullOrEmpty: errorCode]) {
            message = [[AppDelegate sharedInstance].errorMsgDict objectForKey:errorCode];
            if (![AppUtils isNullOrEmpty: message]) {
                return message;
            }
        }
    }else if ([data isKindOfClass:[NSString class]]){
        return data;
    }
    return @"Đã có lỗi xảy ra. Vui lòng kiểm tra lại!";
}

+ (NSString *)getYesterdayDateString {
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow: -(60.0f*60.0f*24.0f)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Bangkok"]];
    return [formatter stringFromDate: yesterday];
}

+ (NSString *)getStatusValueWithCode: (NSString *)status {
    if ([status isEqualToString:@"0"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Waiting"];
        
    }else if ([status isEqualToString:@"1"] || [status isEqualToString:@"7"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Processing"];
        
    }else if ([status isEqualToString:@"2"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Actived"];
        
    }else if ([status isEqualToString:@"3"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Cancelled"];
        
    }else if ([status isEqualToString:@"4"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Renewing"];
        
    }else if ([status isEqualToString:@"5"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Waiting for renewal"];
        
    }else if ([status isEqualToString:@"6"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Expired"];
        
    }else if ([status isEqualToString:@"8"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Suspending"];
        
    }else if ([status isEqualToString:@"9"]) {
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Suspended"];
        
    }else{
        return [[AppDelegate sharedInstance].localization localizedStringForKey:@"Undefined"];
    }
}

+ (BOOL)checkDomainIsNationalDomain: (NSString *)domain {
    if ([domain hasSuffix:@".vn"] || [domain hasSuffix:@".com.vn"]) {
        return TRUE;
    }
    return FALSE;
}

+ (NSString *)durationToString:(int)duration {
    NSMutableString *result = [[NSMutableString alloc] init];
    if (duration / 3600 > 0) {
        [result appendString:SFM(@"%02i:", duration / 3600)];
        duration = duration % 3600;
    }
    return [result stringByAppendingString:SFM(@"%02i:%02i", (duration / 60), (duration % 60))];
}

+ (NSArray *)bluetoothRoutes {
    return @[ AVAudioSessionPortBluetoothA2DP, AVAudioSessionPortBluetoothLE, AVAudioSessionPortBluetoothHFP ];
}

+ (BOOL)stringContainsOnlyNumber: (NSString *)string
{
    NSArray *numbers = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    for (int index=0; index<string.length; index++) {
        char c = [string characterAtIndex: index];
        NSString *character = SFM(@"%c", c);
        if (![numbers containsObject: character]) {
            return FALSE;
        }
    }
    return TRUE;
}

+ (NSString *)urlencode: (NSString *)string {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[string UTF8String];
    unsigned long sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

+ (NSString *)getHashHmacSHA256OfString:(NSString *)data key:(NSString *)key
{
    const char *secretKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *plainData = [data cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, secretKey, strlen(secretKey), plainData, strlen(plainData), cHMAC);
    NSData *HMACData = [NSData dataWithBytes:cHMAC length:sizeof(cHMAC)];
    const unsigned char *bufferChar = (const unsigned char *)[HMACData bytes];
    NSMutableString *hmacString = [NSMutableString stringWithCapacity:HMACData.length * 2];
    for (int i = 0; i < HMACData.length; ++i){
        [hmacString appendFormat:@"%02x", bufferChar[i]];
    }
    return hmacString;
}

+ (BOOL)checkVersionAppToAcceptLogin: (NSString *)requireVersion {
    NSArray *requireArr = [requireVersion componentsSeparatedByString:@"."];
    
    NSString *curVersion = [AppUtils getAppVersionWithBuildVersion: FALSE];
    NSArray *currentArr = [curVersion componentsSeparatedByString:@"."];
    
    if (requireArr.count == currentArr.count) {
        for (int i=0; i<currentArr.count; i++) {
            NSString *require = [requireArr objectAtIndex: i];
            NSString *current = [currentArr objectAtIndex: i];
            
            if ([require intValue] > [current intValue]) {
                return FALSE;
                
            }else if ([current intValue] > [require intValue]) {
                return TRUE;
            }
        }
        //  version hiện tại giống version tối thiểu đc yêu cầu
        return TRUE;
        
    }else if (requireArr.count > currentArr.count) {
        for (int i=0; i<currentArr.count; i++) {
            NSString *require = [requireArr objectAtIndex: i];
            NSString *current = [currentArr objectAtIndex: i];
            
            if ([require intValue] > [current intValue]) {
                return FALSE;
                
            }else if ([current intValue] > [require intValue]) {
                return TRUE;
            }
        }
        //  version hiện tại nhỏ hơn version được yêu cầu
        return FALSE;
    }else {
        for (int i=0; i<requireArr.count; i++) {
            NSString *require = [requireArr objectAtIndex: i];
            NSString *current = [currentArr objectAtIndex: i];
            
            if ([require intValue] > [current intValue]) {
                return FALSE;
                
            }else if ([current intValue] > [require intValue]){
                return TRUE;
            }
        }
        //  version hiện tại lớn hơn version được yêu cầu
        return TRUE;
    }
}

+ (void)addCurvePathForViewWithHeight: (float)height forView: (UIView *)view withColor: (UIColor *)color heightCurve: (float)hCurve
{
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, height-hCurve)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, height-hCurve) controlPoint:CGPointMake(SCREEN_WIDTH/2, height+hCurve)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = color.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
}

@end
