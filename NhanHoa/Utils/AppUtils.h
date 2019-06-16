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
+ (NSString *)getCurrentDateForLogFolder;
+ (NSString *)getCurrentDateTime;
+ (NSString *)getCurrentDateTimeToString;
+ (NSString *)convertDateToString: (NSDate *)date;
+ (NSDate *)convertStringToDate: (NSString *)dateString;
+ (NSString *)getDateStringFromTimerInterval: (long)timeInterval;
+ (NSString *)getDateTimeStringFromTimerInterval: (long)timeInterval;
+ (BOOL)checkNetworkAvailable;
+ (void)addBoxShadowForView: (UIView *)view withColor: (UIColor *)color;

+ (float)getHeightOfWhoIsDomainViewWithContent: (NSString *)content font:(UIFont *)font heightItem: (float)hItem maxSize: (float)maxSize;
+ (NSString *)generateIDForTransaction;
+ (NSString *)getPaymentResultWithResponseCode: (NSString *)responseCode;
+ (BOOL)checkValidCurrency: (NSString *)money;
+ (NSString *)getModelsOfCurrentDevice;
+ (void)setBorderForTextfield: (UITextField *)textfield borderColor: (UIColor *)borderColor;
+ (NSString *)getMD5StringOfString: (NSString *)string;
+(UIImage *)resizeImage:(UIImage *)image;
+ (UIImage*) rotateImage:(UIImage* )originalImage;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;
+ (UIImage*)cropImageWithSize:(CGSize)targetSize fromImage: (UIImage *)sourceImage;
+ (NSString *)getAppVersionWithBuildVersion: (BOOL)showBuildVersion;
+ (NSString *)stringDateFromInterval: (NSTimeInterval)interval;
+ (NSString *)getBuildDate;
+ (void) createDirectoryAndSubDirectory:(NSString *)directory;
+ (void) createDirectory:(NSString*)directory;
+ (NSString *)getDateTimeStringNotHaveSecondsFromDate: (NSDate *)date;
+ (BOOL)validateEmailWithString:(NSString*)email;
+ (BOOL)saveFileToFolder: (NSData *)fileData withName: (NSString *)fileName;
+ (NSData *)getFileDataFromDirectoryWithFileName: (NSString *)fileName;
+ (NSString *)getErrorContentFromData: (id)data;

+ (NSString *)checkTodayWithDateStr: (NSString *)dateStr;
+ (NSString *)checkYesterdayWithDateStr: (NSString *)dateStr;
+ (NSString *)getYesterdayDateString;

@end
