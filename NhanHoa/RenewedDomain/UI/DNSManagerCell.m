//
//  DNSManagerCell.m
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSManagerCell.h"

@implementation DNSManagerCell

@synthesize lbHost, lbSepa1, lbType, lbSepa2, lbValue, lbSepa3, lbMX, lbSepa4, lbTTL, lbSepa5, icMore;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    lbTTL.font = lbType.font = lbMX.font = lbValue.font = lbHost.font = [UIFont fontWithName:RobotoRegular size:13.0];
    
    [icMore setTitle:@"" forState:UIControlStateNormal];
    icMore.backgroundColor = UIColor.redColor;
    icMore.layer.cornerRadius = 35.0/2;
    [icMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self);
        make.width.height.mas_equalTo(35.0);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icMore.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbTTL.textAlignment = NSTextAlignmentCenter;
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa5.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(40.0);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbTTL.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbMX.textAlignment = NSTextAlignmentCenter;
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa4.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(60.0);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbMX.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbValue.textAlignment = NSTextAlignmentCenter;
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa3.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(120.0);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbValue.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbType.textAlignment = NSTextAlignmentCenter;
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa2.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(30.0);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbType.mas_left);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbHost.textAlignment = NSTextAlignmentCenter;
    [lbHost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa1.mas_left);
        make.left.top.bottom.equalTo(self);
    }];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
