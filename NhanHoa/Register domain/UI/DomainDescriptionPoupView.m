//
//  DomainDescriptionPoupView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainDescriptionPoupView.h"

@implementation DomainDescriptionPoupView
@synthesize lbContent, icClose;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        float padding = 15.0;
        
        // Initialization code
        self.backgroundColor =  UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 12.0;
        
        icClose = [[UIButton alloc] init];
        icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [icClose setImage:[UIImage imageNamed:@"close_blue"] forState:UIControlStateNormal];
        [icClose addTarget:self
                     action:@selector(fadeOut)
           forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: icClose];
        [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.width.height.mas_equalTo(40.0);
        }];
        
        lbContent = [[UILabel alloc] init];
        lbContent.numberOfLines = 30;
        lbContent.font = [UIFont fontWithName:RobotoRegular size:20.0];
        lbContent.textColor = TITLE_COLOR;
        [self addSubview: lbContent];
        [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(padding);
            make.right.bottom.equalTo(self).offset(-padding);
            make.top.equalTo(self.icClose.mas_bottom);
        }];
    }
    return self;
}


- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    //Add transparent
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBackground.backgroundColor = UIColor.blackColor;
    viewBackground.alpha = 0.5;
    viewBackground.tag = 20;
    [aView addSubview:viewBackground];
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    for (UIView *subView in self.superview.subviews){
        if (subView.tag == 20){
            [subView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }
    }];
}

@end
