//
//  UpdateNewPersonalProfileView.m
//  NhanHoa
//
//  Created by OS on 10/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateNewPersonalProfileView.h"

@implementation UpdateNewPersonalProfileView
@synthesize scvContent, lbFullname, tfFullname, lbBotFullname, lbGender, icMale, lbMale, icFemale, lbFemale, lbDOB, tfDOB, btnChooseDOB, lbBotDOB, lbPassport, tfPassport, lbBotPassport, lbPhone, tfPhone, lbBotPhone, lbPermanentAddr, tfPermanentAddr, lbBotPermanentAddr, lbCountry, tfCountry, lbBotCountry, lbCity, tfCity, lbBotCity, imgArrowCity, btnChooseCity, btnSaveUpdate;
@synthesize gender, cityCode, transparentView, toolBar, datePicker, delegate;

- (void)setupUIForView
{
    //  Add action to hide keyboard when tap on screen
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer: tapOnScreen];
    //  -----
    
    float padding = 15.0;
    float paddingY = 20.0;
    float hBTN = 55.0;
    
    UIFont *mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        mediumFont = [UIFont fontWithName:RobotoMedium size:16.0];
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        mediumFont = [UIFont fontWithName:RobotoMedium size:18.0];
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    //  scrollview content
    float hLabel = 25.0;
    float hTextfield = 40.0;
    
    scvContent.backgroundColor = UIColor.whiteColor;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self);
    }];
    
    //  fullname
    lbFullname.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Fullname"];
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfFullname.returnKeyType = UIReturnKeyNext;
    tfFullname.delegate = self;
    tfFullname.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter fullname"];
    [tfFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFullname.mas_bottom);
        make.left.right.equalTo(lbFullname);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfFullname.mas_bottom);
        make.left.right.equalTo(tfFullname);
        make.height.mas_equalTo(1.5);
    }];
    
    //  gender and birthday
    lbGender.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Gender"];
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotFullname.mas_bottom).offset(paddingY);
        make.left.equalTo(lbBotFullname);
        make.right.equalTo(lbFullname.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbDOB.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Date of birth"];
    [lbDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbGender);
        make.left.equalTo(lbGender.mas_right).offset(padding);
        make.right.equalTo(lbFullname).offset(-padding);
    }];
    
    tfDOB.placeholder = @"DD/MM/YYYY";
    [tfDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDOB.mas_bottom);
        make.left.right.equalTo(lbDOB);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfDOB.mas_bottom);
        make.left.right.equalTo(tfDOB);
        make.height.mas_equalTo(1);
    }];
    
    [btnChooseDOB setTitle:@"" forState:UIControlStateNormal];
    [btnChooseDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfDOB);
    }];
    
    icMale.imageEdgeInsets = icFemale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbGender).offset(-5.0);
        make.centerY.equalTo(tfDOB.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbMale.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Male"];
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icMale.mas_right).offset(5.0);
        make.top.bottom.equalTo(icMale);
    }];
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMaleGender)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMale.mas_right).offset(padding);
        make.top.bottom.equalTo(icMale);
        make.width.equalTo(icMale.mas_width);
    }];
    
    lbFemale.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Female"];
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.top.bottom.equalTo(icFemale);
    }];
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemaleGender)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    //  passport
    lbPassport.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Passport"];
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotDOB.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfFullname);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    tfPassport.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter passport"];
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassport.mas_bottom);
        make.left.right.equalTo(lbPassport);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPassport.mas_bottom);
        make.left.right.equalTo(tfPassport);
        make.height.mas_equalTo(1);
    }];
    
    //  Phone number
    lbPhone.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Phone number"];
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPassport.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPhone.keyboardType = UIKeyboardTypePhonePad;
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    tfPhone.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter phone number"];
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhone.mas_bottom);
        make.left.right.equalTo(lbPhone);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPhone.mas_bottom);
        make.left.right.equalTo(tfPhone);
        make.height.mas_equalTo(1);
    }];
    
    //  Permanent address
    lbPermanentAddr.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Permanent address"];
    [lbPermanentAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPhone.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPermanentAddr.returnKeyType = UIReturnKeyNext;
    tfPermanentAddr.delegate = self;
    tfPermanentAddr.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter permanent address"];
    [tfPermanentAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPermanentAddr.mas_bottom);
        make.left.right.equalTo(lbPermanentAddr);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotPermanentAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPermanentAddr.mas_bottom);
        make.left.right.equalTo(tfPermanentAddr);
        make.height.mas_equalTo(1);
    }];
    
    //  country
    lbCountry.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Country"];
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPermanentAddr.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPermanentAddr);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfCountry.enabled = FALSE;
    tfCountry.text = @"Việt Nam";
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCountry.mas_bottom);
        make.left.right.equalTo(lbCountry);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfCountry.mas_bottom);
        make.left.right.equalTo(tfCountry);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *imgFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag_vietnam"]];
    [tfCountry addSubview: imgFlag];
    [imgFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfCountry);
        make.centerY.equalTo(tfCountry.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    tfCountry.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, hTextfield)];
    tfCountry.leftViewMode = UITextFieldViewModeAlways;
    
    //  city
    lbCity.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Province/ City"];
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotCountry.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotCountry);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfCity.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Choose province/ city"];
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCity.mas_bottom);
        make.left.right.equalTo(lbCity);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfCity.mas_bottom);
        make.left.right.equalTo(tfCity);
        make.height.mas_equalTo(1);
    }];
    
    [btnChooseCity setTitle:@"" forState:UIControlStateNormal];
    [btnChooseCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfCity);
    }];
    
    [imgArrowCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfCity).offset(-3.0);
        make.centerY.equalTo(tfCity.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    
    btnSaveUpdate.titleLabel.font = mediumFont;
    btnSaveUpdate.backgroundColor = BLUE_COLOR;
    btnSaveUpdate.layer.cornerRadius = 8.0;
    [btnSaveUpdate setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Save update"]
                 forState:UIControlStateNormal];
    [btnSaveUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSaveUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotCity.mas_bottom).offset(2*paddingY);
        make.left.right.equalTo(lbBotCity);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbFullname.font = lbGender.font = lbDOB.font = lbPassport.font = lbPhone.font = lbPermanentAddr.font = lbCountry.font = lbCity.font = mediumFont;
    tfFullname.font = lbMale.font = lbFemale.font = tfDOB.font = tfPassport.font = tfPhone.font = tfPermanentAddr.font = tfCountry.font = tfCity.font = textFont;
    
    lbFullname.textColor = lbGender.textColor = lbDOB.textColor = lbPassport.textColor = lbPhone.textColor = lbPermanentAddr.textColor = lbCountry.textColor = lbCity.textColor = GRAY_50;
    
    tfFullname.textColor = lbMale.textColor = lbFemale.textColor = tfDOB.textColor = tfPassport.textColor = tfPhone.textColor = tfPermanentAddr.textColor = tfCountry.textColor = tfCity.textColor = GRAY_80;
    
    lbBotFullname.backgroundColor = lbBotDOB.backgroundColor = lbBotPassport.backgroundColor = lbBotPhone.backgroundColor = lbBotPermanentAddr.backgroundColor = lbBotCountry.backgroundColor = lbBotCity.backgroundColor = GRAY_220;
    
    float hContentView = padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + 2*paddingY + hBTN + 2*paddingY;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContentView);
    
    //  Add datepicker
    [self addDatePickerForViewWithFont: textFont];
    
    gender = type_men;
    [self selectMaleGender];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
}

