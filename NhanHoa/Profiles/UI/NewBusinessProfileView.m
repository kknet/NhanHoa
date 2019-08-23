//
//  NewBusinessProfileView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewBusinessProfileView.h"
#import "UploadPicture.h"
#import "AccountModel.h"

@implementation NewBusinessProfileView

@synthesize scvContent, lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbInfoBusiness, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, lbCity, tfCity, btnCity, imgCity, lbInfoRegister, lbRegisterName, tfRegisterName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPosition, tfPosition, lbPassport, tfPassport, lbPhone, tfPhone, tfAddress, lbAddress, viewPassport, lbPassportTitle, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, imgPassport, btnCancel, btnSave, btnBOD, btnEdit;

@synthesize padding, hLabel, mTop, delegate, businessCity, gender, datePicker, toolBar, popupChooseCity, linkFrontPassport, linkBehindPassport, mode, wPassport, hPassport, hViewPassport, hContent;

- (void)setupUIForViewForAddProfile: (BOOL)isAddNew update: (BOOL)isUpdate{
    float hBTN = 45.0;
    float hVision = 40.0;
    padding = 15.0;
    hLabel = 30.0;
    mTop = 10.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hLabel = 40.0;
        padding = 30.0;
        hBTN = 55.0;
        hVision = 60.0;
    }
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    lbTitle.font = lbInfoBusiness.font = lbInfoRegister.font = [AppDelegate sharedInstance].fontBold;
    
    lbVision.font = lbBusinessName.font = lbTaxCode.font = lbBusinessAddress.font = lbBusinessPhone.font = lbCountry.font = lbCity.font = lbRegisterName.font = lbGender.font = lbBOD.font = lbPosition.font = lbPassport.font = lbPhone.font = lbAddress.font = lbPassportTitle.font = [AppDelegate sharedInstance].fontMedium;
    
    lbPersonal.font = lbBusiness.font = tfBusinessName.font = tfTaxCode.font = tfBusinessAddress.font = tfBusinessPhone.font = tfCountry.font = tfCity.font = tfRegisterName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPosition.font = tfPassport.font = tfPhone.font = tfAddress.font = lbPassportFront.font = lbPassportBehind.font = [AppDelegate sharedInstance].fontRegular;
    
    lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbGender.textColor = lbBOD.textColor = lbPosition.textColor = lbPassportTitle.textColor = lbPassportFront.textColor = lbPassportBehind.textColor = lbBusinessName.textColor = lbTaxCode.textColor = lbBusinessAddress.textColor = lbBusinessPhone.textColor = lbCountry.textColor = lbCity.textColor = lbRegisterName.textColor = lbPassport.textColor = lbPhone.textColor = lbAddress.textColor = TITLE_COLOR;
    
    lbInfoBusiness.textColor = lbInfoRegister.textColor = BLUE_COLOR;
    
    scvContent.delegate = self;
    scvContent.showsVerticalScrollIndicator = FALSE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    //  title
    float hTitle = 0.0;
    
    float hGender = hLabel;
    if (isUpdate) {
        mode = eEditBusinessProfile;
        
        hTitle = hVision = hGender = 0;
        icPersonal.hidden = lbPersonal.hidden = icBusiness.hidden = lbBusiness.hidden = TRUE;
    }else{
        mode = eAddNewBusinessProfile;
        
        icPersonal.hidden = lbPersonal.hidden = icBusiness.hidden = lbBusiness.hidden = FALSE;
    }
    
    lbTitle.text = SFM(@"2. %@", text_update_profile);
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent);
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    //  vision
    lbVision.text = text_registration_purpose;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hVision);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVision.mas_bottom).offset(mTop);
        make.left.equalTo(lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hGender);
    }];
    [icPersonal addTarget:self
                   action:@selector(whenTapOnPersonal)
         forControlEvents:UIControlEventTouchUpInside];
    
    lbPersonal.text = text_personal;
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icPersonal);
        make.left.equalTo(icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  Add target for lbBusiness
    UITapGestureRecognizer *tapOnPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPersonal)];
    lbPersonal.userInteractionEnabled = TRUE;
    [lbPersonal addGestureRecognizer: tapOnPersonal];
    
    icBusiness.imageEdgeInsets = icPersonal.imageEdgeInsets;
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
    
    //  tax code
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
    
    //  birth day and gender
    lbBOD.text = text_birthday;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfRegisterName.mas_bottom).offset(mTop);
        make.left.equalTo(lbTitle.mas_centerX).offset(padding/2);
        make.right.equalTo(lbTitle);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    tfBOD.enabled = FALSE;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBOD.mas_bottom);
        make.left.right.equalTo(lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD setTitle:@"" forState:UIControlStateNormal];
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfBOD);
    }];
    
    gender = type_men;
    lbGender.text = text_gender;
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbBOD);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
    }];
    
    icMale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbVision).offset(-4.0);
        make.centerY.equalTo(tfBOD.mas_centerY);
        make.width.height.mas_equalTo(hLabel);
    }];
    
    icFemale.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(icMale);
        make.width.equalTo(icMale.mas_width);
    }];
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    lbMale.text = text_male;
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icMale);
        make.left.equalTo(icMale.mas_right).offset(5.0);
        make.right.equalTo(icFemale.mas_left).offset(-5.0);
    }];
    
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    lbFemale.text = text_female;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icFemale);
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
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
    lbPhone.text = registrant_phone_number;
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
    
    //  Address
    lbAddress.text = registrant_address;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    tfAddress.placeholder = enter_registrant_address;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAddress.mas_bottom);
        make.left.right.equalTo(lbAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfAddress.returnKeyType = UIReturnKeyDone;
    tfAddress.delegate = self;
    
    //  view passport
    if (IS_IPHONE || IS_IPOD) {
        wPassport = (SCREEN_WIDTH-3*padding)/2;
        hPassport = wPassport * 2/3;
    }else{
        wPassport = 339.0;
        hPassport = 226.0;
    }
    
    hViewPassport = mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel;
    
    [viewPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvContent);
        make.top.equalTo(tfAddress.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hViewPassport);
    }];
    
    lbPassportTitle.text = text_passport_photos;
    [lbPassportTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport).offset(padding + 20.0 + 10);
        make.top.right.equalTo(viewPassport).offset(mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport).offset(padding);
        make.centerY.equalTo(lbPassportTitle.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    //  front image
    imgPassportFront.layer.cornerRadius = 5.0;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassportTitle.mas_bottom);
        make.left.equalTo(viewPassport).offset((SCREEN_WIDTH/2 - wPassport)/2);
        make.width.mas_equalTo(wPassport);
        make.height.mas_equalTo(hPassport);
    }];
    imgPassportFront.userInteractionEnabled = TRUE;
    UITapGestureRecognizer *tapOnFrontImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnFrontImage)];
    [imgPassportFront addGestureRecognizer: tapOnFrontImg];
    
    lbPassportFront.text = text_front;
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgPassportFront);
        make.top.equalTo(imgPassportFront.mas_bottom);
        make.height.mas_equalTo(hLabel);
    }];
    
    imgPassportBehind.layer.cornerRadius = imgPassportBehind.layer.cornerRadius;
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imgPassportFront);
        make.left.equalTo(viewPassport.mas_centerX).offset((SCREEN_WIDTH/2 - wPassport)/2);
        make.width.equalTo(imgPassportFront.mas_width);
    }];
    imgPassportBehind.userInteractionEnabled = TRUE;
    UITapGestureRecognizer *tapOnBehindImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBehindImage)];
    [imgPassportBehind addGestureRecognizer: tapOnBehindImg];
    
    lbPassportBehind.text = text_backside;
    [lbPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgPassportBehind);
        make.top.equalTo(imgPassportBehind.mas_bottom);
        make.height.mas_equalTo(hLabel);
    }];
    
    btnCancel.layer.cornerRadius = hBTN/2;
    btnCancel.backgroundColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [btnCancel setTitle:text_cancel forState:UIControlStateNormal];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbVision);
        make.right.equalTo(scvContent.mas_centerX).offset(-padding/2);
        make.top.equalTo(viewPassport.mas_bottom).offset(padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitle:text_save_profile forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvContent.mas_centerX).offset(padding/2);
        make.right.equalTo(lbVision);
        make.top.bottom.equalTo(btnCancel);
    }];
    
    btnEdit.hidden = TRUE;
    btnEdit.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnEdit.backgroundColor = BLUE_COLOR;
    btnEdit.layer.borderWidth = 1.0;
    btnEdit.layer.borderColor = BLUE_COLOR.CGColor;
    [btnEdit setTitle:text_update_profile forState:UIControlStateNormal];
    [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnCancel);
        make.right.equalTo(btnSave);
        make.top.bottom.equalTo(btnCancel);
    }];
    
    btnCancel.titleLabel.font = btnSave.titleLabel.font = btnEdit.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    hContent = hTitle + hVision + hGender + (padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (2*padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + hViewPassport + padding + hBTN + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (IBAction)btnSavePress:(UIButton *)sender {
    
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [self makeToast:@"Bạn chưa nhập Tên doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [self makeToast:@"Bạn chưa nhập Mã số thuế!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddress.text]) {
        [self makeToast:@"Bạn chưa nhập Địa chỉ doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [self makeToast:@"Bạn chưa nhập Số điện thoại doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: businessCity]) {
        [self makeToast:@"Bạn chưa nhập Thành phố cho địa chỉ doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [self makeToast:@"Bạn chưa nhập Tên người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [self makeToast:@"Bạn chưa chọn Ngày sinh của người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPosition.text]) {
        [self makeToast:@"Bạn chưa nhập Chức vụ người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:@"Bạn chưa nhập CMND người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Hồ sơ đang được cập nhật.\nVui lòng chờ trong giây lát" Interaction:NO];
    
    if ([AppDelegate sharedInstance].editCMND_a != nil || [AppDelegate sharedInstance].editCMND_b != nil) {
        [self startUploadPassportPictures];
    }else{
        linkFrontPassport = @"";
        linkBehindPassport = @"";
        if (mode == eEditBusinessProfile) {
            [self tryToGetCMND_a];
            [self tryToGetCMND_b];
        }
        
        [self startAddProfileForBusiness];
    }
}

- (IBAction)btnCancelPress:(UIButton *)sender {
}

- (IBAction)btnCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    if (popupChooseCity == nil) {
        float wPopup = 300.0;
        if (!IS_IPHONE && !IS_IPOD) {
            wPopup = 500;
        }
        
        popupChooseCity = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, realHeight-100)];
        popupChooseCity.delegate = self;
    }
    [popupChooseCity showInView:self animated:TRUE];
}

- (IBAction)btnBODPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    float hPickerView;
    float hToolbar;
    if (datePicker.frame.size.height > 0) {
        hPickerView = 0;
        hToolbar = 0;
    }else{
        hPickerView = 200;
        hToolbar = 44.0;
    }
    
    //  set date for picker
    if (![AppUtils isNullOrEmpty: tfBOD.text]) {
        NSDate *bodDate = [AppUtils convertStringToDate: tfBOD.text];
        if (bodDate != nil) {
            datePicker.date = bodDate;
        }else{
            datePicker.date = [NSDate date];
        }
    }else{
        datePicker.date = [NSDate date];
    }
    
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        datePicker.maximumDate = [NSDate date];
    }];
    
}

- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMale];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemale];
}

- (IBAction)btnEditPress:(UIButton *)sender {
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    [self performSelector:@selector(goToEditBusinessProfile) withObject:nil afterDelay:0.01];
}

- (void)goToEditBusinessProfile {
    [btnEdit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnEdit.backgroundColor = BLUE_COLOR;
    if ([delegate respondsToSelector:@selector(onButtonEditPressed)]) {
        [delegate onButtonEditPressed];
    }
}

- (void)selectMale {
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_men;
}

- (void)selectFemale {
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_women;
}

- (void)whenTapOnPersonal {
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    if ([delegate respondsToSelector:@selector(onSelectPersonalProfile)]) {
        [delegate onSelectPersonalProfile];
    }
}

- (void)addDatePickerForView {
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColor.whiteColor;
    [datePicker setValue:BLUE_COLOR forKey:@"textColor"];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [self addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [self addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setTitle:text_close forState:UIControlStateNormal];
    btnClose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
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
    [btnChoose setTitle:text_choose forState:UIControlStateNormal];
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
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
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)chooseDatePicker {
    
    [self closePickerView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    tfBOD.text = [dateFormatter stringFromDate:datePicker.date];
}

- (void)whenTapOnFrontImage {
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    [delegate onBusinessPassportFrontPress];
}

- (void)whenTapOnBehindImage {
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    [delegate onBusinessPassportBehindPress];
}

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)removePassportFrontPhoto {
    [AppDelegate sharedInstance].editCMND_a = nil;
    imgPassportFront.image = FRONT_EMPTY_IMG;
}

- (void)removePassportBehindPhoto {
    [AppDelegate sharedInstance].editCMND_b = nil;
    imgPassportBehind.image = FRONT_EMPTY_IMG;
}

- (void)startUploadPassportPictures {
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [AppDelegate sharedInstance].editCMND_a = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_a];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_a);
        
        NSString *imageName = [NSString stringWithFormat:@"%@_front_%@", [AppUtils getCurrentDateTime], [AccountModel getCusIdOfUser]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                    {
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Can not upload front passport", __FUNCTION__)];
                        linkFrontPassport = @"";
                    }else{
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Finish upload front passport with link: %@", __FUNCTION__, uploadSession.namePicture)];
                        linkFrontPassport = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    
                    [self startUploadPassportBehindPictures];
                });
            }];
        });
    }else{
        linkFrontPassport = @"";
        if (mode == eEditBusinessProfile) {
            [self tryToGetCMND_a];
        }
        [self startUploadPassportBehindPictures];
    }
}

