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
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:16.0];
    
    lbType.font = lbProfile.font = textFont;
    lbType.textColor = lbProfile.textColor = TITLE_COLOR;
    
    lbTypeValue.font = lbCompanyValue.font = lbProfileValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbTypeValue.textColor = lbCompanyValue.textColor = lbProfileValue.textColor = TITLE_COLOR;
    
    lbType.text = @"Hồ sơ:";
    sizeType = [AppUtils getSizeWithText:@"Hồ sơ:" withFont:textFont].width + 5;
    
    lbProfile.text = @"Người đại diện:";
    sizeProfile = [AppUtils getSizeWithText:@"Người đại diện:" withFont:textFont].width + 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setupUIForBusiness: (BOOL)business {
    float padding = 15.0;
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [lbSepa mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(5.0);
    }];
    
    [imgProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY).offset(-2.0);
        make.width.height.mas_equalTo(32.0);
    }];
    
    if (business) {
        lbCompanyValue.hidden = FALSE;
        
        [lbCompanyValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgProfile.mas_right).offset(5.0);
            make.right.equalTo(self).offset(-padding);
            make.centerY.equalTo(self.imgProfile.mas_centerY);
            make.height.mas_equalTo(25.0);
        }];
        
        [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbCompanyValue);
            make.bottom.equalTo(self.lbCompanyValue.mas_top);
            make.width.mas_equalTo(self.sizeType);
            make.height.equalTo(self.lbCompanyValue.mas_height);
        }];
        
        [lbTypeValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbType.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(self.lbType);
        }];
        
        [lbProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbCompanyValue);
            make.top.equalTo(self.lbCompanyValue.mas_bottom);
            make.width.mas_equalTo(self.sizeProfile);
            make.height.equalTo(self.lbCompanyValue.mas_height);
        }];
        
        [lbProfileValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbProfile.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(self.lbProfile);
        }];
    }else{
        lbCompanyValue.hidden = TRUE;
        [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgProfile.mas_right).offset(5.0);
            make.bottom.equalTo(self.imgProfile.mas_centerY);
            make.width.mas_equalTo(self.sizeType);
            make.height.mas_equalTo(25.0);
        }];
        
        [lbTypeValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbType.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(self.lbType);
        }];
        
        [lbProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbType);
            make.top.equalTo(self.imgProfile.mas_centerY);
            make.width.mas_equalTo(self.sizeProfile);
            make.height.equalTo(self.lbType.mas_height);
        }];
        
        [lbProfileValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbProfile.mas_right);
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(self.lbProfile);
        }];
    }
}

@end
