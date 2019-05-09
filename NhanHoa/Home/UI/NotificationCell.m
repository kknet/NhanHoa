//
//  NotificationCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NotificationCell.h"

@implementation NotificationCell
@synthesize imgType, lbTitle, lbValue, lbDateTime, imgSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [UIFont fontWithName:RobotoMedium size:15.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgType.mas_top);
        make.left.equalTo(self.imgType.mas_right).offset(10.0);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(20.0);
    }];
    
    lbValue.textColor = TITLE_COLOR;
    lbValue.font = [UIFont fontWithName:RobotoRegular size:13.0];
    lbValue.numberOfLines = 2;
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(30.0);
    }];
    
    lbDateTime.textColor = UIColor.grayColor;
    lbDateTime.font = [UIFont fontWithName:RobotoRegular size:13.0];
    [lbDateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbValue.mas_bottom);
        make.left.right.equalTo(self.lbValue);
        make.height.mas_equalTo(15.0);
    }];
    
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(2.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