- (void)startUploadPassportBehindPictures {
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [AppDelegate sharedInstance].editCMND_b = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_b];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_b);
        
        NSString *imageName = [NSString stringWithFormat:@"%@_behind_%@", [AppUtils getCurrentDateTime], [AccountModel getCusIdOfUser]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                    {
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Can not upload behind passport", __FUNCTION__)];
                        linkBehindPassport = @"";
                        
                    }else{
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Finish upload behind passport with link: %@", __FUNCTION__, uploadSession.namePicture)];
                        linkBehindPassport = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    [self startAddProfileForBusiness];
                });
            }];
        });
    }else{
        linkBehindPassport = @"";
        if (mode == eEditBusinessProfile) {
            [self tryToGetCMND_b];
        }
        [self startAddProfileForBusiness];
    }
}

- (void)startAddProfileForBusiness {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    
    [info setObject:[NSNumber numberWithInt:type_business] forKey:@"own_type"];
    //  business info
    [info setObject:tfBusinessName.text forKey:@"tc_tc_name"];
    [info setObject:tfTaxCode.text forKey:@"tc_tc_mst"];
    [info setObject:tfBusinessAddress.text forKey:@"tc_tc_address"];
    [info setObject:tfBusinessPhone.text forKey:@"tc_tc_phone"];
    [info setObject:COUNTRY_CODE forKey:@"tc_tc_country"];
    [info setObject:businessCity forKey:@"tc_tc_city"];
    
    //  personal info
    [info setObject:tfPosition.text forKey:@"cn_position"];
    [info setObject:tfRegisterName.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfBOD.text forKey:@"cn_birthday"];
    
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    [info setObject:linkFrontPassport forKey:@"cmnd_a"];
    [info setObject:linkBehindPassport forKey:@"cmnd_b"];
    
    if (mode == eAddNewBusinessProfile) {
        [info setObject:add_contact_mod forKey:@"mod"];
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] addProfileWithContent: info];
        
    }else if (mode == eEditBusinessProfile) {
        [info setObject:edit_contact_mod forKey:@"mod"];
        if ([AppDelegate sharedInstance].profileEdit != nil) {
            NSString *cus_id = [[AppDelegate sharedInstance].profileEdit objectForKey:@"cus_id"];
            [info setObject:cus_id forKey:@"contact_id"];
            
            [WebServiceUtils getInstance].delegate = self;
            [[WebServiceUtils getInstance] editProfileWithContent: info];
            
        }else{
            [WriteLogsUtils writeLogContent:SFM(@"[%s] Contact_id not exitst in profile info", __FUNCTION__)];
        }
    }
}

