//
//  UpdateBusinessProfile.m
//  NhanHoa
//
//  Created by Khai Leo on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateBusinessProfile.h"

@implementation UpdateBusinessProfile

@synthesize lbBusinessInfo, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, lbCity, tfCity, btnCity, imgArrCity, lbRegistrationInfo, lbRegisterName, tfRegisterName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPosition, tfPostition, lbPassport, tfPassport, lbPhone, tfPhone, lbAddress, tfAddress, lbEmail, tfEmail, btnReset, btnSave;
@synthesize gender, hContent, datePicker, toolBar, viewPicker, cityCode;

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    lbBusinessInfo.font = lbRegistrationInfo.font = [AppDelegate sharedInstance].fontBold;
    
    lbBusinessName.font = lbTaxCode.font = lbBusinessAddress.font = lbBusinessPhone.font = lbCountry.font = lbCity.font = lbRegisterName.font = lbGender.font = lbBOD.font = lbPosition.font = lbPassport.font = lbPhone.font = lbAddress.font = lbEmail.font = [AppDelegate sharedInstance].fontMedium;
    
    tfBusinessName.font = tfTaxCode.font = tfBusinessAddress.font = tfBusinessPhone.font = tfCountry.font = tfCity.font = tfRegisterName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPostition.font = tfPassport.font = tfPhone.font = tfAddress.font = tfEmail.font = [AppDelegate sharedInstance].fontRegular;
    
    lbBusinessName.textColor = lbTaxCode.textColor = lbBusinessAddress.textColor = lbBusinessPhone.textColor = lbCountry.textColor = lbCity.textColor = lbRegisterName.textColor = lbPassport.textColor = lbPhone.textColor = lbAddress.textColor = lbEmail.textColor = TITLE_COLOR;
    
    lbBusinessInfo.textColor = lbRegistrationInfo.textColor = BLUE_COLOR;
    
    //  info for business
    [lbBusinessInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  business name
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessInfo.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbBusinessInfo);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessName borderColor:BORDER_COLOR];
    [tfBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessName.mas_bottom);
        make.left.right.equalTo(self.lbBusinessName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessName.returnKeyType = UIReturnKeyNext;
    tfBusinessName.delegate = self;
    
    //  tax code
    [lbTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessName.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfBusinessName);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfTaxCode borderColor:BORDER_COLOR];
    [tfTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTaxCode.mas_bottom);
        make.left.right.equalTo(self.lbTaxCode);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfTaxCode.returnKeyType = UIReturnKeyNext;
    tfTaxCode.delegate = self;
    
    //  business address
    [lbBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfTaxCode.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfTaxCode);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessAddress borderColor:BORDER_COLOR];
    [tfBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessAddress.mas_bottom);
        make.left.right.equalTo(self.lbBusinessAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessAddress.returnKeyType = UIReturnKeyNext;
    tfBusinessAddress.delegate = self;
    
    //  business phone
    [lbBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessAddress.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfBusinessAddress);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessPhone borderColor:BORDER_COLOR];
    [tfBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessPhone.mas_bottom);
        make.left.right.equalTo(self.lbBusinessPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessPhone.returnKeyType = UIReturnKeyNext;
    tfBusinessPhone.delegate = self;
    
    //  country and city
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessPhone.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfCountry.enabled = FALSE;
    tfCountry.text = @"Việt nam";
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  city
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCity.mas_bottom);
        make.left.right.equalTo(self.lbCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    //  register infor
    [lbRegistrationInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfCountry.mas_bottom).offset(2*padding);
        make.left.right.equalTo(self.lbBusinessInfo);
        make.height.mas_equalTo(hLabel);
    }];
    
    //  business name
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegistrationInfo.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbRegistrationInfo);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRegisterName borderColor:BORDER_COLOR];
    [tfRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterName.mas_bottom);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfRegisterName.returnKeyType = UIReturnKeyNext;
    tfRegisterName.delegate = self;
    
    //  birth day and gender
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfRegisterName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    tfBOD.enabled = FALSE;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD setTitle:@"" forState:UIControlStateNormal];
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfBOD);
    }];
    
    gender = type_men;
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
    }];
    
    icMale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbGender).offset(-4.0);
        make.centerY.equalTo(self.tfBOD.mas_centerY);
        make.width.height.mas_equalTo(hLabel);
    }];
    
    icFemale.imageEdgeInsets = icMale.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(self.icMale);
        make.width.equalTo(self.icMale.mas_width);
    }];
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icMale);
        make.left.equalTo(self.icMale.mas_right).offset(5.0);
        make.right.equalTo(self.icFemale.mas_left).offset(-5.0);
    }];
    
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  position
    [lbPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPostition borderColor:BORDER_COLOR];
    [tfPostition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPosition.mas_bottom);
        make.left.right.equalTo(self.lbPosition);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPostition.returnKeyType = UIReturnKeyNext;
    tfPostition.delegate = self;
    
    //  Passport
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPostition.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPostition);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    
    //  Phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    
    //  Address
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfAddress.returnKeyType = UIReturnKeyNext;
    tfAddress.delegate = self;
    
    //  Address
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfAddress);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfEmail.returnKeyType = UIReturnKeyDone;
    tfEmail.delegate = self;
    
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnReset.layer.cornerRadius = 45.0/2;
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self.tfAddress.mas_bottom).offset(2*padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSave.layer.cornerRadius = btnReset.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnReset.mas_right).offset(padding);
        make.top.bottom.equalTo(self.btnReset);
        make.right.equalTo(self).offset(-padding);
    }];
    
    btnReset.titleLabel.font = btnSave.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    hContent = (padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (2*padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + 45.0 + 2*padding;
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
        make.bottom.equalTo(self.datePicker.mas_top);
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
        make.left.equalTo(self.toolBar).offset(15.0);
        make.bottom.top.equalTo(self.toolBar);
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
        make.right.equalTo(self.toolBar).offset(-15.0);
        make.bottom.top.equalTo(self.toolBar);
        make.width.mas_equalTo(100);
    }];
    
    viewPicker = [[UIView alloc] init];
    viewPicker.backgroundColor = UIColor.blackColor;
    viewPicker.alpha = 0.3;
    viewPicker.hidden = TRUE;
    [self addSubview: viewPicker];
    [viewPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(self.toolBar.mas_top);
    }];
}

