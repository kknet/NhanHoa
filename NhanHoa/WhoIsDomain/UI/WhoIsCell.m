//
//  WhoIsCell.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsCell.h"

@implementation WhoIsCell
@synthesize lbWWW, tfDomain, icRemove;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    tfDomain.font = [AppDelegate sharedInstance].fontRegular;
    tfDomain.textColor = TITLE_COLOR;
    tfDomain.placeholder = @"nhập tên miền";
    tfDomain.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tfDomain.layer.borderColor = [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(202/255.0) alpha:1.0].CGColor;
    tfDomain.layer.borderWidth = 1.0;
    [tfDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    tfDomain.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 40.0)];
    tfDomain.leftViewMode = UITextFieldViewModeAlways;
    
    tfDomain.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
    tfDomain.rightViewMode = UITextFieldViewModeAlways;
    
    lbWWW.font = [UIFont fontWithName:RobotoMedium size:13.0];
    lbWWW.textColor = BLUE_COLOR;
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.tfDomain);
        make.width.mas_equalTo(50.0);
    }];
    
    icRemove.backgroundColor = [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(202/255.0) alpha:1.0];
    icRemove.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    icRemove.layer.cornerRadius = 6.0;
    [icRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfDomain).offset(3);
        make.bottom.equalTo(self.tfDomain).offset(-3);
        make.right.equalTo(self.tfDomain).offset(-3);
        make.width.mas_equalTo(40.0-6);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
