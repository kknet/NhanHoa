//
//  UpdateNewBusinessProfileView.m
//  NhanHoa
//
//  Created by OS on 11/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateNewBusinessProfileView.h"

@implementation UpdateNewBusinessProfileView

@synthesize viewMenu, btnRegistrantInfo, btnBusinessInfo, lbMenuActive;

@synthesize scvBusiness, lbBusinessName, tfBusinessName, lbBotBusinessName, lbTaxCode, tfTaxCode, lbBotTaxCode, lbBusinessAddr, tfBusinessAddr, lbBotBusinessAddr, lbBusinessPhone, tfBusinessPhone, lbBotBusinessPhone, lbBusinessCountry, tfBusinessCity, lbBotBusinessCountry, lbBusinessCity, tfBusinessCountry, lbBusinessBotCity, imgBusinessCity, btnChooseBusinessCity, btnSaveInfo;

@synthesize scvRegistrant, lbFullname, tfFullname, lbBotFullname, lbGender, icMale, lbMale, icFemale, lbFemale, lbDOB, tfDOB, lbBotDOB, btnChooseDOB, lbPostition, tfPostition, lbBotPPostition, lbPassport, tfPassport, lbBotPassport, lbPhoneNumber, tfPhoneNumber, lbBotPhoneNumber, lbEmail, tfEmail, lbBotEmail, btnSaveRegistrantInfo, lbAddress, tfAddress, lbBotAddress;
@synthesize datePicker, toolBar, viewDatePicker, lbBGPicker;

@synthesize padding, gender, cityCode, delegate;

- (void)activeRegistrantMenu: (BOOL)select {
    if (select) {
        [btnRegistrantInfo setTitleColor:GRAY_50 forState:UIControlStateNormal];
        [btnBusinessInfo setTitleColor:GRAY_150 forState:UIControlStateNormal];
        
        [lbMenuActive mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewMenu).offset(padding);
        }];
    }else{
        [btnBusinessInfo setTitleColor:GRAY_50 forState:UIControlStateNormal];
        [btnRegistrantInfo setTitleColor:GRAY_150 forState:UIControlStateNormal];
        
        [lbMenuActive mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewMenu).offset(SCREEN_WIDTH/2 + padding/2);
        }];
    }
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)hideKeyboard {
    [self endEditing: TRUE];
}

