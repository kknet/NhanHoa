//
//  DNSDetailCell.m
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSDetailCell.h"

@implementation DNSDetailCell
@synthesize icDelete, icEdit, lbSepa5, lbTTL, lbSepa4, lbMX, lbSepa3, lbValue, lbSepa2, lbType, lbSepa1, lbHost, lbSepa6, lbBotSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    float padding = 5.0;
    
    //  float totalWidth = (padding + 140.0 + padding) + 1.0 + (padding + 40.0 + padding) + 1.0 + (padding + 140.0 + padding) + 1.0 + (padding + 100.0 + padding) + 1.0 + (padding + 50.0 + padding) + 1.0 + (padding + 40.0 + padding) + 1.0 + (padding + 40.0 + padding);
    
    lbTTL.font = lbType.font = lbMX.font = lbValue.font = lbHost.font = [UIFont fontWithName:RobotoRegular size:15.0];
    
    [lbHost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(140.0);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(lbHost.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa1.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(40.0);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbType.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa2.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(120.0);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbValue.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa3.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(100.0);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMX.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa4.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(45.0);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTTL.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [icEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(lbSepa5.mas_right).offset(padding);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icEdit.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [icDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icEdit);
        make.left.equalTo(lbSepa6.mas_right).offset(padding);
        make.width.equalTo(icEdit.mas_width);
    }];
    
    [lbBotSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    icEdit.imageEdgeInsets = icDelete.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    lbBotSepa.backgroundColor = lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
