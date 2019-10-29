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

@synthesize scvPersonal, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbName, tfName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, btnBOD, lbPassport, tfPassport, lbPhone, tfPhone, lbEmail, tfEmail, lbAddress, tfAddress, lbCountry, tfCountry, btnCountry, lbCity, tfCity, imgArrCity, btnCity, imgPassport, lbTitlePassport, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, btnSave, btnCancel, viewPassport;

@synthesize delegate, datePicker, toolBar, gender, cityCode, padding, mTop, hLabel, linkFrontPassport, linkBehindPassport, mode, cusId, btnEdit, hVision, hBTN, wPassport, hPassport, hViewPassport, hContent;

- (void)setupForAddProfileUIForAddNew: (BOOL)isAddNew isUpdate: (BOOL)isUpdate {
    //  setup for add profile
    hVision = 40.0;
    hBTN = 45.0;
    padding = 15.0;
    mTop = 10.0;
    hLabel = 30.0;
    gender = 1;
    linkFrontPassport = @"";
    linkBehindPassport = @"";
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hLabel = 40.0;
        hBTN = 55.0;
        hVision = 60.0;
    }
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [self addGestureRecognizer: tapOnView];
    
    scvPersonal.delegate = self;
    scvPersonal.showsVerticalScrollIndicator = FALSE;
    [scvPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    
    float genderTop = mTop;
    float hGender = hLabel;
    
    if (isUpdate) {
        mode = eEditProfile;
        hVision = genderTop = hGender = 0;
        
        icPersonal.hidden = lbPersonal.hidden = icBusiness.hidden = lbBusiness.hidden = TRUE;
    }else{
        mode = eAddNewProfile;
        
        icPersonal.hidden = lbPersonal.hidden = icBusiness.hidden = lbBusiness.hidden = FALSE;
    }
    
    lbVision.text = text_registration_purpose;
    [lbVision mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvPersonal);
        make.left.equalTo(scvPersonal).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(hVision);
    }];
    
    //  Choose type profile
    icPersonal.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVision.mas_bottom).offset(genderTop);
        make.left.equalTo(lbVision).offset(-4.0);
        make.width.height.mas_equalTo(hGender);
    }];
    
    lbPersonal.text = text_personal;
    [lbPersonal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icPersonal);
        make.left.equalTo(icPersonal.mas_right).offset(3.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    icBusiness.imageEdgeInsets = icPersonal.imageEdgeInsets;
    [icBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icPersonal);
        make.left.equalTo(self.mas_centerX);
        make.width.equalTo(icPersonal.mas_width);
    }];
    [icBusiness addTarget:self
                   action:@selector(whenTapOnBusiness)
         forControlEvents:UIControlEventTouchUpInside];
    
    lbBusiness.text = text_business;
    [lbBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPersonal);
        make.left.equalTo(icBusiness.mas_right).offset(3.0);
        make.right.equalTo(self).offset(-padding);
    }];
    //  Add target for lbBusiness
    UITapGestureRecognizer *tapOnBusiness = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBusiness)];
    lbBusiness.userInteractionEnabled = TRUE;
    [lbBusiness addGestureRecognizer: tapOnBusiness];
    
    //  Name
    lbName.text = text_fullname;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBusiness.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
    tfName.placeholder = text_enter_fullname;
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfName.returnKeyType = UIReturnKeyNext;
    tfName.delegate = self;
    
    //  gender and birth of day
    lbBOD.text = text_birthday;
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfName.mas_bottom).offset(mTop);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBOD borderColor:BORDER_COLOR];
    [tfBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBOD.mas_bottom);
        make.left.right.equalTo(lbBOD);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(tfBOD);
    }];
    
    lbGender.text  = text_gender;
    [lbGender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfName.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(hLabel);
    }];
    
    icMale.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbVision).offset(-4.0);
        make.centerY.equalTo(tfBOD.mas_centerY);
        make.width.height.mas_equalTo(hLabel);
    }];
    
    icFemale.imageEdgeInsets = icMale.imageEdgeInsets;
    [icFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(SCREEN_WIDTH/4);
        make.top.bottom.equalTo(icMale);
        make.width.equalTo(icMale.mas_width);
    }];
    
    //  add action when tap on male label
    UITapGestureRecognizer *tapOnMale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectMale)];
    lbMale.userInteractionEnabled = TRUE;
    [lbMale addGestureRecognizer: tapOnMale];
    
    lbMale.text = text_male;
    [lbMale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icMale);
        make.left.equalTo(icMale.mas_right).offset(5.0);
        make.right.equalTo(icFemale.mas_left).offset(-5.0);
    }];
    
    //  add action when tap on female label
    UITapGestureRecognizer *tapOnFemale = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectFemale)];
    lbFemale.userInteractionEnabled = TRUE;
    [lbFemale addGestureRecognizer: tapOnFemale];
    
    lbFemale.text = text_female;
    [lbFemale mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icFemale);
        make.left.equalTo(icFemale.mas_right).offset(5.0);
        make.right.equalTo(self.mas_centerX);
    }];
    
    //  CMND
    lbPassport.text = text_passport;
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBOD.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPassport borderColor:BORDER_COLOR];
    tfPassport.placeholder = text_enter_passport;
    [tfPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassport.mas_bottom);
        make.left.right.equalTo(lbPassport);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPassport.returnKeyType = UIReturnKeyNext;
    tfPassport.delegate = self;
    
    //  Phone
    lbPhone.text = text_phonenumber;
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPassport.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfPassport);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfPhone borderColor:BORDER_COLOR];
    tfPhone.placeholder = text_enter_phonenumber;
    [tfPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhone.mas_bottom);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfPhone.returnKeyType = UIReturnKeyNext;
    tfPhone.delegate = self;
    
    //  Email
    lbEmail.text = text_email_address;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfPhone.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfPhone);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    tfEmail.placeholder = enter_email_address;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom);
        make.left.right.equalTo(lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    tfEmail.returnKeyType = UIReturnKeyNext;
    tfEmail.delegate = self;
    
    //  address
    lbAddress.text = text_permanent_address;
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfEmail.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfEmail);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfAddress borderColor:BORDER_COLOR];
    tfAddress.placeholder = text_enter_permanent_address;
    [tfAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAddress.mas_bottom);
        make.left.right.equalTo(lbVision);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfAddress.returnKeyType = UIReturnKeyDone;
    tfAddress.delegate = self;
    
    //  country, district
    lbCountry.text = text_country;
    [lbCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfAddress.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(scvPersonal.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfCountry.backgroundColor = LIGHT_GRAY_COLOR;
    [AppUtils setBorderForTextfield:tfCountry borderColor:BORDER_COLOR];
    [tfCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCountry.mas_bottom);
        make.left.right.equalTo(lbCountry);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfCountry.text = text_vietnam;
    
    [btnCountry setTitle:@"" forState:UIControlStateNormal];
    [btnCountry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfCountry);
    }];
    
    lbCity.text = text_city;
    [lbCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbCountry);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.width.equalTo(lbCountry.mas_width);
    }];
    
    [AppUtils setBorderForTextfield:tfCity borderColor:BORDER_COLOR];
    tfCity.placeholder = text_choose_city;
    [tfCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfCountry);
        make.left.right.equalTo(lbCity);
    }];
    
    [imgArrCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfCity.mas_right).offset(-7.5);
        make.centerY.equalTo(tfCity.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnCity setTitle:@"" forState:UIControlStateNormal];
    [btnCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfCity);
    }];
    
    //  view passport
    if (IS_IPHONE || IS_IPOD) {
        wPassport = (SCREEN_WIDTH-3*padding)/2;
        hPassport = wPassport * 2/3;
    }else{
        wPassport = 339.0;
        hPassport = 226.0;
    }
    
    hViewPassport = mTop + [AppDelegate sharedInstance].hTextfield + hPassport + hLabel;
    
    [viewPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvPersonal);
        make.top.equalTo(tfCountry.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hViewPassport);
    }];
    
    lbTitlePassport.text = text_passport_photos;
    [lbTitlePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport).offset(padding + 20.0 + 10);
        make.top.right.equalTo(viewPassport).offset(mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport).offset(padding);
        make.centerY.equalTo(lbTitlePassport.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    //  front image
    imgPassportFront.layer.cornerRadius = 5.0;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitlePassport.mas_bottom);
        make.left.equalTo(viewPassport).offset((SCREEN_WIDTH/2 - wPassport)/2);
        make.width.mas_equalTo(wPassport);
        make.height.mas_equalTo(hPassport);
    }];
    
    
    lbPassportFront.text = text_front;
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgPassportFront);
        make.top.equalTo(imgPassportFront.mas_bottom);
        make.height.equalTo(lbName.mas_height);
    }];
    
    imgPassportBehind.layer.cornerRadius = imgPassportBehind.layer.cornerRadius;
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imgPassportFront);
        make.left.equalTo(viewPassport.mas_centerX).offset((SCREEN_WIDTH/2 - wPassport)/2);
        make.width.equalTo(imgPassportFront.mas_width);
    }];
    
    
    lbPassportBehind.text = text_backside;
    [lbPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgPassportBehind);
        make.top.equalTo(imgPassportBehind.mas_bottom);
        make.height.equalTo(lbName.mas_height);
    }];
    
    imgPassportFront.backgroundColor = imgPassportBehind.backgroundColor = GRAY_240;
    
    btnCancel.layer.cornerRadius = hBTN/2;
    btnCancel.backgroundColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    [btnCancel setTitle:text_cancel forState:UIControlStateNormal];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbName);
        make.right.equalTo(scvPersonal.mas_centerX).offset(-padding/2);
        make.top.equalTo(viewPassport.mas_bottom).offset(padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitle:text_save_profile forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvPersonal.mas_centerX).offset(padding/2);
        make.right.equalTo(lbName);
        make.top.bottom.equalTo(btnCancel);
    }];
    
    btnEdit.hidden = TRUE;
    btnEdit.layer.cornerRadius = btnCancel.layer.cornerRadius;
    btnEdit.backgroundColor = BLUE_COLOR;
    btnEdit.layer.borderWidth = 1.0;
    btnEdit.layer.borderColor = BLUE_COLOR.CGColor;
    [btnEdit setTitle:text_update_profile forState:UIControlStateNormal];
    [btnEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.bottom.equalTo(btnCancel);
    }];
    
    hContent = hVision + hGender + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + hViewPassport + padding + hBTN + padding;
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
    
    lbVision.font = lbName.font = lbGender.font = lbBOD.font = lbPassport.font = lbPhone.font = lbEmail.font = lbAddress.font = lbCountry.font = lbCity.font = lbTitlePassport.font = [AppDelegate sharedInstance].fontMedium;
    
    lbPersonal.font = lbBusiness.font = tfName.font = lbMale.font = lbFemale.font = tfBOD.font = tfPassport.font = tfPhone.font = tfEmail.font = tfAddress.font = tfCountry.font = tfCity.font = lbPassportFront.font = lbPassportBehind.font = [AppDelegate sharedInstance].fontRegular;
    
    btnCancel.titleLabel.font = btnSave.titleLabel.font = btnEdit.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbVision.textColor = lbPersonal.textColor = lbBusiness.textColor = lbName.textColor = tfName.textColor = lbMale.textColor = lbFemale.textColor = lbBOD.textColor = tfBOD.textColor = lbPassport.textColor = tfPassport.textColor = lbPhone.textColor = tfPhone.textColor = lbEmail.textColor = tfEmail.textColor = lbAddress.textColor = tfAddress.textColor = lbCountry.textColor = tfCountry.textColor = lbCity.textColor = tfCity.textColor = lbTitlePassport.textColor = lbPassportBehind.textColor = lbPassportFront.textColor = TITLE_COLOR;
    
    //  Add datepicker
    [self addDatePickerForView];
}

