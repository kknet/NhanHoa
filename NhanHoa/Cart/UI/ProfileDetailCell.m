//
//  ProfileDetailCell.m
//  NhanHoa
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailCell.h"

@implementation ProfileDetailCell
@synthesize imgProfile, lbTypeName, lbProfileName, btnChoose, viewDetail, lbDomainType, lbDomainTypeValue, lbName, lbNameValue, lbBOD, lbBODValue, lbPassport, lbPassportValue, lbAddress, lbAddressValue, lbPhone, lbPhoneValue, lbEmail, lbEmailValue, iconPassport, lbTitlePassport, imgFrontPassport, imgBehindPassport;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float hBTN = 35.0;
    
    //  header: 10 + 20 + 20 + 10
    float mTop = (60.0 - hBTN)/2;
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnChoose.layer.cornerRadius = hBTN/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(mTop);
        make.width.mas_equalTo(70.0);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbTypeName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbTypeName.textColor = TITLE_COLOR;
    [lbTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding+35.0+5.0);
        make.top.equalTo(self).offset(10.0);
        make.right.equalTo(self.btnChoose.mas_left).offset(-5.0);
        make.height.mas_equalTo(20.0);
    }];
    
    lbProfileName.font = lbTypeName.font;
    lbProfileName.textColor = lbTypeName.textColor;
    [lbProfileName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbTypeName);
        make.top.equalTo(self.lbTypeName);
        make.height.equalTo(self.lbTypeName.mas_height);
    }];
    
    [imgProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset()
        make.w
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
