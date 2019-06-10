//
//  HomeMenuCell.m
//  NhanHoa
//
//  Created by admin on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeMenuCell.h"

@implementation HomeMenuCell
@synthesize imgType, lbName, lbSepaRight, lbSepaBottom;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(5.0);
        make.width.height.mas_equalTo(45.0);
    }];
    
    lbName.numberOfLines = 10;
    lbName.font = [UIFont fontWithName:RobotoRegular size:14.0];
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.imgType.mas_bottom).offset(5.0);
        make.width.mas_equalTo(105.0);
    }];
    
    
    lbSepaRight.backgroundColor = LIGHT_GRAY_COLOR;
    [lbSepaRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-1.0);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbSepaBottom.backgroundColor = lbSepaRight.backgroundColor;
    [lbSepaBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

@end
