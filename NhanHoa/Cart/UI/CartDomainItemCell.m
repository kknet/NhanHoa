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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    lbFirstYear.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbFirstYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(25.0);
    }];
    
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbFirstYear.mas_top);
        make.right.equalTo(self.lbFirstYear.mas_right);
        //  make.width.mas_equalTo(25.0);
    }];
    
    lbNum.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self.lbPrice);
        make.width.mas_equalTo(25.0);
    }];
    
    lbName.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbNum.mas_right).offset(10.0);
        make.top.bottom.equalTo(self.lbPrice);
        make.right.equalTo(self.lbPrice.mas_left).offset(-10.0);
    }];
    
    lbDescription.font = lbFirstYear.font;
    lbDescription.textColor = [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1.0];
    [lbDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbName);
        make.top.bottom.equalTo(self.lbFirstYear);
        make.right.equalTo(self.lbFirstYear.mas_left).offset(-10.0);
    }];
    
    icRemove.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [icRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbDescription).offset(-6.0);
        make.top.equalTo(self.mas_centerY).offset(2.0);
        make.width.height.mas_equalTo(38.0);
    }];
    
    tfYears.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfYears mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icRemove.mas_right).offset(40.0);
        make.top.bottom.equalTo(self.icRemove);
        make.width.mas_equalTo(100.0);
    }];
    
    [btnYears setTitle:@"" forState:UIControlStateNormal];
    [btnYears mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.tfYears);
    }];
    
    [imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfYears.mas_right).offset(-4.0);
        make.centerY.equalTo(self.tfYears.mas_centerY);
        make.height.mas_equalTo(12.0);
        make.width.mas_equalTo(15.0);
    }];
    
    lbTotalPrice.textColor = NEW_PRICE_COLOR;
    lbTotalPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.tfYears);
        make.right.equalTo(self).offset(-padding);
        make.left.equalTo(self.tfYears).offset(10.0);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbName);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    lbName.text = (![AppUtils isNullOrEmpty: domainName]) ? domainName : @"";
    
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
    
    lbDescription.hidden = TRUE;

    //  total price
    long totalPrice = [[CartModel getInstance] getTotalPriceForDomain: domainInfo];
    NSString *total = [NSString stringWithFormat:@"%ld", totalPrice];
    total = [AppUtils convertStringToCurrencyFormat: total];
    lbTotalPrice.text = [NSString stringWithFormat:@"%@VNĐ", total];
    
//    available = 1;
//    domain = "dailyxanh.net";
//    flag = 0;
//    "price_first_year" = 219000;
//    "price_next_years" = 219000;
//    "price_vat_first_year" = 21900;
//    "price_vat_next_year" = 21900;
//    "total_first_year" = 240900;
//    "total_next_years" = 240900;
//    vat = 10;
//    "year_for_domain" = 1;
    
}

@end
