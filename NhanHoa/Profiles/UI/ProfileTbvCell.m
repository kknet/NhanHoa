//
//  ProfileTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileTbvCell.h"

@implementation ProfileTbvCell
@synthesize viewWrap, lbRepresentative, lbRepresentativeValue, lbPhone, lbPhoneNumber, lbProfile, lbProfileValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    float padding = 10.0;
    float hLabel = 25.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    float sizeText = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Representative"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 10;
    
    viewWrap.layer.cornerRadius = 10.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    lbRepresentative.textColor = lbPhone.textColor = lbProfile.textColor = [UIColor colorWithRed:(120/255.0) green:(120/255.0) blue:(120/255.0) alpha:1.0];
    lbRepresentativeValue.textColor = lbPhoneNumber.textColor = lbProfileValue.textColor = GRAY_80;
    
    lbRepresentative.font = lbPhone.font = lbProfile.font = textFont;
    lbRepresentativeValue.font = lbPhoneNumber.font = lbProfileValue.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    
    //  phone number
    lbPhone.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Phone number"]);
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap).offset(padding);
        make.centerY.equalTo(viewWrap.mas_centerY);
        make.height.mas_equalTo(hLabel);
        make.width.mas_equalTo(sizeText);
    }];
    
    [lbPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbPhone.mas_right);
        make.top.bottom.equalTo(lbPhone);
        make.right.equalTo(viewWrap).offset(-padding);
    }];
    
    //  representative
    lbRepresentative.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Representative"]);
    [lbRepresentative mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lbPhone.mas_top);
        make.left.right.equalTo(lbPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbRepresentativeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbPhoneNumber);
        make.top.bottom.equalTo(lbRepresentative);
    }];
    
    //  profile type
    lbProfile.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Profile"]);
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhone.mas_bottom);
        make.left.right.equalTo(lbPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbProfileValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbPhoneNumber);
        make.top.bottom.equalTo(lbProfile);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showProfileContentWithInfo: (NSDictionary *)info
{
    NSString *type = [info objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            lbProfileValue.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Personal"];
            
            NSString *phone = [info objectForKey:@"cus_phone"];
            lbPhoneNumber.text = (![AppUtils isNullOrEmpty: phone])? phone : @"";
        }else{
            NSString *cus_company = [info objectForKey:@"cus_company"];
            if (![AppUtils isNullOrEmpty: cus_company]) {
                lbProfileValue.text = cus_company;
            }else{
                lbProfileValue.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Business"];
            }
        }
        
        //  Show profile name
        NSString *name = [info objectForKey:@"cus_realname"];
        lbRepresentativeValue.text = (![AppUtils isNullOrEmpty: name])? name : @"";
    }
}

@end