- (void)setupUIForView {
    //  Add action to hide keyboard when tap on screen
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapOnScreen.delegate = self;
    [self addGestureRecognizer: tapOnScreen];
    //  -----
    
    self.clipsToBounds = TRUE;
    
    padding = 15.0;
    float paddingY = 25.0;
    float hBTN = 53.0;
    float hLabel = 25.0;
    float hTextfield = 50.0;
    
    UIFont *mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        mediumFont = [UIFont fontWithName:RobotoMedium size:16.0];
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        hTextfield = 40.0;
        paddingY = 20.0;
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        mediumFont = [UIFont fontWithName:RobotoMedium size:18.0];
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hTextfield = 40.0;
        paddingY = 20.0;
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hTextfield = 50.0;
        paddingY = 25.0;
        
        hBTN = 53.0;
    }
    
    //  scrollview content
    viewMenu.clipsToBounds = TRUE;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(50.0);
    }];
    [AppUtils addBoxShadowForView:viewMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    lbMenuActive.backgroundColor = [UIColor colorWithRed:(41/255.0) green:(155/255.0)
                                                    blue:(218/255.0) alpha:1.0];
    [lbMenuActive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(padding);
        make.bottom.equalTo(viewMenu);
        make.width.mas_equalTo((SCREEN_WIDTH - 3*padding)/2);
        make.height.mas_equalTo(3.0);
    }];
    
    [btnRegistrantInfo setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Registrant"]
                       forState:UIControlStateNormal];
    btnRegistrantInfo.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnRegistrantInfo setTitleColor:GRAY_50 forState:UIControlStateNormal];
    [btnRegistrantInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(viewMenu);
        make.right.equalTo(viewMenu.mas_centerX);
        make.bottom.equalTo(lbMenuActive.mas_top);
    }];
    
    [btnBusinessInfo setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Business"]
                     forState:UIControlStateNormal];
    btnBusinessInfo.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnBusinessInfo setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnBusinessInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnRegistrantInfo);
        make.left.equalTo(viewMenu.mas_centerX);
        make.right.equalTo(viewMenu);
    }];
    [self activeRegistrantMenu: TRUE];
    
    scvBusiness.hidden = TRUE;
    [scvBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(7.0);
        make.left.right.bottom.equalTo(self);
    }];
    
    //  business name
    lbBusinessName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Business name"];
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvBusiness).offset(padding);
        make.left.equalTo(scvBusiness).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
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
    tfBusinessCountry.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Viet Nam"];
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
    
    btnSaveInfo.titleLabel.font = mediumFont;
    btnSaveInfo.backgroundColor = BLUE_COLOR;
    btnSaveInfo.layer.cornerRadius = 8.0;
    [btnSaveInfo setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Save info"]
                 forState:UIControlStateNormal];
    [btnSaveInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSaveInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusinessBotCity.mas_bottom).offset(2*paddingY);
        make.left.right.equalTo(lbBusinessBotCity);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbBusinessName.font = lbTaxCode.font = lbBusinessAddr.font = lbBusinessPhone.font = lbBusinessCountry.font = lbBusinessCity.font = mediumFont;
    tfBusinessName.font = tfTaxCode.font = tfBusinessAddr.font = tfBusinessPhone.font = tfBusinessCountry.font = tfBusinessCity.font = textFont;
    
    lbBusinessName.textColor = lbTaxCode.textColor = lbBusinessAddr.textColor = lbBusinessPhone.textColor = lbBusinessCountry.textColor = lbBusinessCity.textColor = GRAY_50;
    tfBusinessName.textColor = tfTaxCode.textColor = tfBusinessAddr.textColor = tfBusinessPhone.textColor = tfBusinessCountry.textColor = tfBusinessCity.textColor = GRAY_80;
    
    lbBotBusinessName.backgroundColor = lbBotTaxCode.backgroundColor = lbBotBusinessAddr.backgroundColor = lbBotBusinessPhone.backgroundColor = lbBusinessBotCity.backgroundColor = lbBotBusinessCountry.backgroundColor = GRAY_220;
    
    float hContentView = padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + 2*paddingY + hBTN;
    if ([AppDelegate sharedInstance].safeAreaBottomPadding == 0) {
        hContentView += 2*paddingY;
    }
    
    scvBusiness.contentSize = CGSizeMake(SCREEN_WIDTH, hContentView);
    
    //  setup for registrant scrollview
    scvRegistrant.hidden = FALSE;
    [scvRegistrant mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(7.0);
        make.left.right.bottom.equalTo(self);
    }];
    
    //  fullname
    lbFullname.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Registrant name"];
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvRegistrant).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
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
        make.right.equalTo(lbFullname.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbDOB.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Date of birth"];
    [lbDOB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbGender);
        make.left.equalTo(lbGender.mas_right).offset(padding);
        make.right.equalTo(lbFullname);
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
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMaleGender)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    lbMale.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Male"];
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icMale.mas_right).offset(5.0);
        make.top.bottom.equalTo(icMale);
    }];
    
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMale.mas_right).offset(padding);
        make.top.bottom.equalTo(icMale);
        make.width.equalTo(icMale.mas_width);
    }];
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemaleGender)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    lbFemale.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Female"];
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.top.bottom.equalTo(icFemale);
    }];
    
    //  postition
    lbPostition.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Position"];
    [lbPostition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotDOB.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfFullname);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfPostition.returnKeyType = UIReturnKeyNext;
    tfPostition.delegate = self;
    tfPostition.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter position"];
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
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
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
    
    //  registrant address
    lbAddress.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Address"];
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotEmail.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfAddress.returnKeyType = UIReturnKeyDone;
    tfAddress.delegate = self;
    tfAddress.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter registrant's address"];
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAddress.mas_bottom);
        make.left.right.equalTo(lbAddress);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfAddress.mas_bottom);
        make.left.right.equalTo(tfAddress);
        make.height.mas_equalTo(1);
    }];
    
    btnSaveRegistrantInfo.titleLabel.font = mediumFont;
    btnSaveRegistrantInfo.backgroundColor = BLUE_COLOR;
    btnSaveRegistrantInfo.layer.cornerRadius = 8.0;
    [btnSaveRegistrantInfo setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Save info"]
                           forState:UIControlStateNormal];
    [btnSaveRegistrantInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSaveRegistrantInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotAddress.mas_bottom).offset(2*paddingY);
        make.left.right.equalTo(lbBotAddress);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbFullname.font = lbGender.font = lbDOB.font = lbPostition.font = lbPassport.font = lbPhoneNumber.font = lbEmail.font = lbAddress.font = mediumFont;
    tfFullname.font = lbMale.font = lbFemale.font = tfDOB.font = tfPostition.font = tfPassport.font = tfPhoneNumber.font = tfEmail.font = tfAddress.font = textFont;
    
    lbFullname.textColor = lbGender.textColor = lbDOB.textColor = lbPostition.textColor = lbPassport.textColor = lbPhoneNumber.textColor = lbEmail.textColor = lbAddress.textColor = GRAY_50;
    tfFullname.textColor = lbMale.textColor = lbFemale.textColor = tfDOB.textColor = tfPostition.textColor = tfPassport.textColor = tfPhoneNumber.textColor = tfEmail.textColor = tfAddress.textColor = GRAY_80;
    
    lbBotFullname.backgroundColor = lbBotDOB.backgroundColor = lbBotPPostition.backgroundColor = lbBotPassport.backgroundColor = lbBotPhoneNumber.backgroundColor = lbBotEmail.backgroundColor = lbBotAddress.backgroundColor = GRAY_220;
    
    float hPersonal = padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + 2*paddingY + hBTN;
    if ([AppDelegate sharedInstance].safeAreaBottomPadding == 0) {
        hPersonal += 2*paddingY;
    }
    
    scvRegistrant.contentSize = CGSizeMake(SCREEN_WIDTH, hPersonal);
    
    //  Add datepicker
    [self addDatePickerForViewWithFont: textFont];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


