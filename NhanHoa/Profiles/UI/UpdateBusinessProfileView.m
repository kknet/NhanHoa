//
//  UpdateBusinessProfileView.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateBusinessProfileView.h"
#import "UploadPicture.h"

@implementation UpdateBusinessProfileView

@synthesize viewMenu, btnBusinessInfo, btnRegistrantInfo, lbMenuActive;
@synthesize scvBusiness, lbBusinessName, tfBusinessName, lbBotBusinessName, lbTaxCode, tfTaxCode, lbBotTaxCode, lbBusinessAddr, tfBusinessAddr, lbBotBusinessAddr, lbBusinessPhone, tfBusinessPhone, lbBotBusinessPhone, lbBusinessCountry, tfBusinessCity, lbBotBusinessCountry, lbBusinessCity, tfBusinessCountry, lbBusinessBotCity, imgBusinessCity, btnChooseBusinessCity, btnSaveInfo;

@synthesize scvRegistrant, lbFullname, tfFullname, lbBotFullname, lbGender, icMale, lbMale, icFemale, lbFemale, lbDOB, tfDOB, lbBotDOB, btnChooseDOB, lbPostition, tfPostition, lbBotPPostition, lbPassport, tfPassport, lbBotPassport, lbPhoneNumber, tfPhoneNumber, lbBotPhoneNumber, lbEmail, tfEmail, lbBotEmail, btnSaveRegistrantInfo, lbAddress, tfAddress, lbBotAddress, imgFront, lbFront, imgBackside, lbBackside;

@synthesize padding, businessCity, gender, linkFrontPassport, linkBacksidePassport, delegate, datePicker, toolBar, typeOfView;

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
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hTextfield = 50.0;
        paddingY = 25.0;
        
        hBTN = 55.0;
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
    
    float hContentView = padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + 2*paddingY + hBTN + 2*paddingY;
    
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
    
    //  passport
    lbFront.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Passport's front"];
    [lbFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotAddress.mas_bottom).offset(paddingY);
        make.left.equalTo(lbBotAddress);
        make.right.equalTo(lbBotAddress.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    float hPassport = (SCREEN_WIDTH -3*padding)/2 * 2/3;
    
    //  tap to change photo
    UITapGestureRecognizer *tapOnFront = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnFrontImage)];
    imgFront.userInteractionEnabled = TRUE;
    [imgFront addGestureRecognizer: tapOnFront];
    
    [imgFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFront.mas_bottom);
        make.left.right.equalTo(lbFront);
        make.height.mas_equalTo(hPassport);
    }];
    
    lbBackside.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Passport's backside"];
    [lbBackside mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbFront);
        make.left.equalTo(lbFront.mas_right).offset(padding);
        make.right.equalTo(lbFullname);
    }];
    
    //  tap to change photo
    UITapGestureRecognizer *tapOnBackside = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBacksideImage)];
    imgBackside.userInteractionEnabled = TRUE;
    [imgBackside addGestureRecognizer: tapOnBackside];
    
    [imgBackside mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbBackside);
        make.top.bottom.equalTo(imgFront);
    }];
    
    btnSaveRegistrantInfo.titleLabel.font = mediumFont;
    btnSaveRegistrantInfo.backgroundColor = BLUE_COLOR;
    btnSaveRegistrantInfo.layer.cornerRadius = 8.0;
    [btnSaveRegistrantInfo setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Save info"]
                           forState:UIControlStateNormal];
    [btnSaveRegistrantInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSaveRegistrantInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgFront.mas_bottom).offset(2*paddingY);
        make.left.right.equalTo(lbBotAddress);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbFullname.font = lbGender.font = lbDOB.font = lbPostition.font = lbPassport.font = lbPhoneNumber.font = lbEmail.font = lbAddress.font = lbFront.font = lbBackside.font = mediumFont;
    tfFullname.font = lbMale.font = lbFemale.font = tfDOB.font = tfPostition.font = tfPassport.font = tfPhoneNumber.font = tfEmail.font = tfAddress.font = textFont;
    
    lbFullname.textColor = lbGender.textColor = lbDOB.textColor = lbPostition.textColor = lbPassport.textColor = lbPhoneNumber.textColor = lbEmail.textColor = lbAddress.textColor = lbFront.textColor = lbBackside.textColor = GRAY_50;
    tfFullname.textColor = lbMale.textColor = lbFemale.textColor = tfDOB.textColor = tfPostition.textColor = tfPassport.textColor = tfPhoneNumber.textColor = tfEmail.textColor = tfAddress.textColor = GRAY_80;
    
    lbBotFullname.backgroundColor = lbBotDOB.backgroundColor = lbBotPPostition.backgroundColor = lbBotPassport.backgroundColor = lbBotPhoneNumber.backgroundColor = lbBotEmail.backgroundColor = lbBotAddress.backgroundColor = GRAY_220;
    
    float hPersonal = padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hPassport) + 2*paddingY + hBTN + 2*paddingY;
    
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