- (void)closePickerView {
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewPicker.hidden = TRUE;
        [self layoutIfNeeded];
    }];
}

- (void)chooseDatePicker {
    [self closePickerView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    tfBOD.text = [dateFormatter stringFromDate:datePicker.date];
}

- (void)selectMale {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_men;
}

- (void)selectFemale {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_women;
}
//
//tc_tc_name: string (tên cty / tổ chức)
//tc_tc_mst: string / number (mã số thuế)
//tc_tc_address: string (địa chỉ cty / tổ chức)
//tc_tc_phone: string / number (số đt cty / tổ chức)
//tc_tc_country: 231 (cố định: Viêt Nam [231])
//tc_tc_city:  number (mã tỉnh / thành theo danh sách anh đã gửi).
//
//cn_position: string (chức vụ người đại diện)
//cn_name: Họ và tên (string)
//cn_sex: number (1: nam | 0: nữ)
//cn_email: string (email của hồ sơ)
//cn_birthday: dd/mm/yyyy (ngày tháng năm sinh)
//cn_cmnd: string / number (Số CMND / Passport)
//cn_phone: string / number (Số ĐT)
//cn_address: string (địa chỉ)


- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMale];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemale];
}

- (IBAction)btnCityPress:(UIButton *)sender {
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, realHeight-100)];
    popupView.delegate = self;
    [popupView showInView:self animated:TRUE];
}

- (IBAction)btnBODPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float hPickerView;
    float hToolbar;
    if (datePicker.frame.size.height > 0) {
        viewPicker.hidden = TRUE;
        hPickerView = 0;
        hToolbar = 0;
    }else{
        viewPicker.hidden = FALSE;
        hPickerView = 200;
        hToolbar = 44.0;
    }
    
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
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
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.datePicker.maximumDate = [NSDate date];
    }];
}

- (IBAction)btnResetPress:(UIButton *)sender {
}

- (IBAction)btnSavePress:(UIButton *)sender {
}


