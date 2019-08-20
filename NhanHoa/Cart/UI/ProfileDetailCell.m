//
//  ProfileDetailCell.m
//  NhanHoa
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailCell.h"

@implementation ProfileDetailCell
@synthesize viewDomain, lbDomain, viewHeader, lbTypeName, lbTypeNameValue, lbProfileName, lbProfileNameValue, lbCompanyValue, btnChoose, viewDetail, lbDomainType, lbDomainTypeValue, lbName, lbNameValue, lbBOD, lbBODValue, lbPassport, lbPassportValue, lbAddress, lbAddressValue, lbPhone, lbPhoneValue, lbEmail, lbEmailValue, iconPassport, lbTitlePassport, imgFrontPassport, imgBehindPassport, lbSepa, lbFront, lbBehind;

@synthesize sizeType, sizeProfile, profile, delegate, hLabel, padding, hHeaderItem, profileType;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    float hBTN = 35.0;
    hHeaderItem = 25.0;
    hLabel = 30.0;
    
    if ([DeviceUtils isScreen320] || [DeviceUtils isScreen375]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hHeaderItem = 30.0;
        hBTN = 45.0;
        hLabel = 40.0;
    }
    
    //  header: 10 + 20 + 20 + 10
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(3*hHeaderItem);
    }];
    
    [viewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(3*hHeaderItem);
    }];
    
    lbDomain.textColor = TITLE_COLOR;
    lbDomain.font = [AppDelegate sharedInstance].fontRegular;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewDomain).offset(padding);
        make.right.equalTo(viewDomain).offset(-padding);
        make.top.bottom.equalTo(viewDomain);
    }];
    
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    btnChoose.layer.cornerRadius = hBTN/2;
    
    float sizeText = [AppUtils getSizeWithText:text_unselect withFont:[AppDelegate sharedInstance].fontRegular].width + 20.0;
    
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewHeader.mas_centerY);
        make.right.equalTo(self.viewHeader).offset(-padding);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  get size
    UIFont *textFont = [AppDelegate sharedInstance].fontRegular;
    sizeType = [AppUtils getSizeWithText:@"Hồ sơ:" withFont:textFont].width + 10;
    sizeProfile = [AppUtils getSizeWithText:@"Người đại diện:" withFont: textFont].width + 10;
    
    //  set font and color
    lbTypeName.font = lbProfileName.font = textFont;
    lbTypeNameValue.font = lbCompanyValue.font = lbProfileNameValue.font = [AppDelegate sharedInstance].fontMedium;
    lbTypeName.textColor = lbTypeNameValue.textColor = lbCompanyValue.textColor = lbProfileName.textColor = lbProfileNameValue.textColor = TITLE_COLOR;
    
    //  company
    [lbCompanyValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(padding);
        make.centerY.equalTo(viewHeader.mas_centerY);
        make.height.mas_equalTo(hHeaderItem);
        make.right.equalTo(btnChoose.mas_left).offset(-5.0);
    }];
    
    //  domain type
    [lbTypeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbCompanyValue);
        make.bottom.equalTo(lbCompanyValue.mas_top);
        make.height.mas_equalTo(hHeaderItem);
        make.width.mas_equalTo(sizeType);
    }];
    
    [lbTypeNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTypeName.mas_right);
        make.right.equalTo(lbCompanyValue.mas_right);
        make.top.bottom.equalTo(lbTypeName);
    }];
    
    //  profile name
    [lbProfileName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbCompanyValue);
        make.top.equalTo(lbCompanyValue.mas_bottom);
        make.height.mas_equalTo(hHeaderItem);
        make.width.mas_equalTo(sizeProfile);
    }];
    
    [lbProfileNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbProfileName.mas_right);
        make.right.equalTo(lbCompanyValue.mas_right);
        make.top.bottom.equalTo(lbProfileName);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.height.mas_equalTo(1.0);
    }];
    
    viewDetail.clipsToBounds = TRUE;
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(lbSepa.mas_top);
        make.top.equalTo(viewHeader.mas_bottom);
    }];
    
    
    float wSmallItem = [AppUtils getSizeWithText:@"Họ tên đầy đủ:" withFont:[AppDelegate sharedInstance].fontRegular].width + 5;
    
    lbDomainType.textColor = lbDomainTypeValue.textColor = lbName.textColor = lbNameValue.textColor = lbBOD.textColor = lbBODValue.textColor = lbPassport.textColor = lbPassportValue.textColor = lbAddress.textColor = lbAddressValue.textColor = lbPhone.textColor = lbPhoneValue.textColor = lbEmail.textColor = lbEmailValue.textColor = lbTitlePassport.textColor = lbFront.textColor = lbBehind.textColor = TITLE_COLOR;
    
    lbDomainType.font = lbName.font = lbBOD.font = lbPassport.font = lbAddress.font = lbPhone.font = lbEmail.font = lbTitlePassport.font = lbFront.font = lbBehind.font = [AppDelegate sharedInstance].fontNormal;
    
    lbDomainTypeValue.font = lbNameValue.font = lbBODValue.font = lbPassportValue.font = lbAddressValue.font = lbPhoneValue.font = lbEmailValue.font = [AppDelegate sharedInstance].fontMediumDesc;
    
    
    [lbDomainType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(viewDetail).offset(padding);
        make.height.mas_equalTo(hLabel);
        make.width.mas_equalTo(wSmallItem);
    }];
    
    [lbDomainTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomainType);
        make.left.equalTo(lbDomainType.mas_right);
        make.right.equalTo(viewDetail).offset(-padding);
    }];
    
    //  fullname
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomainType.mas_bottom);
        make.left.right.equalTo(lbDomainType);
        make.height.equalTo(lbDomainType.mas_height);
    }];
    
    [lbNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbName);
        make.left.right.equalTo(lbDomainTypeValue);
    }];
    
    //  BOD
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.equalTo(lbName.mas_height);
    }];
    
    [lbBODValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbBOD);
        make.left.right.equalTo(lbNameValue);
    }];
    
    //  Passport
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBOD.mas_bottom);
        make.left.right.equalTo(lbBOD);
        make.height.equalTo(lbBOD.mas_height);
    }];
    
    [lbPassportValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPassport);
        make.left.right.equalTo(lbBODValue);
    }];
    
    //  Address
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPassport.mas_bottom);
        make.left.right.equalTo(lbPassport);
        make.height.equalTo(lbPassport.mas_height);
    }];
    
    [lbAddressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAddress);
        make.left.right.equalTo(lbPassportValue);
        make.height.mas_equalTo(2*hLabel);
    }];
    
    //  Phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAddressValue.mas_bottom);
        make.left.right.equalTo(lbAddress);
        make.height.equalTo(lbAddress.mas_height);
    }];
    
    [lbPhoneValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPhone);
        make.left.right.equalTo(lbAddressValue);
    }];
    
    //  Email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhone.mas_bottom);
        make.left.right.equalTo(lbPhone);
        make.height.equalTo(lbPhone.mas_height);
    }];
    
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmail);
        make.left.right.equalTo(lbPhoneValue);
    }];
    
    //  passport
    [iconPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom).offset((hLabel-20)/2);
        make.left.equalTo(lbEmail.mas_left);
        make.width.height.mas_equalTo(20.0);
    }];
    
    [lbTitlePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(iconPassport.mas_centerY);
        make.left.equalTo(iconPassport.mas_right).offset(5.0);
        make.right.equalTo(viewDetail).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    float wItem = (SCREEN_WIDTH-3*padding)/2;
    float hItem = wItem * 2/3;
    [imgFrontPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitlePassport.mas_bottom);
        make.left.equalTo(viewDetail).offset(padding);
        make.width.mas_equalTo(wItem);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgFrontPassport);
        make.top.equalTo(imgFrontPassport.mas_bottom);
        make.height.equalTo(lbName.mas_height);
    }];
    
    [imgBehindPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(imgFrontPassport);
        make.left.equalTo(imgFrontPassport.mas_right).offset(padding);
        make.right.equalTo(viewDetail).offset(-padding);
    }];
    
    [lbBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgBehindPassport);
        make.top.equalTo(imgBehindPassport.mas_bottom);
        make.height.equalTo(lbName.mas_height);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateUIForBusinessProfile: (BOOL)business {
    if (business) {
        [viewHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(3*hHeaderItem + 20.0);
        }];
        
        [viewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(3*hHeaderItem + 20.0);
        }];
        
        //  domain type
        [lbTypeName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbCompanyValue);
            make.bottom.equalTo(lbCompanyValue.mas_top);
            make.height.mas_equalTo(hHeaderItem);
            make.width.mas_equalTo(sizeType);
        }];
        
        //  profile name
        [lbProfileName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbCompanyValue);
            make.top.equalTo(lbCompanyValue.mas_bottom);
            make.height.mas_equalTo(hHeaderItem);
            make.width.mas_equalTo(sizeProfile);
        }];
        
        lbCompanyValue.textColor = TITLE_COLOR;
    }else{
        [viewHeader mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(2*hHeaderItem + 20.0);
        }];
        [viewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(2*hHeaderItem + 20.0);
        }];
        
        [lbTypeName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewHeader).offset(padding);
            make.bottom.equalTo(viewHeader.mas_centerY);
            make.width.mas_equalTo(sizeType);
            make.height.mas_equalTo(hHeaderItem);
        }];
        
        //  profile name
        [lbProfileName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbCompanyValue);
            make.top.equalTo(lbTypeName.mas_bottom);
            make.height.mas_equalTo(hHeaderItem);
            make.width.mas_equalTo(sizeProfile);
        }];
        
        lbCompanyValue.textColor = UIColor.clearColor;
    }
}

