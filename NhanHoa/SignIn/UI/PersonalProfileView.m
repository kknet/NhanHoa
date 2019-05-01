//
//  PersonalProfileView.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PersonalProfileView.h"

@implementation PersonalProfileView
@synthesize lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbSex, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbAddress, tfAddress, lbCountry, btnCountry, tfCountry, lbCity, btnCity, tfCity, lbSecureCode, tfSecureCode, imgSecure, btnRegister, imgArrowCity, imgArrowCountry;

- (void)setupUIForView {
    float padding = 15.0;
    float hTextfield = 38.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    
    //  title
    lbTitle.font = [UIFont fontWithName:RobotoBold size:17.0];
    lbTitle.textColor = [UIColor colorWithRed:(55/255.0) green:(67/255.0) blue:(83/255.0) alpha:1.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    //  vision
    lbVision.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbVision.textColor = lbTitle.textColor;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(5.0);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbPersonal.textColor = lbVision.textColor;
    lbPersonal.font = [UIFont fontWithName:RobotoRegular size:16.0];
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
    
    lbBusiness.textColor = lbVision.textColor;
    lbBusiness.font = lbPersonal.font;
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPersonal);
        make.left.equalTo(self.icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  name
    lbName.font = lbVision.font;
    lbName.textColor = lbVision.textColor;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPersonal.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfName.layer.borderWidth = 1.0;
    tfName.layer.borderColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0].CGColor;
    tfName.layer.cornerRadius = 3.0;
    tfName.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo(hTextfield);
    }];
    tfName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfName.leftViewMode = UITextFieldViewModeAlways;
    
    //  sexial and birth of day
    lbBOD.font = lbName.font;
    lbBOD.textColor = lbName.textColor;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBOD.layer.borderWidth = tfName.layer.borderWidth;
    tfBOD.layer.borderColor =  tfName.layer.borderColor;
    tfBOD.layer.cornerRadius = tfName.layer.cornerRadius;
    tfBOD.font = tfName.font;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo(hTextfield);
    }];
    tfBOD.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBOD.leftViewMode = UITextFieldViewModeAlways;
    
    lbSex.font = lbName.font;
    lbSex.textColor = lbName.textColor;
    [lbSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(hLabel);
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
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    lbMale.font = lbPersonal.font;
    lbMale.textColor = lbPersonal.textColor;
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icMale);
        make.left.equalTo(self.icMale.mas_right).offset(5.0);
        make.right.equalTo(self.icFemale.mas_left).offset(-5.0);
    }];
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    lbFemale.font = lbMale.font;
    lbFemale.textColor = lbMale.textColor;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  passport
    lbPassport.font = lbVision.font;
    lbPassport.textColor = lbVision.textColor;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPassport.layer.borderWidth = tfName.layer.borderWidth;
    tfPassport.layer.borderColor =  tfName.layer.borderColor;
    tfPassport.layer.cornerRadius = tfName.layer.cornerRadius;
    tfPassport.font = tfName.font;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo(hTextfield);
    }];
    tfPassport.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassport.leftViewMode = UITextFieldViewModeAlways;
    
    //  phone
    lbPhone.font = lbVision.font;
    lbPhone.textColor = lbVision.textColor;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPhone.layer.borderWidth = tfName.layer.borderWidth;
    tfPhone.layer.borderColor =  tfName.layer.borderColor;
    tfPhone.layer.cornerRadius = tfName.layer.cornerRadius;
    tfPhone.font = tfName.font;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo(hTextfield);
    }];
    tfPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPhone.leftViewMode = UITextFieldViewModeAlways;
    
    //  address
    lbAddress.font = lbVision.font;
    lbAddress.textColor = lbVision.textColor;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfAddress.layer.borderWidth = tfName.layer.borderWidth;
    tfAddress.layer.borderColor =  tfName.layer.borderColor;
    tfAddress.layer.cornerRadius = tfName.layer.cornerRadius;
    tfAddress.font = tfName.font;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo(hTextfield);
    }];
    tfAddress.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAddress.leftViewMode = UITextFieldViewModeAlways;
    
    //  country, district
    lbCountry.font = lbVision.font;
    lbCountry.textColor = lbVision.textColor;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfCountry.layer.borderWidth = tfName.layer.borderWidth;
    tfCountry.layer.borderColor =  tfName.layer.borderColor;
    tfCountry.layer.cornerRadius = tfName.layer.cornerRadius;
    tfCountry.font = tfName.font;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo(hTextfield);
    }];
    tfCountry.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCountry.leftViewMode = UITextFieldViewModeAlways;
    
    [imgArrowCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCountry.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCountry.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    tfCountry.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30.0, hTextfield)];
    tfCountry.rightViewMode = UITextFieldViewModeAlways;
    
    [btnCountry setTitle:@"" forState:UIControlStateNormal];
    [btnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCountry);
    }];
    
    
    lbCity.font = lbVision.font;
    lbCity.textColor = lbVision.textColor;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    tfCity.layer.borderWidth = tfName.layer.borderWidth;
    tfCity.layer.borderColor =  tfName.layer.borderColor;
    tfCity.layer.cornerRadius = tfName.layer.cornerRadius;
    tfCity.font = tfName.font;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfCountry);
        make.left.right.equalTo(self.lbCity);
    }];
    
    
    [imgArrowCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    tfCity.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCity.leftViewMode = UITextFieldViewModeAlways;
    
    tfCity.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30.0, hTextfield)];
    tfCity.rightViewMode = UITextFieldViewModeAlways;
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    //  security code
    lbSecureCode.font = lbVision.font;
    lbSecureCode.textColor = lbVision.textColor;
    [lbSecureCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfCountry.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfSecureCode.font = tfName.font;
    [tfSecureCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSecureCode.mas_bottom);
        make.left.right.equalTo(self.tfCountry);
        make.height.mas_equalTo(hTextfield);
    }];
    tfSecureCode.layer.borderColor = ORANGE_COLOR.CGColor;
    tfSecureCode.layer.borderWidth = 1.0;
    tfSecureCode.layer.cornerRadius = tfName.layer.cornerRadius;
    
    tfSecureCode.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfSecureCode.leftViewMode = UITextFieldViewModeAlways;
    
    [imgSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tfCity);
        make.centerY.equalTo(self.tfSecureCode.mas_centerY);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  register button
    btnRegister.titleLabel.font = [UIFont fontWithName:RobotoMedium size:18.0];
    btnRegister.backgroundColor = BLUE_COLOR;
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnRegister.layer.borderColor = BLUE_COLOR.CGColor;
    btnRegister.layer.borderWidth = 1.0;
    btnRegister.layer.cornerRadius = 40.0/2;
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.tfSecureCode.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(40.0);
    }];
}

- (IBAction)icPersonalClick:(UIButton *)sender {
}

- (IBAction)icBusinessClick:(UIButton *)sender {
}

- (IBAction)icMaleClick:(UIButton *)sender {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (void)selectMale {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (void)selectFemale {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
}
@end
