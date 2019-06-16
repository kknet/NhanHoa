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

@synthesize scvPersonal, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbAddress, tfAddress, lbCountry, tfCountry, btnCountry, lbCity, tfCity, imgArrCity, btnCity, imgPassport, lbTitlePassport, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, btnSave, btnCancel, lbWarningName, lbWarningPhone, lbWarningCountry, lbWarningAddress, lbWarningCity, viewPassport;

@synthesize delegate, datePicker, toolBar, gender, cityCode, padding, mTop, hLabel, linkFrontPassport, linkBehindPassport, mode, cusId, btnEdit;

- (void)setupForAddProfileUIForAddNew: (BOOL)isAddNew isUpdate: (BOOL)isUpdate {
    //  setup for add profile
    padding = 15.0;
    mTop = 10.0;
    hLabel = 30.0;
    gender = 1;
    linkFrontPassport = @"";
    linkBehindPassport = @"";
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    [scvPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    scvPersonal.delegate = self;
    
    float hVision = 40.0;
    float genderTop = self.mTop;
    float hGender = self.hLabel;
    
    if (isUpdate) {
        mode = eEditProfile;
        hVision = genderTop = hGender = 0;
        
        icPersonal.hidden = lbPersonal.hidden = icBusiness.hidden = lbBusiness.hidden = TRUE;
    }else{
        mode = eAddNewProfile;
        
        icPersonal.hidden = lbPersonal.hidden = icBusiness.hidden = lbBusiness.hidden = FALSE;
    }
    
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvPersonal);
        make.left.equalTo(self.scvPersonal).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(hVision);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVision.mas_bottom).offset(genderTop);
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hGender);
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
    [icBusiness addTarget:self
                   action:@selector(whenTapOnBusiness)
         forControlEvents:UIControlEventTouchUpInside];
    
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPersonal);
        make.left.equalTo(self.icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-self.padding);
    }];
    //  Add target for lbBusiness
    UITapGestureRecognizer *tapOnBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBusiness)];
    lbBusiness.userInteractionEnabled = TRUE;
    [lbBusiness addGestureRecognizer: tapOnBusiness];
    
    //  Name
    float sizeText = [AppUtils getSizeWithText:@"Họ tên" withFont:[AppDelegate sharedInstance].fontRegular].width + 5.0;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBusiness.mas_bottom).offset(self.mTop);
        make.left.equalTo(self.lbVision);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbWarningName.font = [AppDelegate sharedInstance].fontDesc;
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
    tfName.returnKeyType = UIReturnKeyNext;
    tfName.delegate = self;
    
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
    
    icMale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbVision).offset(-4.0);
        make.centerY.equalTo(self.tfBOD.mas_centerY);
        make.width.height.mas_equalTo(self.hLabel);
    }];
    
    icFemale.imageEdgeInsets = self.icMale.imageEdgeInsets;
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
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    
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
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    
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
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    tfEmail.returnKeyType = UIReturnKeyNext;
    tfEmail.delegate = self;
    
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
    tfAddress.returnKeyType = UIReturnKeyDone;
    tfAddress.delegate = self;
    
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
    
    btnEdit.hidden = TRUE;
    btnEdit.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnEdit.backgroundColor = BLUE_COLOR;
    btnEdit.layer.borderWidth = 1.0;
    btnEdit.layer.borderColor = BLUE_COLOR.CGColor;
    [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCancel);
        make.right.equalTo(self.btnSave);
        make.top.bottom.equalTo(self.btnCancel);
    }];
    
    float hScrollView = hVision + hGender + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + hViewPassport + 2*padding + 45 + 2*padding;
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
    
    lbVision.font = lbName.font = lbGender.font = lbBOD.font = lbPassport.font = lbPhone.font = lbEmail.font = lbAddress.font = lbCountry.font = lbCity.font = lbTitlePassport.font = [AppDelegate sharedInstance].fontMedium;
    
    lbPersonal.font = lbBusiness.font = tfName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPassport.font = tfPhone.font = tfEmail.font = tfAddress.font = tfCountry.font = tfCity.font = lbPassportFront.font = lbPassportBehind.font = [AppDelegate sharedInstance].fontRegular;
    
    btnCancel.titleLabel.font = btnSave.titleLabel.font = btnEdit.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbName.textColor = tfName.textColor = lbMale.textColor = lbFemale.textColor = lbBOD.textColor = tfBOD.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbEmail.textColor = tfEmail.textColor = lbAddress.textColor = tfAddress.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = lbTitlePassport.textColor = lbPassportBehind.textColor = lbPassportFront.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
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
    btnClose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
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
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
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
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    float hViewPassport = mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel;
    
    float hScrollView = 40 + (mTop + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + hViewPassport + 2*padding + 45 + 2*padding;
    
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
    
    if ([AppUtils isNullOrEmpty: tfPassport.text]) {
        [self makeToast:@"Bạn chưa nhập CMND!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfPhone.text]) {
        [self makeToast:@"Bạn chưa nhập địa chỉ!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfEmail.text]) {
        [self makeToast:@"Bạn chưa nhập địa chỉ email!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfAddress.text]) {
        [self makeToast:@"Bạn chưa nhập địa chỉ!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: cityCode]) {
        [self makeToast:@"Bạn chưa chọn Tỉnh/thành phố!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Hồ sơ đang được cập nhật.\nVui lòng chờ trong giây lát" Interaction:NO];
    
    if ([AppDelegate sharedInstance].editCMND_a != nil || [AppDelegate sharedInstance].editCMND_b != nil) {
        [self startUploadPassportPictures];
    }else{
        [self handlePersonalProfileProfile];
    }
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onCancelButtonClicked)]) {
        [delegate onCancelButtonClicked];
    }
}

- (IBAction)btnBODPress:(UIButton *)sender {
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
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
    
    [datePicker mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(hPickerView);
    }];
    [toolBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.datePicker.mas_top);
        make.height.mas_equalTo(hToolbar);
    }];
    
    //  set date for picker
    if (![AppUtils isNullOrEmpty: tfBOD.text]) {
        NSDate *bodDate = [AppUtils convertStringToDate: tfBOD.text];
        if (bodDate != nil) {
            datePicker.date = bodDate;
        }else{
            datePicker.date = [NSDate date];
        }
    }else{
        datePicker.date = [NSDate date];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        self.datePicker.maximumDate = [NSDate date];
    }];
}

