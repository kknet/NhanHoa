//
//  CallViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 7/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CallViewController.h"
#import "UIMiniKeypad.h"

@interface CallViewController (){
    NSTimer *durationTimer;
    NSString *subname;
}

@end

@implementation CallViewController
@synthesize imgBackground, viewOutgoing, lbOutName, imgOutState, lbOutCallState, imgOutAvatar, icOutMute, icOutEndCall, icOutSpeaker;
@synthesize viewCall, bgCall, lbName, lbDuration, lbSubName, imgAvatar, icMute, icSpeaker, icHangup, icHoldCall, icMiniKeypad;
@synthesize remoteName, callDirection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    //  self.navigationController.navigationBarHidden = [AppDelegate sharedInstance].cartView.hidden = TRUE;
    
    [WriteLogsUtils writeForGoToScreen:@"CallViewController"];
    
    [self registerObserveres];
    
    //  set remote name
    subname = @"";
    if (callDirection == IncomingCall) {
        NSArray *nameInfo = [[AppDelegate sharedInstance] getContactNameOfRemoteForCall];
        if (nameInfo != nil) {
            remoteName = [nameInfo objectAtIndex: 0];
            subname = [nameInfo objectAtIndex: 1];
        }
    }
    if ([AppUtils isNullOrEmpty: remoteName]) {
        remoteName = unknown;
    }
    lbOutName.text = lbName.text = remoteName;
    lbSubName.text = subname;
    
    if (callDirection == OutgoingCall) {
        lbOutCallState.text = @"Vui lòng chờ...";
        
        viewOutgoing.hidden = FALSE;
        viewCall.hidden = TRUE;
        
    }else{
        viewOutgoing.hidden = TRUE;
        viewCall.hidden = FALSE;
        
        //  Hiển thị duration nếu khi vào màn hình call và cuộc gọi đã được kết nối thành công
        if ([[AppDelegate sharedInstance] isCallWasConnected]) {
            [self startToUpdateDurationForCall];
        }
    }
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(audioRouteChangeListenerCallback:)
                                               name:AVAudioSessionRouteChangeNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (IBAction)icOutSpeakerClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    TypeOutputRoute curRoute = [DeviceUtils getCurrentRouteForCall];
    if (curRoute == eReceiver) {
        BOOL result = [DeviceUtils enableSpeakerForCall: TRUE];
        if (!result) {
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
        [icOutSpeaker setImage:[UIImage imageNamed:@"speaker_enable"] forState:UIControlStateNormal];
        [icSpeaker setImage:[UIImage imageNamed:@"speaker_enable"] forState:UIControlStateNormal];
    }else{
        BOOL result = [DeviceUtils enableSpeakerForCall: FALSE];
        if (!result) {
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
        [icOutSpeaker setImage:[UIImage imageNamed:@"speaker_normal"] forState:UIControlStateNormal];
        [icSpeaker setImage:[UIImage imageNamed:@"speaker_normal"] forState:UIControlStateNormal];
    }
}

- (IBAction)icOutMuteClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    return;
    
    BOOL isMuted = [[AppDelegate sharedInstance] checkMicrophoneWasMuted];
    if (isMuted) {
        BOOL result = [[AppDelegate sharedInstance] muteMicrophone: FALSE];
        if (result) {
            [sender setImage:[UIImage imageNamed:@"mute_normal.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Microphone đã được bật" duration:1.0 position:CSToastPositionCenter];
        }else{
            [sender setImage:[UIImage imageNamed:@"mute_enable.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
    }else {
        BOOL result = [[AppDelegate sharedInstance] muteMicrophone: TRUE];
        if (result) {
            [sender setImage:[UIImage imageNamed:@"mute_enable.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Microphone đã được tắt" duration:1.0 position:CSToastPositionCenter];
        }else{
            [sender setImage:[UIImage imageNamed:@"mute_normal.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
    }
}

- (IBAction)icOutEndCallClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[AppDelegate sharedInstance] hideCallView];
    [[AppDelegate sharedInstance] hangupAllCall];
}

- (void)registerObserveres {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onCallStateChanged:)
                                                 name:notifCallStateChanged object:nil];
}

- (void)setupUIForView
{
    float margin = 25.0;
    float marginIcon;
    float wIconEndCall = 80.0;
    float wSmallIcon;
    float marginQuality = 50.0;
    float wAvatar = 120.0;
    
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            //  Screen width: 320.000000 - Screen height: 667.000000
            wAvatar = 110.0;
            wIconEndCall = 65.0;
            wSmallIcon = 50.0;
            marginQuality = 30.0;
            marginIcon = 10.0;
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            //  Screen width: 375.000000 - Screen height: 667.000000
            wAvatar = 120.0;
            wIconEndCall = 70.0;
            wSmallIcon = 55.0;
            marginIcon = 10.0;
            
        }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
        {
            //  Screen width: 414.000000 - Screen height: 736.000000
            wAvatar = 130.0;
            wIconEndCall = 80.0;
            wSmallIcon = 60.0;
            margin = 45.0;
            marginIcon = 12.0;
            
        }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator]){
            //  Screen width: 375.000000 - Screen height: 812.000000
            wAvatar = 150.0;
            wIconEndCall = 75.0;
            wSmallIcon = 58.0;
            margin = 45.0;
            marginIcon = 12.0;
            
        }else{
            wAvatar = 130.0;
            wIconEndCall = 80.0;
            wSmallIcon = 60.0;
            margin = 45.0;
            marginIcon = 10.0;
        }
        
    }else{
        wAvatar = 180.0;
        wIconEndCall = 80.0;
        wSmallIcon = 60.0;
        margin = 45.0;
        marginIcon = 10.0;
    }
    
    [imgBackground mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [viewOutgoing mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [imgOutAvatar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewOutgoing.mas_centerX);
        make.centerY.equalTo(self.viewOutgoing.mas_centerY);
        make.width.height.mas_equalTo(wAvatar);
    }];
    imgOutAvatar.clipsToBounds = YES;
    imgOutAvatar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imgOutAvatar.layer.borderWidth = 1.0;
    imgOutAvatar.layer.cornerRadius = wAvatar/2;
    
    lbOutCallState.font = [UIFont fontWithName:RobotoRegular size:20.0];
    [lbOutCallState mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewOutgoing.mas_centerX);
        make.bottom.equalTo(self.imgOutAvatar.mas_top).offset(-marginQuality);
        make.width.mas_equalTo(300.0);
        make.height.mas_equalTo(30.0);
    }];
    
    [imgOutState mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewOutgoing.mas_centerX);
        make.bottom.equalTo(self.lbOutCallState.mas_top).offset(-5.0);
        make.width.height.mas_equalTo(24.0);
    }];
    
    lbOutName.font = [UIFont fontWithName:RobotoMedium size:28.0];
    [lbOutName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.imgOutState.mas_top).offset(-20.0);
        make.height.mas_equalTo(35.0);
        make.width.mas_equalTo(300.0);
    }];
    
    //  footer icons
    icOutSpeaker.layer.cornerRadius = icOutMute.layer.cornerRadius = wSmallIcon/2;
    icOutSpeaker.backgroundColor = icOutMute.backgroundColor = UIColor.clearColor;
    icOutEndCall.layer.cornerRadius = wIconEndCall/2;
    
    [icOutEndCall mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewOutgoing.mas_centerX);
        make.bottom.equalTo(self.viewOutgoing).offset(-40.0);
        make.width.height.mas_equalTo(wIconEndCall);
    }];
    
    [icOutSpeaker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icOutEndCall.mas_centerY);
        make.left.equalTo(self.icOutEndCall.mas_right).offset(margin);
        make.width.height.mas_equalTo(wSmallIcon);
    }];
    
    icOutMute.enabled = FALSE;
    [icOutMute setImage:[UIImage imageNamed:@"mute_dis.png"] forState:UIControlStateDisabled];
    [icOutMute mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icOutEndCall.mas_centerY);
        make.right.equalTo(self.icOutEndCall.mas_left).offset(-margin);
        make.width.height.mas_equalTo(wSmallIcon);
    }];
    
    //  For call
    [viewCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [bgCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.viewCall);
    }];
    
    imgAvatar.backgroundColor = UIColor.clearColor;
    [imgAvatar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewCall.mas_centerX);
        make.centerY.equalTo(self.viewCall.mas_centerY);
        make.width.height.mas_equalTo(wAvatar);
    }];
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.borderColor = UIColor.whiteColor.CGColor;
    imgAvatar.layer.borderWidth = 2.0;
    imgAvatar.layer.cornerRadius = wAvatar/2;
    
    lbDuration.font = [UIFont fontWithName:RobotoRegular size:40.0];
    lbDuration.textColor = UIColor.whiteColor;
    [lbDuration mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewCall.mas_centerX);
        make.bottom.equalTo(self.imgAvatar.mas_top).offset(-marginQuality);
        make.width.mas_equalTo(200.0);
        make.height.mas_equalTo(50);
    }];
    
    lbSubName.font = [UIFont fontWithName:RobotoMedium size:20.0];
    [lbSubName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewCall).offset(5.0);
        make.right.equalTo(self.viewCall).offset(-5.0);
        make.bottom.equalTo(self.lbDuration.mas_top).offset(-30.0);
        make.height.mas_equalTo(25.0);
    }];
    
    [lbName mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewCall).offset(5.0);
        make.right.equalTo(self.viewCall).offset(-5.0);
        make.bottom.equalTo(self.lbSubName.mas_top);
        make.height.mas_equalTo(40.0);
    }];
    lbName.marqueeType = MLContinuous;
    lbName.scrollDuration = 10.0;
    lbName.animationCurve = UIViewAnimationOptionCurveEaseInOut;
    lbName.fadeLength = 10.0;
    lbName.continuousMarqueeExtraBuffer = 10.0f;
    lbName.font = [UIFont fontWithName:RobotoMedium size:26.0];
    lbName.textColor = UIColor.whiteColor;
    
    [icHangup mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewCall.mas_centerX);
        make.bottom.equalTo(self.viewCall).offset(-40.0);
        make.width.height.mas_equalTo(wIconEndCall);
    }];
    
    [icSpeaker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.icHangup.mas_centerY);
        make.right.equalTo(self.icHangup.mas_left).offset(-marginIcon);
        make.width.height.mas_equalTo(wSmallIcon);
    }];
    
    [icMute mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icSpeaker);
        make.right.equalTo(self.icSpeaker.mas_left).offset(-marginIcon);
        make.width.mas_equalTo(wSmallIcon);
    }];
    
    [icHoldCall mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icSpeaker);
        make.left.equalTo(self.icHangup.mas_right).offset(marginIcon);
        make.width.mas_equalTo(wSmallIcon);
    }];
    
    [icMiniKeypad mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icSpeaker);
        make.left.equalTo(self.icHoldCall.mas_right).offset(marginIcon);
        make.width.mas_equalTo(wSmallIcon);
    }];
}

