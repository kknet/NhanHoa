//
//  NewProfileView.m
//  NhanHoa
//
//  Created by admin on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewProfileView.h"
#import "CityObject.h"

@implementation NewProfileView

@synthesize scvPersonal, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbAddress, tfAddress, lbCountry, tfCountry, imgArrCountry, btnCountry, lbCity, tfCity, imgArrCity, btnCity, imgPassport, lbTitlePassport, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, btnSave, btnCancel;
@synthesize delegate, datePicker, toolBar, hNav, gender;

- (void)setupForAddProfileUI {
    warning
    //  setup for add profile
    float padding = 15.0;
    float mTop = 10.0;
    float hLabel = 30.0;
    float hTextfield = 38.0;
    gender = 1;
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self addGestureRecognizer: tapOnView];
    
    UIFont *regularFont = [UIFont fontWithName:RobotoRegular size:16.0];
    UIFont *mediuFont = [UIFont fontWithName:RobotoMedium size:16.0];
    
    [scvPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvPersonal);
        make.left.equalTo(self).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(40.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(mTop);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hLabel);
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
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  Name
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusiness.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfName.layer.borderWidth = 1.0;
    tfName.layer.borderColor = BORDER_COLOR.CGColor;
    tfName.layer.cornerRadius = 3.0;
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo(hTextfield);
    }];
    tfName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfName.leftViewMode = UITextFieldViewModeAlways;
    
    //  sexial and birth of day
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBOD.layer.borderWidth = tfName.layer.borderWidth;
    tfBOD.layer.borderColor =  tfName.layer.borderColor;
    tfBOD.layer.cornerRadius = tfName.layer.cornerRadius;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo(hTextfield);
    }];
    tfBOD.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfBOD.leftViewMode = UITextFieldViewModeAlways;
    
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.tfBOD);
    }];
    
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icMale);
        make.left.equalTo(self.icMale.mas_right).offset(5.0);
        make.right.equalTo(self.icFemale.mas_left).offset(-5.0);
    }];
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  CMND
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.lbName);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPassport.layer.borderWidth = tfName.layer.borderWidth;
    tfPassport.layer.borderColor =  tfName.layer.borderColor;
    tfPassport.layer.cornerRadius = tfName.layer.cornerRadius;
    tfPassport.keyboardType = UIKeyboardTypeNumberPad;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo(hTextfield);
    }];
    tfPassport.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPassport.leftViewMode = UITextFieldViewModeAlways;
    
    //  Phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPhone.layer.borderWidth = tfName.layer.borderWidth;
    tfPhone.layer.borderColor =  tfName.layer.borderColor;
    tfPhone.layer.cornerRadius = tfName.layer.cornerRadius;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo(hTextfield);
    }];
    tfPhone.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfPhone.leftViewMode = UITextFieldViewModeAlways;
    
    //  Email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfEmail.layer.borderWidth = tfName.layer.borderWidth;
    tfEmail.layer.borderColor =  tfName.layer.borderColor;
    tfEmail.layer.cornerRadius = tfName.layer.cornerRadius;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo(hTextfield);
    }];
    tfEmail.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfEmail.leftViewMode = UITextFieldViewModeAlways;
    
    //  address
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(self.tfEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfAddress.layer.borderWidth = tfName.layer.borderWidth;
    tfAddress.layer.borderColor =  tfName.layer.borderColor;
    tfAddress.layer.cornerRadius = tfName.layer.cornerRadius;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo(hTextfield);
    }];
    tfAddress.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfAddress.leftViewMode = UITextFieldViewModeAlways;
    
    //  country, district
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfCountry.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    tfCountry.layer.borderWidth = tfName.layer.borderWidth;
    tfCountry.layer.borderColor =  tfName.layer.borderColor;
    tfCountry.layer.cornerRadius = tfName.layer.cornerRadius;
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo(hTextfield);
    }];
    tfCountry.text = @"Việt Nam";
    tfCountry.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hTextfield)];
    tfCountry.leftViewMode = UITextFieldViewModeAlways;
    
    [imgArrCountry mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
    }];
    
    tfCity.layer.borderWidth = tfName.layer.borderWidth;
    tfCity.layer.borderColor =  tfName.layer.borderColor;
    tfCity.layer.cornerRadius = tfName.layer.cornerRadius;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfCountry);
        make.left.right.equalTo(self.lbCity);
    }];
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    //  image passport
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvPersonal).offset(padding);
        make.top.equalTo(self.tfCountry.mas_bottom).offset(mTop+(hTextfield-20.0)/2);
        make.width.height.mas_equalTo(20.0);
    }];
    
    [lbTitlePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPassport.mas_right).offset(10.0);
        make.centerY.equalTo(self.imgPassport.mas_centerY);
        make.right.equalTo(self.lbAddress.mas_right);
        make.height.mas_equalTo(hTextfield);
    }];
    
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitlePassport.mas_bottom);
        make.left.equalTo(self.scvPersonal).offset(padding);
        make.width.mas_equalTo(wPassport);
        make.height.mas_equalTo(hPassport);
    }];
    
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.imgPassportFront.mas_bottom);
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imgPassportFront);
        make.left.equalTo(self.imgPassportFront.mas_right).offset(padding);
        make.width.equalTo(self.imgPassportFront.mas_width);
    }];
    
    [lbPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.equalTo(self.imgPassportBehind.mas_bottom);
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    btnCancel.layer.cornerRadius = 45.0/2;
    btnCancel.backgroundColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.lbPassportFront.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(45.0);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.bottom.equalTo(self.btnCancel);
    }];
    
    float hScrollView = 40 + 9*10.0 + 9*30 + 8*38 + hPassport + 2*padding + 45 + 2*padding;
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
    
    lbVision.font = lbName.font = lbGender.font = lbBOD.font = lbPassport.font = lbPhone.font = lbEmail.font = lbAddress.font = lbCountry.font = lbCity.font = lbTitlePassport.font = mediuFont;
    lbPersonal.font = lbBusiness.font = tfName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPassport.font = tfPhone.font = tfEmail.font = tfAddress.font = tfCountry.font = tfCity.font = lbPassportFront.font = lbPassportBehind.font = regularFont;
    
    btnCancel.titleLabel.font = btnSave.titleLabel.font = [UIFont fontWithName:RobotoMedium size:18.0];
    
    lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbName.textColor = tfName.textColor = lbMale.textColor = lbFemale.textColor = lbBOD.textColor = tfBOD.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbEmail.textColor = tfEmail.textColor = lbAddress.textColor = tfAddress.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = lbTitlePassport.textColor = lbPassportBehind.textColor = lbPassportFront.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    //  own_type
    //  cn_name
    //  cn_sex
    //  cn_day
    //  cn_month
    //  cn_year
    //  cn_cmnd
    //  cn_phone
    //  cn_rl_email
    //  cn_address
    //  cn_country
    //  cn_city
    
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
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [self addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(0);
    }];
    
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setTitle:@"Đóng" forState:UIControlStateNormal];
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
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0);
    }];
    
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
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

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (IBAction)btnSavePress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfName.text]) {
        [self makeToast:@"Bạn chưa nhập họ tên!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [self makeToast:@"Bạn chưa nhập ngày sinh!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [self makeToast:@"Bạn chưa nhập ngày sinh!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    
}

- (IBAction)btnBODPress:(UIButton *)sender {
    float hPickerView;
    float hToolbar;
    if (datePicker.frame.size.height > 0) {
        hPickerView = 0;
        hToolbar = 0;
    }else{
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
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.datePicker.date = [NSDate date];
        self.datePicker.maximumDate = [NSDate date];
    }];
}

- (IBAction)btnCityPress:(UIButton *)sender
{
    if (hNav == 0) {
        hNav = 64.0;
    }
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + hNav);
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, realHeight-100)];
    popupView.delegate = self;
    [popupView showInView:self animated:TRUE];
}

- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMale];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemale];
}

- (void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
}

- (void)selectMale {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = 1;
}

- (void)selectFemale {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = 0;
}

@end