- (IBAction)btnCityPress:(UIButton *)sender
{
    [self endEditing: TRUE];
    
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
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

- (IBAction)btnEditPress:(UIButton *)sender {
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    [self performSelector:@selector(goToEditBusinessProfile) withObject:nil afterDelay:0.01];
}

- (void)goToEditBusinessProfile {
    [btnEdit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnEdit.backgroundColor = BLUE_COLOR;
    if ([delegate respondsToSelector:@selector(onButtonEditPersonalProfilePressed)]) {
        [delegate onButtonEditPersonalProfilePressed];
    }
}

- (void)choosedCity:(CityObject *)city {
    tfCity.text = city.name;
    cityCode = city.code;
}

- (void)selectMale {
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
    [icMale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icFemale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_men;
}

- (void)selectFemale {
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
    [icFemale setImage:[UIImage imageNamed:@"tick_orange"] forState:UIControlStateNormal];
    [icMale setImage:[UIImage imageNamed:@"no_tick"] forState:UIControlStateNormal];
    gender = type_women;
}

- (void)whenTapOnFrontImage {
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
    if ([delegate respondsToSelector:@selector(onPassportFrontPress)]) {
        [delegate onPassportFrontPress];
    }
}

- (void)whenTapOnBehindImage {
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
    if ([delegate respondsToSelector:@selector(onPassportBehindPress)]) {
        [delegate onPassportBehindPress];
    }
}

- (void)whenTapOnBusiness {
    //  Don't thing if screen is view profile info
    if (mode == eViewProfile) {
        return;
    }
    
    if ([delegate respondsToSelector:@selector(onSelectBusinessProfile)]) {
        [delegate onSelectBusinessProfile];
    }
}

- (void)startUploadPassportPictures
{
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang xử lý. Vui lòng chờ trong giây lát" Interaction:NO];
    
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        [AppDelegate sharedInstance].editCMND_a = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_a];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_a);
        NSString *imageName = [NSString stringWithFormat:@"%@_front_%@.PNG", [AppUtils getCurrentDateTime], [AccountModel getCusIdOfUser]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"])
                    {
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Can not upload front passport", __FUNCTION__)];
                        
                        //  Nếu update không thành công thì dùng ảnh cũ, còn thêm mới thì set giá trị rỗng
                        if (self.mode == eAddNewProfile) {
                            self.linkFrontPassport = @"";
                        }
                        
                    }else{
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Finish upload front passport with link: %@", __FUNCTION__, uploadSession.namePicture)];
                        
                        self.linkFrontPassport = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    
                    [self startUploadPassportBehindPictures];
                });
            }];
        });
    }else{
        [self startUploadPassportBehindPictures];
    }
}

