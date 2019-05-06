//
//  ProfileDetailCell.m
//  NhanHoa
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailCell.h"

@implementation ProfileDetailCell
@synthesize imgProfile, lbTypeName, lbTypeNameValue, lbProfileName, lbProfileNameValue, lbCompany, lbCompanyValue, btnChoose, viewDetail, lbDomainType, lbDomainTypeValue, lbName, lbNameValue, lbBOD, lbBODValue, lbPassport, lbPassportValue, lbAddress, lbAddressValue, lbPhone, lbPhoneValue, lbEmail, lbEmailValue, iconPassport, lbTitlePassport, imgFrontPassport, imgBehindPassport, lbSepa, lbFront, lbBehind;

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
    
    [imgProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(10.0);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  type name
    lbTypeName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbTypeName.clipsToBounds = TRUE;
    lbTypeName.textColor = TITLE_COLOR;
    lbTypeName.backgroundColor = UIColor.redColor;
    [lbTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgProfile.mas_right).offset(5.0);
        make.top.equalTo(self.imgProfile);
        make.height.mas_equalTo(20.0);
        //make.width.mas_equalTo(90.0);
    }];
    
    lbTypeNameValue.clipsToBounds = TRUE;
    lbTypeNameValue.backgroundColor = UIColor.greenColor;
    lbTypeNameValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbTypeNameValue.textColor = TITLE_COLOR;
    [lbTypeNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTypeName.mas_right).offset(5.0);
        make.top.bottom.equalTo(self.lbTypeName);
        make.right.equalTo(self).offset(-padding);
        //  make.right.equalTo(self.btnChoose.mas_left).offset(-5.0);
    }];
    
    //  company
    lbCompany.backgroundColor = UIColor.redColor;
    lbCompany.clipsToBounds = TRUE;
    lbCompany.font = lbTypeName.font;
    lbCompany.textColor = lbTypeName.textColor;
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTypeName);
        make.top.equalTo(self.lbTypeName.mas_bottom);
        make.height.equalTo(self.lbTypeName.mas_height);
    }];
    
    lbCompanyValue.clipsToBounds = TRUE;
    lbCompanyValue.font = lbTypeNameValue.font;
    lbCompanyValue.textColor = lbTypeNameValue.textColor;
    [lbCompanyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbCompany.mas_right).offset(5.0);
        make.top.bottom.equalTo(self.lbCompany);
        make.right.equalTo(self.btnChoose.mas_left).offset(-5.0);
    }];
    
    //  profile name
    lbProfileName.font = lbTypeName.font;
    lbProfileName.textColor = lbTypeName.textColor;
    [lbProfileName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbCompany);
        make.top.equalTo(self.lbCompany.mas_bottom);
        make.height.equalTo(self.lbCompany.mas_height);
    }];
    
    lbProfileNameValue.font = lbTypeNameValue.font;
    lbProfileNameValue.textColor = lbTypeNameValue.textColor;
    [lbProfileNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbProfileName.mas_right).offset(5.0);
        make.top.bottom.equalTo(self.lbProfileName);
        make.right.equalTo(self.btnChoose.mas_left).offset(-5.0);
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
        make.top.equalTo(self.lbProfileName.mas_bottom).offset(10.0);
    }];
    
    float hLabel = 30.0;
    float wSmallItem = (SCREEN_WIDTH - 3*padding)/3;
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
        make.left.equalTo(self.lbDomainType.mas_right).offset(padding);
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
        make.height.greaterThanOrEqualTo(self.lbAddress.mas_height);
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
        make.top.bottom.equalTo(self.iconPassport);
        make.left.equalTo(self.iconPassport.mas_right).offset(5.0);
        make.right.equalTo(self.viewDetail).offset(-padding);
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
    float mTop;
    if (business) {
        mTop = 80.0;
        lbCompany.textColor = lbCompanyValue.textColor = TITLE_COLOR;
        [lbCompany mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbTypeName);
            make.top.equalTo(self.lbTypeName.mas_bottom);
            make.height.equalTo(self.lbTypeName.mas_height);
        }];
        
        [lbCompanyValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lbCompany.mas_right).offset(5.0);
            make.top.bottom.equalTo(self.lbCompany);
            make.height.equalTo(self.lbTypeName.mas_height);
        }];
    }else{
        mTop = 60.0;
        lbCompany.textColor = lbCompanyValue.textColor = UIColor.clearColor;
        [lbCompany mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lbTypeName);
            make.top.equalTo(self.lbTypeName.mas_bottom);
            make.height.mas_equalTo(0.1);
        }];
        
        [lbCompanyValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lbCompany.mas_right).offset(5.0);
            make.top.bottom.equalTo(self.lbCompany);
            make.height.mas_equalTo(0);
        }];
    }
    
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.lbSepa.mas_top);
        make.top.equalTo(self).offset(mTop);
    }];
}

@end