#pragma mark - ChooseCityPopupView
- (void)choosedCity:(CityObject *)city {
    businessCity = city.code;
    tfCity.text = city.name;
}

#pragma mark - UIScrollview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closePickerView];
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UITableViewCell class]] || [touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")])
    {
        return NO;
    }
    return YES;
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfBusinessName) {
        [tfTaxCode becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfBusinessAddress becomeFirstResponder];
        
    }else if (textField == tfBusinessAddress) {
        [tfBusinessPhone becomeFirstResponder];
        
    }else if (textField == tfBusinessPhone) {
        [tfRegisterName becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfRegisterName becomeFirstResponder];
        
    }else if (textField == tfRegisterName) {
        [tfPosition becomeFirstResponder];
        
    }else if (textField == tfPosition) {
        [tfPassport becomeFirstResponder];
        
    }else if (textField == tfPassport) {
        [tfPhone becomeFirstResponder];
        
    }else if (textField == tfPhone) {
        [tfAddress becomeFirstResponder];
        
    }else if (textField == tfAddress) {
        [self closeKeyboard];
    }
    return TRUE;
}

#pragma mark - Webservice Delegate
-(void)failedToAddProfileWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)addProfileSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    [AppDelegate sharedInstance].editCMND_a = [AppDelegate sharedInstance].editCMND_b = nil;
    [self profileWasCreatedSuccessful];
}