- (void)showProfileDetailWithDomainView {
    viewHeader.hidden = TRUE;
    viewDomain.hidden = FALSE;
    
    float hDomain = 40.0;
    if (!IS_IPHONE && !IS_IPOD) {
        hDomain = 60.0;
    }
    
    [viewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(hDomain);
    }];
    
    [viewDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(lbSepa.mas_top);
        make.top.equalTo(viewDomain.mas_bottom);
    }];
}

- (void)displayProfileInfo: (NSDictionary *)info
{
    profile = [[NSDictionary alloc] initWithDictionary: info];
    
    NSString *type = [info objectForKey:@"cus_own_type"];
    if ([type isEqualToString:@"0"]) {
        lbTypeNameValue.text = lbDomainTypeValue.text = text_personal;
    }else{
        lbTypeNameValue.text = lbDomainTypeValue.text = text_business;
        
        NSString *cus_company = [info objectForKey:@"cus_company"];
        if (cus_company != nil) {
            lbProfileNameValue.text = cus_company;
        }else{
            lbProfileNameValue.text = @"";
        }
    }
    
    //  Show profile name
    NSString *name = [info objectForKey:@"cus_realname"];
    lbProfileNameValue.text = lbNameValue.text = (![AppUtils isNullOrEmpty: name])? name : @"";
    
    NSString *cus_birthday = [info objectForKey:@"cus_birthday"];
    lbBODValue.text = (![AppUtils isNullOrEmpty: cus_birthday])? cus_birthday : @"";
    
    NSString *cus_card_id = [info objectForKey:@"cus_idcard_number"];
    lbPassportValue.text = (![AppUtils isNullOrEmpty: cus_card_id])? cus_card_id : @"";
    
    NSString *cus_contract_address = [info objectForKey:@"cus_contract_address"];
    if (![AppUtils isNullOrEmpty: cus_contract_address]) {
        lbAddressValue.text = cus_contract_address;
    }else{
        cus_contract_address = [info objectForKey:@"cus_address"];
        lbAddressValue.text = (![AppUtils isNullOrEmpty: cus_contract_address])? cus_contract_address : @"";
    }
    
    NSString *cus_contract_phone = [info objectForKey:@"cus_contract_phone"];
    if (![AppUtils isNullOrEmpty: cus_contract_phone]) {
        lbPhoneValue.text = cus_contract_phone;
    }else{
        cus_contract_phone = [info objectForKey:@"cus_phone"];
        lbPhoneValue.text = (![AppUtils isNullOrEmpty: cus_contract_phone])? cus_contract_phone : @"";
    }
    
    NSString *cus_email = [info objectForKey:@"cus_rl_email"];
    if (![AppUtils isNullOrEmpty: cus_email])
    {
        lbEmailValue.text = cus_email;
    }else{
        cus_email = [info objectForKey:@"cus_email"];
        lbEmailValue.text = (![AppUtils isNullOrEmpty: cus_email]) ? cus_email : @"";
    }
    
    NSString *cmnd_a = [info objectForKey:@"cmnd_a"];
    if (![AppUtils isNullOrEmpty: cmnd_a]) {
        [imgFrontPassport sd_setImageWithURL:[NSURL URLWithString: cmnd_a] placeholderImage:FRONT_EMPTY_IMG];
    }else{
        NSString *idcardFrontImg = [info objectForKey:@"cus_idcard_front_img"];
        if (![AppUtils isNullOrEmpty: idcardFrontImg]) {
            [imgFrontPassport sd_setImageWithURL:[NSURL URLWithString: idcardFrontImg] placeholderImage:FRONT_EMPTY_IMG];
        }else{
            imgFrontPassport.image = FRONT_EMPTY_IMG;
        }
    }
    
    NSString *cmnd_b = [info objectForKey:@"cmnd_b"];
    if (![AppUtils isNullOrEmpty: cmnd_b]) {
        [imgBehindPassport sd_setImageWithURL:[NSURL URLWithString: cmnd_b] placeholderImage:BEHIND_EMPTY_IMG];
    }else{
        NSString *idcardBackImg = [info objectForKey:@"cus_idcard_back_img"];
        if (![AppUtils isNullOrEmpty: idcardBackImg]) {
            [imgBehindPassport sd_setImageWithURL:[NSURL URLWithString: idcardBackImg] placeholderImage:FRONT_EMPTY_IMG];
        }else{
            imgBehindPassport.image = FRONT_EMPTY_IMG;
        }
    }
}

- (IBAction)btnChoosePress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(selectedProfile:)]) {
        [delegate selectedProfile: profile];
    }
}

- (void)tryToUpdateUIWithAddress {
    float wSmallItem = [AppUtils getSizeWithText:@"Họ tên đầy đủ:" withFont:[AppDelegate sharedInstance].fontRegular].width + 5;
    float hText = [AppUtils getSizeWithText:lbAddressValue.text withFont:lbAddressValue.font andMaxWidth:(SCREEN_WIDTH - 2*padding - wSmallItem)].height + 10.0;
    if (hText < hHeaderItem) {
        hText = hHeaderItem;
    }
    
    [lbAddressValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbAddress.mas_centerY);
        make.left.right.equalTo(lbPassportValue);
        make.height.mas_equalTo(hText);
    }];
    
}
@end
