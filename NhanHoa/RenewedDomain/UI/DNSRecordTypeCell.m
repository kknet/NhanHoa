//
//  DNSRecordTypeCell.m
//  NhanHoa
//
//  Created by OS on 8/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSRecordTypeCell.h"

@implementation DNSRecordTypeCell
@synthesize lbName, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    lbName.font = [AppDelegate sharedInstance].fontRegular;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(7.5);
        make.right.equalTo(self).offset(-7.5);
        make.top.bottom.equalTo(self);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:235/255.0 alpha:1.0];
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