- (void)displayBusinessInformation
{
    
    
    
    {
        "careers_id" = 0;
        "cus_account_list" = "<null>";
        "cus_activate" = 1;
        "cus_address" = "1020 Ph\U1ea1m V\U0103n \U0110\U1ed3ng";
        "cus_adminnote" = "<null>";
        "cus_aff" = "<null>";
        "cus_aff_balance" = 0;
        "cus_aff_id" = 0;
        "cus_aff_method" = 0;
        "cus_age" = "<null>";
        "cus_algolia_object_id" = 0;
        "cus_api_domain_api_key" = "<null>";
        "cus_api_domain_auth_userid" = 0;
        "cus_api_permission" = 0;
        "cus_azcontest" = 0;
        "cus_balance" = 0;
        "cus_balance_alert_time" = 0;
        "cus_bank_branch" = "<null>";
        "cus_bankaccount" = "<null>";
        "cus_bankname" = "<null>";
        "cus_banknumber" = "<null>";
        "cus_bday" = 2;
        "cus_birthday" = "02/12/1991";
        "cus_bmonth" = 12;
        "cus_byear" = 1991;
        "cus_card_code" = "<null>";
        "cus_card_id" = "<null>";
        "cus_card_reason" = "<null>";
        "cus_card_time" = 0;
        "cus_city" = 1;
        "cus_code" = ACC140661;
        "cus_company" = "Doanh nghi\U1ec7p KLTN";
        "cus_company_address" = "15/27A L\U00ea Th\U00e1nh T\U00f4n, P.B\U1ebfn Ngh\U00e9, Q.1";
        "cus_company_delegate" = "L\U00ca QUANG KH\U1ea2I";
        "cus_company_delegate_2_bday" = 2;
        "cus_company_delegate_2_birthday" = "02/12/1991";
        "cus_company_delegate_2_bmonth" = 12;
        "cus_company_delegate_2_byear" = 1991;
        "cus_company_delegate_2_email" = "";
        "cus_company_delegate_2_gender" = 1;
        "cus_company_delegate_2_id_date" = 0;
        "cus_company_delegate_2_id_number" = 212000002;
        "cus_company_delegate_2_name" = "L\U00ca QUANG KH\U1ea2I";
        "cus_company_delegate_bday" = 2;
        "cus_company_delegate_birthday" = "02/12/1991";
        "cus_company_delegate_bmonth" = 12;
        "cus_company_delegate_byear" = 1991;
        "cus_company_delegate_email" = "";
        "cus_company_delegate_gender" = 1;
        "cus_company_delegate_id_date" = 0;
        "cus_company_delegate_id_number" = 212000002;
        "cus_company_phone" = 0932205601;
        "cus_country" = 231;
        "cus_ctv_fixed" = 0;
        "cus_customer_count" = 0;
        "cus_debt_balance" = 0;
        "cus_deleted" = 0;
        "cus_disable_backorder_failed" = 1;
        "cus_display_name" = NULL;
        "cus_district" = 0;
        "cus_dns_default" = "<null>";
        "cus_dns_default_qt" = "<null>";
        "cus_email" = "lekhai02121991@gmail.com";
        "cus_email_notification" = "<null>";
        "cus_email_vat" = "<null>";
        "cus_enable_api_domain" = 0;
        "cus_enable_view_order_expired" = 0;
        "cus_exist_info" = 0;
        "cus_facebook_login" = 0;
        "cus_fax" = "<null>";
        "cus_firstname" = "<null>";
        "cus_gender" = 1;
        "cus_id" = 140661;
        "cus_idcard_back_img" = "<null>";
        "cus_idcard_date" = 0;
        "cus_idcard_front_img" = "<null>";
        "cus_idcard_msg" = "<null>";
        "cus_idcard_name" = "<null>";
        "cus_idcard_number" = 212000002;
        "cus_idcard_status" = 0;
        "cus_ip_address" = "";
        "cus_is_api" = 0;
        "cus_is_api_domain" = 0;
        "cus_jobtitle" = "Nh\U00e2n Vi\U00ean";
        "cus_lastname" = "<null>";
        "cus_location" = hcm;
        "cus_otp" = 0;
        "cus_own_type" = 1;
        "cus_partner_service" = "<null>";
        "cus_passport_name" = "<null>";
        "cus_passport_number" = "<null>";
        "cus_password" = d0521106f6ba7f9ac0a7370fb28d0ec6;
        "cus_paypal_email" = "<null>";
        "cus_phone" = 0363430737;
        "cus_phonehome" = "<null>";
        "cus_photo" = "http://nhanhoa.com/uploads/default.png";
        "cus_point" = 0;
        "cus_point_used" = 0;
        "cus_position" = "Nh\U00e2n Vi\U00ean";
        "cus_profile_list" = "-1";
        "cus_profile_note" = "<null>";
        "cus_realname" = "L\U00ca QUANG KH\U1ea2I";
        "cus_register_time" = 1559529265;
        "cus_reseller_content" = "<null>";
        "cus_reseller_customed" = 0;
        "cus_reseller_domain" = "<null>";
        "cus_reseller_email" = "<null>";
        "cus_reseller_fixed" = 0;
        "cus_reseller_id" = 0;
        "cus_reseller_overdraft" = 0;
        "cus_reseller_register" = 0;
        "cus_reseller_security_level" = 0;
        "cus_reseller_username" = "<null>";
        "cus_rl_email" = "";
        "cus_security_answer" = "<null>";
        "cus_security_custom_question" = "<null>";
        "cus_security_method" = 0;
        "cus_security_question" = "<null>";
        "cus_seller" = 0;
        "cus_seller_update" = 0;
        "cus_send_email_to" = 0;
        "cus_send_subemail" = 0;
        "cus_social" = 0;
        "cus_status" = 1;
        "cus_subemail" = "<null>";
        "cus_syn_algolia" = 0;
        "cus_taxcode" = "MST-987654321";
        "cus_temp_email" = "<null>";
        "cus_time" = 1559691619;
        "cus_token" = "";
        "cus_total_balance" = 0;
        "cus_total_point" = 0;
        "cus_town" = 0;
        "cus_type" = 0;
        "cus_username" = "lekhai02121991@gmail.com";
        "cus_web_domain" = "<null>";
        "cus_website" = "<null>";
        "cus_withdraw" = 0;
        "cus_yahoo" = "<null>";
        "cus_zonedns_domain" = "<null>";
        "cus_zonedns_email_footer" = "";
        "cus_zonedns_logo" = "<null>";
        "cus_zonedns_value" = "<null>";
        "dns_enable" = 0;
        "dns_enable_qt" = 0;
        "list_banner" =     (
                             {
                                 image = "https://nhanhoa.com/uploads/logo/1550653015_1200.400.jpg";
                                 url = "https://nhanhoa.com/khuyen-mai-server/";
                             },
                             {
                                 image = "https://nhanhoa.com/uploads/logo/1549956238_domain50-1200x400.jpg";
                                 url = "https://nhanhoa.com/ten-mien/dang-ky-moi-ten-mien.html";
                             },
                             {
                                 image = "https://nhanhoa.com/uploads/logo/1554109685_banner-gsuite.jpg";
                                 url = "https://nhanhoa.com/gsuite.html";
                             },
                             {
                                 image = "https://nhanhoa.com/uploads/logo/1512723722_untitled-3-01.jpg";
                                 url = "https://nhanhoa.com/khuyen-mai-email-server-2017.html";
                             },
                             {
                                 image = "https://nhanhoa.com/uploads/logo/1483495406_1200-400.jpg";
                                 url = "https://nhanhoa.com/ten-mien/dang-ky-moi-ten-mien.html";
                             }
                             );
        "list_price" =     (
                            {
                                name = ".xyz";
                                price = 280000;
                            },
                            {
                                name = ".vn";
                                price = 750000;
                            },
                            {
                                name = ".com";
                                price = 299000;
                            },
                            {
                                name = ".com.vn";
                                price = 630000;
                            },
                            {
                                name = ".net";
                                price = 299000;
                            }
                            );
        "lv_content" = "<null>";
        "lv_id" = 0;
        "member_id" = 0;
        "rel_id" = 0;
        "reseller_content" = "<null>";
        "reseller_id" = 0;
        "reseller_type" = 0;
        "reseller_upload_folder" = "<null>";
        "user_id" = 0;
        "zonedns_enable" = 0;
    }
}

#pragma mark - Choose city delegate
-(void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
    cityCode = city.code;
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

@end
