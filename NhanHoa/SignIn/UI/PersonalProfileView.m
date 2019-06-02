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
@synthesize datePicker, toolBar, transparentView, gender, cityCode, delegate, ownType, contentSize;

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
    ownType = type_personal;
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(5.0);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hLabel);
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
    
    UITapGestureRecognizer *tapOnBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnSelectBusinessProfile)];
    lbBusiness.userInteractionEnabled = TRUE;
    [lbBusiness addGestureRecognizer: tapOnBusiness];
    
    
    //  name
    lbName.font = lbVision.font;
    lbName.textColor = lbVision.textColor;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPersonal.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
    tfName.font = [AppDelegate sharedInstance].fontRegular;
    tfName.returnKeyType = UIReturnKeyNext;
    tfName.delegate = self;
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  sexial and birth of day
    lbBOD.font = lbName.font;
    lbBOD.textColor = lbName.textColor;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    tfBOD.enabled = FALSE;
    tfBOD.font = tfName.font;
    tfBOD.returnKeyType = UIReturnKeyNext;
    tfBOD.delegate = self;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD setTitle:@"" forState:UIControlStateNormal];
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfBOD);
    }];
    
    lbSex.font = lbName.font;
    lbSex.textColor = lbName.textColor;
    [lbSex mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(hLabel);
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
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    tfPassport.font = tfName.font;
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  phone
    lbPhone.font = lbVision.font;
    lbPhone.textColor = lbVision.textColor;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    tfPhone.font = tfName.font;
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  address
    lbAddress.font = lbVision.font;
    lbAddress.textColor = lbVision.textColor;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    tfAddress.font = tfName.font;
    tfAddress.returnKeyType = UIReturnKeyNext;
    tfAddress.delegate = self;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  country, district
    lbCountry.font = lbVision.font;
    lbCountry.textColor = lbVision.textColor;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    tfCountry.enabled = FALSE;
    tfCountry.text = @"Việt nam";
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfCountry.font = tfName.font;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    lbCity.font = lbVision.font;
    lbCity.textColor = lbVision.textColor;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
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
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
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
        make.top.equalTo(self.tfCountry.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(45.0);
    }];
    
    //  Add datepicker
    [self addDatePickerForView];
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
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
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
        [self makeToast:@"Vui lòng nhập \'Họ tên\'" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfBOD.text isEqualToString:@""]) {
        [self makeToast:@"Vui lòng chọn \'Ngày sinh\'" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfPassport.text isEqualToString:@""]) {
        [self makeToast:@"Vui lòng nhập \'CMND\'" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfPhone.text isEqualToString:@""]) {
        [self makeToast:@"Vui lòng nhập \'Số điện thoại\'" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfAddress.text isEqualToString:@""]) {
        [self makeToast:@"Vui lòng nhập \'Địa chỉ\'" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfCity.text isEqualToString:@""]) {
        [self makeToast:@"Vui lòng chọn \'Tỉnh/Thành phố\'" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    if (ownType == type_personal) {
        [info setObject:[NSNumber numberWithInt:ownType] forKey:@"own_type"];
        [info setObject:tfName.text forKey:@"cn_name"];
        [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
        [info setObject:tfBOD.text forKey:@"cn_birthday"];
        [info setObject:tfPassport.text forKey:@"cn_cmnd"];
        [info setObject:tfPhone.text forKey:@"cn_phone"];
        [info setObject:tfAddress.text forKey:@"cn_address"];
        [info setObject:COUNTRY_CODE forKey:@"cn_country"];
        [info setObject:cityCode forKey:@"cn_city"];
        
    }else {
        
    }
    
    if ([delegate respondsToSelector:@selector(readyToRegisterAccount:)]) {
        [delegate readyToRegisterAccount: info];
    }
    
//  email: string (tạo mới tài khoản, email cũng chính là username)
//  password: MD5
//  own_type

    
    
    
//mod: register_account

//own_type: number (cá nhân: 0 | công ty / tổ chức: 1)
//if (own_type: 0) { // cá nhân

//} elseif (own_type: 1) { // công ty / tổ chức
//    tc_tc_name: string (tên cty / tổ chức)
//    tc_tc_mst: string / number (mã số thuế)
//    tc_tc_address: string (địa chỉ cty / tổ chức)
//    tc_tc_phone: string / number (số đt cty / tổ chức)
//    tc_tc_country: 231 (cố định: Viêt Nam [231])
//    tc_tc_city:  number (mã tỉnh / thành theo danh sách anh đã gửi).
//    cn_position: string (chức vụ người đại diện)
//    cn_name: Họ và tên (string)
//    cn_sex: number (1: nam | 0: nữ)
//    cn_birthday: dd/mm/yyyy (ngày tháng năm sinh)
//    cn_cmnd: string / number (Số CMND / Passport)
//    cn_phone: string / number (Số ĐT)
//    cn_address: string (địa chỉ)
//    cn_country: 231 (cố định: Viêt Nam [231])
//    cn_city: number (mã tỉnh / thành theo danh sách anh đã gửi).
//    } else {
//    api: error response
//    }
//
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
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
    //  set date for picker
    if (![AppUtils isNullOrEmpty: tfBOD.text]) {
        NSDate *bodDate = [AppUtils convertStringToDate: tfBOD.text];
        datePicker.date = bodDate;
    }else{
        datePicker.date = [NSDate date];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.datePicker.maximumDate = [NSDate date];
    }];
}

- (IBAction)btnCityPress:(UIButton *)sender {
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, SCREEN_HEIGHT-100)];
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
    btnClose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
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
    [btnChoose setTitle:@"Chọn" forState:UIControlStateNormal];
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
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
    cityCode = city.name;
}

@end
