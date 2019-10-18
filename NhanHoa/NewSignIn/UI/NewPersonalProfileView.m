//
//  NewPersonalProfileView.m
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewPersonalProfileView.h"

@implementation NewPersonalProfileView

@synthesize viewHeader, icBack, lbHeader, scvContent, viewTitle, lbTitle, lbFullname, tfFullname, lbBotFullname, lbGender, icMale, lbMale, icFemale, lbFemale, lbBirthday, tfBirthday, lbBotBirthday, lbPassport, tfPassport, lbBotPassport, lbPhoneNumber, tfPhoneNumber, lbBotPhoneNumber, lbPermanentAddr, tfPermanentAddr, lbBotPermanentAddr, lbCountry, tfCountry, lbBotCountry, lbCity, tfCity, lbBotCity, imgArrCity, btnChooseCity, tvPolicy, btnRegister;
@synthesize hContentView;

- (void)setupUIForViewWithHeightNav: (float)hNav {
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float padding = 15.0;
    float paddingY = 15.0;
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
    
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(hNav);
    }];
    
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.left.equalTo(viewHeader).offset(padding);
        make.width.height.mas_equalTo(40);
    }];
    
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  scrollview content
    float hLabel = 25.0;
    float hTextfield = 40.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(viewHeader);
    }];
    
    [viewTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(60.0);
    }];
    
    lbTitle.textColor = BLUE_COLOR;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewTitle).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
        make.bottom.equalTo(viewTitle);
        make.height.mas_equalTo(40.0);
    }];
    
    //  fullname
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTitle.mas_bottom).offset(padding);
        make.left.equalTo(viewTitle).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [tfFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFullname.mas_bottom);
        make.left.right.equalTo(lbFullname);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [lbBotFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfFullname.mas_bottom);
        make.left.right.equalTo(tfFullname);
        make.height.mas_equalTo(1);
    }];
    
    //  gender and birthday
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotFullname.mas_bottom).offset(paddingY);
        make.left.equalTo(lbBotFullname);
        make.right.equalTo(viewTitle.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbBirthday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbGender);
        make.left.equalTo(lbGender.mas_right).offset(padding);
        make.right.equalTo(viewTitle).offset(-padding);
    }];
    
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
    
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbGender);
        make.centerY.equalTo(tfBirthday.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icBack.mas_right).offset(5.0);
        make.top.bottom.equalTo(icMale);
    }];
    
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMale.mas_right).offset(padding);
        make.top.bottom.equalTo(icMale);
        make.width.equalTo(icMale.mas_width);
    }];
    
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.top.bottom.equalTo(icFemale);
    }];
    
    //  passport
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotBirthday.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfFullname);
        make.height.mas_equalTo(hLabel);
    }];
    
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
    [lbPhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPassport.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
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
    [lbPermanentAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPhoneNumber.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPhoneNumber);
        make.height.mas_equalTo(hLabel);
    }];
    
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
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotPermanentAddr.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotPermanentAddr);
        make.height.mas_equalTo(hLabel);
    }];
    
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
    
    //  city
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotCountry.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotCountry);
        make.height.mas_equalTo(hLabel);
    }];
    
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
    
    [btnChooseCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfCountry);
    }];
    
    //  textview content
    
    [tvPolicy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBotCity.mas_bottom).offset(paddingY);
        make.left.right.equalTo(lbBotCity);
        make.height.mas_equalTo(80.0);
    }];
    
    btnRegister.titleLabel.font = mediumFont;
    btnRegister.backgroundColor = BLUE_COLOR;
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tvPolicy.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tvPolicy);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbFullname.font = mediumFont;
    tfFullname.font = textFont;
    
    lbBotFullname.backgroundColor = GRAY_200;
    
    hContentView = (hStatus + hNav) + 60.0 + padding + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + (hLabel + hTextfield + 1.0) + paddingY + 80.0 + paddingY + hBTN + paddingY;
}

@end
