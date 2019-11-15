//
//  PaymentMethodCell.m
//  NhanHoa
//
//  Created by admin on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentMethodCell.h"

@implementation PaymentMethodCell
@synthesize imgType, lbTitle, imgChoose, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float sizeIcon = 50.0;
    float sizeTick = 25.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        sizeTick = 20.0;
        sizeIcon = 40.0;
        lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        sizeTick = 23.0;
        sizeIcon = 45.0;
        lbTitle.font = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        sizeTick = 25.0;
        sizeIcon = 50.0;
        lbTitle.font = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    [imgChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-10.0);
        make.width.height.mas_equalTo(sizeTick);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.numberOfLines = 2;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(padding);
        make.right.equalTo(self.imgChoose.mas_left).offset(-padding);
        make.top.bottom.equalTo(self);
    }];
    
    lbSepa.text = @"";
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
