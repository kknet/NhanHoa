//
//  DomainProfileTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainProfileTbvCell.h"

@implementation DomainProfileTbvCell
@synthesize lbDomain, viewInfo, icProfile, lbName, lbPhone, lbCompany, lbSepa, btnChoose;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    float paddingTop = 25.0;
    float paddingY = 15.0;
    float hTitle = 20.0;
    float hLabel = 20.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        
    }
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    lbDomain.textColor = GRAY_50;
    lbDomain.font = textFont;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(paddingTop);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hTitle);
    }];
    
    viewInfo.layer.cornerRadius = 5.0;
    viewInfo.backgroundColor = GRAY_235;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbDomain);
        make.height.mas_equalTo(80.0);
    }];
    
    icProfile.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [icProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo).offset(10.0);
        make.centerY.equalTo(viewInfo.mas_centerY);
        make.width.height.mas_equalTo(50.0);
    }];
    
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    btnChoose.layer.cornerRadius = 5.0;
    [btnChoose setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewInfo).offset(-10.0);
        make.centerY.equalTo(viewInfo.mas_centerY);
        make.height.mas_equalTo(40.0);
    }];
    
    lbPhone.textColor = lbName.textColor = lbCompany.textColor = GRAY_100;
    
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icProfile.mas_right).offset(5.0);
        make.centerY.equalTo(viewInfo.mas_centerY);
        make.right.equalTo(btnChoose.mas_left).offset(-5.0);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbPhone);
        make.bottom.equalTo(lbPhone.mas_top);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbPhone);
        make.top.equalTo(lbPhone.mas_bottom);
        make.height.mas_equalTo(hLabel);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showProfileContentForCell: (BOOL)show {
    if (show) {
        viewInfo.backgroundColor = UIColor.clearColor;
        lbName.hidden = lbPhone.hidden = lbCompany.hidden = FALSE;
        [btnChoose setTitle:@"Sửa" forState:UIControlStateNormal];
        btnChoose.backgroundColor = GRAY_80;
    }else{
        viewInfo.backgroundColor = GRAY_235;
        lbName.hidden = lbPhone.hidden = lbCompany.hidden = TRUE;
        [btnChoose setTitle:@"Chọn hồ sơ" forState:UIControlStateNormal];
        btnChoose.backgroundColor = BLUE_COLOR;
    }
    
    float sizeBTN = [AppUtils getSizeWithText:btnChoose.currentTitle withFont:btnChoose.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
    [btnChoose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeBTN);
    }];
}

- (void)displayContentWithInfo: (NSDictionary *)profile {
    NSString *type = [profile objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            lbCompany.text = @"";
        }else{
            NSString *company = [profile objectForKey:@"cus_company"];
            lbCompany.text = (![AppUtils isNullOrEmpty: company]) ? company : @"";
        }
        
        NSString *name = [profile objectForKey:@"cus_realname"];
        lbName.text = (![AppUtils isNullOrEmpty: name])? name : @"";
        
        NSString *phone = [profile objectForKey:@"cus_phone"];
        lbPhone.text = (![AppUtils isNullOrEmpty: phone])? phone : @"";
        
    }else{
        lbName.text = lbPhone.text = lbCompany.text = @"";
    }
}

@end
