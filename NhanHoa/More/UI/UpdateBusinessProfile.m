//
//  UpdateBusinessProfile.m
//  NhanHoa
//
//  Created by Khai Leo on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateBusinessProfile.h"
#import "AccountModel.h"

@implementation UpdateBusinessProfile

@synthesize lbBusinessInfo, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, lbCity, tfCity, btnCity, imgArrCity, lbRegistrationInfo, lbRegisterName, tfRegisterName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPosition, tfPostition, lbPassport, tfPassport, lbPhone, tfPhone, lbAddress, tfAddress, lbEmail, tfEmail, btnReset, btnSave;
@synthesize gender, hContent, datePicker, toolBar, viewPicker, cityCode, delegate;

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
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
    btnReset.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    btnReset.layer.borderWidth = 1.0;
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self.tfEmail.mas_bottom).offset(2*padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSave.layer.cornerRadius = btnReset.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    btnSave.layer.borderColor = BLUE_COLOR.CGColor;
    btnSave.layer.borderWidth = 1.0;
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
    [[AppDelegate sharedInstance].window addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(0);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [[AppDelegate sharedInstance].window addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo([AppDelegate sharedInstance].window);
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
    [[AppDelegate sharedInstance].window addSubview: viewPicker];
    [viewPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo([AppDelegate sharedInstance].window);
        make.bottom.equalTo(self.toolBar.mas_top);
    }];
}

- (void)closePickerView {
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(0);
    }];
    
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo([AppDelegate sharedInstance].window);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.viewPicker.hidden = TRUE;
        [[AppDelegate sharedInstance].window layoutIfNeeded];
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
    [self endEditing: TRUE];
    
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
        make.left.right.bottom.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo([AppDelegate sharedInstance].window);
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
        [[AppDelegate sharedInstance].window layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.datePicker.maximumDate = [NSDate date];
    }];
}

- (IBAction)btnResetPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:OLD_PRICE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startResetAllChangeValue) withObject:nil afterDelay:0.05];
}

- (void)startResetAllChangeValue {
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [self displayBusinessInformation];
}

- (IBAction)btnSavePress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startUpdateAllValue) withObject:nil afterDelay:0.05];
}

- (void)startUpdateAllValue {
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [self makeToast:@"Vui lòng nhập Tên doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [self makeToast:@"Vui lòng nhập Mã số thuế doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddress.text]) {
        [self makeToast:@"Vui lòng nhập Địa chỉ doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [self makeToast:@"Vui lòng nhập Số điện thoại doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cityCode]) {
        [self makeToast:@"Vui lòng chọn Tỉnh/thành phố cho doanh nghiệp" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfRegisterName.text]) {
        [self makeToast:@"Vui lòng nhập Tên người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [self makeToast:@"Vui lòng nhập ngày sinh người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPostition.text]) {
        [self makeToast:@"Vui lòng nhập Chức vụ người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:@"Vui lòng nhập CMND người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [self makeToast:@"Vui lòng nhập Số điện thoại người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfAddress.text]) {
        [self makeToast:@"Vui lòng nhập Địa chỉ người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfEmail.text]) {
        [self makeToast:@"Vui lòng nhập Email người đăng ký" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(saveBusinessMyAccountInformation:)]) {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
        [info setObject:[NSNumber numberWithInt:type_business] forKey:@"own_type"];
        [info setObject:tfBusinessName.text forKey:@"tc_tc_name"];
        [info setObject:tfTaxCode.text forKey:@"tc_tc_mst"];
        [info setObject:tfBusinessAddress.text forKey:@"tc_tc_address"];
        [info setObject:tfBusinessPhone.text forKey:@"tc_tc_phone"];
        [info setObject:COUNTRY_CODE forKey:@"tc_tc_country"];
        [info setObject:cityCode forKey:@"tc_tc_city"];
        
        [info setObject:tfPostition.text forKey:@"cn_position"];
        [info setObject:tfRegisterName.text forKey:@"cn_name"];
        [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
        [info setObject:tfEmail.text forKey:@"cn_email"];
        [info setObject:tfBOD.text forKey:@"cn_birthday"];
        [info setObject:tfPassport.text forKey:@"cn_cmnd"];
        [info setObject:tfPhone.text forKey:@"cn_phone"];
        [info setObject:tfAddress.text forKey:@"cn_address"];
        
        [delegate saveBusinessMyAccountInformation: info];
    }
}

- (void)displayBusinessInformation
{
    tfBusinessName.text = [AccountModel getCusCompanyName];
    tfTaxCode.text = [AccountModel getCusCompanyTax];
    tfBusinessAddress.text = [AccountModel getCusCompanyAddress];
    tfBusinessPhone.text = [AccountModel getCusCompanyPhone];
    
    cityCode = [AccountModel getCusCityCode];
    if (![AppUtils isNullOrEmpty: cityCode]) {
        NSString *cityName = [[AppDelegate sharedInstance] findCityObjectWithCityCode: cityCode];
        tfCity.text = cityName;
    }
    
    tfRegisterName.text = [AccountModel getCusRealName];
    
    gender = [AccountModel getCusGender];
    if (gender == type_men) {
        [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    }else{
        [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    }
    
    tfBOD.text = [AccountModel getCusBirthday];
    tfPostition.text = [AccountModel getCusCompanyPosition];
    tfPassport.text = [AccountModel getCusPassport];
    tfPhone.text = [AccountModel getCusPhone];
    tfAddress.text = [AccountModel getCusAddress];
    tfEmail.text = [AccountModel getCusEmail];
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
