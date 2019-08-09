//
//  SelectAmountClvCell.m
//  NhanHoa
//
//  Created by OS on 8/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SelectAmountClvCell.h"

@implementation SelectAmountClvCell
@synthesize lbNum, lbSepaRight, lbSepaBottom;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    lbNum.font = [UIFont fontWithName:RobotoMedium size:20.0];
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [lbSepaBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    [lbSepaRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbSepaBottom.backgroundColor = lbSepaRight.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
}

@end
