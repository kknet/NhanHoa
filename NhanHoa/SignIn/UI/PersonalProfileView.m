//
//  PersonalProfileView.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PersonalProfileView.h"


@implementation PersonalProfileView
@synthesize lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbSex, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbAddress, tfAddress, lbCountry, tfCountry, lbCity, btnCity, tfCity, btnRegister, imgArrowCity;
@synthesize datePicker, toolBar, transparentView, gender, cityCode, delegate, contentHeight;

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float mTop = 10.0;
    float hTitle = 40.0;
    float hBTN = 45.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        hLabel = 40.0;
        hTitle = 60.0;
        hBTN = 55.0;
        padding = 30.0;
    }
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKyboard)];
    tapOnScreen.delegate = self;
    self.userInteractionEnabled = TRUE;
    [self addGestureRecognizer: tapOnScreen];
    
    //  title
    lbTitle.text = SFM(@"2. %@", text_update_profile);
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    //  vision
    lbVision.text = text_registration_purpose;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = icBusiness.imageEdgeInsets = icMale.imageEdgeInsets = icFemale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
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
    
    UITapGestureRecognizer *tapOnBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnSelectBusinessProfile)];
    lbBusiness.userInteractionEnabled = TRUE;
    [lbBusiness addGestureRecognizer: tapOnBusiness];
    
    //  name
    lbName.text = text_fullname;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPersonal.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
    tfName.returnKeyType = UIReturnKeyNext;
    tfName.delegate = self;
    tfName.placeholder = text_enter_fullname;
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  gender and birth of day
    lbBOD.text = text_birthday;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    tfBOD.enabled = FALSE;
    tfBOD.returnKeyType = UIReturnKeyNext;
    tfBOD.delegate = self;
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
        make.top.equalTo(tfName.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(hLabel);
    }];
    
    gender = type_men;
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icPersonal.mas_left);
        make.centerY.equalTo(tfBOD.mas_centerY);
        make.width.equalTo(icPersonal.mas_width);
        make.height.equalTo(icPersonal.mas_height);
    }];
    
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
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    lbFemale.text = text_female;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icFemale);
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  passport
    lbPassport.text = text_passport;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    tfPassport.placeholder = text_enter_passport;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassport.mas_bottom);
        make.left.right.equalTo(lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  phone
    lbPhone.text = text_phonenumber;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    tfPhone.placeholder = text_enter_phonenumber;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhone.mas_bottom);
        make.left.right.equalTo(lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  address
    lbAddress.text = text_permanent_address;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    tfAddress.returnKeyType = UIReturnKeyNext;
    tfAddress.delegate = self;
    tfAddress.placeholder = text_enter_permanent_address;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAddress.mas_bottom);
        make.left.right.equalTo(lbAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  country, district
    lbCountry.text = text_country;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    tfCountry.enabled = FALSE;
    tfCountry.text = text_vietnam;
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCountry.mas_bottom);
        make.left.right.equalTo(lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    lbCity.text = text_city;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    tfCity.layer.borderWidth = tfName.layer.borderWidth;
    tfCity.layer.borderColor =  tfName.layer.borderColor;
    tfCity.layer.cornerRadius = tfName.layer.cornerRadius;
    tfCity.placeholder = text_choose_city;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfCountry);
        make.left.right.equalTo(lbCity);
    }];
    
    [imgArrowCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfCity);
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
        make.top.equalTo(tfCountry.mas_bottom).offset(padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontBold;
    lbVision.font = lbName.font = lbSex.font = lbBOD.font = lbPassport.font = lbPhone.font = lbAddress.font = lbCountry.font = lbCity.font = [AppDelegate sharedInstance].fontMedium;
    lbPersonal.font = lbBusiness.font = tfName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPassport.font = tfPhone.font = tfAddress.font = tfCountry.font = tfCity.font = [AppDelegate sharedInstance].fontRegular;
    btnRegister.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbTitle.textColor = lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbName.textColor = tfName.textColor = lbSex.textColor = lbMale.textColor = lbFemale.textColor = lbBOD.textColor = tfBOD.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbAddress.textColor = tfAddress.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    contentHeight = hTitle + 5.0 + 30 + 5.0 + hLabel + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + padding + hBTN + padding;
    
}

- (void)tapOnSelectBusinessProfile {
    if ([delegate respondsToSelector:@selector(selectBusinessProfile)]) {
        [delegate selectBusinessProfile];
    }
}

- (void)closeKyboard {
    [self endEditing: TRUE];
}

- (IBAction)icPersonalClick:(UIButton *)sender {
}

- (IBAction)icBusinessClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(selectBusinessProfile)]) {
        [delegate selectBusinessProfile];
    }
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

- (IBAction)btnRegisterPress:(UIButton *)sender
{
    if ([tfName.text isEqualToString:@""]) {
        [self makeToast:pls_enter_fullname duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfBOD.text isEqualToString:@""]) {
        [self makeToast:pls_choose_birthday duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfPassport.text isEqualToString:@""]) {
        [self makeToast:pls_enter_birthday duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfPhone.text isEqualToString:@""]) {
        [self makeToast:pls_enter_phone_number duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfAddress.text isEqualToString:@""]) {
        [self makeToast:pls_enter_permanent_address duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfCity.text isEqualToString:@""]) {
        [self makeToast:pls_choose_city duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    [info setObject:tfName.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfBOD.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:cityCode forKey:@"cn_city"];
    
    if ([delegate respondsToSelector:@selector(readyToRegisterPersonalAccount:)]) {
        [delegate readyToRegisterPersonalAccount: info];
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

- (IBAction)btnCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float wPopup = 300.0;
    if (!IS_IPHONE && !IS_IPOD) {
        wPopup = 500;
    }
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfName) {
        [tfPassport becomeFirstResponder];
        
    }else if (textField == tfPassport) {
        [tfPhone becomeFirstResponder];
        
    }else if (textField == tfPhone) {
        [tfAddress becomeFirstResponder];
        
    }else if (textField == tfAddress) {
        [self endEditing: TRUE];
    }
    return TRUE;
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
        make.left.right.bottom.equalTo(self.transparentView);
        make.height.mas_equalTo(0);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [[AppDelegate sharedInstance].window addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.transparentView);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setTitle:text_close forState:UIControlStateNormal];
    btnClose.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
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
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
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
        self.transparentView.hidden = TRUE;
        [self layoutIfNeeded];
    }];
}

- (void)chooseDatePicker {
    [self closePickerView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    tfBOD.text = [dateFormatter stringFromDate:datePicker.date];
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

#pragma mark - City popup delegate
-(void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
    cityCode = city.code;
}

@end
