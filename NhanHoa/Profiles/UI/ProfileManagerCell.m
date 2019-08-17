//
//  ProfileManagerCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileManagerCell.h"

@implementation ProfileManagerCell

@synthesize imgProfile, lbType, lbTypeValue, lbCompanyValue, lbProfile, lbProfileValue, lbSepa;
@synthesize sizeType, sizeProfile;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    lbTypeValue.text = lbCompanyValue.text = lbProfileValue.text = @"";
    
    // Configure the view for the selected state
    lbType.font = lbProfile.font = [AppDelegate sharedInstance].fontRegular;
    lbType.textColor = lbProfile.textColor = TITLE_COLOR;
    
    lbTypeValue.font = lbCompanyValue.font = lbProfileValue.font = [AppDelegate sharedInstance].fontMedium;
    lbTypeValue.textColor = lbCompanyValue.textColor = lbProfileValue.textColor = TITLE_COLOR;
    
    if (!IS_IPHONE && !IS_IPOD) {
        lbType.font = lbProfile.font = [AppDelegate sharedInstance].fontNormal;
        lbTypeValue.font = lbCompanyValue.font = lbProfileValue.font = [AppDelegate sharedInstance].fontMediumDesc;
    }
    
    lbType.text = @"Hồ sơ:";
    sizeType = [AppUtils getSizeWithText:@"Hồ sơ:" withFont:lbType.font].width + 5;
    
    lbProfile.text = @"Người đại diện:";
    sizeProfile = [AppUtils getSizeWithText:@"Người đại diện:" withFont:lbProfile.font].width + 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUIForBusiness: (BOOL)business {
    float padding = 15.0;
    float hLabel = 30.0;
    float hIcon = 32.0;
    float marginX = 5.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hLabel = 30.0;
        hIcon = 50.0;
        marginX = 15.0;
    }
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(5.0);
    }];
    
    [imgProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY).offset(-2.0);
        make.width.height.mas_equalTo(hIcon);
    }];
    
    if (business) {
        lbCompanyValue.hidden = FALSE;
        
        [lbCompanyValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgProfile.mas_right).offset(marginX);
            make.right.equalTo(self).offset(-padding);
            make.centerY.equalTo(imgProfile.mas_centerY);
            make.height.mas_equalTo(hLabel);
        }];
        
        [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbCompanyValue);
            make.bottom.equalTo(lbCompanyValue.mas_top);
            make.width.mas_equalTo(sizeType);
            make.height.equalTo(lbCompanyValue.mas_height);
        }];
        
        [lbTypeValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbType.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(lbType);
        }];
        
        [lbProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbCompanyValue);
            make.top.equalTo(lbCompanyValue.mas_bottom);
            make.width.mas_equalTo(sizeProfile);
            make.height.equalTo(lbCompanyValue.mas_height);
        }];
        
        [lbProfileValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbProfile.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(lbProfile);
        }];
    }else{
        lbCompanyValue.hidden = TRUE;
        [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgProfile.mas_right).offset(marginX);
            make.bottom.equalTo(imgProfile.mas_centerY);
            make.width.mas_equalTo(sizeType);
            make.height.mas_equalTo(hLabel);
        }];
        
        [lbTypeValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbType.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(self.lbType);
        }];
        
        [lbProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbType);
            make.top.equalTo(imgProfile.mas_centerY);
            make.width.mas_equalTo(sizeProfile);
            make.height.equalTo(lbType.mas_height);
        }];
        
        [lbProfileValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbProfile.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(lbProfile);
        }];
    }
}

@end