- (void)hideKeyboard {
    [self endEditing: TRUE];
}

- (void)selectMaleGender {
    gender = type_men;
    
    [icMale setImage:[UIImage imageNamed:@"ic_tick_active.png"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
}

- (void)selectFemaleGender {
    gender = type_women;
    
    [icMale setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"ic_tick_active.png"] forState:UIControlStateNormal];
}


- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMaleGender];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemaleGender];
}

- (IBAction)btnChooseDOBPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if (toolBar.frame.origin.y == SCREEN_HEIGHT) {
        transparentView.hidden = FALSE;
        [toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(transparentView.mas_bottom).offset(-45.0-200.0);
        }];
    }else{
        transparentView.hidden = TRUE;
        [toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(transparentView.mas_bottom);
        }];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    //  set date for picker
    NSDate *bodDate = [AppUtils convertStringToDate: tfDOB.text];
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

- (IBAction)btnChooseCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float wPopup = 300.0;
    if (!IS_IPHONE && !IS_IPOD) {
        wPopup = 500;
    }
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

- (IBAction)btnSaveUpdatePress:(UIButton *)sender
{
    if ([AppUtils isNullOrEmpty: tfFullname.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter fullname"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfDOB.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose your birthday"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter passport"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter phone number"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPermanentAddr.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter permanent address"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cityCode]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose province or city"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating..."] Interaction:NO];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSNumber numberWithInt:type_personal] forKey:@"own_type"];
    [info setObject:tfFullname.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfDOB.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfPermanentAddr.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:cityCode forKey:@"cn_city"];
    
    [info setObject:edit_profile_mod forKey:@"mod"];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateAccountProfileWithInfo: info];
}

- (void)addDatePickerForViewWithFont: (UIFont *)textFont {
    transparentView = [[UIView alloc] init];
    transparentView.hidden = TRUE;
    transparentView.backgroundColor = UIColor.blackColor;
    transparentView.alpha = 0.5;
    [[AppDelegate sharedInstance].window addSubview: transparentView];
    [transparentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo([AppDelegate sharedInstance].window);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [[AppDelegate sharedInstance].window addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(transparentView);
        make.top.equalTo(transparentView.mas_bottom);
        make.height.mas_equalTo(45.0);
    }];
    
    UIButton *btnClose = [[UIButton alloc] init];
    [btnClose setTitle:text_close forState:UIControlStateNormal];
    btnClose.titleLabel.font = textFont;
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
    btnChoose.titleLabel.font = textFont;
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
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColor.whiteColor;
    [datePicker setValue:BLUE_COLOR forKey:@"textColor"];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [[AppDelegate sharedInstance].window addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(toolBar.mas_bottom);
        make.left.right.equalTo(self.transparentView);
        make.height.mas_equalTo(200);
    }];
}

