//
//  NewBusinessProfileView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewBusinessProfileView.h"
#import "UploadPicture.h"
#import "AccountModel.h"

@implementation NewBusinessProfileView

@synthesize scvContent, lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbInfoBusiness, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, lbCity, tfCity, btnCity, imgCity, lbInfoRegister, lbRegisterName, tfRegisterName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPosition, tfPosition, lbPassport, tfPassport, lbPhone, tfPhone, tfAddress, lbAddress, lbPerCountry, tfPerCountry, lbPerCity, tfPerCity, imgPerCityArrow, btnPerCity, viewPassport, lbPassportTitle, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, imgPassport, btnCancel, btnSave, btnBOD;

@synthesize padding, hLabel, mTop, delegate, businessCity, personalCity, gender, datePicker, toolBar, popupChooseCity, imgFront, linkFrontPassport, imgBehind, linkBehindPassport, webService;

- (void)setupUIForViewForAddProfile: (BOOL)isAddNew {
    padding = 15.0;
    hLabel = 30.0;
    mTop = 10.0;
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    lbTitle.font = lbInfoBusiness.font = lbInfoRegister.font = [AppDelegate sharedInstance].fontBold;
    
    lbVision.font = lbBusinessName.font = lbTaxCode.font = lbBusinessAddress.font = lbBusinessPhone.font = lbCountry.font = lbCity.font = lbRegisterName.font = lbGender.font = lbBOD.font = lbPosition.font = lbPassport.font = lbPhone.font = lbAddress.font = lbPerCountry.font = lbPerCity.font = [AppDelegate sharedInstance].fontMedium;
    
    lbPersonal.font = lbBusiness.font = tfBusinessName.font = tfTaxCode.font = tfBusinessAddress.font = tfBusinessPhone.font = tfCountry.font = tfCity.font = tfRegisterName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPosition.font = tfPassport.font = tfPhone.font = tfAddress.font = tfPerCountry.font = tfPerCity.font = [AppDelegate sharedInstance].fontRegular;
    
    lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbBusinessName.textColor = lbTaxCode.textColor = lbBusinessAddress.textColor = lbBusinessPhone.textColor = lbCountry.textColor = lbCity.textColor = lbRegisterName.textColor = lbPassport.textColor = lbPhone.textColor = lbAddress.textColor = lbPerCountry.textColor = lbPerCity.textColor = TITLE_COLOR;
    
    lbInfoBusiness.textColor = lbInfoRegister.textColor = BLUE_COLOR;
    
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    //  title
    float hTitle = 40.0;
    if (isAddNew) {
        hTitle = 0;
    }
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(hTitle);
    }];
    
    //  vision
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(40.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(self.hLabel);
    }];
    [icPersonal addTarget:self
                   action:@selector(whenTapOnPersonal)
         forControlEvents:UIControlEventTouchUpInside];
    
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  Add target for lbBusiness
    UITapGestureRecognizer *tapOnPersonal = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPersonal)];
    lbPersonal.userInteractionEnabled = TRUE;
    [lbPersonal addGestureRecognizer: tapOnPersonal];
    
    icBusiness.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icPersonal);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(self.icPersonal.mas_width);
    }];
    
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPersonal);
        make.left.equalTo(self.icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-self.padding);
    }];
    
    //  info for business
    [lbInfoBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPersonal.mas_bottom).offset(self.padding);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    //  business name
    [lbBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbInfoBusiness.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbInfoBusiness);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessName borderColor:BORDER_COLOR];
    [tfBusinessName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessName.mas_bottom);
        make.left.right.equalTo(self.lbBusinessName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessName.returnKeyType = UIReturnKeyNext;
    tfBusinessName.delegate = self;
    
    //  tax code
    [lbTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessName.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfBusinessName);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfTaxCode borderColor:BORDER_COLOR];
    [tfTaxCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTaxCode.mas_bottom);
        make.left.right.equalTo(self.lbTaxCode);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfTaxCode.returnKeyType = UIReturnKeyNext;
    tfTaxCode.delegate = self;
    
    //  business address
    [lbBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfTaxCode.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfTaxCode);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessAddress borderColor:BORDER_COLOR];
    [tfBusinessAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessAddress.mas_bottom);
        make.left.right.equalTo(self.lbBusinessAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessAddress.returnKeyType = UIReturnKeyNext;
    tfBusinessAddress.delegate = self;
    
    //  business phone
    [lbBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessAddress.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfBusinessAddress);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBusinessPhone borderColor:BORDER_COLOR];
    [tfBusinessPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusinessPhone.mas_bottom);
        make.left.right.equalTo(self.lbBusinessPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBusinessPhone.returnKeyType = UIReturnKeyNext;
    tfBusinessPhone.delegate = self;
    
    //  country and city
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBusinessPhone.mas_bottom).offset(self.mTop);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.mas_centerX).offset(-self.padding/2);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfCountry.enabled = FALSE;
    tfCountry.text = @"Việt nam";
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.right.equalTo(self.lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  city
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self).offset(-self.padding);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCity.mas_bottom);
        make.left.right.equalTo(self.lbCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    //  register infor
    [lbInfoRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfCountry.mas_bottom).offset(2*self.padding);
        make.left.right.equalTo(self.lbTitle);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    //  business name
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbInfoRegister.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbInfoRegister);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRegisterName borderColor:BORDER_COLOR];
    [tfRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterName.mas_bottom);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfRegisterName.returnKeyType = UIReturnKeyNext;
    tfRegisterName.delegate = self;
    
    //  birth day and gender
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfRegisterName.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self).offset(-self.padding);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    tfBOD.enabled = FALSE;
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD setTitle:@"" forState:UIControlStateNormal];
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfBOD);
    }];
    
    gender = type_men;
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.mas_centerX).offset(-self.padding/2);
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
    
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icFemale);
        make.left.equalTo(self.icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  position
    [lbPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBOD.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPosition borderColor:BORDER_COLOR];
    [tfPosition mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPosition.mas_bottom);
        make.left.right.equalTo(self.lbPosition);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPosition.returnKeyType = UIReturnKeyNext;
    tfPosition.delegate = self;
    
    //  Passport
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPosition.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPosition);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    
    //  Phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPassport);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    
    //  Address
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfAddress.returnKeyType = UIReturnKeyDone;
    tfAddress.delegate = self;
    
    //  country and city
    [lbPerCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(self.mTop);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.mas_centerX).offset(-self.padding/2);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPerCountry borderColor:BORDER_COLOR];
    tfPerCountry.backgroundColor = LIGHT_GRAY_COLOR;
    tfPerCountry.enabled = FALSE;
    tfPerCountry.text = @"Việt nam";
    [tfPerCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPerCountry.mas_bottom);
        make.left.right.equalTo(self.lbPerCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  city
    [lbPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPerCountry);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self).offset(-self.padding);
    }];
    
    [AppUtils setBorderForTextfield:tfPerCity borderColor:BORDER_COLOR];
    [tfPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPerCity.mas_bottom);
        make.left.right.equalTo(self.lbPerCity);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPerCityArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfPerCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfPerCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnPerCity setTitle:@"" forState:UIControlStateNormal];
    [btnPerCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfPerCity);
    }];
    
    //  view passport
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    float hViewPassport = mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel;
    
    [viewPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.tfPerCountry.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hViewPassport);
    }];
    
    [lbPassportTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewPassport).offset(self.padding + 20.0 + 10);
        make.top.right.equalTo(self.viewPassport).offset(self.mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewPassport).offset(self.padding);
        make.centerY.equalTo(self.lbPassportTitle.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    //  front image
    imgPassportFront.layer.cornerRadius = 5.0;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassportTitle.mas_bottom);
        make.left.equalTo(self.viewPassport).offset(self.padding);
        make.width.mas_equalTo(wPassport);
        make.height.mas_equalTo(hPassport);
    }];
    imgPassportFront.userInteractionEnabled = TRUE;
    UITapGestureRecognizer *tapOnFrontImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnFrontImage)];
    [imgPassportFront addGestureRecognizer: tapOnFrontImg];
    
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.imgPassportFront.mas_bottom);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    imgPassportBehind.layer.cornerRadius = imgPassportBehind.layer.cornerRadius;
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.imgPassportFront);
        make.left.equalTo(self.imgPassportFront.mas_right).offset(self.padding);
        make.width.equalTo(self.imgPassportFront.mas_width);
    }];
    imgPassportBehind.userInteractionEnabled = TRUE;
    UITapGestureRecognizer *tapOnBehindImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBehindImage)];
    [imgPassportBehind addGestureRecognizer: tapOnBehindImg];
    
    [lbPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.equalTo(self.imgPassportBehind.mas_bottom);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    btnCancel.layer.cornerRadius = 45.0/2;
    btnCancel.backgroundColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.viewPassport.mas_bottom).offset(2*self.padding);
        make.height.mas_equalTo(45.0);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.bottom.equalTo(self.btnCancel);
    }];
    
    //  Add datepicker
    [self addDatePickerForView];
    
    float hScrollView = hTitle + 40.0 + (mTop + hLabel) + (padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (2*padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + hViewPassport + 2*padding + 45.0 + 2*padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
    
    
    tfBusinessName.text = @"Thiền Nguyễn Company";
    tfTaxCode.text = @"MST_0123456";
    tfBusinessAddress.text = @"1020 Phạm Văn Đồng, P.Hiệp Bình Chánh";
    tfBusinessPhone.text = @"0932205601";
    tfRegisterName.text = @"Khải Le";
    tfPosition.text = @"Nhân viên";
    tfPassport.text = @"212456789";
    tfPhone.text = @"0363430737";
    tfAddress.text = @"1020 Phạm Văn Đồng";
    tfBOD.text = @"02/12/1991";
}

- (IBAction)btnSavePress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfBusinessName.text]) {
        [self makeToast:@"Bạn chưa nhập Tên doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTaxCode.text]) {
        [self makeToast:@"Bạn chưa nhập Mã số thuế!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessAddress.text]) {
        [self makeToast:@"Bạn chưa nhập Địa chỉ doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [self makeToast:@"Bạn chưa nhập Số điện thoại doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: businessCity]) {
        [self makeToast:@"Bạn chưa nhập Thành phố cho địa chỉ doanh nghiệp!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBusinessPhone.text]) {
        [self makeToast:@"Bạn chưa nhập Tên người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [self makeToast:@"Bạn chưa chọn Ngày sinh của người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPosition.text]) {
        [self makeToast:@"Bạn chưa nhập Chức vụ người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:@"Bạn chưa nhập CMND người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfAddress.text] || [AppUtils isNullOrEmpty: personalCity]) {
        [self makeToast:@"Bạn chưa nhập Địa chỉ người đăng ký!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (imgFront != nil || imgBehind != nil) {
        [self startUploadPassportPictures];
    }else{
        linkFrontPassport = @"";
        linkBehindPassport = @"";
        [self startAddProfileForBusiness];
    }
}

- (IBAction)btnCancelPress:(UIButton *)sender {
}

- (IBAction)btnPerCityPress:(UIButton *)sender {
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    if (popupChooseCity == nil) {
        popupChooseCity = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, realHeight-100)];
        popupChooseCity.delegate = self;
    }
    popupChooseCity.tag = 1;
    [popupChooseCity showInView:self animated:TRUE];
}

- (IBAction)btnCityPress:(UIButton *)sender {
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    if (popupChooseCity == nil) {
        popupChooseCity = [[ChooseCityPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, 50, 300, realHeight-100)];
        popupChooseCity.delegate = self;
    }
    popupChooseCity.tag = 2;
    [popupChooseCity showInView:self animated:TRUE];
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

- (IBAction)icMaleClick:(UIButton *)sender {
    [self selectMale];
}

- (IBAction)icFemaleClick:(UIButton *)sender {
    [self selectFemale];
}

- (void)selectMale {
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_men;
}

- (void)selectFemale {
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_women;
}

- (void)whenTapOnPersonal {
    if ([delegate respondsToSelector:@selector(onSelectPersonalProfile)]) {
        [delegate onSelectPersonalProfile];
    }
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
    toolBar.clipsToBounds = TRUE;
    toolBar.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    [self addSubview: toolBar];
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
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
    [btnChoose setTitle:text_choose forState:UIControlStateNormal];
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

- (void)whenTapOnFrontImage {
    if ([delegate respondsToSelector:@selector(onBusinessPassportFrontPress)]) {
        [delegate onBusinessPassportFrontPress];
    }
}

- (void)whenTapOnBehindImage {
    if ([delegate respondsToSelector:@selector(onBusinessPassportBehindPress)]) {
        [delegate onBusinessPassportBehindPress];
    }
}

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)removePassportFrontPhoto {
    imgFront = nil;
    imgPassportFront.image = FRONT_EMPTY_IMG;
}

- (void)removePassportBehindPhoto {
    imgBehind = nil;
    imgPassportBehind.image = FRONT_EMPTY_IMG;
}

- (void)startUploadPassportPictures {
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [ProgressHUD show:@"Đang xử lý. Vui lòng chờ trong giây lát" Interaction:NO];
    
    if (imgFront != nil) {
        __block NSData *uploadData = UIImagePNGRepresentation(imgFront);
        if (uploadData == nil) {
            uploadData = UIImageJPEGRepresentation(imgFront, 1.0);
        }
        NSString *imageName = [NSString stringWithFormat:@"%@_passport_front_%@", [AccountModel getCusIdOfUser], [AppUtils randomStringWithLength: 10]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                        [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] Can not upload front passport", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
                        [self makeToast:@"Ảnh CMND mặt trước của bạn chưa được tải thành công." duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                        
                        self.linkFrontPassport = @"";
                    }else{
                        [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] Finish upload front passport with link: %@", __FUNCTION__, uploadSession.namePicture] toFilePath:[AppDelegate sharedInstance].logFilePath];
                        
                        self.linkFrontPassport = uploadSession.namePicture;
                    }
                    
                    [self startUploadPassportBehindPictures];
                });
            }];
        });
    }else{
        self.linkFrontPassport = @"";
        [self startUploadPassportBehindPictures];
    }
}