- (void)startUploadPassportBehindPictures {
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        [AppDelegate sharedInstance].editCMND_b = [AppUtils resizeImage: [AppDelegate sharedInstance].editCMND_b];
        NSData *uploadData = UIImagePNGRepresentation([AppDelegate sharedInstance].editCMND_b);
        
        NSString *imageName = [NSString stringWithFormat:@"%@_behind_%@.PNG", [AppUtils getCurrentDateTime], [AccountModel getCusIdOfUser]];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            UploadPicture *session = [[UploadPicture alloc] init];
            [session uploadData:uploadData withName:imageName beginUploadBlock:nil finishUploadBlock:^(UploadPicture *uploadSession) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (uploadSession.uploadError != nil || [uploadSession.namePicture isEqualToString:@"Error"]) {
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Can not upload behind passport", __FUNCTION__)];
                        
                        //  Nếu update không thành công thì dùng ảnh cũ, còn thêm mới thì set giá trị rỗng
                        if (self.mode == eAddNewProfile) {
                            self.linkBehindPassport = @"";
                        }
                        
                    }else{
                        [WriteLogsUtils writeLogContent:SFM(@"[%s] Finish upload behind passport with link: %@", __FUNCTION__, uploadSession.namePicture)];
                        
                        self.linkBehindPassport = [NSString stringWithFormat:@"%@/%@", link_upload_photo, uploadSession.namePicture];
                    }
                    [self handlePersonalProfileProfile];
                });
            }];
        });
    }else{
        [self handlePersonalProfileProfile];
    }
}

- (void)handlePersonalProfileProfile
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"password"];
    [info setObject:[NSNumber numberWithInt:type_personal] forKey:@"own_type"];
    
    [info setObject:tfName.text forKey:@"cn_name"];
    [info setObject:[NSNumber numberWithInt:gender] forKey:@"cn_sex"];
    [info setObject:tfEmail.text forKey:@"cn_email"];
    [info setObject:tfBOD.text forKey:@"cn_birthday"];
    [info setObject:tfPassport.text forKey:@"cn_cmnd"];
    [info setObject:tfPhone.text forKey:@"cn_phone"];
    [info setObject:tfAddress.text forKey:@"cn_address"];
    [info setObject:COUNTRY_CODE forKey:@"cn_country"];
    [info setObject:cityCode forKey:@"cn_city"];
    [info setObject:linkFrontPassport forKey:@"cmnd_a"];
    [info setObject:linkBehindPassport forKey:@"cmnd_b"];
    
    if (mode == eAddNewProfile) {
        [info setObject:add_contact_mod forKey:@"mod"];
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] addProfileWithContent: info];
        
    }else if (mode == eEditProfile){
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

#pragma mark - Webservice Delegate
-(void)failedToAddProfileWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)addProfileSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    [AppDelegate sharedInstance].editCMND_a = [AppDelegate sharedInstance].editCMND_b = nil;
    [self profileWasCreatedSuccessful];
}

-(void)failedToEditProfileWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)editProfileSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD dismiss];
    [AppDelegate sharedInstance].editCMND_a = [AppDelegate sharedInstance].editCMND_b = nil;
    [self profileWasUpdatedSuccessful];
}

- (void)profileWasCreatedSuccessful {
    [self makeToast:@"Hồ sơ đã được tạo thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)profileWasUpdatedSuccessful {
    [self makeToast:@"Hồ sơ đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(gotoListProfiles) withObject:nil afterDelay:2.0];
}

- (void)gotoListProfiles {
    [AppDelegate sharedInstance].needReloadListProfile = TRUE;
    if ([delegate respondsToSelector:@selector(personalProfileWasUpdated)]) {
        [delegate personalProfileWasUpdated];
    }
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(profileWasCreated)]) {
        [delegate profileWasCreated];
    }
}

- (void)removePassportFrontPhoto {
    [AppDelegate sharedInstance].editCMND_a = nil;
    imgPassportFront.image = FRONT_EMPTY_IMG;
}

- (void)removePassportBehindPhoto {
    [AppDelegate sharedInstance].editCMND_b = nil;
    imgPassportBehind.image = FRONT_EMPTY_IMG;
}


