//
//  DomainProfileCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainProfileCell.h"

@implementation DomainProfileCell
@synthesize lbDomain, btnChooseProfile, viewProfileInfo, imgType, lbProfileDesc;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    btnChooseProfile.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnChooseProfile.backgroundColor = BLUE_COLOR;
    [btnChooseProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(38.0);
    }];
    
    lbDomain.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbDomain.textColor = TITLE_COLOR;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.btnChooseProfile.mas_left).offset(-10.0);
        make.top.bottom.equalTo(self.btnChooseProfile);
    }];
    
    //  profile info
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnChooseProfile.mas_bottom);
        make.bottom.equalTo(self).offset(-10.0);
        make.left.equalTo(self).offset(padding);
        make.left.equalTo(self).offset(padding);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.left.equalTo(self.viewProfileInfo);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [lbProfileDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.viewProfileInfo);
        make.left.equalTo(self.imgType.mas_right).offset(10.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