- (void)startUploadPassportBehindPictures {
    if (imgBehind != nil) {
        __block NSData *uploadData = UIImagePNGRepresentation(imgBehind);
        if (uploadData == nil) {
            uploadData = UIImageJPEGRepresentation(imgBehind, 1.0);
        }
        NSString *imageName = [NSString stringWithFormat:@"%@_passport_behind_%@", [AccountModel getCusIdOfUser], [AppUtils randomStringWithLength: 10]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                        [self makeToast:@"Ảnh CMND mặt sau của bạn chưa được tải thành công." duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                        self.linkBehindPassport = @"";
                        
                    }else{
                        self.linkBehindPassport = uploadSession.namePicture;
                    }
                    [self startAddProfileForBusiness];
                });
            }];
        });
    }else{
        [self startAddProfileForBusiness];
    }
}

- (void)startAddProfileForBusiness {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:add_contact_mod forKey:@"mod"];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    [info setObject:[NSNumber numberWithInt:type_business] forKey:@"own_type"];
    
    //  business info
    [info setObject:tfBusinessName.text forKey:@"tc_tc_name"];
    [info setObject:tfTaxCode.text forKey:@"tc_tc_mst"];
    [info setObject:tfBusinessAddress.text forKey:@"tc_tc_address"];
    [info setObject:tfBusinessPhone.text forKey:@"tc_tc_phone"];
    [info setObject:COUNTRY_CODE forKey:@"tc_tc_country"];
    [info setObject:businessCity forKey:@"tc_tc_city"];
    
    //  personal info
    [info setObject:tfPosition.text forKey:@"cn_position"];
    [info setObject:tfRegisterName.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfBOD.text forKey:@"cn_birthday"];
    
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:personalCity forKey:@"cn_city"];
    [info setObject:linkFrontPassport forKey:@"cmnd_a"];
    [info setObject:linkBehindPassport forKey:@"cmnd_b"];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    [webService callWebServiceWithLink:add_contact_func withParams:info];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jSonDict = %@", __FUNCTION__, @[info]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

