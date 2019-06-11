//
//  BankCell.m
//  NhanHoa
//
//  Created by Khai Leo on 6/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BankCell.h"

@implementation BankCell
@synthesize lbCode, lbName, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    lbName.font = lbCode.font = [AppDelegate sharedInstance].fontDesc;
    lbName.textColor = lbCode.textColor = TITLE_COLOR;
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
    }];
    
    [lbCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbName);
        make.top.equalTo(self.mas_centerY).offset(2.0);
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
