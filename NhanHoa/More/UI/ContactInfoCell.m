//
//  ContactInfoCell.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ContactInfoCell.h"

@implementation ContactInfoCell
@synthesize lbValue, lbTitle, imgSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float maxSize = [AppUtils getSizeWithText:@"Số điện thoại" withFont:[UIFont fontWithName:RobotoRegular size:17.0]].width;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(maxSize + 5.0);
    }];
    
    lbValue.font = [UIFont fontWithName:RobotoMedium size:17.0];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle.mas_right).offset(5.0);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
