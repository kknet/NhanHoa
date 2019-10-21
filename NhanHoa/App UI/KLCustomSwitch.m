//
//  KLCustomSwitch.m
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "KLCustomSwitch.h"

@implementation KLCustomSwitch
@synthesize lbSlider, lbThumb, btnOn, btnOff;
@synthesize sizeThumb, delegate;

- (id)initWithState: (BOOL)state frame: (CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        UIColor *bgOn = [UIColor colorWithRed:(34/255.0) green:(194/255.0) blue:(126/255.0) alpha:1.0];
        UIColor *bgOff = GRAY_200;
        
        sizeThumb = 24.0;
        
        lbSlider = [[UILabel alloc] init];
        lbSlider.clipsToBounds = TRUE;
        lbSlider.backgroundColor = [UIColor colorWithRed:(210/255.0) green:(218/255.0) blue:(231/255.0) alpha:1.0];
        lbSlider.layer.cornerRadius = sizeThumb/4.0;
        [self addSubview: lbSlider];
        [lbSlider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
            make.width.mas_equalTo(1.5*sizeThumb);
            make.height.mas_equalTo(sizeThumb/2.0);
        }];
        
        lbThumb = [[UILabel alloc] init];
        lbThumb.clipsToBounds = TRUE;
        lbThumb.layer.cornerRadius = sizeThumb/2;
        [self addSubview: lbThumb];
        if (state) {
            lbThumb.backgroundColor = bgOn;
            [lbThumb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.left.equalTo(lbSlider.mas_centerX);
                make.width.height.mas_equalTo(sizeThumb);
            }];
        }else{
            lbThumb.backgroundColor = bgOff;
            [lbThumb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.mas_centerY);
                make.right.equalTo(lbSlider.mas_centerX);
                make.width.height.mas_equalTo(sizeThumb);
            }];
        }
        
        btnOff = [UIButton buttonWithType: UIButtonTypeCustom];
        [btnOff addTarget:self
                   action:@selector(onSwitchOff)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btnOff];
        [btnOff mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.right.equalTo(self.mas_centerX);
        }];
        
        btnOn = [UIButton buttonWithType: UIButtonTypeCustom];
        [btnOn addTarget:self
                  action:@selector(onSwitchOn)
        forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btnOn];
        [btnOn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.left.equalTo(self.mas_centerX);
        }];
    }
    return self;
}

- (void)onSwitchOff {
    lbThumb.backgroundColor = GRAY_200;
    [lbThumb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(lbSlider.mas_centerX);
        make.width.height.mas_equalTo(sizeThumb);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    if ([delegate respondsToSelector:@selector(switchValueChangedOff)]) {
        [delegate switchValueChangedOff];
    }
}

- (void)onSwitchOn {
    lbThumb.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(194/255.0) blue:(126/255.0) alpha:1.0];
    [lbThumb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(lbSlider.mas_centerX);
        make.width.height.mas_equalTo(sizeThumb);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    if ([delegate respondsToSelector:@selector(switchValueChangedOn)]) {
        [delegate switchValueChangedOn];
    }
}

- (void)setUIForOffState {
    lbThumb.backgroundColor = GRAY_200;
    [lbThumb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(lbSlider.mas_centerX);
        make.width.height.mas_equalTo(sizeThumb);
    }];
}

- (void)setUIForOnState {
    lbThumb.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(194/255.0) blue:(126/255.0) alpha:1.0];
    [lbThumb mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(lbSlider.mas_centerX);
        make.width.height.mas_equalTo(sizeThumb);
    }];
    
}

@end
