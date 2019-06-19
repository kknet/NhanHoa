//
//  AudioSessionUtils.h
//  NhanHoa
//
//  Created by Khai Leo on 6/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@interface AudioSessionUtils : NSObject
@property (nonatomic, strong) AVAudioPlayer *player;
- (void)playNotificationTone;

@end

NS_ASSUME_NONNULL_END
