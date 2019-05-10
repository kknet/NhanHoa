//
//  ProfileDetailCell.m
//  NhanHoa
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailCell.h"

@implementation ProfileDetailCell
@synthesize viewDomain, lbDomain, viewHeader, imgProfile, lbTypeName, lbTypeNameValue, lbProfileName, lbProfileNameValue, lbCompany, lbCompanyValue, btnChoose, viewDetail, lbDomainType, lbDomainTypeValue, lbName, lbNameValue, lbBOD, lbBODValue, lbPassport, lbPassportValue, lbAddress, lbAddressValue, lbPhone, lbPhoneValue, lbEmail, lbEmailValue, iconPassport, lbTitlePassport, imgFrontPassport, imgBehindPassport, lbSepa, lbFront, lbBehind;

@synthesize sizeType, sizeCompany, sizeProfile;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float hBTN = 35.0;
    
    //  header: 10 + 20 + 20 + 10
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(80.0);
    }];
    
    [viewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(80.0);
    }];
    
    lbDomain.textColor = TITLE_COLOR;
    lbDomain.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewDomain).offset(padding);
        make.right.equalTo(self.viewDomain).offset(-padding);
        make.top.bottom.equalTo(self.viewDomain);
    }];
    
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnChoose.layer.cornerRadius = hBTN/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewHeader.mas_centerY);
        make.right.equalTo(self.viewHeader).offset(-padding);
        make.width.mas_equalTo(70.0);
        make.height.mas_equalTo(hBTN);
    }];
    
    [imgProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewHeader.mas_centerY);
        make.left.equalTo(self.viewHeader).offset(padding);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  get size
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:16.0];
    sizeType = [AppUtils getSizeWithText:@"Loại tên miền:" withFont:textFont].width + 10;
    sizeCompany = [AppUtils getSizeWithText:@"Tên công ty:" withFont: lbTypeName.font].width + 10;
    sizeProfile = [AppUtils getSizeWithText:@"Hồ sơ:" withFont: lbTypeName.font].width + 10;
    
    //  set font and color
    lbTypeName.font = lbCompany.font = lbProfileName.font = textFont;
    lbTypeNameValue.font = lbCompanyValue.font = lbProfileNameValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbTypeName.textColor = lbTypeNameValue.textColor = lbCompany.textColor = lbCompanyValue.textColor = lbProfileName.textColor = lbProfileNameValue.textColor = TITLE_COLOR;
    
    //  company
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgProfile.mas_right).offset(5.0);
        make.centerY.equalTo(self.viewHeader.mas_centerY);
        make.width.mas_equalTo(self.sizeCompany);
        make.height.mas_equalTo(20.0);
    }];
    
    [lbCompanyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbCompany.mas_right);
        make.top.bottom.equalTo(self.lbCompany);
        make.right.equalTo(self.btnChoose.mas_left).offset(-5.0);
    }];
    
    //  domain type
    [lbTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbCompany);
        make.bottom.equalTo(self.lbCompany.mas_top);
        make.height.mas_equalTo(20.0);
        make.width.mas_equalTo(self.sizeType);
    }];
    
    [lbTypeNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTypeName.mas_right);
        make.right.equalTo(self.lbCompanyValue.mas_right);
        make.top.bottom.equalTo(self.lbTypeName);
    }];
    
    //  profile name
    [lbProfileName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbCompany);
        make.top.equalTo(self.lbCompany.mas_bottom);
        make.height.mas_equalTo(20.0);
        make.width.mas_equalTo(self.sizeProfile);
    }];
    
    [lbProfileNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbProfileName.mas_right);
        make.right.equalTo(self.lbCompanyValue.mas_right);
        make.top.bottom.equalTo(self.lbProfileName);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.height.mas_equalTo(1.0);
    }];
    
    viewDetail.clipsToBounds = TRUE;
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.lbSepa.mas_top);
        make.top.equalTo(self.viewHeader.mas_bottom);
    }];
    
    float hLabel = 30.0;
    float wSmallItem = [AppUtils getSizeWithText:@"Họ tên đầy đủ:" withFont:[UIFont fontWithName:RobotoRegular size:16.0]].width + 5;
    lbDomainType.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbDomainType.textColor = TITLE_COLOR;
    [lbDomainType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.viewDetail).offset(padding);
        make.height.mas_equalTo(hLabel);
        make.width.mas_equalTo(wSmallItem);
    }];
    
    lbDomainTypeValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbDomainTypeValue.textColor = TITLE_COLOR;
    [lbDomainTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDomainType);
        make.left.equalTo(self.lbDomainType.mas_right);
        make.right.equalTo(self.viewDetail).offset(-padding);
    }];
    
    //  fullname
    lbName.font = lbDomainType.font;
    lbName.textColor = lbDomainType.textColor;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomainType.mas_bottom);
        make.left.right.equalTo(self.lbDomainType);
        make.height.equalTo(self.lbDomainType.mas_height);
    }];
    
    lbNameValue.font = lbDomainTypeValue.font;
    lbNameValue.textColor = lbDomainTypeValue.textColor;
    [lbNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbName);
        make.left.right.equalTo(self.lbDomainTypeValue);
    }];
    
    //  BOD
    lbBOD.font = lbDomainType.font;
    lbBOD.textColor = lbDomainType.textColor;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbName);
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    lbBODValue.font = lbDomainTypeValue.font;
    lbBODValue.textColor = lbDomainTypeValue.textColor;
    [lbBODValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.right.equalTo(self.lbNameValue);
    }];
    
    //  Passport
    lbPassport.font = lbDomainType.font;
    lbPassport.textColor = lbDomainType.textColor;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.equalTo(self.lbBOD.mas_height);
    }];
    
    lbPassportValue.font = lbDomainTypeValue.font;
    lbPassportValue.textColor = lbDomainTypeValue.textColor;
    [lbPassportValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPassport);
        make.left.right.equalTo(self.lbBODValue);
    }];
    
    //  Address
    lbAddress.font = lbDomainType.font;
    lbAddress.textColor = lbDomainType.textColor;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.equalTo(self.lbPassport.mas_height);
    }];
    
    lbAddressValue.font = lbDomainTypeValue.font;
    lbAddressValue.textColor = lbDomainTypeValue.textColor;
    [lbAddressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress);
        make.left.right.equalTo(self.lbPassportValue);
        make.height.mas_equalTo(2*hLabel);
    }];
    
    //  Phone
    lbPhone.font = lbDomainType.font;
    lbPhone.textColor = lbDomainType.textColor;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddressValue.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.equalTo(self.lbAddress.mas_height);
    }];
    
    lbPhoneValue.font = lbDomainTypeValue.font;
    lbPhoneValue.textColor = lbDomainTypeValue.textColor;
    [lbPhoneValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPhone);
        make.left.right.equalTo(self.lbAddressValue);
    }];
    
    //  Email
    lbEmail.font = lbDomainType.font;
    lbEmail.textColor = lbDomainType.textColor;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.equalTo(self.lbPhone.mas_height);
    }];
    
    lbEmailValue.font = lbDomainTypeValue.font;
    lbEmailValue.textColor = lbDomainTypeValue.textColor;
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbEmail);
        make.left.right.equalTo(self.lbPhoneValue);
    }];
    
    //  passport
    [iconPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom).offset((hLabel-20)/2);
        make.left.equalTo(self.lbEmail.mas_left);
        make.width.height.mas_equalTo(20.0);
    }];
    
    lbTitlePassport.font = lbTypeName.font;
    lbTitlePassport.textColor = lbTypeName.textColor;
    [lbTitlePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconPassport.mas_centerY);
        make.left.equalTo(self.iconPassport.mas_right).offset(5.0);
        make.right.equalTo(self.viewDetail).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    float wItem = (SCREEN_WIDTH-3*padding)/2;
    float hItem = wItem * 2/3;
    [imgFrontPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitlePassport.mas_bottom);
        make.left.equalTo(self.viewDetail).offset(padding);
        make.width.mas_equalTo(wItem);
        make.height.mas_equalTo(hItem);
    }];
    
    lbFront.font = lbTypeName.font;
    lbFront.textColor = lbTypeName.textColor;
    [lbFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgFrontPassport);
        make.top.equalTo(self.imgFrontPassport.mas_bottom);
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    [imgBehindPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imgFrontPassport);
        make.left.equalTo(self.imgFrontPassport.mas_right).offset(padding);
        make.right.equalTo(self.viewDetail).offset(-padding);
    }];
    
    lbBehind.font = lbTypeName.font;
    lbBehind.textColor = lbTypeName.textColor;
    [lbBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgBehindPassport);
        make.top.equalTo(self.imgBehindPassport.mas_bottom);
        make.height.equalTo(self.lbName.mas_height);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIForBusinessProfile: (BOOL)business {
    if (business) {
        lbCompany.textColor = lbCompanyValue.textColor = TITLE_COLOR;
        [lbCompany mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgProfile.mas_right).offset(5.0);
            make.centerY.equalTo(self.imgProfile.mas_centerY);
            make.width.mas_equalTo(self.sizeCompany);
            make.height.mas_equalTo(20.0);
        }];
    }else{
        lbCompany.textColor = lbCompanyValue.textColor = TITLE_COLOR;
        [lbCompany mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgProfile.mas_right).offset(5.0);
            make.centerY.equalTo(self.imgProfile.mas_centerY);
            make.width.mas_equalTo(self.sizeCompany);
            make.height.mas_equalTo(0.0);
        }];
    }
}

- (void)showProfileDetailWithDomainView {
    viewHeader.hidden = TRUE;
    viewDomain.hidden = FALSE;
    
    [viewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(40.0);
    }];
    
    [viewDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.lbSepa.mas_top);
        make.top.equalTo(self.viewDomain.mas_bottom);
    }];
}

@end