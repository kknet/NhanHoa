//
//  BusinessProfileView.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BusinessProfileView.h"

@implementation BusinessProfileView

@synthesize lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbInfoBusiness, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, lbCity, tfCity, btnCity, imgCity, lbInfoRegister, lbRegisterName, tfRegisterName, lbSex, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPosition, tfPosition, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbPerCountry, tfPerCountry, lbPerCity, tfPerCity, imgPerCityArrow, btnPerCity, btnRegister, lbPerAddress, tfPerAddress, btnBOD;
@synthesize delegate, businessCityCode, cityCode, gender, typeCity, contentHeight;
@synthesize transparentView, datePicker, toolBar;

- (void)selectPersonalProfile {
    if ([delegate respondsToSelector:@selector(selectPersonalProfile)]) {
        [delegate selectPersonalProfile];
    }
}

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    float hTitle = 40.0;
    float hBTN = 45.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hLabel = 40.0;
        hTitle = 60.0;
        padding = 30.0;
        hBTN = 55.0;
    }
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKyboard)];
    tapOnScreen.delegate = self;
    self.userInteractionEnabled = TRUE;
    [self addGestureRecognizer: tapOnScreen];
    
    //  title
    lbTitle.font = [AppDelegate sharedInstance].fontBold;
    lbTitle.textColor = [UIColor colorWithRed:(55/255.0) green:(67/255.0) blue:(83/255.0) alpha:1.0];
    lbTitle.text = SFM(@"2. %@", text_update_profile);
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    //  vision
    lbVision.font = [AppDelegate sharedInstance].fontMedium;
    lbVision.text = text_registration_purpose;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = icBusiness.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVision.mas_bottom).offset(5.0);
        make.left.equalTo(lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hLabel);
    }];
    
    lbPersonal.text = text_personal;
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icPersonal);
        make.left.equalTo(icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    UITapGestureRecognizer *tapOnPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectPersonalProfile)];
    lbPersonal.userInteractionEnabled = TRUE;
    [lbPersonal addGestureRecognizer: tapOnPersonal];
    
    [icBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icPersonal);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(icPersonal.mas_width);
    }];
    
    lbBusiness.text = text_business;
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPersonal);
        make.left.equalTo(icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  info for business
    lbInfoBusiness.text = text_business_info;
    [lbInfoBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPersonal.mas_bottom).offset(padding);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  business name
    lbBusinessName.text = text_business_name;
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbInfoBusiness.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbInfoBusiness);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessName borderColor:BORDER_COLOR];
    tfBusinessName.placeholder = enter_business_name;
    [tfBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessName.mas_bottom);
        make.left.right.equalTo(lbBusinessName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessName.returnKeyType = UIReturnKeyNext;
    tfBusinessName.delegate = self;
    
    //  business tax code
    lbTaxCode.text = text_business_tax_code;
    [lbTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessName.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfBusinessName);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfTaxCode borderColor:BORDER_COLOR];
    tfTaxCode.placeholder = enter_business_tax_code;
    [tfTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTaxCode.mas_bottom);
        make.left.right.equalTo(lbTaxCode);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfTaxCode.returnKeyType = UIReturnKeyNext;
    tfTaxCode.delegate = self;
    
    //  business address
    lbBusinessAddress.text = text_business_address;
    [lbBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfTaxCode.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfTaxCode);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessAddress borderColor:BORDER_COLOR];
    tfBusinessAddress.placeholder = enter_business_address;
    [tfBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessAddress.mas_bottom);
        make.left.right.equalTo(lbBusinessAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessAddress.returnKeyType = UIReturnKeyNext;
    tfBusinessAddress.delegate = self;
    
    //  business phone
    lbBusinessPhone.text = text_business_phone;
    [lbBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessAddress.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfBusinessAddress);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessPhone borderColor:BORDER_COLOR];
    tfBusinessPhone.placeholder = enter_business_phone;
    [tfBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessPhone.mas_bottom);
        make.left.right.equalTo(lbBusinessPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessPhone.returnKeyType = UIReturnKeyNext;
    tfBusinessPhone.delegate = self;
    
    //  country and city
    lbCountry.text = text_country;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessPhone.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfCountry.enabled = FALSE;
    tfCountry.text = text_vietnam;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCountry.mas_bottom);
        make.left.right.equalTo(lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  city
    lbCity.text = text_city;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    tfCity.placeholder = text_choose_city;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCity.mas_bottom);
        make.left.right.equalTo(lbCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfCity);
    }];
    
    //  register infor
    lbInfoRegister.text = text_registrar_info;
    [lbInfoRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfCountry.mas_bottom).offset(2*padding);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  business name
    lbRegisterName.text = text_registrant_name;
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbInfoRegister.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbInfoRegister);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRegisterName borderColor:BORDER_COLOR];
    tfRegisterName.placeholder = enter_registrant_name;
    [tfRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRegisterName.mas_bottom);
        make.left.right.equalTo(lbRegisterName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfRegisterName.returnKeyType = UIReturnKeyNext;
    tfRegisterName.delegate = self;
    
    //  birth day and sex
    lbBOD.text = text_birthday;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfRegisterName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBOD.mas_bottom);
        make.left.right.equalTo(lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD setTitle:@"" forState:UIControlStateNormal];
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfBOD);
    }];
    
    lbSex.text = text_gender;
    [lbSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbBOD);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
    }];
    
    gender = type_men;
    icMale.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icPersonal.mas_left);
        make.centerY.equalTo(tfBOD.mas_centerY);
        make.width.equalTo(icPersonal.mas_width);
        make.height.equalTo(icPersonal.mas_height);
    }];
    
    icFemale.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(icMale);
        make.width.equalTo(icMale.mas_width);
    }];
    
    lbMale.text = text_male;
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icMale);
        make.left.equalTo(icMale.mas_right).offset(5.0);
        make.right.equalTo(icFemale.mas_left).offset(-5.0);
    }];
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    lbFemale.text = text_female;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icFemale);
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    //  position
    lbPosition.text = text_postition;
    [lbPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbRegisterName);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPosition borderColor:BORDER_COLOR];
    tfPosition.placeholder = enter_postition;
    [tfPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPosition.mas_bottom);
        make.left.right.equalTo(lbPosition);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPosition.returnKeyType = UIReturnKeyNext;
    tfPosition.delegate = self;
    
    //  Passport
    lbPassport.text = text_passport;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPosition.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfPosition);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    tfPassport.placeholder = enter_passport;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassport.mas_bottom);
        make.left.right.equalTo(lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    
    //  Phone
    lbPhone.text = text_phonenumber;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    tfPhone.placeholder = enter_phone_number;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhone.mas_bottom);
        make.left.right.equalTo(lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    
    //  Email
    lbEmail.text = text_email;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    tfEmail.placeholder = enter_email_address;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom);
        make.left.right.equalTo(lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfEmail.returnKeyType = UIReturnKeyNext;
    tfEmail.delegate = self;
    
    //  personal address
    lbPerAddress.text = text_address;
    [lbPerAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPerAddress borderColor:BORDER_COLOR];
    tfPerAddress.placeholder = enter_address;
    [tfPerAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPerAddress.mas_bottom);
        make.left.right.equalTo(lbPerAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPerAddress.returnKeyType = UIReturnKeyNext;
    tfPerAddress.delegate = self;
    
    lbPerCountry.text = text_country;
    [lbPerCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPerAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPerCountry borderColor:BORDER_COLOR];
    tfPerCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfPerCountry.enabled = FALSE;
    tfPerCountry.text = text_vietnam;
    [tfPerCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPerCountry.mas_bottom);
        make.left.right.equalTo(lbPerCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  city
    lbPerCity.text = text_city;
    [lbPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPerCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfPerCity borderColor:BORDER_COLOR];
    tfPerCity.placeholder = text_choose_city;
    [tfPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPerCity.mas_bottom);
        make.left.right.equalTo(lbPerCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPerCityArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfPerCity.mas_right).offset(-7.5);
        make.centerY.equalTo(tfPerCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnPerCity setTitle:@"" forState:UIControlStateNormal];
    [btnPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfPerCity);
    }];
    
    //  register button
    btnRegister.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnRegister.backgroundColor = BLUE_COLOR;
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnRegister.layer.borderColor = BLUE_COLOR.CGColor;
    btnRegister.layer.borderWidth = 1.0;
    btnRegister.layer.cornerRadius = hBTN/2;
    [btnRegister setTitle:text_sign_up forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(tfPerCity.mas_bottom).offset(padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbTitle.font = lbInfoBusiness.font = lbInfoRegister.font = [AppDelegate sharedInstance].fontBold;
    lbVision.font = lbBusinessName.font = lbTaxCode.font = lbBusinessAddress.font = lbBusinessPhone.font = lbCountry.font = lbCity.font = lbRegisterName.font = lbSex.font = lbBOD.font = lbPosition.font = lbPassport.font = lbPhone.font = lbEmail.font = lbPerAddress.font = lbPerCountry.font = lbPerCity.font = [AppDelegate sharedInstance].fontMedium;
    
    lbPersonal.font = lbBusiness.font = tfBusinessName.font = tfTaxCode.font = tfBusinessAddress.font = tfBusinessPhone.font = tfCountry.font = tfCity.font = tfRegisterName.font = lbFemale.font = lbMale.font = tfBOD.font = tfPosition.font = tfPassport.font = tfPhone.font = tfEmail.font = tfPerAddress.font = tfPerCountry.font = tfPerCity.font = [AppDelegate sharedInstance].fontRegular;
    
    lbInfoBusiness.textColor = lbInfoRegister.textColor = BLUE_COLOR;
    lbTitle.textColor = lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbBusinessName.textColor = tfBusinessName.textColor = lbTaxCode.textColor = tfTaxCode.textColor = lbBusinessAddress.textColor = tfBusinessAddress.textColor = lbBusinessPhone.textColor = tfBusinessPhone.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = lbRegisterName.textColor = tfRegisterName.textColor = lbSex.textColor = lbMale.textColor = lbFemale.textColor = lbBOD.textColor = tfBOD.textColor = lbPosition.textColor = tfPosition.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbEmail.textColor = tfEmail.textColor = lbPerAddress.textColor = tfPerAddress.textColor = lbPerCountry.textColor = tfPerCountry.textColor = lbPerAddress.textColor = tfPerAddress.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    contentHeight = hTitle + 30 + 5.0 + hLabel + padding + hLabel + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + hLabel + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + padding + hBTN + padding;
}

- (IBAction)chooseBusinessCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    typeCity = 2;
    
    float wPopup = 300.0;
    if (!IS_IPHONE && !IS_IPOD) {
        wPopup = 500;
    }
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

- (IBAction)choosePersonalCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    typeCity = 1;
    
    float wPopup = 300.0;
    if (!IS_IPHONE && !IS_IPOD) {
        wPopup = 500;
    }
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_business_name duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_business_tax_code duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddress.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_business_address duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_business_phone duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: businessCityCode]) {
        [[AppDelegate sharedInstance].window makeToast:pls_choose_business_city duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfRegisterName.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_name duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_dob duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPosition.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_postition duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_passport duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_phone duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfEmail.text]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_email duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPerAddress.text] || [AppUtils isNullOrEmpty: cityCode]) {
        [[AppDelegate sharedInstance].window makeToast:pls_enter_registrant_address duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:tfBusinessName.text forKey:@"tc_tc_name"];
    [info setObject:tfTaxCode.text forKey:@"tc_tc_mst"];
    [info setObject:tfBusinessAddress.text forKey:@"tc_tc_address"];
    [info setObject:tfBusinessPhone.text forKey:@"tc_tc_phone"];
    [info setObject:COUNTRY_CODE forKey:@"tc_tc_country"];
    [info setObject:businessCityCode forKey:@"tc_tc_city"];
    
    [info setObject:tfPosition.text forKey:@"cn_position"];
    [info setObject:tfRegisterName.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfBOD.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfPerAddress.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:cityCode forKey:@"cn_city"];
    
    if ([delegate respondsToSelector:@selector(readyToRegisterBusinessAccount:)]) {
        [delegate readyToRegisterBusinessAccount: info];
    }
}

