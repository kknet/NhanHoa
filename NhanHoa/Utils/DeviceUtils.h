//
//  DeviceUtils.h
//  NhanHoa
//
//  Created by Khai Leo on 7/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceUtils : NSObject

+ (NSString *)getModelsOfCurrentDevice;
+ (BOOL)isScreen320;
+ (TypeOutputRoute)getCurrentRouteForCall;
+ (BOOL)enableSpeakerForCall: (BOOL)speaker;

@end

NS_ASSUME_NONNULL_END