- (void)addDatePickerForViewWithFont: (UIFont *)textFont {
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
    
    tfDOB.text = [dateFormatter stringFromDate:datePicker.date];
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

- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    float realHeight = SCREEN_HEIGHT - ([UIApplication sharedApplication].statusBarFrame.size.height + 50.0);
    float wPopup = 300.0;
    if (!IS_IPHONE && !IS_IPOD) {
        wPopup = 500;
    }
    
    ChooseCityPopupView *popupView = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, 50, wPopup, realHeight-100)];
    popupView.delegate = self;
    [popupView showInView:self animated:TRUE];
}

- (IBAction)btnSaveInfoBusinessPress:(UIButton *)sender {
    [self checkToUpdateBusinessProfile];
}

- (IBAction)btnSaveRegistrantInfoPress:(UIButton *)sender {
    [self checkToUpdateBusinessProfile];
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


- (void)displayInfoForProfileWithInfo: (NSDictionary *)info
{
    //  display business informations
    
    NSString *company = [info objectForKey:@"cus_company"];
    tfBusinessName.text = (![AppUtils isNullOrEmpty: company])? company : @"";
    
    NSString *taxcode = [info objectForKey:@"cus_taxcode"];
    tfTaxCode.text = (![AppUtils isNullOrEmpty: taxcode])? taxcode : @"";
    
    NSString *company_address = [info objectForKey:@"cus_company_address"];
    tfBusinessAddr.text = (![AppUtils isNullOrEmpty: company_address])? company_address : @"";
    
    NSString *company_phone = [info objectForKey:@"cus_company_phone"];
    tfBusinessPhone.text = (![AppUtils isNullOrEmpty: company_phone])? company_phone : @"";
    
    NSString *cus_city = [info objectForKey:@"cus_city"];
    if (![AppUtils isNullOrEmpty: cus_city]) {
        businessCity = cus_city;
        tfBusinessCity.text = [[AppDelegate sharedInstance] findCityObjectWithCityCode: cus_city];
    }else{
        businessCity = @"";
        tfBusinessCity.text = @"";
    }
    
    //  registrant informations
    NSString *cus_realname = [info objectForKey:@"cus_realname"];
    tfFullname.text = (![AppUtils isNullOrEmpty: cus_realname])? cus_realname : @"";
    
    NSString *cus_birthday = [info objectForKey:@"cus_birthday"];
    tfDOB.text = (![AppUtils isNullOrEmpty: cus_birthday])? cus_birthday : @"";
    
    NSString *gender = [info objectForKey:@"cus_gender"];
    if ([gender isEqualToString:@"1"]) {
        [self selectMaleGender];
    }else{
        [self selectFemaleGender];
    }
    
    NSString *cus_position = [info objectForKey:@"cus_position"];
    tfPostition.text = (![AppUtils isNullOrEmpty: cus_position])? cus_position : @"";
    
    NSString *cus_idcard_number = [info objectForKey:@"cus_idcard_number"];
    tfPassport.text = (![AppUtils isNullOrEmpty: cus_idcard_number])? cus_idcard_number : @"";
    
    NSString *cus_phone = [info objectForKey:@"cus_phone"];
    tfPhoneNumber.text = (![AppUtils isNullOrEmpty: cus_phone])? cus_phone : @"";
    
    NSString *email = [info objectForKey:@"cus_rl_email"];
    tfEmail.text = (![AppUtils isNullOrEmpty: email])? email : @"";
    
    NSString *cus_address = [info objectForKey:@"cus_address"];
    tfAddress.text = (![AppUtils isNullOrEmpty: cus_address])? cus_address : @"";
    
    //  cmnd mat truoc
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        imgFront.image = [AppDelegate sharedInstance].editCMND_a;
    }else{
        NSString *cmnd_a = [info objectForKey:@"cmnd_a"];
        if (![AppUtils isNullOrEmpty: cmnd_a]) {
            [imgFront sd_setImageWithURL:[NSURL URLWithString:cmnd_a] placeholderImage:FRONT_EMPTY_IMG];
        }else{
            imgFront.image = FRONT_EMPTY_IMG;
        }
    }

    //  cmnd mat sau
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        imgBackside.image = [AppDelegate sharedInstance].editCMND_b;
    }else{
        NSString *cmnd_b = [info objectForKey:@"cmnd_b"];
        if (![AppUtils isNullOrEmpty: cmnd_b]) {
            [imgBackside sd_setImageWithURL:[NSURL URLWithString:cmnd_b] placeholderImage:BEHIND_EMPTY_IMG];
            linkBacksidePassport = cmnd_b;
        }else{
            imgBackside.image = BEHIND_EMPTY_IMG;
            linkBacksidePassport = @"";
        }
    }
}

- (void)saveAllValueBeforeChangeView {
    //  business info
    
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessName.text forKey:@"cus_company"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfTaxCode.text forKey:@"cus_taxcode"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessAddr.text forKey:@"cus_company_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessPhone.text forKey:@"cus_company_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfFullname.text forKey:@"cus_realname"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfDOB.text forKey:@"cus_birthday"];
    [[AppDelegate sharedInstance].profileEdit setObject:[NSString stringWithFormat:@"%d", gender] forKey:@"cus_gender"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPostition.text forKey:@"cus_position"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPassport.text forKey:@"cus_idcard_number"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPhoneNumber.text forKey:@"cus_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfEmail.text forKey:@"cus_rl_email"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfAddress.text forKey:@"cus_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:businessCity forKey:@"cus_city"];
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

