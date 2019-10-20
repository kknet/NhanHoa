//
//  NewPersonalProfileView.m
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewPersonalProfileView.h"

@implementation NewPersonalProfileView

@synthesize viewHeader, icBack, lbHeader, scvContent, viewTitle, lbTitle, lbFullname, tfFullname, lbBotFullname, lbGender, icMale, lbMale, icFemale, lbFemale, lbBirthday, tfBirthday, lbBotBirthday, btnChooseDOB, lbPassport, tfPassport, lbBotPassport, lbPhoneNumber, tfPhoneNumber, lbBotPhoneNumber, lbPermanentAddr, tfPermanentAddr, lbBotPermanentAddr, lbCountry, tfCountry, lbBotCountry, lbCity, tfCity, lbBotCity, imgArrCity, btnChooseCity, tvPolicy, btnRegister;
@synthesize hContentView, delegate, gender;
@synthesize transparentView, datePicker, toolBar, cityCode;

- (void)setupUIForViewWithHeightNav: (float)hNav
{
    //  Add action to hide keyboard when tap on screen
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer: tapOnScreen];
    //  -----
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
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
    
    //  header view
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    
    lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Personal profile"];
    lbHeader.font = [UIFont fontWithName:RobotoRegular size:(textFont.pointSize + 3)];
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(hNav);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.left.equalTo(viewHeader).offset(padding-10.0);
        make.width.height.mas_equalTo(40);
    }];
    
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  scrollview content
    float hLabel = 25.0;
    float hTextfield = 40.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(2.0);
        make.left.right.bottom.equalTo(self);
    }];
    
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60.0);
    }];
    
    lbTitle.textColor = BLUE_COLOR;
    lbTitle.font = mediumFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewTitle).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
        make.bottom.equalTo(viewTitle);
        make.height.mas_equalTo(40.0);
    }];
    
    //  fullname
    lbFullname.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Fullname"];
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTitle.mas_bottom).offset(padding);
        make.left.equalTo(viewTitle).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
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
        make.right.equalTo(viewTitle.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbBirthday.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Date of birth"];
    [lbBirthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbGender);
        make.left.equalTo(lbGender.mas_right).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
    }];
    
    tfBirthday.placeholder = @"DD/MM/YYYY";
    [tfBirthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBirthday.mas_bottom);
        make.left.right.equalTo(lbBirthday);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotBirthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBirthday.mas_bottom);
        make.left.right.equalTo(tfBirthday);
        make.height.mas_equalTo(1);
    }];
    
    [btnChooseDOB setTitle:@"" forState:UIControlStateNormal];
    [btnChooseDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfBirthday);
    }];
    
    icMale.imageEdgeInsets = icFemale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbGender).offset(-5.0);
        make.centerY.equalTo(tfBirthday.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbMale.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Male"];
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icBack.mas_right).offset(5.0);
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
        make.top.equalTo(lbBotBirthday.mas_bottom).offset(paddingY);
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
    lbPhoneNumber.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Phone number"];
    [lbPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPassport.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPhoneNumber.keyboardType = UIKeyboardTypePhonePad;
    tfPhoneNumber.returnKeyType = UIReturnKeyNext;
    tfPhoneNumber.delegate = self;
    tfPhoneNumber.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter phone number"];
    [tfPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhoneNumber.mas_bottom);
        make.left.right.equalTo(lbPhoneNumber);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPhoneNumber.mas_bottom);
        make.left.right.equalTo(tfPhoneNumber);
        make.height.mas_equalTo(1);
    }];
    
    //  Permanent address
    lbPermanentAddr.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Permanent address"];
    [lbPermanentAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPhoneNumber.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPhoneNumber);
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
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfCity).offset(-3.0);
        make.centerY.equalTo(tfCity.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    
    //  textview content
    [self setContentForTextViewPolicyWithFont: [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2]];
    
    tvPolicy.editable = FALSE;
    tvPolicy.delegate = self;
    tvPolicy.scrollEnabled = FALSE;
    [tvPolicy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotCity.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotCity);
        make.height.mas_equalTo(90.0);
    }];
    
    btnRegister.titleLabel.font = mediumFont;
    btnRegister.backgroundColor = BLUE_COLOR;
    btnRegister.layer.cornerRadius = 8.0;
    [btnRegister setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Sign Up"]
                 forState:UIControlStateNormal];
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tvPolicy.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tvPolicy);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbFullname.font = lbGender.font = lbBirthday.font = lbPassport.font = lbPhoneNumber.font = lbPermanentAddr.font = lbCountry.font = lbCity.font = mediumFont;
    tfFullname.font = lbMale.font = lbFemale.font = tfBirthday.font = tfPassport.font = tfPhoneNumber.font = tfPermanentAddr.font = tfCountry.font = tfCity.font = textFont;
    
    lbHeader.textColor = lbFullname.textColor = lbGender.textColor = lbBirthday.textColor = lbPassport.textColor = lbPhoneNumber.textColor = lbPermanentAddr.textColor = lbCountry.textColor = lbCity.textColor = GRAY_50;
    tfFullname.textColor = lbMale.textColor = lbFemale.textColor = tfBirthday.textColor = tfPassport.textColor = tfPhoneNumber.textColor = tfPermanentAddr.textColor = tfCountry.textColor = tfCity.textColor = GRAY_80;
    
    lbBotFullname.backgroundColor = lbBotBirthday.backgroundColor = lbBotPassport.backgroundColor = lbBotPhoneNumber.backgroundColor = lbBotPermanentAddr.backgroundColor = lbBotCountry.backgroundColor = lbBotCity.backgroundColor = GRAY_220;
    
    hContentView = (hStatus + hNav) + 60.0 + padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + 80.0 + paddingY + hBTN + paddingY;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContentView-(hStatus + hNav));
    
    //  Add datepicker
    [self addDatePickerForViewWithFont: textFont];
    
    gender = type_men;
    [self selectMaleGender];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
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
    
    tfBirthday.text = [dateFormatter stringFromDate:datePicker.date];
}

