//
//  CityCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell
@synthesize lbName, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    lbName.font = [UIFont fontWithName:RobotoRegular size:18.0];
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15.0);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-15.0);
    }];
    
    lbSepa.text = @"";
    lbSepa.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