- (void)keyboardDidShow:(NSNotification *)notif {
    [self closePickerView];
    
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvBusiness mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
    
    [scvRegistrant mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [scvBusiness mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
    
    [scvRegistrant mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
}

- (IBAction)btnRegistrantInfoPress:(UIButton *)sender {
    [self activeRegistrantMenu: TRUE];
    
    scvRegistrant.hidden = FALSE;
    scvBusiness.hidden = TRUE;
}

- (IBAction)btnBusinessInfoPress:(UIButton *)sender {
    [self activeRegistrantMenu: FALSE];
    
    scvRegistrant.hidden = TRUE;
    scvBusiness.hidden = FALSE;
}

- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMaleGender];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemaleGender];
}

- (IBAction)btnChooseDOBPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
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
    if (![AppUtils isNullOrEmpty:  tfDOB.text]) {
        NSDate *bodDate = [AppUtils convertStringToDate: tfDOB.text];
        if (bodDate != nil) {
            datePicker.date = bodDate;
        }else{
            datePicker.date = [NSDate date];
        }
    }else{
        datePicker.date = [NSDate date];
    }
    
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewDatePicker);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewDatePicker);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        datePicker.maximumDate = [NSDate date];
        if (hPickerView == 0) {
            viewDatePicker.hidden = TRUE;
        }else{
            viewDatePicker.hidden = FALSE;
        }
    }];
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

- (IBAction)btnSaveRegistrantPress:(UIButton *)sender {
    [self startToCheckAndUpdateProfileInformation];
}

- (IBAction)btnSaveInfoPress:(UIButton *)sender {
    [self startToCheckAndUpdateProfileInformation];
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

- (void)displayBusinessProfileInfo
{
    //  display registrant info
    tfFullname.text = [AccountModel getCusRealName];
    
    gender = [AccountModel getCusGender];
    if (gender == type_men) {
        [icMale setImage:[UIImage imageNamed:@"ic_tick_active"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"ic_tick"] forState:UIControlStateNormal];

    }else {
        [icMale setImage:[UIImage imageNamed:@"ic_tick"] forState:UIControlStateNormal];
        [icFemale setImage:[UIImage imageNamed:@"ic_tick_active"] forState:UIControlStateNormal];
    }

    tfDOB.text = [AccountModel getCusBirthday];
    tfPostition.text = [AccountModel getCusCompanyPosition];
    tfPassport.text = [AccountModel getCusPassport];
    tfPhoneNumber.text = [AccountModel getCusPhone];
    tfAddress.text = [AccountModel getCusAddress];
    tfEmail.text = [AccountModel getCusEmail];
    
    tfBusinessName.text = [AccountModel getCusCompanyName];
    tfTaxCode.text = [AccountModel getCusCompanyTax];
    tfBusinessAddr.text = [AccountModel getCusCompanyAddress];
    tfBusinessPhone.text = [AccountModel getCusCompanyPhone];
    
    cityCode = [AccountModel getCusCityCode];
    NSString *cityName = [[AppDelegate sharedInstance] findCityObjectWithCityCode: cityCode];
    tfBusinessCity.text = (![AppUtils isNullOrEmpty: cityName]) ? cityName : @"";
}

- (void)addDatePickerForViewWithFont: (UIFont *)textFont
{
    viewDatePicker = [[UIView alloc] init];
    viewDatePicker.hidden = TRUE;
    viewDatePicker.backgroundColor = UIColor.clearColor;
    [[AppDelegate sharedInstance].window addSubview: viewDatePicker];
    [viewDatePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo([AppDelegate sharedInstance].window);
    }];
    
    lbBGPicker = [[UILabel alloc] init];
    lbBGPicker.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [viewDatePicker addSubview: lbBGPicker];
    [lbBGPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewDatePicker);
    }];
    
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    datePicker.backgroundColor = UIColor.whiteColor;
    [datePicker setValue:BLUE_COLOR forKey:@"textColor"];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [viewDatePicker addSubview: datePicker];
    [datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewDatePicker);
        make.height.mas_equalTo(0);
    }];
    
    toolBar = [[UIView alloc] init];
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [viewDatePicker addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewDatePicker);
        make.bottom.equalTo(datePicker.mas_top);
        make.height.mas_equalTo(0);
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
    [btnChoose setTitle:text_choose forState:UIControlStateNormal];
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
}

