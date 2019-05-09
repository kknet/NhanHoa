//
//  BonusHistoryCell.m
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BonusHistoryCell.h"

@implementation BonusHistoryCell
@synthesize lbActionName, lbDateTime, lbValue, imgSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    lbValue.font = [UIFont fontWithName:RobotoRegular size:18.0];
    lbValue.textColor = TITLE_COLOR;
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
        make.width.mas_equalTo(100.0);
    }];
    
    lbActionName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbActionName.textColor = TITLE_COLOR;
    [lbActionName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self.lbValue);
        make.right.equalTo(self.lbValue.mas_left).offset(5.0);
    }];
    
    lbDateTime.font = [UIFont fontWithName:RobotoRegular size:14.0];
    lbDateTime.textColor = UIColor.grayColor;
    [lbDateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbActionName);
        make.top.equalTo(self.lbActionName.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbActionName);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