- (void)hideKeyboard {
    [self endEditing: TRUE];
}

- (IBAction)icBackClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onPersonalViewBackClicked)]) {
        [delegate onPersonalViewBackClicked];
    }
}

- (IBAction)icMaleClick:(id)sender {
    [self selectMaleGender];
}

- (void)selectMaleGender {
    gender = type_men;
    
    [icMale setImage:[UIImage imageNamed:@"ic_tick_active.png"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemaleGender];
}

- (void)selectFemaleGender {
    gender = type_women;
    
    [icMale setImage:[UIImage imageNamed:@"ic_tick.png"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"ic_tick_active.png"] forState:UIControlStateNormal];
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
    NSDate *bodDate = [AppUtils convertStringToDate: tfBirthday.text];
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

- (IBAction)btnRegisterPress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfFullname.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter fullname"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBirthday.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose your birthday"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter passport"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhoneNumber.text]) {
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
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    [info setObject:tfFullname.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfBirthday.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhoneNumber.text forKey:@"cn_phone"];
    [info setObject:tfPermanentAddr.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:cityCode forKey:@"cn_city"];
    
    if ([delegate respondsToSelector:@selector(readyToRegisterPersonalAccount:)]) {
        [delegate readyToRegisterPersonalAccount: info];
    }
}

- (void)setContentForTextViewPolicyWithFont: (UIFont *)font {
    NSString *content = SFM(@"%@\n%@ %@ %@\n%@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Press on 'Register', the default you will agree with"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"Terms of service"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"and"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"Privacy policy"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"of Nhan Hoa"]);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
    
    NSRange range = [content rangeOfString: [[AppDelegate sharedInstance].localization localizedStringForKey:@"Terms of service"]];
    if (range.location != NSNotFound) {
        [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
        [attr addAttribute:NSLinkAttributeName value:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Terms of service"] range:range];
    }
    
    range = [content rangeOfString:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Privacy policy"]];
    if (range.location != NSNotFound) {
        [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
        [attr addAttribute:NSLinkAttributeName value:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Privacy policy"] range:range];
    }
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentCenter;
    //  paragraph.lineSpacing = 40.0;
    
    [attr addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, content.length)];
    [attr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, content.length)];
    
    tvPolicy.attributedText = attr;
}

#pragma mark - UITextview delegate
-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction {
    NSLog(@"link: %@", URL.absoluteString);
    return TRUE;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfFullname) {
        [tfPassport becomeFirstResponder];
        
    }else if (textField == tfPassport) {
        [tfPhoneNumber becomeFirstResponder];
        
    }else if (textField == tfPhoneNumber) {
        [tfPermanentAddr becomeFirstResponder];
        
    }else if (textField == tfPermanentAddr) {
        [self endEditing: TRUE];
    }
    return TRUE;
}

#pragma mark - City popup delegate
-(void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
    cityCode = city.code;
}

@end