- (void)chooseDatePicker {
    [self closePickerView];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/YYYY"];
    
    tfDOB.text = [dateFormatter stringFromDate:datePicker.date];
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
    }completion:^(BOOL finished) {
        viewDatePicker.hidden = TRUE;
    }];
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
    if (textField == tfFullname) {
        [tfPostition becomeFirstResponder];
        
    }else if (textField == tfPostition) {
        [tfPassport becomeFirstResponder];
        
    }else if (textField == tfPassport) {
        [tfPhoneNumber becomeFirstResponder];
        
    }else if (textField == tfPhoneNumber) {
        [tfEmail becomeFirstResponder];
        
    }else if (textField == tfEmail) {
        [tfAddress becomeFirstResponder];
        
    }else if (textField == tfAddress) {
        [self endEditing: TRUE];
        
    }else if (textField == tfBusinessName) {
        [tfTaxCode becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfBusinessAddr becomeFirstResponder];
        
    }else if (textField == tfBusinessAddr) {
        [tfBusinessPhone becomeFirstResponder];
        
    }else if (textField == tfBusinessPhone) {
        [self endEditing: TRUE];
    }
    return TRUE;
}

- (void)startToCheckAndUpdateProfileInformation
{
    //  check registration info
    if ([AppUtils isNullOrEmpty: tfFullname.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant name"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfDOB.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose registrant's date of birth"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPostition.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant position"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant passport"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhoneNumber.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant phone number"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfAddress.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant address"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    //  check business info
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business name"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business tax code"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddr.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business address"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter business phone number"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cityCode]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose city for business"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating..."] Interaction:NO];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSNumber numberWithInt:type_business] forKey:@"own_type"];
    
    //  set business info
    [info setObject:tfBusinessName.text forKey:@"tc_tc_name"];
    [info setObject:tfTaxCode.text forKey:@"tc_tc_mst"];
    [info setObject:tfBusinessAddr.text forKey:@"tc_tc_address"];
    [info setObject:tfBusinessPhone.text forKey:@"tc_tc_phone"];
    [info setObject:COUNTRY_CODE forKey:@"tc_tc_country"];
    [info setObject:cityCode forKey:@"tc_tc_city"];
    
    //  set registrant info
    [info setObject:tfPostition.text forKey:@"cn_position"];
    [info setObject:tfFullname.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfEmail.text forKey:@"cn_email"];
    [info setObject:tfDOB.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhoneNumber.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    
    [info setObject:edit_profile_mod forKey:@"mod"];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateAccountProfileWithInfo: info];
}

#pragma mark - WebserviceUtil Delegate
-(void)failedToUpdateAccountInfoWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self performSelector:@selector(updateFailed) withObject:nil afterDelay:2.0];
}

-(void)updateAccountInfoSuccessfulWithData:(NSDictionary *)data {
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

-(void)failedToLoginWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your info has been updated successfully"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    
    [self performSelector:@selector(updateSuccessfully) withObject:nil afterDelay:2.0];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your info has been updated successfully"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    
    [self performSelector:@selector(updateSuccessfully) withObject:nil afterDelay:2.0];
}

- (void)updateSuccessfully {
    if ([delegate respondsToSelector:@selector(updateBusinessProfileInfoSuccessfully)]) {
        [delegate updateBusinessProfileInfoSuccessfully];
    }
}

- (void)updateFailed {
    if ([delegate respondsToSelector:@selector(updateBusinessProfileInfoFailed)]) {
        [delegate updateBusinessProfileInfoFailed];
    }
}

#pragma mark - City popup delegate
-(void)choosedCity:(CityObject *)city {
    tfBusinessCity.text = city.name;
    cityCode = city.code;
}


@end
