//
//  NewBusinessProfileView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewBusinessProfileView.h"

@implementation NewBusinessProfileView

@synthesize scvContent, lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbInfoBusiness, lbBusinessName, tfBusinessName, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, btnCountry, imgCountry, lbCity, tfCity, btnCity, imgCity, lbInfoRegister, lbRegisterName, tfRegisterName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPosition, tfPosition, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbCode, tfCode, imgCode, btnRegister;

@synthesize padding, hTextfield, hLabel, mTop;

- (void)setupUIForView {
    UIFont *regularFont = [UIFont fontWithName:RobotoRegular size:16.0];
    UIFont *mediumFont = [UIFont fontWithName:RobotoMedium size:16.0];
    
    padding = 15.0;
    hTextfield = 38.0;
    hLabel = 30.0;
    mTop = 10.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    //  title
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(40.0);
    }];
    
    //  vision
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(5.0);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    icBusiness.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(self.icPersonal.mas_width);
    }];
    
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPersonal);
        make.left.equalTo(self.icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self.lbVision.mas_right);
    }];
    
    //  info for business
    [lbInfoBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPersonal.mas_bottom).offset(self.padding);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    //  business name
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbInfoBusiness.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbInfoBusiness);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfBusinessName.layer.borderWidth = 1.0;
    tfBusinessName.layer.borderColor = BORDER_COLOR.CGColor;
    tfBusinessName.layer.cornerRadius = 3.0;
    tfBusinessName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessName.mas_bottom);
        make.left.right.equalTo(self.lbBusinessName);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfBusinessName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBusinessName.leftViewMode = UITextFieldViewModeAlways;
    
    //  business address
    [lbBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessName.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfBusinessName);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfBusinessAddress.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfBusinessAddress.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfBusinessAddress.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    
    [tfBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessAddress.mas_bottom);
        make.left.right.equalTo(self.lbBusinessAddress);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfBusinessAddress.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBusinessAddress.leftViewMode = UITextFieldViewModeAlways;
    
    //  business phone
    [lbBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessAddress.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfBusinessAddress);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfBusinessPhone.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfBusinessPhone.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfBusinessPhone.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    
    tfBusinessPhone.font = tfBusinessName.font;
    [tfBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessPhone.mas_bottom);
        make.left.right.equalTo(self.lbBusinessPhone);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfBusinessPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBusinessPhone.leftViewMode = UITextFieldViewModeAlways;
    
    //  country and city
    lbCountry.font = lbVision.font;
    lbCountry.textColor = lbVision.textColor;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessPhone.mas_bottom).offset(self.mTop);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.mas_centerX).offset(-self.padding/2);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfCountry.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfCountry.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfCountry.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    
    tfCountry.font = tfBusinessName.font;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfCountry.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCountry.leftViewMode = UITextFieldViewModeAlways;
    
    [imgCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCountry.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCountry.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCountry setTitle:@"" forState:UIControlStateNormal];
    [btnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCountry);
    }];
    
    //  city
    lbCity.font = lbVision.font;
    lbCity.textColor = lbVision.textColor;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self).offset(-self.padding);
    }];
    
    tfCity.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfCity.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfCity.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfCity.font = tfBusinessName.font;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCity.mas_bottom);
        make.left.right.equalTo(self.lbCity);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfCity.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCity.leftViewMode = UITextFieldViewModeAlways;
    
    [imgCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    //  register infor
    lbInfoRegister.font = lbInfoBusiness.font;
    lbInfoRegister.textColor = BLUE_COLOR;
    [lbInfoRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfCountry.mas_bottom).offset(2*self.padding);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    //  business name
    lbRegisterName.font = lbVision.font;
    lbRegisterName.textColor = lbVision.textColor;
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbInfoRegister.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbInfoRegister);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfRegisterName.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfRegisterName.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfRegisterName.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfRegisterName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterName.mas_bottom);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfRegisterName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfRegisterName.leftViewMode = UITextFieldViewModeAlways;
    
    //  birth day and sex
    lbBOD.font = lbRegisterName.font;
    lbBOD.textColor = lbRegisterName.textColor;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfRegisterName.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBOD.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfBOD.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfBOD.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfBOD.font = tfBusinessName.font;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfBOD.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBOD.leftViewMode = UITextFieldViewModeAlways;
    
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.mas_centerX).offset(-self.padding/2);
    }];
    
    icMale.imageEdgeInsets = self.icPersonal.imageEdgeInsets;
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icPersonal.mas_left);
        make.centerY.equalTo(self.tfBOD.mas_centerY);
        make.width.equalTo(self.icPersonal.mas_width);
        make.height.equalTo(self.icPersonal.mas_height);
    }];
    
    icFemale.imageEdgeInsets = self.icPersonal.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(self.icMale);
        make.width.equalTo(self.icMale.mas_width);
    }];
    
    lbMale.font = lbPersonal.font;
    lbMale.textColor = lbPersonal.textColor;
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icMale);
        make.left.equalTo(self.icMale.mas_right).offset(5.0);
        make.right.equalTo(self.icFemale.mas_left).offset(-5.0);
    }];
    
    lbFemale.font = lbMale.font;
    lbFemale.textColor = lbMale.textColor;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  position
    lbPosition.font = lbRegisterName.font;
    lbPosition.textColor = lbRegisterName.textColor;
    [lbPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfPosition.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfPosition.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfPosition.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfPosition.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPosition.mas_bottom);
        make.left.right.equalTo(self.lbPosition);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfPosition.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPosition.leftViewMode = UITextFieldViewModeAlways;
    
    //  Passport
    lbPassport.font = lbRegisterName.font;
    lbPassport.textColor = lbRegisterName.textColor;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPosition.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPosition);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfPassport.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfPassport.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfPassport.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfPassport.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfPassport.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassport.leftViewMode = UITextFieldViewModeAlways;
    
    //  Phone
    lbPhone.font = lbRegisterName.font;
    lbPhone.textColor = lbRegisterName.textColor;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfPhone.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfPhone.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfPhone.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfPhone.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPhone.leftViewMode = UITextFieldViewModeAlways;
    
    //  Email
    lbEmail.font = lbRegisterName.font;
    lbEmail.textColor = lbRegisterName.textColor;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfEmail.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfEmail.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfEmail.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfEmail.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfEmail.leftViewMode = UITextFieldViewModeAlways;
    
    //  Secure code
    lbCode.font = lbRegisterName.font;
    lbCode.textColor = lbRegisterName.textColor;
    [lbCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfEmail);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    tfCode.layer.borderWidth = tfBusinessName.layer.borderWidth;
    tfCode.layer.borderColor =  tfBusinessName.layer.borderColor;
    tfCode.layer.cornerRadius = tfBusinessName.layer.cornerRadius;
    tfCode.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCode.mas_bottom);
        make.left.equalTo(self.lbCode);
        make.right.equalTo(self.mas_centerX).offset(-self.padding/2);
        make.height.mas_equalTo(self.hTextfield);
    }];
    tfCode.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCode.leftViewMode = UITextFieldViewModeAlways;
    
    [imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.centerY.equalTo(self.tfCode.mas_centerY);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(self.hTextfield);
    }];
    
    //  register button
    btnRegister.titleLabel.font = [UIFont fontWithName:RobotoMedium size:18.0];
    btnRegister.backgroundColor = BLUE_COLOR;
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnRegister.layer.borderColor = BLUE_COLOR.CGColor;
    btnRegister.layer.borderWidth = 1.0;
    btnRegister.layer.cornerRadius = 40.0/2;
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self).offset(-self.padding);
        make.top.equalTo(self.tfCode.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(40.0);
    }];
}

@end
