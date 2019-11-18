//
//  PricingDomainsTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PricingDomainsTbvCell.h"

@implementation PricingDomainsTbvCell
@synthesize lbType, lbSetup, lbRenew, lbTransfer, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 6.0;
    float hLabel = 35.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:17.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:17.0];
    }
    
    lbType.font = lbSetup.font = lbRenew.font = lbTransfer.font = textFont;
    lbType.layer.cornerRadius = lbSetup.layer.cornerRadius = lbRenew.layer.cornerRadius = lbTransfer.layer.cornerRadius = 5.0;
    lbType.backgroundColor = lbSetup.backgroundColor = lbRenew.backgroundColor = lbTransfer.backgroundColor = GRAY_235;
    lbType.clipsToBounds = lbSetup.clipsToBounds = lbRenew.clipsToBounds = lbTransfer.clipsToBounds = TRUE;
    lbType.textColor = lbSetup.textColor = lbRenew.textColor = lbTransfer.textColor = GRAY_80;
    
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbType.mas_right).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSetup.mas_right).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbTransfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbRenew.mas_right).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showPricingContentWithInfo: (NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    lbType.text = (![AppUtils isNullOrEmpty: name]) ? SFM(@" %@ ", name) : @"";
    
    id renew = [info objectForKey:@"renew"];
    if (renew != nil && [renew isKindOfClass:[NSNumber class]]) {
        NSString *renewValue = [AppUtils convertStringToCurrencyFormat:SFM(@"%ld", [renew longValue])];
        lbSetup.text = SFM(@" %@vnđ ", renewValue);
        
    }else if (renew != nil && [renew isKindOfClass:[NSString class]]) {
        NSString *renewValue = [AppUtils convertStringToCurrencyFormat:renew];
        lbSetup.text = SFM(@" %@vnđ ", renewValue);
    }else{
        lbSetup.text = @"";
    }
    
    id setup = [info objectForKey:@"setup"];
    if (setup != nil && [setup isKindOfClass:[NSNumber class]]) {
        NSString *setupValue = [AppUtils convertStringToCurrencyFormat:SFM(@"%ld", [setup longValue])];
        lbRenew.text = SFM(@" %@vnđ ", setupValue);
        
    }else if (setup != nil && [setup isKindOfClass:[NSString class]]) {
        lbRenew.text = SFM(@" %@ ", setup);
    }else{
        lbRenew.text = @"";
    }
    
    id transfer = [info objectForKey:@"transfer"];
    if (transfer != nil && [transfer isKindOfClass:[NSNumber class]]) {
        NSString *transferValue = [AppUtils convertStringToCurrencyFormat:SFM(@"%ld", [transfer longValue])];
        lbTransfer.text = SFM(@" %@vnđ ", transferValue);
        
    }else if (transfer != nil && [transfer isKindOfClass:[NSString class]]) {
        lbTransfer.text = SFM(@" %@ ", transfer);
    }else{
        lbTransfer.text = @"";
    }
}

@end
