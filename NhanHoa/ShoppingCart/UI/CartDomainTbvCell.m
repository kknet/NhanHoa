//
//  CartDomainTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartDomainTbvCell.h"
#import "CartModel.h"

@implementation CartDomainTbvCell
@synthesize lbNo, lbDomain, lbFirstPriceTitle, lbFirstPriceMoney, tfYear, imgArr, btnSelectYear, icRemove, lbTotalMoney, lbSepa, lbWhoisProtect, icShowDesc, swWhoIsProtect, lbWhoisProtectFee, viewWhoisProtect, lbBotSepa;
@synthesize hBTN;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float hLabel = 30.0;
    hBTN = 45.0;
    
    tfYear.textColor = BLUE_COLOR;
    lbDomain.textColor = lbTotalMoney.textColor = GRAY_50;
    lbFirstPriceTitle.textColor = lbFirstPriceMoney.textColor = lbWhoisProtect.textColor = GRAY_80;
    lbWhoisProtectFee.textColor = GRAY_100;
    
    float paddingTop = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        hBTN = 40.0;
        paddingTop = 10.0;
        hLabel = 20.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hBTN = 40.0;
        padding = 10.0;
        paddingTop = 10.0;
        hLabel = 25.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hBTN = 45.0;
        paddingTop = 15.0;
        hLabel = 30.0;
    }
    
    lbDomain.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize+1];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(paddingTop);
        make.left.equalTo(self).offset(padding + 25.0 + 3.0);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbNo.font = textFont;
    [lbNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(lbDomain.mas_centerY);
        make.width.mas_equalTo(25.0);
    }];
    
    lbFirstPriceMoney.font = lbFirstPriceTitle.font;
    [lbFirstPriceMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbDomain);
        make.top.equalTo(lbDomain.mas_bottom);
        make.height.mas_equalTo(hLabel-5.0);
    }];
    
    lbFirstPriceTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Price for first year"];
    lbFirstPriceTitle.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-1];
    [lbFirstPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbDomain);
        make.top.bottom.equalTo(lbFirstPriceMoney);
        make.right.equalTo(lbFirstPriceMoney.mas_left).offset(-5.0);
    }];
    
    tfYear.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [tfYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbFirstPriceTitle);
        make.top.equalTo(lbFirstPriceTitle.mas_bottom).offset(15.0);
        make.height.mas_equalTo(hBTN);
        make.width.mas_equalTo(100.0);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfYear).offset(-5.0);
        make.centerY.equalTo(tfYear.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    
    [btnSelectYear setTitle:@"" forState:UIControlStateNormal];
    [btnSelectYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfYear);
    }];
    
    icRemove.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icRemove mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(tfYear.mas_centerY);
        make.width.height.mas_equalTo(hBTN);
    }];
    
    lbTotalMoney.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbTotalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbFirstPriceMoney);
        make.top.bottom.equalTo(tfYear);
        make.left.equalTo(icRemove.mas_right).offset(5.0);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfYear.mas_bottom).offset(15.0);
        make.left.equalTo(tfYear);
        make.right.equalTo(lbTotalMoney);
        make.height.mas_equalTo(1.0);
    }];
    
    //  view whois protect
    viewWhoisProtect.clipsToBounds = TRUE;
    [viewWhoisProtect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa.mas_bottom);
        make.left.right.equalTo(lbSepa);
        make.height.mas_equalTo(hBTN + 25.0);
    }];

    lbWhoisProtect.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-1.0];
    [lbWhoisProtect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(viewWhoisProtect);
    }];

    icShowDesc.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icShowDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbWhoisProtect.mas_right).offset(5.0);
        make.centerY.equalTo(viewWhoisProtect.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];

    lbWhoisProtectFee.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Free"];
    lbWhoisProtectFee.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-1.0];
    [lbWhoisProtectFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(viewWhoisProtect);
    }];
    
    if (swWhoIsProtect == nil) {
        float originX = ((SCREEN_WIDTH - 2*padding - 25.0 - 3.0) - 60.0)/2;
        swWhoIsProtect = [[KLCustomSwitch alloc] initWithState:TRUE frame:CGRectMake(originX + 20.0, ((hBTN + 10.0) - 30.0)/2, 60.0, 30.0)];
        swWhoIsProtect.delegate = self;
        swWhoIsProtect.enabled = TRUE;
        [viewWhoisProtect addSubview: swWhoIsProtect];
    }

    lbBotSepa.backgroundColor = [UIColor colorWithRed:(238/255.0) green:(238/255.0)
                                                 blue:(238/255.0) alpha:1.0];
    [lbBotSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(5.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayDomainInfoForCart: (NSDictionary *)domainInfo {
    if (domainInfo == nil) {
        return;
    }
    
    NSString *domainName = [domainInfo objectForKey:@"domain"];
    lbDomain.text = (![AppUtils isNullOrEmpty: domainName]) ? domainName : @"";
    
    NSString *price = @"";
    id firstYearPrice = [domainInfo objectForKey:@"price_first_year"];
    if (firstYearPrice != nil && [firstYearPrice isKindOfClass:[NSNumber class]]) {
        price = SFM(@"%ld", [firstYearPrice longValue]);
        price = [AppUtils convertStringToCurrencyFormat: price];
        
    }else if (firstYearPrice != nil && [firstYearPrice isKindOfClass:[NSString class]]) {
        price = SFM(@"%ld", (long)[firstYearPrice longLongValue]);
        price = [AppUtils convertStringToCurrencyFormat: price];
    }
    lbFirstPriceMoney.text = SFM(@"%@VNĐ", price);
    
    NSString *years = [domainInfo objectForKey:year_for_domain];
    tfYear.text = SFM(@"%@ năm", years);
    
    NSString *whoisProtect = [domainInfo objectForKey:whois_protect];
    if ([whoisProtect isEqualToString:@"1"]) {
        [swWhoIsProtect setUIForOnState];
    }else{
        [swWhoIsProtect setUIForOffState];
    }
    
    //  total price
    long totalPrice = [[CartModel getInstance] getTotalPriceForDomain: domainInfo];
    NSString *total = SFM(@"%ld", totalPrice);
    total = [AppUtils convertStringToCurrencyFormat: total];
    lbTotalMoney.text = SFM(@"%@VNĐ", total);

    BOOL isNationalDomain = [AppUtils checkDomainIsNationalDomain: domainName];
    [self frameForShowWhoisProtectView: !isNationalDomain];
}

- (void)frameForShowWhoisProtectView: (BOOL)show {
    if (show) {
        lbSepa.hidden = FALSE;
        [viewWhoisProtect mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hBTN + 10.0);
        }];
    }else{
        lbSepa.hidden = TRUE;
        [viewWhoisProtect mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - Custom switch delegate
-(void)switchValueChangedOn {
    int index = (int)[swWhoIsProtect tag];
    if (index < [[CartModel getInstance] countItemInCart]) {
        NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: index];
        [domainInfo setObject:@"1" forKey:whois_protect];
    }
}

-(void)switchValueChangedOff {
    int index = (int)[swWhoIsProtect tag];
    if (index < [[CartModel getInstance] countItemInCart]) {
        NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: index];
        [domainInfo setObject:@"0" forKey:whois_protect];
    }
}

@end
