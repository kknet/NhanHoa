//
//  DeviceUtils.m
//  NhanHoa
//
//  Created by Khai Leo on 7/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DeviceUtils.h"
#import <sys/utsname.h>

@implementation DeviceUtils

//  https://www.theiphonewiki.com/wiki/Models
+ (NSString *)getModelsOfCurrentDevice {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *modelType =  [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return modelType;
}

+ (BOOL)isScreen320 {
    NSString *deviceMode = [self getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        return TRUE;
        
    }
    return FALSE;
}

//  check current route used bluetooth
+ (TypeOutputRoute)getCurrentRouteForCall {
    AVAudioSessionRouteDescription *currentRoute = [[AVAudioSession sharedInstance] currentRoute];
    NSArray *outputs = currentRoute.outputs;
    for (AVAudioSessionPortDescription *route in outputs) {
        if (route.portType == AVAudioSessionPortBuiltInReceiver) {
            return eReceiver;
            
        }else if (route.portType == AVAudioSessionPortBuiltInSpeaker || [[route.portType lowercaseString] containsString:@"speaker"]) {
            return eSpeaker;
            
        }else if (route.portType == AVAudioSessionPortBluetoothHFP || route.portType == AVAudioSessionPortBluetoothLE || route.portType == AVAudioSessionPortBluetoothA2DP || [[route.portType lowercaseString] containsString:@"bluetooth"]) {
            return eEarphone;
        }
    }
    return eReceiver;
}

+ (BOOL)enableSpeakerForCall: (BOOL)speaker {
    BOOL success;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;
    
    if (speaker) {
        success = [session setCategory:AVAudioSessionCategoryPlayAndRecord
                           withOptions:AVAudioSessionCategoryOptionMixWithOthers
                                 error:&error];
        if (!success){
            return FALSE;
        }
        
        success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:&error];
        if (!success){
            return FALSE;
        }
        
        success = [session setActive:YES error:&error];
        if (!success){
            return FALSE;
        }
    }else{
        success = [session setCategory:AVAudioSessionCategoryPlayAndRecord
                           withOptions:AVAudioSessionCategoryOptionMixWithOthers
                                 error:&error];
        if (!success){
            return FALSE;
        }
        
        success = [session overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:&error];
        if (!success){
            return FALSE;
        }
        
        success = [session setActive:YES error:&error];
        if (!success){
            return FALSE;
        }
    }
    return success;
}

//  [Khai le - 28/10/2018]
+ (float)getSizeOfKeypadButtonForDevice {
    if (!IS_IPOD && !IS_IPHONE) {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            return 75.0;
        }
        return 85.0;
    }
    
    NSString *deviceMode = [self getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        //  Screen width: 320.000000 - Screen height: 667.000000
        return 62.0;
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        //  Screen width: 375.000000 - Screen height: 667.000000
        return 70.0;
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
    {
        //  Screen width: 414.000000 - Screen height: 736.000000
        return 77.0;
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator]){
        //  Screen width: 375.000000 - Screen height: 812.000000
        return 80.0;
    }else{
        return 62.0;
    }
}

+ (float)getSpaceYBetweenKeypadButtonsForDevice {
    if (!IS_IPOD && !IS_IPHONE) {
        UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight) {
            return 15.0;
        }
        return 40.0;
    }
    
    NSString *deviceMode = [self getModelsOfCurrentDevice];
    
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        return 9.0;
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
    {
        return 17.0;
    }else{
        return 15.0;
    }
}

+ (float)getSpaceXBetweenKeypadButtonsForDevice
{
    if (!IS_IPOD && !IS_IPHONE) {
        return 50.0;
    }
    
    NSString *deviceMode = [self getModelsOfCurrentDevice];
    
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        return 20.0;
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
    {
        return 30.0;
    }else{
        return 28.0;
    }
}

+ (BOOL)isiPhoneXAndNewer {
    NSString *deviceMode = [self getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2])
    {
        return TRUE;
        
    }
    return FALSE;
}


+ (BOOL)isScreen375 {
    NSString *deviceMode = [self getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        return TRUE;
        
    }
    return FALSE;
}

+ (BOOL)isIPAD {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

+ (BOOL)isLandscapeMode {
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
    {
        return TRUE;
    }else{
        return FALSE;
    }
}

+ (float)getWidthOfScreen {
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft)
    {
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            return SCREEN_WIDTH;
        }else{
            return SCREEN_HEIGHT;
        }
    }else{
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            return SCREEN_HEIGHT;
        }else{
            return SCREEN_WIDTH;
        }
    }
}

+ (float)getHeightOfScreen {
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft)
    {
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            return SCREEN_HEIGHT;
        }else{
            return SCREEN_WIDTH;
        }
    }else{
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            return SCREEN_WIDTH;
        }else{
            return SCREEN_HEIGHT;
        }
    }
}

@end