- (void)onCallStateChanged: (NSNotification *)notif
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDictionary *info = [notif object];
        if ([info isKindOfClass:[NSDictionary class]]) {
            NSString *state = [info objectForKey:@"state"];
            NSString *last_status = [info objectForKey:@"last_status"];
            
            [WriteLogsUtils writeLogContent:SFM(@"[%s] state -------> %@", __FUNCTION__, state)];
            
            if ([state isEqualToString: CALL_INV_STATE_CALLING]) {
                self.lbOutCallState.text = @"Đang gọi...";
                
            }else if ([state isEqualToString: CALL_INV_STATE_EARLY]) {
                self.lbOutCallState.text = @"Đang đổ chuông...";
                
            }else if ([state isEqualToString: CALL_INV_STATE_CONNECTING]) {
                self.lbOutCallState.text = @"Đang kết nối...";
                
            }else if ([state isEqualToString: CALL_INV_STATE_CONFIRMED]) {
                self.lbOutCallState.text = @"Đã kết nối";
                self.viewCall.hidden = FALSE;
                self.viewOutgoing.hidden = TRUE;
                
                //  Update duration for call
                [self startToUpdateDurationForCall];
                
            }else if ([state isEqualToString: CALL_INV_STATE_DISCONNECTED]) {
                NSString *content = @"Kết thúc cuộc gọi";
                if ([last_status isEqualToString:@"503"] || [last_status isEqualToString:@"603"]) {
                    content = @"Người dùng đang bận";
                }
                
                if (viewOutgoing.isHidden) {
                    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter];
                }else{
                    self.lbOutCallState.text = content;
                }
                [self performSelector:@selector(dismissCallView) withObject:nil afterDelay:2.0];
                
                //  clear timer
                [durationTimer invalidate];
                durationTimer = nil;
                [self hideMiniKeypad];
                
                [[AppDelegate sharedInstance] removeAccount];
            }
            
            if ([state isEqualToString: CALL_INV_STATE_CALLING] || [state isEqualToString: CALL_INV_STATE_EARLY]) {
                [[AppDelegate sharedInstance] playRingbackTone];
                
            }else if ([state isEqualToString: CALL_INV_STATE_CONNECTING] || [state isEqualToString: CALL_INV_STATE_CONFIRMED] || [state isEqualToString: CALL_INV_STATE_DISCONNECTED]) {
                [[AppDelegate sharedInstance] stopRingbackTone];
            }
        }
    });
}

