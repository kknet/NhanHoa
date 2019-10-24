//
//  MoreTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "MoreTbvCell.h"

@implementation MoreTbvCell
@synthesize imgMenu, lbName, lbSepa, imgArrow;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    float padding = 15.0;
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    [imgMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(28.0);
    }];
    
    [imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbName.textColor = GRAY_50;
    lbName.font = textFont;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgMenu.mas_right).offset(padding);
        make.right.equalTo(imgArrow.mas_left).offset(-5.0);
        make.top.bottom.equalTo(self);
    }];
    
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgMenu);
        make.right.equalTo(imgArrow);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