-(void)failedToEditProfileWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)editProfileSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    [self profileWasUpdatedSuccessful];
}

- (void)profileWasCreatedSuccessful {
    [self makeToast:@"Hồ sơ đã được tạo thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)profileWasUpdatedSuccessful {
    [self makeToast:@"Hồ sơ đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(gotoListProfiles) withObject:nil afterDelay:2.0];
}

- (void)gotoListProfiles {
    [AppDelegate sharedInstance].needReloadListProfile = TRUE;
    if ([delegate respondsToSelector:@selector(businessProfileWasUpdated)]) {
        [delegate businessProfileWasUpdated];
    }
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(businessProfileWasCreated)]) {
        [delegate businessProfileWasCreated];
    }
}

- (void)displayInfoForProfileWithInfo: (NSDictionary *)info {
    NSString *cus_company = [info objectForKey:@"cus_company"];
    if (![AppUtils isNullOrEmpty: cus_company]) {
        tfBusinessName.text = cus_company;
    }else{
        tfBusinessName.text = @"";
    }
    
    NSString *cus_taxcode = [info objectForKey:@"cus_taxcode"];
    if (![AppUtils isNullOrEmpty: cus_taxcode]) {
        tfTaxCode.text = cus_taxcode;
    }else{
        tfTaxCode.text = @"";
    }
    
    NSString *cus_company_address = [info objectForKey:@"cus_company_address"];
    if (![AppUtils isNullOrEmpty: cus_company_address]) {
        tfBusinessAddress.text = cus_company_address;
    }else{
        tfBusinessAddress.text = @"";
    }
    
    NSString *cus_company_phone = [info objectForKey:@"cus_company_phone"];
    if (![AppUtils isNullOrEmpty: cus_company_phone]) {
        tfBusinessPhone.text = cus_company_phone;
    }else{
        tfBusinessPhone.text = @"";
    }
    
    NSString *cus_realname = [info objectForKey:@"cus_realname"];
    if (![AppUtils isNullOrEmpty: cus_realname]) {
        tfRegisterName.text = cus_realname;
    }else{
        tfRegisterName.text = @"";
    }
    
    NSString *cus_birthday = [info objectForKey:@"cus_birthday"];
    if (![AppUtils isNullOrEmpty: cus_birthday]) {
        tfBOD.text = cus_birthday;
    }else{
        tfBOD.text = @"";
    }
    
    NSString *gender = [info objectForKey:@"cus_gender"];
    if ([gender isEqualToString:@"1"]) {
        [self selectMale];
    }else{
        [self selectFemale];
    }
    
    NSString *cus_position = [info objectForKey:@"cus_position"];
    if (![AppUtils isNullOrEmpty: cus_position]) {
        tfPosition.text = cus_position;
    }else{
        tfPosition.text = @"";
    }
    
    NSString *cus_idcard_number = [info objectForKey:@"cus_idcard_number"];
    if (![AppUtils isNullOrEmpty: cus_idcard_number]) {
        tfPassport.text = cus_idcard_number;
    }else{
        tfPassport.text = @"";
    }
    
    NSString *cus_phone = [info objectForKey:@"cus_phone"];
    if (![AppUtils isNullOrEmpty: cus_phone]) {
        tfPhone.text = cus_phone;
    }else{
        tfPhone.text = @"";
    }
    
    NSString *cus_address = [info objectForKey:@"cus_address"];
    if (![AppUtils isNullOrEmpty: cus_address]) {
        tfAddress.text = cus_address;
    }else{
        tfAddress.text = @"";
    }
    
    NSString *cus_city = [info objectForKey:@"cus_city"];
    if (![AppUtils isNullOrEmpty: cus_city]) {
        businessCity = cus_city;
        tfCity.text = [[AppDelegate sharedInstance] findCityObjectWithCityCode: cus_city];
    }else{
        businessCity = @"";
        tfCity.text = @"";
    }
    
    //  cmnd mat truoc
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        imgPassportFront.image = [AppDelegate sharedInstance].editCMND_a;
    }else{
        NSString *cmnd_a = [info objectForKey:@"cmnd_a"];
        if (![AppUtils isNullOrEmpty: cmnd_a]) {
            [imgPassportFront sd_setImageWithURL:[NSURL URLWithString:cmnd_a] placeholderImage:FRONT_EMPTY_IMG];
            linkFrontPassport = cmnd_a;
        }else{
            imgPassportFront.image = FRONT_EMPTY_IMG;
            linkFrontPassport = @"";
        }
    }
    
    //  cmnd mat sau
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        imgPassportBehind.image = [AppDelegate sharedInstance].editCMND_b;
    }else{
        NSString *cmnd_b = [info objectForKey:@"cmnd_b"];
        if (![AppUtils isNullOrEmpty: cmnd_b]) {
            [imgPassportBehind sd_setImageWithURL:[NSURL URLWithString:cmnd_b] placeholderImage:BEHIND_EMPTY_IMG];
            linkBehindPassport = cmnd_b;
        }else{
            imgPassportBehind.image = BEHIND_EMPTY_IMG;
            linkBehindPassport = @"";
        }
    }
}