- (void)dismissCallView {
    //  [self.navigationController popViewControllerAnimated: TRUE];
    [[AppDelegate sharedInstance] hideCallView];
}

- (IBAction)icMuteClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    BOOL isMuted = [[AppDelegate sharedInstance] checkMicrophoneWasMuted];
    if (isMuted) {
        BOOL result = [[AppDelegate sharedInstance] muteMicrophone: FALSE];
        if (result) {
            [sender setImage:[UIImage imageNamed:@"mute_normal.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Microphone đã được bật" duration:1.0 position:CSToastPositionCenter];
        }else{
            [sender setImage:[UIImage imageNamed:@"mute_enable.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
    }else {
        BOOL result = [[AppDelegate sharedInstance] muteMicrophone: TRUE];
        if (result) {
            [sender setImage:[UIImage imageNamed:@"mute_enable.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Microphone đã được tắt" duration:1.0 position:CSToastPositionCenter];
        }else{
            [sender setImage:[UIImage imageNamed:@"mute_normal.png"] forState:UIControlStateNormal];
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
    }
}

- (IBAction)icSpeakerClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    TypeOutputRoute curRoute = [DeviceUtils getCurrentRouteForCall];
    if (curRoute == eReceiver) {
        BOOL result = [DeviceUtils enableSpeakerForCall: TRUE];
        if (!result) {
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
        [sender setImage:[UIImage imageNamed:@"speaker_enable"] forState:UIControlStateNormal];
        [self.view makeToast:@"Đã bật loa ngoài" duration:1.0 position:CSToastPositionCenter];
    }else{
        BOOL result = [DeviceUtils enableSpeakerForCall: FALSE];
        if (!result) {
            [self.view makeToast:@"Thất bại" duration:1.0 position:CSToastPositionCenter];
        }
        [sender setImage:[UIImage imageNamed:@"speaker_normal"] forState:UIControlStateNormal];
        [self.view makeToast:@"Đã tắt loa ngoài" duration:1.0 position:CSToastPositionCenter];
    }
}

- (IBAction)icHangupClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[AppDelegate sharedInstance] hangupAllCall];
}

- (IBAction)icHoldCallClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    BOOL holing = [[AppDelegate sharedInstance] checkCurrentCallWasHold];
    if (holing) {
        [[AppDelegate sharedInstance] holdCurrentCall: FALSE];
        [icHoldCall setImage:[UIImage imageNamed:@"hold_normal.png"] forState:UIControlStateNormal];
    }else{
        [[AppDelegate sharedInstance] holdCurrentCall: TRUE];
        [icHoldCall setImage:[UIImage imageNamed:@"hold_enable.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)icMiniKeypadClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [self showMiniKeypadOnView: self.view];
}

- (void)startToUpdateDurationForCall {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (durationTimer) {
        [durationTimer invalidate];
        durationTimer = nil;
    }
    
    [self resetDurationValueForCall];
    durationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(resetDurationValueForCall) userInfo:nil repeats:TRUE];
}

- (void)resetDurationValueForCall
{
    long duration = [[AppDelegate sharedInstance] getDurationForCurrentCall];
    NSString *strDuration = [AppUtils durationToString: (int)duration];
    lbDuration.text = strDuration;
}

- (void)showMiniKeypadOnView: (UIView *)aview {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UIMiniKeypad" owner:nil options:nil];
    UIMiniKeypad *viewKeypad;
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[UIMiniKeypad class]]) {
            viewKeypad = (UIMiniKeypad *) currentObject;
            break;
        }
    }
    [viewKeypad.iconBack addTarget:self
                            action:@selector(hideMiniKeypad)
                  forControlEvents:UIControlEventTouchUpInside];
    [aview addSubview:viewKeypad];
    [viewKeypad.iconMiniKeypadEndCall addTarget:self
                                         action:@selector(endCallFromMiniKeypad)
                               forControlEvents:UIControlEventTouchUpInside];
    
    [viewKeypad mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(aview);
    }];
    [viewKeypad setupUIForView];
    
    viewKeypad.tag = 10;
    [self fadeIn:viewKeypad];
}