- (void)closePickerView {
    [toolBar mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(transparentView.mas_bottom);
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
    
    tfDOB.text = [dateFormatter stringFromDate:datePicker.date];
}

- (void)displayPersonalProfileInfo {
    gender = [AccountModel getCusGender];
    if (gender == type_men) {
        [icMale setImage:[UIImage imageNamed:@"ic_tick_active"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"ic_tick"] forState:UIControlStateNormal];
        
    }else {
        [icMale setImage:[UIImage imageNamed:@"ic_tick"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"ic_tick_active"] forState:UIControlStateNormal];
    }
    
    tfFullname.text = [AccountModel getCusRealName];
    tfDOB.text = [AccountModel getCusBirthday];
    tfPassport.text = [AccountModel getCusPassport];
    tfPhone.text = [AccountModel getCusPhone];
    tfPermanentAddr.text = [AccountModel getCusAddress];
    
    cityCode = [AccountModel getCusCityCode];
    NSString *cityName = [[AppDelegate sharedInstance] findCityObjectWithCityCode: cityCode];
    tfCity.text = (![AppUtils isNullOrEmpty: cityName]) ? cityName : @"";
}

#pragma mark - City popup delegate
-(void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
    cityCode = city.code;
}

#pragma mark - WebserviceUtil delegate
-(void)failedToUpdateAccountInfoWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self performSelector:@selector(updateFailed) withObject:nil afterDelay:2.0];
}

-(void)failedToLoginWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your info has been updated successfully"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    
    [self performSelector:@selector(updateSuccessfully) withObject:nil afterDelay:2.0];
}

-(void)updateAccountInfoSuccessfulWithData:(NSDictionary *)data {
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
    [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your info has been updated successfully"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    
    [self performSelector:@selector(updateSuccessfully) withObject:nil afterDelay:2.0];
}

- (void)updateSuccessfully {
    if ([delegate respondsToSelector:@selector(updateProfileInfoSuccessfully)]) {
        [delegate updateProfileInfoSuccessfully];
    }
}

- (void)updateFailed {
    if ([delegate respondsToSelector:@selector(updateProfileInfoFailed)]) {
        [delegate updateProfileInfoFailed];
    }
}

@end
