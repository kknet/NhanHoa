//
//  ContactTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ContactTbvCell.h"

@implementation ContactTbvCell
@synthesize imgType, lbTitle, btnValue, lbSepa;

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
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(28.0);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgType.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(0);
    }];
    
    btnValue.titleLabel.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [btnValue setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.bottom.equalTo(self);
        make.left.equalTo(lbTitle.mas_right).offset(5.0);
    }];
    
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)updateTitleWithCurrentContent {
    float size = [AppUtils getSizeWithText:lbTitle.text withFont:lbTitle.font andMaxWidth:SCREEN_WIDTH].width + 5.0;
    [lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size);
    }];
}

@end
