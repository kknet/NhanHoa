//
//  CustomSwitchButton.m
//  linphone
//
//  Created by lam quang quan on 11/7/18.
//

#import "CustomSwitchButton.h"

@implementation CustomSwitchButton

@synthesize lbBackground, btnEnable, btnDisable, btnThumb, curState, lbState, border, wIcon, bgOn, bgOff, isEnabled, delegate, startPoint, endPoint;

- (id)initWithState: (BOOL)state frame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        curState = state;
        bgOn = [UIColor colorWithRed:(80/255.0) green:(208/255.0) blue:(135/255.0) alpha:1.0];
        
        bgOff = [UIColor colorWithRed:(118/255.0) green:(134/255.0)
                                 blue:(158/255.0) alpha:1.0];
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.frame.size.height/2;
        
        border = 3.0;
        wIcon = frame.size.height - 2*border;
        
        lbBackground = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview: lbBackground];
        
        btnThumb = [UIButton buttonWithType: UIButtonTypeCustom];
        btnThumb.clipsToBounds = YES;
        btnThumb.layer.cornerRadius = wIcon/2;
        btnThumb.backgroundColor = UIColor.whiteColor;
        [self addSubview: btnThumb];
        
        lbState = [[UILabel alloc] init];
        lbState.font = [AppDelegate sharedInstance].fontRegular;
        lbState.textColor = UIColor.whiteColor;
        lbState.textAlignment = NSTextAlignmentCenter;
        lbState.backgroundColor = UIColor.clearColor;
        [self addSubview: lbState];
        
        //  Add target action
        lbState.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapChangeValue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToChangeValue)];
        [lbState addGestureRecognizer: tapChangeValue];
        
        if (state) {
            btnThumb.frame = CGRectMake(frame.size.width-border-wIcon, border, wIcon, wIcon);
            lbState.frame = CGRectMake(0, border, frame.size.width-(2*border+wIcon), frame.size.height-border);
            lbState.text = @"BẬT";
            lbBackground.backgroundColor = bgOn;
        }else{
            btnThumb.frame = CGRectMake(border, border, wIcon, wIcon);
            lbState.frame = CGRectMake(btnThumb.frame.origin.x+btnThumb.frame.size.width, border, frame.size.width-(2*border+wIcon), frame.size.height-border);
            lbState.text = @"TẮT";
            lbBackground.backgroundColor = bgOff;
        }
    }
    return self;
}

//  Chuyển view gồm 2 ảnh thành ảnh
- (UIImage *)imageFromView:(UIView *) view {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [[UIScreen mainScreen] scale]);
    } else {
        UIGraphicsBeginImageContext(view.frame.size);
    }
    [view.layer renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)onButtonEnableClicked: (UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.btnThumb.frame = self.btnEnable.frame;
        [self.lbBackground setBackgroundColor:[UIColor colorWithRed:(146/255.0) green:(147/255.0)
                                                           blue:(151/255.0) alpha:1.0]];
        [self.btnThumb setBackgroundImage:[UIImage imageNamed:@"ic_switch_round_dis.png"]
                             forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
        self.curState = NO;
    }];
}

- (void)onButtonDisableClicked: (UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        self.btnThumb.frame = self.btnDisable.frame;
        [self.lbBackground setBackgroundColor:[UIColor colorWithRed:(95/255.0) green:(182/255.0)
                                                           blue:(113/255.0) alpha:1.0]];
        [self.btnThumb setBackgroundImage:[UIImage imageNamed:@"ic_switch_round.png"]
                             forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
        self.curState = YES;
    }];
}

- (void)setUIForDisableStateWithActionTarget: (BOOL)action
{
    [UIView animateWithDuration:0.2 animations:^{
        self.btnThumb.frame = CGRectMake(self.border, self.border, self.wIcon, self.wIcon);
        self.lbState.frame = CGRectMake(self.btnThumb.frame.origin.x+self.btnThumb.frame.size.width, self.border, self.frame.size.width-(2*self.border+self.wIcon), self.frame.size.height-self.border);
        
        self.lbState.text = @"TẮT";
        self.lbBackground.backgroundColor = self.bgOff;
    } completion:^(BOOL finished) {
        self.curState = NO;
        if (action) {
            [self.delegate switchButtonDisabled];
        }
    }];
}

- (void)setUIForEnableStateWithActionTarget: (BOOL)action
{
    [UIView animateWithDuration:0.2 animations:^{
        self.btnThumb.frame = CGRectMake(self.frame.size.width-self.border-self.wIcon, self.border, self.wIcon, self.wIcon);
        self.lbState.frame = CGRectMake(0, self.border, self.frame.size.width-(2*self.border+self.wIcon), self.frame.size.height-self.border);
        self.lbState.text = @"BẬT";
        self.lbBackground.backgroundColor = self.bgOn;
    }completion:^(BOOL finished) {
        self.curState = YES;
        if (action) {
            [self.delegate switchButtonEnabled];
        }
    }];
}

- (void)tapToChangeValue {
    if (curState) {
        [self setUIForDisableStateWithActionTarget: YES];
    }else{
        [self setUIForEnableStateWithActionTarget: YES];
    }
}

- (void)btnThumbMoved:(UIPanGestureRecognizer *)gesture {
    if ([gesture state] == UIGestureRecognizerStateBegan) {
        startPoint = [gesture locationInView: self];
    }else if ([gesture state] == UIGestureRecognizerStateEnded){
        endPoint = [gesture locationInView: self];
        [self checkToChangeUI];
    }
}

- (void)checkToChangeUI {
    if (!isEnabled) {
        NSLog(@"You can not change value when switch button in disable state");
        return;
    }
    
    if (curState) {
        if (startPoint.x - endPoint.x > 10) {
            [self setUIForDisableStateWithActionTarget: YES];
        }
    }else{
        if (endPoint.x - startPoint.x > 10) {
            [self setUIForEnableStateWithActionTarget: YES];
        }
    }
}

@end