- (void)endCallFromMiniKeypad {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [self hideMiniKeypad];
    [[AppDelegate sharedInstance] hangupAllCall];
}

//  Hide keypad mini
- (void)hideMiniKeypad{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    for (UIView *subView in self.view.subviews) {
        if (subView.tag == 10) {
            [UIView animateWithDuration:.35 animations:^{
                subView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                subView.alpha = 0.0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [subView removeFromSuperview];
                }
            }];
        }
    }
}

- (void)fadeIn :(UIView*)view{
    view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    view.alpha = 0.0;
    [UIView animateWithDuration:.35 animations:^{
        view.transform = CGAffineTransformMakeScale(1.0, 1.0);
        view.alpha = 1.0;
    }];
}

- (void)audioRouteChangeListenerCallback:(NSNotification *)notif {
    if ([DeviceUtils isIPAD]) {
        return;
    }
    
    // there is at least one bug when you disconnect an audio bluetooth headset
    // since we only get notification of route having changed, we cannot tell if that is due to:
    // -bluetooth headset disconnected or
    // -user wanted to use earpiece
    // the only thing we can assume is that when we lost a device, it must be a bluetooth one (strong hypothesis though)
    if ([[notif.userInfo valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue] ==
        AVAudioSessionRouteChangeReasonOldDeviceUnavailable)
    {
        NSLog(@"_bluetoothAvailable = NO;");
    }
    
    AVAudioSessionRouteDescription *newRoute = [AVAudioSession sharedInstance].currentRoute;
    if (newRoute && (unsigned long)newRoute.outputs.count > 0) {
        NSString *route = newRoute.outputs[0].portType;
        
        NSLog(@"Detect BLE: newRoute = %@", route);
        
        BOOL _speakerEnabled = [route isEqualToString:AVAudioSessionPortBuiltInSpeaker];
        if (notif.userInfo != nil) {
            NSDictionary *info = notif.userInfo;
            id headphonesObj = [info objectForKey:@"AVAudioSessionRouteChangeReasonKey"];
            if (headphonesObj != nil && [headphonesObj isKindOfClass:[NSNumber class]]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"headsetPluginChanged" object:headphonesObj];
            }
        }
        
        //  [Khai Le - 23/03/2019]
        if (([[AppUtils bluetoothRoutes] containsObject:route]) && !_speakerEnabled) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"bluetoothEnabled" object:nil];
        }else if ([[route lowercaseString] containsString:@"speaker"]){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"speakerEnabled" object:nil];
            
            [icSpeaker setImage:[UIImage imageNamed:@"speaker_enable"] forState:UIControlStateNormal];
            [icOutSpeaker setImage:[UIImage imageNamed:@"speaker_enable"] forState:UIControlStateNormal];
            
        }else{
            [icSpeaker setImage:[UIImage imageNamed:@"speaker_normal"] forState:UIControlStateNormal];
            [icOutSpeaker setImage:[UIImage imageNamed:@"speaker_normal"] forState:UIControlStateNormal];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"iPhoneReceiverEnabled" object:nil];
        }
    }
}


@end
