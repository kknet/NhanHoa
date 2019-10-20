//
//  SignUpBusinessProfileView.m
//  NhanHoa
//
//  Created by OS on 10/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SignUpBusinessProfileView.h"

@implementation SignUpBusinessProfileView
@synthesize viewHeader, icBack, lbHeader, scvContent, viewTitle, lbTitle, lbBusinessName, tfBusinessName, lbBotBusinessName, lbTaxCode, tfTaxCode, lbBotTaxCode, lbBusinessAddr, tfBusinessAddr, lbBotBusinessAddr, lbBusinessPhone, tfBusinessPhone, lbBotBusinessPhone, lbBusinessCountry, tfBusinessCountry, lbBotBusinessCountry, lbBusinessCity, tfBusinessCity, lbBusinessBotCity, btnContinue, btnChooseBusinessCity, imgBusinessCity;

@synthesize scvPersonal, viewPersonalTitle, lbPersonalTitle, lbFullname, tfFullname, lbBotFullname, lbGender, icMale, lbMale, icFemale, lbFemale, lbDOB, tfDOB, lbBotDOB, btnChooseDOB, lbPostition, tfPostition, lbBotPPostition, lbPassport, tfPassport, lbBotPassport, lbPhoneNumber, tfPhoneNumber, lbBotPhoneNumber, lbEmail, tfEmail, lbBotEmail, lbCountry, tfCountry, lbBotCountry, lbCity, tfCity, lbBotCity, tvPolicy, btnChooseCity, btnRegister, imgCityArr;

@synthesize delegate, businessCityCode;

