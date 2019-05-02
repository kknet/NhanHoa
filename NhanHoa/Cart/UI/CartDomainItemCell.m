//
//  CartDomainItemCell.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartDomainItemCell.h"

@implementation CartDomainItemCell

@synthesize lbNum, lbName, lbPrice, lbDescription, lbFirstYear, icRemove, tfYears, imgArrow, btnYears, lbTotalPrice, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    lbFirstYear.font = [UIFont fontWithName:RobotoThin size:14.0];
    [lbFirstYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(-2.0);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(25.0);
    }];
    
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbFirstYear.mas_top);
        make.right.equalTo(self.lbFirstYear);
        make.width.mas_equalTo(25.0);
    }];
    sssss
    lbNum.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self.lbFirstYear.mas_top);
        make.width.mas_equalTo(25.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