- (void)setupUIForOnlyView {
    btnEdit.hidden = FALSE;
    mode = eViewBusinessProfile;
    UIColor *disableColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    tfBusinessName.backgroundColor = tfTaxCode.backgroundColor = tfBusinessAddress.backgroundColor = tfBusinessPhone.backgroundColor = tfCountry.backgroundColor = tfCity.backgroundColor = tfRegisterName.backgroundColor = tfBOD.backgroundColor = tfPosition.backgroundColor = tfPassport.backgroundColor = tfPhone.backgroundColor = tfAddress.backgroundColor = disableColor;
    
    tfBusinessName.enabled = tfTaxCode.enabled = tfBusinessAddress.enabled = tfBusinessPhone.enabled = tfCountry.enabled = tfCity.enabled = tfRegisterName.enabled = tfBOD.enabled = tfPosition.enabled = tfPassport.enabled = tfPhone.enabled = tfAddress.enabled = FALSE;
    
    imgCity.hidden = btnCancel.hidden = btnSave.hidden = TRUE;
    
    
}

- (void)saveAllValueBeforeChangeView {
    //  business info
    
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessName.text forKey:@"cus_company"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfTaxCode.text forKey:@"cus_taxcode"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessAddress.text forKey:@"cus_company_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessPhone.text forKey:@"cus_company_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfRegisterName.text forKey:@"cus_realname"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBOD.text forKey:@"cus_birthday"];
    [[AppDelegate sharedInstance].profileEdit setObject:[NSString stringWithFormat:@"%d", gender] forKey:@"cus_gender"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPosition.text forKey:@"cus_position"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPassport.text forKey:@"cus_idcard_number"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPhone.text forKey:@"cus_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfAddress.text forKey:@"cus_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:businessCity forKey:@"cus_city"];
}

- (void)tryToGetCMND_a {
    if ([AppDelegate sharedInstance].profileEdit != nil) {
        NSString *cmnd_a = [[AppDelegate sharedInstance].profileEdit objectForKey:@"cmnd_a"];
        if (![AppUtils isNullOrEmpty: cmnd_a]) {
            linkFrontPassport = cmnd_a;
        }
    }
}

- (void)tryToGetCMND_b {
    if ([AppDelegate sharedInstance].profileEdit != nil) {
        NSString *cmnd_b = [[AppDelegate sharedInstance].profileEdit objectForKey:@"cmnd_b"];
        if (![AppUtils isNullOrEmpty: cmnd_b]) {
            linkBehindPassport = cmnd_b;
        }
    }
}

- (void)reUpdateLayoutForView {
    float widthScreen = [DeviceUtils getWidthOfScreen];
    [lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen-2*padding);
    }];
    
    [viewPassport mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen);
    }];
    
    [imgPassportFront mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport).offset((widthScreen/2 - wPassport)/2);
    }];
    
    [imgPassportBehind mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport.mas_centerX).offset((widthScreen/2 - wPassport)/2);
    }];
    
    scvContent.contentSize = CGSizeMake(widthScreen, hContent);
}

@end