- (void)whenTapOnFrontImage {
    if ([delegate respondsToSelector:@selector(clickOnFrontBusinessProfile)]) {
        [delegate clickOnFrontBusinessProfile];
    }
}

- (void)whenTapOnBacksideImage {
    if ([delegate respondsToSelector:@selector(clickOnBacksideBusinessProfile)]) {
        [delegate clickOnBacksideBusinessProfile];
    }
}

- (void)checkToUpdateBusinessProfile {
    [self endEditing: TRUE];
    
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
    
    if ([AppUtils isNullOrEmpty: businessCity]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please choose city for business"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    //  check registration infor
    
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
    
    if ([AppUtils isNullOrEmpty: tfEmail.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant email"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfAddress.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter registrant address"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (typeOfView == eAddNewBusinessProfile) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Adding..."] Interaction:NO];
    }else{
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating..."] Interaction:NO];
    }
    
    if ([AppDelegate sharedInstance].editCMND_a != nil || [AppDelegate sharedInstance].editCMND_b != nil) {
        [self startUploadPassportPictures];
    }else{
        linkFrontPassport = linkBacksidePassport = @"";
        
        [self startUpdateProfileForBusiness];
    }
}

- (void)startUploadPassportPictures {
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [AppDelegate sharedInstance].editCMND_a = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_a];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_a);
        
        NSString *imageName = SFM(@"%@_front_%@", [AppUtils getCurrentDateTime], [AccountModel getCusIdOfUser]);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                    {
                        linkFrontPassport = @"";
                    }else{
                        linkFrontPassport = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    
                    [self startUploadPassportBehindPictures];
                });
            }];
        });
    }else{
        linkFrontPassport = @"";

        [self startUploadPassportBehindPictures];
    }
}

- (void)startUploadPassportBehindPictures {
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [AppDelegate sharedInstance].editCMND_b = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_b];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_b);
        
        NSString *imageName = SFM(@"%@_behind_%@", [AppUtils getCurrentDateTime], [AccountModel getCusIdOfUser]);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                    {
                        linkBacksidePassport = @"";
                    }else{
                        linkBacksidePassport = SFM(@"%@/%@", link_upload_photo, uploadSession.namePicture);
                    }
                    [self startUpdateProfileForBusiness];
                });
            }];
        });
    }else{
        linkBacksidePassport = @"";
        
        [self startUpdateProfileForBusiness];
    }
}

- (void)startUpdateProfileForBusiness {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    
    [info setObject:[NSNumber numberWithInt:type_business] forKey:@"own_type"];
    //  business info
    [info setObject:tfBusinessName.text forKey:@"tc_tc_name"];
    [info setObject:tfTaxCode.text forKey:@"tc_tc_mst"];
    [info setObject:tfBusinessAddr.text forKey:@"tc_tc_address"];
    [info setObject:tfBusinessPhone.text forKey:@"tc_tc_phone"];
    [info setObject:COUNTRY_CODE forKey:@"tc_tc_country"];
    [info setObject:businessCity forKey:@"tc_tc_city"];
    
    //  personal info
    [info setObject:tfPostition.text forKey:@"cn_position"];
    [info setObject:tfFullname.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfDOB.text forKey:@"cn_birthday"];
    
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhoneNumber.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    [info setObject:linkFrontPassport forKey:@"cmnd_a"];
    [info setObject:linkBacksidePassport forKey:@"cmnd_b"];
    [info setObject:tfEmail.text forKey:@"cn_email"];
    
    if (typeOfView == eAddNewBusinessProfile) {
        [info setObject:add_contact_mod forKey:@"mod"];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] addProfileWithContent: info];
        
    }else{
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

-(void)failedToEditProfileWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    if ([delegate respondsToSelector:@selector(failedToUpdateBusinessProfileWithError:)]) {
        [delegate failedToUpdateBusinessProfileWithError: content];
    }
}

-(void)editProfileSuccessful {
    [ProgressHUD dismiss];
    if ([delegate respondsToSelector:@selector(updateBusinessProfileSuccessfully)]) {
        [delegate updateBusinessProfileSuccessfully];
    }
}

-(void)failedToAddProfileWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    if ([delegate respondsToSelector:@selector(failedToAddBusinessProfileWithError:)]) {
        [delegate failedToAddBusinessProfileWithError: content];
    }
}

-(void)addProfileSuccessful {
    [ProgressHUD dismiss];
    [AppDelegate sharedInstance].editCMND_a = [AppDelegate sharedInstance].editCMND_b = nil;
    if ([delegate respondsToSelector:@selector(addBusinessProfileSuccessfully)]) {
        [delegate addBusinessProfileSuccessfully];
    }
}

#pragma mark - ChooseCityPopupView
- (void)choosedCity:(CityObject *)city {
    businessCity = city.code;
    tfBusinessCity.text = city.name;
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

@end