#pragma mark - ChooseCityPopupView
- (void)choosedCity:(CityObject *)city {
    if (popupChooseCity.tag == 1) {
        personalCity = city.code;
        tfPerCity.text = city.name;
    }else{
        businessCity = city.code;
        tfCity.text = city.name;
    }
}

#pragma mark - UIScrollview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closePickerView];
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
    if (textField == tfBusinessName) {
        [tfTaxCode becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfBusinessAddress becomeFirstResponder];
        
    }else if (textField == tfBusinessAddress) {
        [tfBusinessPhone becomeFirstResponder];
        
    }else if (textField == tfBusinessPhone) {
        [tfRegisterName becomeFirstResponder];
        
    }else if (textField == tfTaxCode) {
        [tfRegisterName becomeFirstResponder];
        
    }else if (textField == tfRegisterName) {
        [tfPosition becomeFirstResponder];
        
    }else if (textField == tfPosition) {
        [tfPassport becomeFirstResponder];
        
    }else if (textField == tfPassport) {
        [tfPhone becomeFirstResponder];
        
    }else if (textField == tfPhone) {
        [tfAddress becomeFirstResponder];
        
    }else if (textField == tfAddress) {
        [self closeKeyboard];
    }
    return TRUE;
}

#pragma mark - Webservice Delegate
- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    if ([link isEqualToString:add_contact_func]) {
        
        if (![AppUtils checkNetworkAvailable]) {
            [self makeToast:no_internet duration:2.0 position:CSToastPositionTop style:[AppDelegate sharedInstance].errorStyle];
        }else{
            [self makeToast:@"Tạo hồ sơ thất bại. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    if ([link isEqualToString:add_contact_func]) {
        [self profileWasCreatedSuccessful];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)profileWasCreatedSuccessful {
    [self makeToast:@"Hồ sơ đã được tạo thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(businessProfileWasCreated)]) {
        [delegate businessProfileWasCreated];
    }
}

//  {"tc_tc_address":"1020 Phạm Văn Đồng, P.Hiệp Bình Chánh","cn_birthday":"02/12/1991","cn_phone":"0363430737","tc_tc_name":"Thiền Nguyễn Company","tc_tc_city":"1","cmnd_b":"","own_type":1,"cn_name":"Khải Le","cn_country":"231","mod":"add_contact","cn_address":"1020 Phạm Văn Đồng","cn_city":"1","cmnd_a":"","tc_tc_country":"231","cn_sex":1,"cn_cmnd":"212456789","tc_tc_mst":"MST_0123456","tc_tc_phone":"0932205601","password":"97046ec8a290c4ff214acddfcf1fa363","cn_position":"Nhân viên","username":"lehoangson@gmail.com"}

@end