- (IBAction)icPersonalClick:(UIButton *)sender {
    [self selectPersonalProfile];
}

- (IBAction)icMaleClick:(UIButton *)sender {
    gender = type_men;
    
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    gender = type_women;
    
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (void)selectMale {
    gender = type_men;
    
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (void)selectFemale {
    gender = type_women;
    
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (void)closeKyboard {
    [self endEditing: TRUE];
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]] || [touch.view isKindOfClass:NSClassFromString(@"UIButton")])
    {
        return NO;
    }
    return YES;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfBusinessName) {
        [tfTaxCode becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfBusinessAddress becomeFirstResponder];
        
    }else if (textField == tfBusinessAddress) {
        [tfBusinessPhone becomeFirstResponder];
        
    }else if (textField == tfBusinessPhone) {
        [tfRegisterName becomeFirstResponder];
        
    }else if (textField == tfRegisterName) {
        [tfPosition becomeFirstResponder];
        
    }else if (textField == tfPosition) {
        [tfPassport becomeFirstResponder];
        
    }else if (textField == tfPassport) {
        [tfPhone becomeFirstResponder];
        
    }else if (textField == tfPhone) {
        [tfEmail becomeFirstResponder];
        
    }else if (textField == tfEmail) {
        [tfPerAddress becomeFirstResponder];
        
    }else if (textField == tfPerAddress) {
        [self closeKyboard];
    }
    return TRUE;
}

