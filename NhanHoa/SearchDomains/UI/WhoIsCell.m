//
//  WhoIsCell.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsCell.h"

@implementation WhoIsCell
@synthesize imgSearch, tfDomain, icRemove;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float hTextfield = 44.0;
    self.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    tfDomain.font = textFont;
    tfDomain.textColor = GRAY_50;
    tfDomain.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter domain name"];
    tfDomain.backgroundColor = UIColor.whiteColor;
    tfDomain.layer.cornerRadius = 12.0;
    [tfDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    tfDomain.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding + 18.0 + 10.0, hTextfield)];
    tfDomain.leftViewMode = UITextFieldViewModeAlways;
    
    tfDomain.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfDomain.rightViewMode = UITextFieldViewModeAlways;
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfDomain).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    icRemove.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [icRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfDomain).offset(-3);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
