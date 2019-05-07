//
//  SettingMenuCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SettingMenuCell.h"

@implementation SettingMenuCell
@synthesize lbName, lbSepa, imgType, imgArrow;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    imgType.backgroundColor = UIColor.clearColor;
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    [imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbName.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(padding);
        make.right.equalTo(self.imgArrow.mas_left).offset(-5.0);
        make.top.bottom.equalTo(self.imgType);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
