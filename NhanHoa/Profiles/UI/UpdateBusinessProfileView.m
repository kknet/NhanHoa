//
//  UpdateBusinessProfileView.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateBusinessProfileView.h"

@implementation UpdateBusinessProfileView

@synthesize viewMenu, btnBusinessInfo, btnRegistrantInfo, lbMenuActive;
@synthesize scvBusiness, lbBusinessName, tfBusinessName, lbBotBusinessName, lbTaxCode, tfTaxCode, lbBotTaxCode, lbBusinessAddr, tfBusinessAddr, lbBotBusinessAddr, lbBusinessPhone, tfBusinessPhone, lbBotBusinessPhone, lbBusinessCountry, tfBusinessCity, lbBotBusinessCountry, lbBusinessCity, tfBusinessCountry, lbBusinessBotCity, imgBusinessCity, btnChooseBusinessCity, btnSaveInfo;
@synthesize padding;

- (void)activeRegistrantMenu: (BOOL)select {
    if (select) {
        [btnRegistrantInfo setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        [btnBusinessInfo setTitleColor:GRAY_150 forState:UIControlStateNormal];
        
        [lbMenuActive mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewMenu).offset(padding);
            make.bottom.equalTo(viewMenu);
            make.width.mas_equalTo((SCREEN_WIDTH - 4*padding)/2);
            make.height.mas_equalTo(4.0);
        }];
    }else{
        [btnRegistrantInfo setTitleColor:GRAY_150 forState:UIControlStateNormal];
        [btnBusinessInfo setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
        
        [lbMenuActive mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(btnBusinessInfo).offset(padding);
            make.bottom.equalTo(viewMenu);
            make.width.mas_equalTo((SCREEN_WIDTH - 4*padding)/2);
            make.height.mas_equalTo(4.0);
        }];
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)setupUIForView {
    //  Add action to hide keyboard when tap on screen
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self addGestureRecognizer: tapOnScreen];
    //  -----
    
    self.clipsToBounds = TRUE;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
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
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        mediumFont = [UIFont fontWithName:RobotoMedium size:20.0];
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hTextfield = 50.0;
        paddingY = 25.0;
    }
    
    //  scrollview content
    viewMenu.clipsToBounds = TRUE;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(50.0);
    }];
    
    btnBusinessInfo.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnBusinessInfo setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btnBusinessInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(viewMenu);
        make.right.equalTo(viewMenu.mas_centerX);
    }];
    
    btnRegistrantInfo.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnRegistrantInfo setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnRegistrantInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu.mas_centerX);
        make.top.right.bottom.equalTo(viewMenu);
    }];
    [self activeRegistrantMenu: FALSE];
    
    
    [lbMenuActive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(padding);
        make.bottom.equalTo(viewMenu);
        make.width.mas_equalTo((SCREEN_WIDTH - 4*padding)/2);
        make.height.mas_equalTo(4.0);
    }];
    
    [scvBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom);
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
}


- (IBAction)btnRegistrantInfoPress:(UIButton *)sender {
    [self activeRegistrantMenu: TRUE];
}

- (IBAction)btnBusinessInfoPress:(UIButton *)sender {
    [self activeRegistrantMenu: FALSE];
}

- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender {
}

- (IBAction)btnSaveInfoBusinessPress:(UIButton *)sender {
}
@end
