//
//  BusinessProfileView.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BusinessProfileView.h"

@implementation BusinessProfileView

@synthesize lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbInfoBusiness, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, btnCountry, imgCountry, lbCity, tfCity, btnCity, imgCity, lbInfoRegister, lbRegisterName, tfRegisterName, lbSex, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPosition, tfPosition, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbPerCountry, tfPerCountry, imgPerCountryArrow, lbPerCity, tfPerCity, imgPerCityArrow, btnPerCity, lbCode, tfCode, imgCode, btnRegister, lbPerAddress, tfPerAddress;
@synthesize delegate, businessCityCode, cityCode, gender, typeCity;

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKyboard)];
    tapOnScreen.delegate = self;
    self.userInteractionEnabled = TRUE;
    [self addGestureRecognizer: tapOnScreen];
    
    //  title
    lbTitle.font = [AppDelegate sharedInstance].fontBold;
    lbTitle.textColor = [UIColor colorWithRed:(55/255.0) green:(67/255.0) blue:(83/255.0) alpha:1.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    //  vision
    lbVision.font = [AppDelegate sharedInstance].fontMedium;
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
    lbPersonal.font = [AppDelegate sharedInstance].fontRegular;
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
    
    //  info for business
    lbInfoBusiness.font = [AppDelegate sharedInstance].fontBold;
    lbInfoBusiness.textColor = BLUE_COLOR;
    [lbInfoBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPersonal.mas_bottom).offset(padding);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  business name
    lbBusinessName.font = lbVision.font;
    lbBusinessName.textColor = lbVision.textColor;
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbInfoBusiness.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbInfoBusiness);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessName borderColor:BORDER_COLOR];
    tfBusinessName.font = [AppDelegate sharedInstance].fontRegular;
    [tfBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessName.mas_bottom);
        make.left.right.equalTo(self.lbBusinessName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessName.returnKeyType = UIReturnKeyNext;
    tfBusinessName.delegate = self;
    
    //  business tax code
    lbTaxCode.font = lbVision.font;
    lbTaxCode.textColor = lbVision.textColor;
    [lbTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessName.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfBusinessName);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfTaxCode borderColor:BORDER_COLOR];
    tfTaxCode.font = tfBusinessName.font;
    [tfTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTaxCode.mas_bottom);
        make.left.right.equalTo(self.lbTaxCode);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfTaxCode.returnKeyType = UIReturnKeyNext;
    tfTaxCode.delegate = self;
    
    //  business address
    lbBusinessAddress.font = lbVision.font;
    lbBusinessAddress.textColor = lbVision.textColor;
    [lbBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfTaxCode.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfTaxCode);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessAddress borderColor:BORDER_COLOR];
    tfBusinessAddress.font = tfTaxCode.font;
    [tfBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessAddress.mas_bottom);
        make.left.right.equalTo(self.lbBusinessAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessAddress.returnKeyType = UIReturnKeyNext;
    tfBusinessAddress.delegate = self;
    
    //  business phone
    lbBusinessPhone.font = lbVision.font;
    lbBusinessPhone.textColor = lbVision.textColor;
    [lbBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessAddress.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfBusinessAddress);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessPhone borderColor:BORDER_COLOR];
    tfBusinessPhone.font = tfBusinessName.font;
    [tfBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessPhone.mas_bottom);
        make.left.right.equalTo(self.lbBusinessPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  country and city
    lbCountry.font = lbVision.font;
    lbCountry.textColor = lbVision.textColor;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessPhone.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    tfCountry.font = tfBusinessName.font;
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfCountry.enabled = FALSE;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
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
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    tfCity.font = tfBusinessName.font;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCity.mas_bottom);
        make.left.right.equalTo(self.lbCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
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
        make.top.equalTo(self.tfCountry.mas_bottom).offset(2*padding);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  business name
    lbRegisterName.font = lbVision.font;
    lbRegisterName.textColor = lbVision.textColor;
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbInfoRegister.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbInfoRegister);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRegisterName borderColor:BORDER_COLOR];
    tfRegisterName.font = [AppDelegate sharedInstance].fontMedium;
    [tfRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterName.mas_bottom);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfRegisterName.returnKeyType = UIReturnKeyNext;
    tfRegisterName.delegate = self;
    
    //  birth day and sex
    lbBOD.font = lbRegisterName.font;
    lbBOD.textColor = lbRegisterName.textColor;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfRegisterName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    tfBOD.font = tfBusinessName.font;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    lbSex.font = lbRegisterName.font;
    lbSex.textColor = lbRegisterName.textColor;
    [lbSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
    }];
    
    gender = type_men;
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
        make.top.equalTo(self.tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPosition borderColor:BORDER_COLOR];
    tfPosition.font = [AppDelegate sharedInstance].fontRegular;
    [tfPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPosition.mas_bottom);
        make.left.right.equalTo(self.lbPosition);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPosition.returnKeyType = UIReturnKeyNext;
    tfPosition.delegate = self;
    
    //  Passport
    lbPassport.font = lbRegisterName.font;
    lbPassport.textColor = lbRegisterName.textColor;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPosition.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPosition);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    tfPassport.font = [AppDelegate sharedInstance].fontRegular;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    
    //  Phone
    lbPhone.font = lbRegisterName.font;
    lbPhone.textColor = lbRegisterName.textColor;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    tfPhone.font = [AppDelegate sharedInstance].fontRegular;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    
    //  Email
    lbEmail.font = lbRegisterName.font;
    lbEmail.textColor = lbRegisterName.textColor;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    tfEmail.font = [AppDelegate sharedInstance].fontRegular;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfEmail.returnKeyType = UIReturnKeyNext;
    tfEmail.delegate = self;
    
    //  personal address
    lbPerAddress.font = lbEmail.font;
    lbPerAddress.textColor = lbEmail.textColor;
    [lbPerAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPerAddress borderColor:BORDER_COLOR];
    tfPerAddress.font = [AppDelegate sharedInstance].fontRegular;
    [tfPerAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPerAddress.mas_bottom);
        make.left.right.equalTo(self.lbPerAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPerAddress.returnKeyType = UIReturnKeyNext;
    tfPerAddress.delegate = self;
    
    lbPerCountry.font = lbCountry.font;
    lbPerCountry.textColor = lbCountry.textColor;
    [lbPerCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPerAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPerCountry borderColor:BORDER_COLOR];
    tfPerCountry.font = tfBusinessName.font;
    tfPerCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfPerCountry.enabled = FALSE;
    [tfPerCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPerCountry.mas_bottom);
        make.left.right.equalTo(self.lbPerCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPerCountryArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfPerCountry.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfPerCountry.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    //  city
    lbPerCity.font = lbVision.font;
    lbPerCity.textColor = lbVision.textColor;
    [lbPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPerCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfPerCity borderColor:BORDER_COLOR];
    tfPerCity.font = tfBusinessName.font;
    [tfPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPerCity.mas_bottom);
        make.left.right.equalTo(self.lbPerCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPerCityArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfPerCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfPerCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnPerCity setTitle:@"" forState:UIControlStateNormal];
    [btnPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfPerCity);
    }];
    
    //  Secure code
    lbCode.font = lbRegisterName.font;
    lbCode.textColor = lbRegisterName.textColor;
    [lbCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPerCountry.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCode borderColor:BORDER_COLOR];
    tfCode.font = [AppDelegate sharedInstance].fontRegular;
    [tfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCode.mas_bottom);
        make.left.equalTo(self.lbCode);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfCode.returnKeyType = UIReturnKeyDone;
    tfCode.delegate = self;
    
    [imgCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.centerY.equalTo(self.tfCode.mas_centerY);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  register button
    btnRegister.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnRegister.backgroundColor = BLUE_COLOR;
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnRegister.layer.borderColor = BLUE_COLOR.CGColor;
    btnRegister.layer.borderWidth = 1.0;
    btnRegister.layer.cornerRadius = 45.0/2;
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.tfCode.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(45.0);
    }];
}

- (IBAction)chooseBusinessCityPress:(UIButton *)sender {
    typeCity = 2;
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

- (IBAction)choosePersonalCityPress:(UIButton *)sender {
    typeCity = 1;
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Tên doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Mã số thuế" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddress.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Địa chỉ doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Số điện thoại doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: businessCityCode]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa chọn Tỉnh/thành phố cho doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfRegisterName.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Tên người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Ngày sinh người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPosition.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Chức vụ của người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập CMND người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Điện thoại người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfEmail.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Email người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPerAddress.text] || [AppUtils isNullOrEmpty: cityCode]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa cung cấp đầy đủ Địa chỉ người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfCode.text]) {
        [[AppDelegate sharedInstance].window makeToast:@"Bạn chưa nhập Mã bảo mật" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
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
        [tfCode becomeFirstResponder];
        
    }else if (textField == tfCode) {
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

@end