- (void)addDatePickerForView {
    
}

- (void)setupViewForAddNewProfileView {
    hContent = hVision + (mTop + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + hViewPassport + padding + hBTN + padding;
    
    scvPersonal.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (void)closePickerView {
}

- (void)chooseDatePicker {
}

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (IBAction)btnSavePress:(UIButton *)sender {
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onCancelButtonClicked)]) {
        [delegate onCancelButtonClicked];
    }
}

- (IBAction)btnBODPress:(UIButton *)sender {
    
}

- (IBAction)btnCityPress:(UIButton *)sender
{
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
}

- (void)whenTapOnBehindImage {
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
}

- (void)startUploadPassportBehindPictures {
}

- (void)handlePersonalProfileProfile
{
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
    
}

-(void)editProfileSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
}

- (void)profileWasCreatedSuccessful {
    [self makeToast:@"Hồ sơ đã được tạo thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)profileWasUpdatedSuccessful {
    
}

- (void)gotoListProfiles {
    
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(profileWasCreated)]) {
        [delegate profileWasCreated];
    }
}

- (void)removePassportFrontPhoto {
}

- (void)removePassportBehindPhoto {
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
}

- (void)saveAllValueBeforeChangeView {
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return TRUE;
}

- (void)reUpdateLayoutForView {
    float widthScreen = [DeviceUtils getWidthOfScreen];
    [lbVision mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen-2*padding);
    }];
    
    [viewPassport mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen);
    }];
    
    [viewPassport mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen);
    }];
    
    [imgPassportFront mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport).offset((widthScreen/2 - wPassport)/2);
    }];
    
    [imgPassportBehind mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewPassport.mas_centerX).offset((widthScreen/2 - wPassport)/2);
    }];
    
    scvPersonal.contentSize = CGSizeMake(widthScreen, hContent);
}

@end
