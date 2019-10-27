//
//  ChooseMoneyTbvCell.m
//  NhanHoa
//
//  Created by Khai Leo on 10/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChooseMoneyTbvCell.h"

@implementation ChooseMoneyTbvCell
@synthesize lbSepa, lbMoney;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    float padding = 15.0;
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
