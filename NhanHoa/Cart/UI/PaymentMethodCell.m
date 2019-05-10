//
//  PaymentMethodCell.m
//  NhanHoa
//
//  Created by admin on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentMethodCell.h"

@implementation PaymentMethodCell
@synthesize imgType, lbTitle, imgChoose;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    [imgChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-10.0);
        make.width.height.mas_equalTo(20.0);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbTitle.textColor = TITLE_COLOR;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(padding);
        make.right.equalTo(self.imgChoose.mas_left).offset(-padding);
        make.top.bottom.equalTo(self.imgType);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