#pragma mark - ChooseCityPopupView Delegate
- (void)choosedCity:(CityObject *)city {
    if (typeCity == 1) {
        cityCode = city.code;
        tfPerCity.text = city.name;
    }else{
        businessCityCode = city.code;
        tfCity.text = city.name;
    }
}

- (IBAction)btnBODPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float hPickerView;
    float hToolbar;
    if (datePicker.frame.size.height > 0) {
        hPickerView = 0;
        hToolbar = 0;
        transparentView.hidden = TRUE;
    }else{
        hPickerView = 200;
        hToolbar = 44.0;
        transparentView.hidden = FALSE;
    }
    
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo([AppDelegate sharedInstance].window);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
    //  set date for picker
    NSDate *bodDate = [AppUtils convertStringToDate: tfBOD.text];
    if (bodDate == nil) {
        bodDate = [NSDate date];
    }
    datePicker.date = bodDate;
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        datePicker.maximumDate = [NSDate date];
    }];
}

- (void)addDatePickerForView {
    transparentView = [[UIView alloc] init];
    transparentView.hidden = TRUE;
    transparentView.backgroundColor = UIColor.blackColor;
    transparentView.alpha = 0.5;
    [[AppDelegate sharedInstance].window addSubview: transparentView];
    [transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColor.whiteColor;
    [datePicker setValue:BLUE_COLOR forKey:@"textColor"];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [[AppDelegate sharedInstance].window addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(transparentView);
        make.height.mas_equalTo(0);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [[AppDelegate sharedInstance].window addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(transparentView);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setTitle:text_close forState:UIControlStateNormal];
    btnClose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnClose setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    btnClose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnClose addTarget:self
                 action:@selector(closePickerView)
       forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview: btnClose];
    [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toolBar).offset(15.0);
        make.bottom.top.equalTo(toolBar);
        make.width.mas_equalTo(100);
    }];
    
    UIButton *btnChoose = [[UIButton alloc] init];
    [btnChoose setTitle:text_select forState:UIControlStateNormal];
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnChoose setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnChoose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnChoose addTarget:self
                  action:@selector(chooseDatePicker)
        forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview: btnChoose];
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toolBar).offset(-15.0);
        make.bottom.top.equalTo(toolBar);
        make.width.mas_equalTo(100);
    }];
}

- (void)closePickerView {
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(0);
    }];
    
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo([AppDelegate sharedInstance].window);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        transparentView.hidden = TRUE;
        [self layoutIfNeeded];
    }];
}

- (void)chooseDatePicker {
    [self closePickerView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    tfBOD.text = [dateFormatter stringFromDate:datePicker.date];
}

@end
