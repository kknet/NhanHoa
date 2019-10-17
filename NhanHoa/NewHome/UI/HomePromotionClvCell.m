//
//  HomePromotionClvCell.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomePromotionClvCell.h"

@implementation HomePromotionClvCell
@synthesize lbTitle, imgPromotion, viewContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = TRUE;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:18.0];
    if (IS_IPHONE || IS_IPOD) {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            textFont = [UIFont fontWithName:RobotoMedium size:15.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
            textFont = [UIFont fontWithName:RobotoMedium size:16.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
            textFont = [UIFont fontWithName:RobotoMedium size:17.0];
        }
    }
    
    viewContent.layer.cornerRadius = 10.0;
    viewContent.clipsToBounds = TRUE;
    viewContent.backgroundColor = UIColor.whiteColor;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.left.bottom.right.equalTo(self);
        make.top.left.equalTo(self);
        make.bottom.right.equalTo(self).offset(-5.0);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_80;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent).offset(5.0);
        make.right.equalTo(viewContent).offset(-5.0);
        make.bottom.equalTo(viewContent);
        make.height.mas_equalTo(50.0);
    }];
    
    [imgPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewContent);
        make.bottom.equalTo(lbTitle.mas_top);
    }];
    
    [self addBoxShadowForView:self color:GRAY_80 opacity:0.8 offsetX:1 offsetY:1];
}

- (void)addBoxShadowForView: (UIView *)view color: (UIColor *)color opacity: (float)opacity offsetX: (float)x offsetY:(float)y
{
    view.layer.masksToBounds = FALSE;
    view.layer.shadowOffset = CGSizeMake(x, y);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = opacity;
}

@end
