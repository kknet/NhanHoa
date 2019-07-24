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

@end