- (void)setupUIForViewWithHeightNav: (float)hNav
{
    //  Add action to hide keyboard when tap on screen
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer: tapOnScreen];
    //  -----
    
    self.clipsToBounds = TRUE;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float padding = 15.0;
    float paddingY = 25.0;
    float hBTN = 55.0;
    float hLabel = 25.0;
    float hTextfield = 50.0;
    
    UIFont *mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        mediumFont = [UIFont fontWithName:RobotoMedium size:16.0];
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        hTextfield = 40.0;
        paddingY = 20.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        mediumFont = [UIFont fontWithName:RobotoMedium size:18.0];
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hTextfield = 40.0;
        paddingY = 20.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hTextfield = 50.0;
        paddingY = 25.0;
    }
    
    //  header view
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    
    lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Business profile"];
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
    lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter business informations"];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewTitle).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
        make.bottom.equalTo(viewTitle);
        make.height.mas_equalTo(40.0);
    }];
    
    //  business name
    lbBusinessName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Business name"];
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTitle.mas_bottom).offset(padding);
        make.left.equalTo(viewTitle).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBusinessName.returnKeyType = UIReturnKeyNext;
    tfBusinessName.delegate = self;
    tfBusinessName.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter business name"];
    [tfBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessName.mas_bottom);
        make.left.right.equalTo(lbBusinessName);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessName.mas_bottom);
        make.left.right.equalTo(tfBusinessName);
        make.height.mas_equalTo(1.5);
    }];
    
    //  tax code
    lbTaxCode.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Tax code"];
    [lbTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotBusinessName.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfBusinessName);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfTaxCode.returnKeyType = UIReturnKeyNext;
    tfTaxCode.delegate = self;
    tfTaxCode.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter tax code"];
    [tfTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTaxCode.mas_bottom);
        make.left.right.equalTo(lbTaxCode);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfTaxCode.mas_bottom);
        make.left.right.equalTo(tfTaxCode);
        make.height.mas_equalTo(1);
    }];
    
    //  business address
    lbBusinessAddr.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Business address"];
    [lbBusinessAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotTaxCode.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotTaxCode);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBusinessAddr.returnKeyType = UIReturnKeyNext;
    tfBusinessAddr.delegate = self;
    tfBusinessAddr.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter business address"];
    [tfBusinessAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessAddr.mas_bottom);
        make.left.right.equalTo(lbBusinessAddr);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotBusinessAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessAddr.mas_bottom);
        make.left.right.equalTo(tfBusinessAddr);
        make.height.mas_equalTo(1);
    }];
    
    //  business phone number
    lbBusinessPhone.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Business phone number"];
    [lbBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotBusinessAddr.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotBusinessAddr);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBusinessPhone.returnKeyType = UIReturnKeyDone;
    tfBusinessPhone.delegate = self;
    tfBusinessPhone.keyboardType = UIKeyboardTypePhonePad;
    tfBusinessPhone.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter business phone number"];
    [tfBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessPhone.mas_bottom);
        make.left.right.equalTo(lbBusinessPhone);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessPhone.mas_bottom);
        make.left.right.equalTo(tfBusinessPhone);
        make.height.mas_equalTo(1);
    }];
    
    //  country
    lbBusinessCountry.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Country"];
    [lbBusinessCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotBusinessPhone.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotBusinessPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBusinessCountry.enabled = FALSE;
    tfBusinessCountry.text = @"Việt Nam";
    [tfBusinessCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessCountry.mas_bottom);
        make.left.right.equalTo(lbBusinessCountry);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotBusinessCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessCountry.mas_bottom);
        make.left.right.equalTo(tfBusinessCountry);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView *imgFlag = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag_vietnam"]];
    [tfBusinessCountry addSubview: imgFlag];
    [imgFlag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfBusinessCountry);
        make.centerY.equalTo(tfBusinessCountry.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    tfBusinessCountry.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40.0, hTextfield)];
    tfBusinessCountry.leftViewMode = UITextFieldViewModeAlways;
    
    //  city
    lbBusinessCity.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Province/ City"];
    [lbBusinessCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotBusinessCountry.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotBusinessCountry);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBusinessCity.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Choose province/ city"];
    [tfBusinessCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessCity.mas_bottom);
        make.left.right.equalTo(lbBusinessCity);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBusinessBotCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBusinessCity.mas_bottom);
        make.left.right.equalTo(tfBusinessCity);
        make.height.mas_equalTo(1);
    }];
    
    [btnChooseBusinessCity setTitle:@"" forState:UIControlStateNormal];
    [btnChooseBusinessCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfBusinessCity);
    }];
    
    [imgBusinessCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfBusinessCity).offset(-3.0);
        make.centerY.equalTo(tfBusinessCity.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    
    btnContinue.titleLabel.font = mediumFont;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.cornerRadius = 8.0;
    [btnContinue setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Continue"]
                 forState:UIControlStateNormal];
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessBotCity.mas_bottom).offset(2*paddingY);
        make.left.right.equalTo(lbBusinessBotCity);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbBusinessName.font = lbTaxCode.font = lbBusinessAddr.font = lbBusinessPhone.font = lbBusinessCountry.font = lbBusinessCity.font = mediumFont;
    tfBusinessName.font = tfTaxCode.font = tfBusinessAddr.font = tfBusinessPhone.font = tfBusinessCountry.font = tfBusinessCity.font = textFont;
    
    lbHeader.textColor = lbBusinessName.textColor = lbTaxCode.textColor = lbBusinessAddr.textColor = lbBusinessPhone.textColor = lbBusinessCountry.textColor = lbBusinessCity.textColor = GRAY_50;
    
    lbBotBusinessName.backgroundColor = lbBotTaxCode.backgroundColor = lbBotBusinessAddr.backgroundColor = lbBotBusinessPhone.backgroundColor = lbBusinessBotCity.backgroundColor = lbBotBusinessCountry.backgroundColor = GRAY_220;
    
    float hContentView = (hStatus + hNav) + 60.0 + padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + 2*paddingY + hBTN + 2*paddingY;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContentView-(hStatus + hNav));
    
    //  setup for personal scrollview
    [scvPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(2.0);
        make.left.equalTo(self).offset(SCREEN_WIDTH);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [viewPersonalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvPersonal);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60.0);
    }];
    
    lbPersonalTitle.textColor = BLUE_COLOR;
    lbPersonalTitle.font = mediumFont;
    [lbPersonalTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPersonalTitle).offset(padding);
        make.right.equalTo(viewPersonalTitle).offset(-padding);
        make.bottom.equalTo(viewPersonalTitle);
        make.height.mas_equalTo(40.0);
    }];
    
    //  fullname
    lbFullname.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Registrant name"];
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewPersonalTitle.mas_bottom).offset(padding);
        make.left.equalTo(viewPersonalTitle).offset(padding);
        make.right.equalTo(viewPersonalTitle).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfFullname.returnKeyType = UIReturnKeyNext;
    tfFullname.delegate = self;
    tfFullname.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter registrant name"];
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
        make.right.equalTo(viewPersonalTitle.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbDOB.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Date of birth"];
    [lbDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbGender);
        make.left.equalTo(lbGender.mas_right).offset(padding);
        make.right.equalTo(viewPersonalTitle).offset(-padding);
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
        make.left.equalTo(icBack.mas_right).offset(5.0);
        make.top.bottom.equalTo(icMale);
    }];
    
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
    
    //  postition
    lbPostition.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Postition"];
    [lbPostition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotDOB.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfFullname);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPostition.returnKeyType = UIReturnKeyNext;
    tfPostition.delegate = self;
    tfPostition.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter postition"];
    [tfPostition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPostition.mas_bottom);
        make.left.right.equalTo(lbPostition);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotPPostition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPostition.mas_bottom);
        make.left.right.equalTo(tfPostition);
        make.height.mas_equalTo(1);
    }];
    
    //  passport
    lbPassport.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Passport"];
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPPostition.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPPostition);
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
    
    //  Email
    lbEmail.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Email"];
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPhoneNumber.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPhoneNumber);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfEmail.returnKeyType = UIReturnKeyNext;
    tfEmail.delegate = self;
    tfEmail.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter Email"];
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom);
        make.left.right.equalTo(lbEmail);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfEmail.mas_bottom);
        make.left.right.equalTo(tfEmail);
        make.height.mas_equalTo(1);
    }];
    
    //  country
    lbCountry.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Country"];
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotEmail.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotEmail);
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
    
    UIImageView *imgFlag2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flag_vietnam"]];
    [tfCountry addSubview: imgFlag2];
    [imgFlag2 mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    [imgCityArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfCity).offset(-3.0);
        make.centerY.equalTo(tfCity.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    
    //  textview content
    [self setContentForTextViewPolicyWithFont: [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2]];
    
    tvPolicy.editable = FALSE;
    tvPolicy.scrollEnabled = FALSE;
    tvPolicy.delegate = self;
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
    
    lbFullname.font = lbGender.font = lbDOB.font = lbPostition.font = lbPassport.font = lbPhoneNumber.font = lbEmail.font = lbCountry.font = lbCity.font = mediumFont;
    tfFullname.font = lbMale.font = lbFemale.font = tfDOB.font = tfPostition.font = tfPassport.font = tfPhoneNumber.font = tfEmail.font = tfCountry.font = tfCity.font = textFont;
    
    lbHeader.textColor = lbFullname.textColor = lbGender.textColor = lbDOB.textColor = lbPostition.textColor = lbPassport.textColor = lbPhoneNumber.textColor = lbEmail.textColor = lbCountry.textColor = lbCity.textColor = GRAY_50;
    
    lbBotFullname.backgroundColor = lbBotDOB.backgroundColor = lbBotPPostition.backgroundColor = lbBotPassport.backgroundColor = lbBotPhoneNumber.backgroundColor = lbBotEmail.backgroundColor = lbBotCountry.backgroundColor = lbBotCity.backgroundColor = GRAY_220;
    
    float hPersonal = 60.0 + padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + 80.0 + paddingY + hBTN + paddingY;
    
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hPersonal);
    
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
    
    [scvPersonal mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
    
    [scvPersonal mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
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

- (void)hideKeyboard {
    [self endEditing: TRUE];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if (scvPersonal.frame.origin.x == 0) {
        [scvPersonal mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(SCREEN_WIDTH);
        }];
        [UIView animateWithDuration:0.2 animations:^{
            [self layoutIfNeeded];
        }];
    }else{
        if ([delegate respondsToSelector:@selector(onBusinessViewBackClicked)]) {
            [delegate onBusinessViewBackClicked];
        }
    }
}

- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float wPopup = 300.0;
    if (!IS_IPHONE && !IS_IPOD) {
        wPopup = 500;
    }
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, SCREEN_HEIGHT-100)];
    popupView.delegate = self;
    [popupView showInView:[AppDelegate sharedInstance].window animated:TRUE];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [[AppDelegate sharedInstance].window makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business name"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [[AppDelegate sharedInstance].window makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business tax code"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddr.text]) {
        [[AppDelegate sharedInstance].window makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business address"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [[AppDelegate sharedInstance].window makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business phone number"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: businessCityCode]) {
        [[AppDelegate sharedInstance].window makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose city for business"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [scvPersonal mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
}

- (IBAction)btnChooseCityPress:(UIButton *)sender {
}

- (IBAction)btnChooseDOBPress:(UIButton *)sender {
}

#pragma mark - City popup delegate
-(void)choosedCity:(CityObject *)city {
    tfBusinessCity.text = city.name;
    businessCityCode = city.code;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfBusinessName) {
        [tfTaxCode becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfBusinessAddr becomeFirstResponder];
        
    }else if (textField == tfBusinessAddr) {
        [tfBusinessPhone becomeFirstResponder];
        
    }else if (textField == tfBusinessPhone) {
        [self endEditing: TRUE];
        
    }
    else if (textField == tfFullname) {
        [tfPostition becomeFirstResponder];

    }else if (textField == tfPostition) {
        [tfPassport becomeFirstResponder];

    }else if (textField == tfPassport) {
        [tfPhoneNumber becomeFirstResponder];

    }else if (textField == tfPhoneNumber) {
        [tfEmail becomeFirstResponder];

    }
//    else if (textField == tfEmail) {
//        [tfPerAddress becomeFirstResponder];
//
//    }else if (textField == tfPerAddress) {
//        [self closeKyboard];
//    }
    return TRUE;
}

@end
