//
//  AudioSessionUtils.m
//  NhanHoa
//
//  Created by Khai Leo on 6/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AudioSessionUtils.h"


@implementation AudioSessionUtils
@synthesize player;

- (void)playNotificationTone {
    /* Use this code to play an audio file */
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"iphone_text" withExtension:@"mp3"];
    
    NSError *error;
    if (player == nil) {
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:path error:&error];
    }
    player.numberOfLoops = 0; //Infinite
    player.volume = 1.0;
    [player prepareToPlay];
    [player play];
}

@end
