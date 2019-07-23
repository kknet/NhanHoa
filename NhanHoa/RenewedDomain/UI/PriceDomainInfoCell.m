//
//  PriceDomainInfoCell.m
//  NhanHoa
//
//  Created by Khai Leo on 6/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PriceDomainInfoCell.h"

@implementation PriceDomainInfoCell
@synthesize lbName, lbRenew, lbSetup, lbTransfer, imgSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    if ([AppUtils isScreen320]) {
        padding = 5.0;
    }
    
    float smallPadding = 7.5;
    float sizeItem = (SCREEN_WIDTH - 2*padding - 3*smallPadding)/4;
    
    float fontSize = [AppDelegate sharedInstance].fontRegular.pointSize;
    lbName.font = lbRenew.font = lbSetup.font = lbTransfer.font = [UIFont fontWithName:RobotoRegular size:fontSize-3];
    lbName.textColor = lbRenew.textColor = lbSetup.textColor = TITLE_COLOR;
    lbTransfer.textColor = NEW_PRICE_COLOR;
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(sizeItem-10.0);
    }];
    
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbName.mas_right).offset(smallPadding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(sizeItem+5);
    }];
    
    [lbSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbRenew.mas_right).offset(smallPadding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(sizeItem+5);
    }];
    
    [lbTransfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbSetup.mas_right).offset(smallPadding);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showContentWithInfo: (NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    lbName.text = (![AppUtils isNullOrEmpty: name]) ? name : @"";
    
    id renew = [info objectForKey:@"renew"];
    if (renew != nil && [renew isKindOfClass:[NSNumber class]]) {
        NSString *renewValue = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", [renew longValue]]];
        lbSetup.text = [NSString stringWithFormat:@"%@VNĐ", renewValue];
        
    }else if (renew != nil && [renew isKindOfClass:[NSString class]]) {
        NSString *renewValue = [AppUtils convertStringToCurrencyFormat:renew];
        lbSetup.text = [NSString stringWithFormat:@"%@VNĐ", renewValue];
    }else{
        lbSetup.text = @"";
    }
    
    id setup = [info objectForKey:@"setup"];
    if (setup != nil && [setup isKindOfClass:[NSNumber class]]) {
        NSString *setupValue = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", [setup longValue]]];
        lbRenew.text = [NSString stringWithFormat:@"%@VNĐ", setupValue];
        
    }else if (setup != nil && [setup isKindOfClass:[NSString class]]) {
        lbRenew.text = setup;
    }else{
        lbRenew.text = @"";
    }
    
    id transfer = [info objectForKey:@"transfer"];
    if (transfer != nil && [transfer isKindOfClass:[NSNumber class]]) {
        NSString *transferValue = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", [transfer longValue]]];
        lbTransfer.text = [NSString stringWithFormat:@"%@VNĐ", transferValue];
        
    }else if (transfer != nil && [transfer isKindOfClass:[NSString class]]) {
        lbTransfer.text = transfer;
    }else{
        lbTransfer.text = @"";
    }
}

@end
