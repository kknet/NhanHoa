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
    float hTextfield = 40.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hTextfield = 50.0;
    }
    
    float sizeText = [AppUtils getSizeWithText:lbWWW.text withFont:[AppDelegate sharedInstance].fontMediumDesc].width + 15.0;
    
    tfDomain.font = [AppDelegate sharedInstance].fontRegular;
    tfDomain.textColor = TITLE_COLOR;
    tfDomain.placeholder = [text_enter_domain_name lowercaseString];
    tfDomain.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tfDomain.layer.borderColor = GRAY_200.CGColor;
    tfDomain.layer.borderWidth = 1.0;
    [tfDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    tfDomain.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeText, hTextfield)];
    tfDomain.leftViewMode = UITextFieldViewModeAlways;
    
    tfDomain.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfDomain.rightViewMode = UITextFieldViewModeAlways;
    
    lbWWW.font = [AppDelegate sharedInstance].fontMediumDesc;
    lbWWW.textColor = BLUE_COLOR;
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(tfDomain);
        make.width.mas_equalTo(sizeText);
    }];
    
    icRemove.backgroundColor = [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(202/255.0) alpha:1.0];
    icRemove.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    icRemove.layer.cornerRadius = 6.0;
    [icRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfDomain).offset(3);
        make.bottom.equalTo(tfDomain).offset(-3);
        make.right.equalTo(tfDomain).offset(-3);
        make.width.mas_equalTo(hTextfield-6);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
