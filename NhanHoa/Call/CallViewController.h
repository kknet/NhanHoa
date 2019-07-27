//
//  CallViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 7/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarqueeLabel.h"

typedef enum CallDirection{
    OutgoingCall,
    IncomingCall,
}CallDirection;

NS_ASSUME_NONNULL_BEGIN

@interface CallViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;

//  out going view
@property (weak, nonatomic) IBOutlet UIView *viewOutgoing;
@property (weak, nonatomic) IBOutlet UILabel *lbOutName;
@property (weak, nonatomic) IBOutlet UIImageView *imgOutState;
@property (weak, nonatomic) IBOutlet UILabel *lbOutCallState;
@property (weak, nonatomic) IBOutlet UIImageView *imgOutAvatar;
@property (weak, nonatomic) IBOutlet UIButton *icOutSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *icOutEndCall;
@property (weak, nonatomic) IBOutlet UIButton *icOutMute;

- (IBAction)icOutSpeakerClick:(UIButton *)sender;
- (IBAction)icOutMuteClick:(UIButton *)sender;
- (IBAction)icOutEndCallClick:(UIButton *)sender;

//  call view
@property (weak, nonatomic) IBOutlet UIView *viewCall;
@property (weak, nonatomic) IBOutlet UIImageView *bgCall;
@property (weak, nonatomic) IBOutlet MarqueeLabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbSubName;
@property (weak, nonatomic) IBOutlet UILabel *lbDuration;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UIButton *icMute;
@property (weak, nonatomic) IBOutlet UIButton *icSpeaker;
@property (weak, nonatomic) IBOutlet UIButton *icHangup;
@property (weak, nonatomic) IBOutlet UIButton *icHoldCall;
@property (weak, nonatomic) IBOutlet UIButton *icMiniKeypad;

- (IBAction)icMuteClick:(UIButton *)sender;
- (IBAction)icSpeakerClick:(UIButton *)sender;
- (IBAction)icHangupClick:(UIButton *)sender;
- (IBAction)icHoldCallClick:(UIButton *)sender;
- (IBAction)icMiniKeypadClick:(UIButton *)sender;

@property (nonatomic, strong) NSString *remoteName;
@property (nonatomic, assign) CallDirection callDirection;

@end

NS_ASSUME_NONNULL_END
