//
//  CartDomainItemCell.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartDomainItemCell.h"
#import "CartModel.h"

@implementation CartDomainItemCell

@synthesize lbNum, lbName, lbPrice, lbDescription, lbFirstYear, icRemove, tfYears, imgArrow, btnYears, lbTotalPrice, lbSepa;
@synthesize protectView, lbProtect, lbProtectDomain, btnInfo, swProtect, lbFree, padding, hItem;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    hItem = 30.0;
    float hIcon = 38.0;
    float wTextfield = 100.0;
    float smallPadding = 5.0;
    float sizeInfo = 31.0;
    
    lbNum.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbName.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbFirstYear.font = [UIFont fontWithName:RobotoRegular size:14.0];
    tfYears.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbTotalPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    btnInfo.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    if (!IS_IPHONE && !IS_IPOD) {
        lbNum.font = lbPrice.font = tfYears.font = [AppDelegate sharedInstance].fontRegular;
        lbName.font = lbTotalPrice.font = [AppDelegate sharedInstance].fontMedium;
        lbFirstYear.font = [AppDelegate sharedInstance].fontDesc;
        
        padding = 30.0;
        hItem = 40.0;
        hIcon = 45.0;
        wTextfield = 200.0;
        smallPadding = 30.0;
        sizeInfo = 45.0;
        btnInfo.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    }
    
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self);
        make.width.mas_equalTo(25.0);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbNum);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbNum.mas_right).offset(10.0);
        make.top.bottom.equalTo(lbNum);
        make.right.equalTo(lbPrice.mas_left).offset(-10.0);
    }];
    
    [lbFirstYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPrice.mas_bottom);
        make.left.right.equalTo(lbPrice);
        make.height.mas_equalTo(hItem);
    }];
    
    lbDescription.font = lbFirstYear.font;
    lbDescription.textColor = [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1.0];
    [lbDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbName);
        make.top.bottom.equalTo(lbFirstYear);
        make.right.equalTo(lbFirstYear.mas_left).offset(-10.0);
    }];
    
    icRemove.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [icRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbDescription).offset(-6.0);
        make.top.equalTo(lbFirstYear.mas_bottom);
        make.width.height.mas_equalTo(hIcon);
    }];
    
    [tfYears mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icRemove.mas_right).offset(40.0);
        make.top.bottom.equalTo(icRemove);
        make.width.mas_equalTo(wTextfield);
    }];
    
    [btnYears setTitle:@"" forState:UIControlStateNormal];
    [btnYears mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfYears);
    }];
    
    [imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfYears.mas_right).offset(-4.0);
        make.centerY.equalTo(tfYears.mas_centerY);
        make.height.mas_equalTo(12.0);
        make.width.mas_equalTo(15.0);
    }];
    
    lbTotalPrice.textColor = NEW_PRICE_COLOR;
    [lbTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfYears);
        make.right.equalTo(self).offset(-padding);
        make.left.equalTo(tfYears).offset(10.0);
    }];
    
    lbSepa.backgroundColor = GRAY_215;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbName);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    protectView.clipsToBounds = TRUE;
    protectView.backgroundColor = GRAY_235;
    [protectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfYears.mas_bottom).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(2*hItem);
    }];
    
    lbFree.text = SFM(@"(%@)", text_free);
    lbFree.font = [AppDelegate sharedInstance].fontItalic;
    
    float sizeText = [AppUtils getSizeWithText:lbFree.text withFont:lbFree.font].width + 30.0;
    [lbFree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(protectView).offset(-5.0);
        make.centerY.equalTo(protectView.mas_centerY);
        make.width.mas_equalTo(sizeText);
    }];
    
    [swProtect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbFree.mas_left).offset(-10.0);
        make.centerY.equalTo(protectView.mas_centerY);
        make.width.mas_equalTo(49.0);
        make.height.mas_equalTo(31.0);
    }];
    
    [btnInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(swProtect.mas_left).offset(-10.0);
        make.centerY.equalTo(swProtect.mas_centerY);
        make.width.height.mas_equalTo(sizeInfo);
    }];
    
    lbProtect.text = text_whois_protect;
    lbProtect.font = [AppDelegate sharedInstance].fontMedium;
    [lbProtect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btnInfo.mas_left).offset(-10.0);
        make.bottom.equalTo(protectView.mas_centerY).offset(-2.0);
        make.left.equalTo(protectView).offset(smallPadding);
    }];
    
    lbProtectDomain.text = @"";
    lbProtectDomain.textColor = TITLE_COLOR;
    lbProtectDomain.font = [AppDelegate sharedInstance].fontNormal;
    [lbProtectDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbProtect);
        make.top.equalTo(protectView.mas_centerY).offset(2.0);
    }];
}

