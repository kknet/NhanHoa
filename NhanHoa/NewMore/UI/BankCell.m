//
//  BankCell.m
//  NhanHoa
//
//  Created by Khai Leo on 6/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BankCell.h"

@implementation BankCell
@synthesize lbName, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    lbName.font = [AppDelegate sharedInstance].fontDesc;
    lbName.textColor = TITLE_COLOR;
    
    lbName.numberOfLines = 5;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
        make.top.equalTo(self);
        make.bottom.equalTo(self).offset(1.0);
    }];
    
    lbSepa.backgroundColor = BORDER_COLOR;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
