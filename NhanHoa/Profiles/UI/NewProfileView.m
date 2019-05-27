//
//  NewProfileView.m
//  NhanHoa
//
//  Created by admin on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewProfileView.h"
#import "CityObject.h"
#import "UploadPicture.h"
#import "AccountModel.h"

@implementation NewProfileView

@synthesize scvPersonal, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbAddress, tfAddress, lbCountry, tfCountry, imgArrCountry, btnCountry, lbCity, tfCity, imgArrCity, btnCity, imgPassport, lbTitlePassport, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, btnSave, btnCancel, lbWarningName, lbWarningPhone, lbWarningCountry, lbWarningAddress, lbWarningCity, viewPassport, viewSecure, lbSecure, tfSecure, imgSecure;

@synthesize delegate, datePicker, toolBar, gender, cityCode, padding, mTop, hLabel, imgFront, imgBehind, linkFrontPassport, linkBehindPassport;

- (void)setupForAddProfileUI {
    //  setup for add profile
    padding = 15.0;
    mTop = 10.0;
    hLabel = 30.0;
    gender = 1;
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    [scvPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    scvPersonal.delegate = self;
    
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvPersonal);
        make.left.equalTo(self.scvPersonal).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(40.0);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(self.hLabel);
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
        make.right.equalTo(self).offset(-self.padding);
    }];
    
    //  Name
    float sizeText = [AppUtils getSizeWithText:@"Họ tên" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusiness.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.lbVision);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbWarningName.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbWarningName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbName);
        make.left.equalTo(self.lbName.mas_right);
        make.width.mas_equalTo(20.0);
    }];
    
    [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbName.mas_bottom);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  gender and birth of day
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self).offset(-self.padding);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.tfBOD);
    }];
    
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfName.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(self.hLabel);
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
        make.top.equalTo(self.tfBOD.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  Phone
    sizeText = [AppUtils getSizeWithText:@"Số điện thoại" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPassport.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.tfPassport);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbWarningPhone.font = lbWarningName.font;
    [lbWarningPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPhone);
        make.left.equalTo(self.lbPhone.mas_right);
        make.width.mas_equalTo(20.0);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  Email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfPhone.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.tfPhone);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  address
    sizeText = [AppUtils getSizeWithText:@"Địa chỉ" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.tfEmail);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbWarningAddress.font = lbWarningName.font;
    [lbWarningAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbAddress);
        make.left.equalTo(self.lbAddress.mas_right);
        make.width.mas_equalTo(20.0);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress.mas_bottom);
        make.left.right.equalTo(self.lbVision);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  country, district
    sizeText = [AppUtils getSizeWithText:@"Quốc gia" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfAddress.mas_bottom).offset(self.mTop);
        make.left.equalTo(self).offset(self.padding);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbWarningCountry.font = lbWarningName.font;
    [lbWarningCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.lbCountry.mas_right);
        make.width.mas_equalTo(20.0);
    }];
    
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbCountry.mas_bottom);
        make.left.equalTo(self.lbCountry);
        make.right.equalTo(self.scvPersonal.mas_centerX).offset(-self.padding/2);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfCountry.text = @"Việt Nam";
    
    [imgArrCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCountry.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCountry.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCountry setTitle:@"" forState:UIControlStateNormal];
    [btnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCountry);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Tỉnh/Thành phố" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCountry);
        make.left.equalTo(self.mas_centerX).offset(self.padding/2);
        make.width.mas_equalTo(sizeText);
    }];
    
    lbWarningCity.font = lbWarningName.font;
    [lbWarningCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbCity);
        make.left.equalTo(self.lbCity.mas_right);
        make.width.mas_equalTo(20.0);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfCountry);
        make.left.equalTo(self.lbCity);
        make.right.equalTo(self.lbVision.mas_right);
    }];
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(self.tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfCity);
    }];
    
    //  view passport
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    float hViewPassport = mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel;
    
    [viewPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvPersonal);
        make.top.equalTo(self.tfCountry.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hViewPassport);
    }];
    
    [lbTitlePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewPassport).offset(self.padding + 20.0 + 10);
        make.top.right.equalTo(self.viewPassport).offset(self.mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewPassport).offset(self.padding);
        make.centerY.equalTo(self.lbTitlePassport.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    //  front image
    imgPassportFront.layer.cornerRadius = 5.0;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitlePassport.mas_bottom);
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
        make.height.equalTo(self.lbName.mas_height);
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
        make.height.equalTo(self.lbName.mas_height);
    }];
    
    //  view secure
    viewSecure.clipsToBounds = TRUE;
    [viewSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvPersonal);
        make.top.equalTo(self.viewPassport.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.mTop + self.hLabel + [AppDelegate sharedInstance].hTextfield);
    }];
    
    [lbSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewSecure).offset(self.mTop);
        make.left.equalTo(self.viewSecure).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfSecure borderColor:ORANGE_COLOR];
    [tfSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSecure.mas_bottom);
        make.left.equalTo(self.lbSecure);
        make.right.equalTo(self.viewSecure.mas_centerX).offset(-self.padding/2);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfSecure);
        make.left.equalTo(self.viewSecure.mas_centerX).offset(self.padding/2);
        make.right.equalTo(self.viewSecure).offset(-self.padding);
    }];
    
    btnCancel.layer.cornerRadius = 45.0/2;
    btnCancel.backgroundColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportFront);
        make.top.equalTo(self.viewSecure.mas_bottom).offset(2*self.padding);
        make.height.mas_equalTo(45.0);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgPassportBehind);
        make.top.bottom.equalTo(self.btnCancel);
    }];
    
    float hScrollView = 40 + 8*mTop + 8*hLabel + 7*[AppDelegate sharedInstance].hTextfield + (mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + 45 + 2*padding;
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
    
    lbVision.font = lbName.font = lbGender.font = lbBOD.font = lbPassport.font = lbPhone.font = lbEmail.font = lbAddress.font = lbCountry.font = lbCity.font = lbTitlePassport.font = [AppDelegate sharedInstance].fontMedium;
    lbPersonal.font = lbBusiness.font = tfName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPassport.font = tfPhone.font = tfEmail.font = tfAddress.font = tfCountry.font = tfCity.font = lbPassportFront.font = lbPassportBehind.font = [AppDelegate sharedInstance].fontRegular;
    
    btnCancel.titleLabel.font = btnSave.titleLabel.font = [UIFont fontWithName:RobotoMedium size:18.0];
    
    lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbName.textColor = tfName.textColor = lbMale.textColor = lbFemale.textColor = lbBOD.textColor = tfBOD.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbEmail.textColor = tfEmail.textColor = lbAddress.textColor = tfAddress.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = lbTitlePassport.textColor = lbPassportBehind.textColor = lbPassportFront.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
    
    //  40 + mTop + hLabel + (mTop + hLabel + hTextfield)(name) + (mTop + hLabel + hTextfield)(gender) + (mTop + hLabel + hTextfield)(passport) + (mTop + hLabel + hTextfield)(phone) + (mTop + hLabel + hTextfield)(email) + (mTop + hLabel + hTextfield)(address) + (mTop + hLabel + hTextfield)(country) + hViewPassport + (2*padding + 45.0 + 2*padding)
    
    tfName.text = @"Lê Khải";
    tfPassport.text = @"123456789";
    tfPhone.text = @"0363430737";
    tfEmail.text = @"lekhai0212@gmail.com";
    tfAddress.text = @"1020 Phạm Văn Đồng, P.Hiệp Bình Chánh";
    tfBOD.text = @"02/12/1991";
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

- (void)setupViewForAddNewProfileView {
    [viewSecure mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvPersonal);
        make.top.equalTo(self.viewPassport.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
    
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    float hScrollView = 40 + 8*mTop + 8*hLabel + 7*[AppDelegate sharedInstance].hTextfield + (mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel) + 2*padding + 45 + 2*padding;
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
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
        [self makeToast:@"Bạn chưa nhập Họ tên!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfBOD.text]) {
        [self makeToast:@"Bạn chưa chọn ngày sinh!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [self makeToast:@"Bạn chưa nhập địa chỉ!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfCountry.text]) {
        [self makeToast:@"Bạn chưa chọn Quốc gia!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cityCode]) {
        [self makeToast:@"Bạn chưa chọn Tỉnh/thành phố!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (imgFront == nil || imgBehind == nil) {
        [self makeToast:@"Bạn chưa chọn ảnh CMND!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (imgFront != nil) {
        [self startUploadPassportFontPictures];
    }
    
    
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:[NSNumber numberWithInt:type_personal] forKey:@"own_type"];
    [info setObject:tfName.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfBOD.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:cityCode forKey:@"cn_city"];
    [info setObject:cityCode forKey:@"cmnd_a"];
    [info setObject:cityCode forKey:@"cmnd_b"];
    
    
//mod: add_contact
//username: string (email mà khách đã đăng nhập, hồ sơ cần tạo sẽ trực thuộc tài khoản này).
//password: MD5 (mật khẩu khách đăng nhập)
//    Thông tin tạo hồ sơ
//own_type: number (cá nhân: 0 | công ty / tổ chức: 1)
//(own_type: 1) { // công ty / tổ chức
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
//    cmnd_a: URL (Link hình CMND mặt trước của người đại diện)
//    cmnd_b: URL (Link hình CMND mặt sau của người đại diện)
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onCancelButtonClicked)]) {
        [delegate onCancelButtonClicked];
    }
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
    float realHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    
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
    cityCode = city.code;
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

- (void)whenTapOnFrontImage {
    if ([delegate respondsToSelector:@selector(onPassportFrontPress)]) {
        [delegate onPassportFrontPress];
    }
}

- (void)whenTapOnBehindImage {
    if ([delegate respondsToSelector:@selector(onPassportBehindPress)]) {
        [delegate onPassportBehindPress];
    }
}

- (void)startUploadPassportFontPictures {
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
    [ProgressHUD show:@"Đang xử lý. Vui lòng chờ trong giây lát" Interaction:NO];
    
    __block NSData *frontUploadData = UIImagePNGRepresentation(imgFront);
    if (uploadData == nil) {
        uploadData = UIImageJPEGRepresentation(imgFront, 1.0);
    }
    NSString *imageName = [NSString stringWithFormat:@"%@_passport_front_%@", [AccountModel getCusIdOfUser], [AppUtils randomStringWithLength: 10]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        UploadPicture *session = [[UploadPicture alloc] init];
        [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                    [self makeToast:@"Ảnh CMND mặt trước của bạn chưa được tải thành công." duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                }else{
                    self.linkFrontPassport = uploadSession.namePicture;
                    //  continue upload passport behind image
                    uploadData = UIImagePNGRepresentation(self.imgBehind);
                    if (uploadData == nil) {
                        uploadData = UIImageJPEGRepresentation(imgFront, 1.0);
                    }
                    
                }
            });
        }];
    });
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closePickerView];
}

@end
