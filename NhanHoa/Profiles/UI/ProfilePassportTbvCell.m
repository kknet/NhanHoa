//
//  ProfilePassportTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfilePassportTbvCell.h"

@implementation ProfilePassportTbvCell
@synthesize lbFront, imgFront, lbBackside, imgBackside;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:19.0];
    }
    
    lbFront.textColor = lbBackside.textColor = GRAY_150;
    lbFront.font = lbBackside.font = textFont;
    
    [lbFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(50.0);
    }];
    
    [lbBackside mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbFront);
        make.left.equalTo(lbFront.mas_right).offset(padding);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [imgFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFront.mas_bottom);
        make.left.right.equalTo(lbFront);
        make.bottom.equalTo(self).offset(-padding);
    }];
    
    [imgBackside mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imgFront);
        make.left.right.equalTo(lbBackside);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
