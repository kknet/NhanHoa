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

@synthesize scvContent, lbTitle, lbVision, icPersonal, lbPersonal, icBusiness, lbBusiness, lbInfoBusiness, lbBusinessName, tfBusinessName, lbTaxCode, tfTaxCode, lbBusinessAddress, tfBusinessAddress, lbBusinessPhone, tfBusinessPhone, lbCountry, tfCountry, lbCity, tfCity, btnCity, imgCity, lbInfoRegister, lbRegisterName, tfRegisterName, lbGender, icMale, lbMale, icFemale, lbFemale, lbBOD, tfBOD, lbPosition, tfPosition, lbPassport, tfPassport, lbPhone, tfPhone, tfAddress, lbAddress, viewPassport, lbPassportTitle, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehind, imgPassport, btnCancel, btnSave, btnBOD, btnEdit;

@synthesize padding, hLabel, mTop, delegate, businessCity, gender, datePicker, toolBar, popupChooseCity, linkFrontPassport, linkBehindPassport, mode, wPassport, hPassport, hViewPassport, hContent;

- (void)setupUIForViewForAddProfile: (BOOL)isAddNew update: (BOOL)isUpdate{
}

- (IBAction)btnSavePress:(UIButton *)sender {
}

- (IBAction)btnCancelPress:(UIButton *)sender {
}

- (IBAction)btnCityPress:(UIButton *)sender {
}

- (IBAction)btnBODPress:(UIButton *)sender {
}

- (IBAction)icMaleClick:(UIButton *)sender {
}

- (IBAction)icFemaleClick:(UIButton *)sender {
}

- (IBAction)btnEditPress:(UIButton *)sender {
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    [self performSelector:@selector(goToEditBusinessProfile) withObject:nil afterDelay:0.01];
}

- (void)goToEditBusinessProfile {
    [btnEdit setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnEdit.backgroundColor = BLUE_COLOR;
    if ([delegate respondsToSelector:@selector(onButtonEditPressed)]) {
        [delegate onButtonEditPressed];
    }
}

- (void)selectMale {
}

- (void)selectFemale {
}

- (void)whenTapOnPersonal {
    //  Don't thing if screen is view profile info
    if (mode == eViewBusinessProfile) {
        return;
    }
    
    if ([delegate respondsToSelector:@selector(onSelectPersonalProfile)]) {
        [delegate onSelectPersonalProfile];
    }
}

- (void)addDatePickerForView {
}

- (void)closePickerView {
}

- (void)chooseDatePicker {
}

- (void)whenTapOnFrontImage {
}

- (void)whenTapOnBehindImage {
}

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)removePassportFrontPhoto {
    [AppDelegate sharedInstance].editCMND_a = nil;
    imgPassportFront.image = FRONT_EMPTY_IMG;
}

- (void)removePassportBehindPhoto {
    [AppDelegate sharedInstance].editCMND_b = nil;
    imgPassportBehind.image = FRONT_EMPTY_IMG;
}

- (void)startUploadPassportPictures {
}

- (void)startUploadPassportBehindPictures {
}

- (void)startAddProfileForBusiness {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
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
    [info setObject:linkFrontPassport forKey:@"cmnd_a"];
    [info setObject:linkBehindPassport forKey:@"cmnd_b"];
    //  cn_email: string (email của hồ sơ)
    
    if (mode == eAddNewBusinessProfile) {
        [info setObject:add_contact_mod forKey:@"mod"];
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] addProfileWithContent: info];
        
    }else if (mode == eEditBusinessProfile) {
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

- (void)choosedCity:(CityObject *)city {
}

#pragma mark - UIScrollview Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self closePickerView];
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return YES;
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return TRUE;
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
    if ([delegate respondsToSelector:@selector(businessProfileWasUpdated)]) {
        [delegate businessProfileWasUpdated];
    }
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(businessProfileWasCreated)]) {
        [delegate businessProfileWasCreated];
    }
}

- (void)displayInfoForProfileWithInfo: (NSDictionary *)info {
    
}

- (void)setupUIForOnlyView {
    btnEdit.hidden = FALSE;
    mode = eViewBusinessProfile;
    UIColor *disableColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0) blue:(245/255.0) alpha:1.0];
    tfBusinessName.backgroundColor = tfTaxCode.backgroundColor = tfBusinessAddress.backgroundColor = tfBusinessPhone.backgroundColor = tfCountry.backgroundColor = tfCity.backgroundColor = tfRegisterName.backgroundColor = tfBOD.backgroundColor = tfPosition.backgroundColor = tfPassport.backgroundColor = tfPhone.backgroundColor = tfAddress.backgroundColor = disableColor;
    
    tfBusinessName.enabled = tfTaxCode.enabled = tfBusinessAddress.enabled = tfBusinessPhone.enabled = tfCountry.enabled = tfCity.enabled = tfRegisterName.enabled = tfBOD.enabled = tfPosition.enabled = tfPassport.enabled = tfPhone.enabled = tfAddress.enabled = FALSE;
    
    imgCity.hidden = btnCancel.hidden = btnSave.hidden = TRUE;
    
    
}

- (void)saveAllValueBeforeChangeView {
    //  business info
    
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessName.text forKey:@"cus_company"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfTaxCode.text forKey:@"cus_taxcode"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessAddress.text forKey:@"cus_company_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBusinessPhone.text forKey:@"cus_company_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfRegisterName.text forKey:@"cus_realname"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfBOD.text forKey:@"cus_birthday"];
    [[AppDelegate sharedInstance].profileEdit setObject:[NSString stringWithFormat:@"%d", gender] forKey:@"cus_gender"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPosition.text forKey:@"cus_position"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPassport.text forKey:@"cus_idcard_number"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfPhone.text forKey:@"cus_phone"];
    [[AppDelegate sharedInstance].profileEdit setObject:tfAddress.text forKey:@"cus_address"];
    [[AppDelegate sharedInstance].profileEdit setObject:businessCity forKey:@"cus_city"];
}

- (void)tryToGetCMND_a {
}

- (void)tryToGetCMND_b {
}

- (void)reUpdateLayoutForView {
    float widthScreen = [DeviceUtils getWidthOfScreen];
    [lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(widthScreen-2*padding);
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
    
    scvContent.contentSize = CGSizeMake(widthScreen, hContent);
}

- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender {
}
- (IBAction)btnContinuePress:(UIButton *)sender {
}
@end