- (void)displayInfoForPersonalProfileWithInfo: (NSDictionary *)info {
    NSString *fullname = [info objectForKey:@"cus_realname"];    //  cus_contract_name???
    if (![AppUtils isNullOrEmpty: fullname]) {
        tfName.text = fullname;
    }else{
        tfName.text = @"";
    }
    
    NSString *gender = [info objectForKey:@"cus_gender"];
    if ([gender isEqualToString:@"1"]) {
        [self selectMale];
    }else{
        [self selectFemale];
    }
    
    NSString *birthday = [info objectForKey:@"cus_birthday"];
    if (![AppUtils isNullOrEmpty: birthday]) {
        tfBOD.text = birthday;
    }else{
        tfBOD.text = @"";
    }
    
    NSString *passport = [info objectForKey:@"cus_idcard_number"];
    if (![AppUtils isNullOrEmpty: passport]) {
        tfPassport.text = passport;
    }else{
        tfPassport.text = @"";
    }
    
    NSString *phone = [info objectForKey:@"cus_phone"];
    if (![AppUtils isNullOrEmpty: phone]) {
        tfPhone.text = phone;
    }else{
        tfPhone.text = @"";
    }
    
    NSString *email = [info objectForKey:@"cus_rl_email"];
    if (![AppUtils isNullOrEmpty: email]) {
        tfEmail.text = email;
    }else{
        tfEmail.text = @"";
    }
    
    NSString *address = [info objectForKey:@"cus_address"];
    if (![AppUtils isNullOrEmpty: address]) {
        tfAddress.text = address;
    }else{
        tfAddress.text = @"";
    }
    //  cmnd mat truoc
    if ([AppDelegate sharedInstance].editCMND_a != nil) {
        imgPassportFront.image = [AppDelegate sharedInstance].editCMND_a;
    }else{
        NSString *cmnd_a = [info objectForKey:@"cmnd_a"];
        if (![AppUtils isNullOrEmpty: cmnd_a]) {
            linkFrontPassport = cmnd_a;
            [imgPassportFront sd_setImageWithURL:[NSURL URLWithString:cmnd_a] placeholderImage:FRONT_EMPTY_IMG];
        }else{
            imgPassportFront.image = FRONT_EMPTY_IMG;
        }
    }
    
    //  cmnd mat sau
    if ([AppDelegate sharedInstance].editCMND_b != nil) {
        imgPassportBehind.image = [AppDelegate sharedInstance].editCMND_b;
    }else{
        NSString *cmnd_b = [info objectForKey:@"cmnd_b"];
        if (![AppUtils isNullOrEmpty: cmnd_b]) {
            linkBehindPassport = cmnd_b;
            [imgPassportBehind sd_setImageWithURL:[NSURL URLWithString:cmnd_b] placeholderImage:BEHIND_EMPTY_IMG];
        }else{
            imgPassportBehind.image = BEHIND_EMPTY_IMG;
        }
    }
    
    
    NSString *city = [info objectForKey:@"cus_city"];
    if (![AppUtils isNullOrEmpty: city]) {
        tfCity.text = [[AppDelegate sharedInstance] findCityObjectWithCityCode: city];
        cityCode = city;
    }else{
        tfCity.text = @"";
        cityCode = @"";
    }
    
    cusId = [info objectForKey:@"cus_id"];
}

- (void)setupUIForOnlyView {
    btnEdit.hidden = FALSE;
    mode = eViewProfile;
    UIColor *disableColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    tfName.backgroundColor = tfBOD.backgroundColor = tfPassport.backgroundColor = tfPhone.backgroundColor = tfEmail.backgroundColor = tfAddress.backgroundColor = tfCountry.backgroundColor = tfCity.backgroundColor = disableColor;
    
    tfName.enabled = tfBOD.enabled = tfPassport.enabled = tfPhone.enabled = tfEmail.enabled = tfAddress.enabled = tfCountry.enabled = tfCity.enabled = FALSE;
    
    imgArrCity.hidden = btnCancel.hidden = btnSave.hidden = TRUE;
}

- (void)saveAllValueBeforeChangeView {
    [[AppDelegate sharedInstance].profileEdit setObject:tfName.text forKey:@"cus_realname"];
    [[AppDelegate sharedInstance].profileEdit setObject:[NSString stringWithFormat:@"%d", gender] forKey:@"cus_gender"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBOD.text forKey:@"cus_birthday"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPassport.text forKey:@"cus_idcard_number"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPhone.text forKey:@"cus_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfEmail.text forKey:@"cus_email"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfAddress.text forKey:@"cus_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:cityCode forKey:@"cus_city"];
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfName) {
        [tfPassport becomeFirstResponder];
    }else if (textField == tfPassport) {
        [tfPhone becomeFirstResponder];
    }else if (textField == tfPhone) {
        [tfEmail becomeFirstResponder];
    }else if (textField == tfEmail) {
        [tfAddress becomeFirstResponder];
    }else if (textField == tfAddress) {
        [self endEditing: TRUE];
    }
    return TRUE;
}

@end
