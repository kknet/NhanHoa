//
//  KLCustomSwitch.h
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KLCustomSwitchDelegate <NSObject>
@optional
- (void)switchValueChangedOn;
- (void)switchValueChangedOff;
@end

@interface KLCustomSwitch : UIView

@property (nonatomic, strong) id<KLCustomSwitchDelegate, NSObject> delegate;

- (id)initWithState: (BOOL)state frame: (CGRect)frame;

@property (nonatomic, strong) UILabel *lbSlider;
@property (nonatomic, strong) UILabel *lbThumb;
@property (nonatomic, strong) UIButton *btnOff;
@property (nonatomic, strong) UIButton *btnOn;

@property (nonatomic, assign) float sizeThumb;
@property (nonatomic, assign) BOOL curState;
@property (nonatomic, assign) BOOL enabled;

- (void)setUIForOffState;
- (void)setUIForOnState;

@end

NS_ASSUME_NONNULL_END