- (void)frameForShowWhoisProtectView: (BOOL)show {
    if (show) {
        [protectView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tfYears.mas_bottom).offset(7.5);
            make.left.equalTo(self).offset(padding);
            make.right.equalTo(self).offset(-padding);
            make.height.mas_equalTo(2*hItem);
        }];
    }else{
        [protectView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tfYears.mas_bottom).offset(7.5);
            make.left.equalTo(self).offset(padding);
            make.right.equalTo(self).offset(-padding);
            make.height.mas_equalTo(0.0);
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)swProtectChanged:(UISwitch *)sender {
    int index = (int)[sender tag];
    NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: index];
    NSString *value = (sender.on) ? @"1" : @"0";
    [domainInfo setObject:value forKey:whois_protect];
}

- (IBAction)btnInfoPress:(UIButton *)sender {
    [[AppDelegate sharedInstance].cartWindow makeToast:text_hide_info_when_whois duration:3.0 position:CSToastPositionCenter];
}

- (void)displayDataWithInfo: (NSDictionary *)info forYear: (int)yearsForRenew {
    if (info == nil) {
        lbPrice.text = lbTotalPrice.text = @"N/A";
    }else{
        id price = [info objectForKey:@"price"];
        long priceValue = 0;
        if (price != nil && [price isKindOfClass:[NSString class]]) {
            priceValue = (long)[price longLongValue];
            
            NSString *strPrice = [AppUtils convertStringToCurrencyFormat: price];
            lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", strPrice];
            
        }else if (price != nil && [price isKindOfClass:[NSNumber class]]) {
            priceValue = [price longValue];
            
            NSString *strPrice = [NSString stringWithFormat:@"%ld", [price longValue]];
            strPrice = [AppUtils convertStringToCurrencyFormat: strPrice];
            lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", strPrice];
        }else{
            lbPrice.text = @"N/A";
        }
        
        if (priceValue > 0 && yearsForRenew > 0) {
            long totalPrice = priceValue * yearsForRenew;
            NSString *strTotal = [NSString stringWithFormat:@"%ld", totalPrice];
            strTotal = [AppUtils convertStringToCurrencyFormat: strTotal];
            lbTotalPrice.text = [NSString stringWithFormat:@"%@VNĐ", strTotal];
        }else{
            lbTotalPrice.text = @"N/A";
        }
    }
}

- (void)displayDomainInfoForCart: (NSDictionary *)domainInfo {
    if (domainInfo == nil) {
        return;
    }
    
    NSString *domainName = [domainInfo objectForKey:@"domain"];
    lbName.text = lbProtectDomain.text = (![AppUtils isNullOrEmpty: domainName]) ? domainName : @"";
    
    NSString *price = @"";
    id firstYearPrice = [domainInfo objectForKey:@"price_first_year"];
    if (firstYearPrice != nil && [firstYearPrice isKindOfClass:[NSNumber class]]) {
        price = [NSString stringWithFormat:@"%ld", [firstYearPrice longValue]];
        price = [AppUtils convertStringToCurrencyFormat: price];
        
    }else if (firstYearPrice != nil && [firstYearPrice isKindOfClass:[NSString class]]) {
        price = [NSString stringWithFormat:@"%ld", (long)[firstYearPrice longLongValue]];
        price = [AppUtils convertStringToCurrencyFormat: price];
    }
    lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", price];
    
    NSString *years = [domainInfo objectForKey:year_for_domain];
    tfYears.text = [NSString stringWithFormat:@"%@ năm", years];
    
    NSString *whoisProtect = [domainInfo objectForKey:whois_protect];
    if ([whoisProtect isEqualToString:@"1"]) {
        [swProtect setOn: TRUE];
    }else{
        [swProtect setOn: FALSE];
    }
    
    lbDescription.hidden = TRUE;

    //  total price
    long totalPrice = [[CartModel getInstance] getTotalPriceForDomain: domainInfo];
    NSString *total = [NSString stringWithFormat:@"%ld", totalPrice];
    total = [AppUtils convertStringToCurrencyFormat: total];
    lbTotalPrice.text = [NSString stringWithFormat:@"%@VNĐ", total];
    
    BOOL isNationalDomain = [AppUtils checkDomainIsNationalDomain: domainName];
    [self frameForShowWhoisProtectView: !isNationalDomain];
}

@end
