//
//  PromotionClvCell.m
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PromotionClvCell.h"

@implementation PromotionClvCell
@synthesize lbTitle, lbContent, imgPromotion;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    self.layer.cornerRadius = 10.0;
    self.clipsToBounds = TRUE;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
    }
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbContent.textColor = GRAY_150;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_80;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lbContent.mas_top);
        make.left.right.equalTo(lbContent);
        make.height.mas_equalTo(30.0);
    }];
    
    [imgPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(lbTitle.mas_top);
    }];
}

@end
