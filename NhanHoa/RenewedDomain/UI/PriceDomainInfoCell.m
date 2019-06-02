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
    float sizeItem = (SCREEN_WIDTH - 5*padding)/4;
    
    float fontSize = [AppDelegate sharedInstance].fontRegular.pointSize;
    lbName.font = lbRenew.font = lbSetup.font = lbTransfer.font = [UIFont fontWithName:RobotoRegular size:fontSize-1];
    lbName.textColor = lbRenew.textColor = lbSetup.textColor = TITLE_COLOR;
    lbTransfer.textColor = NEW_PRICE_COLOR;
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(sizeItem);
    }];
    
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbName.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
    }];
    
    [lbSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(sizeItem);
    }];
    
    [lbTransfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbSetup.mas_right).offset(padding);
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
        lbRenew.text = [NSString stringWithFormat:@"%@đ", renewValue];
        
    }else if (renew != nil && [renew isKindOfClass:[NSString class]]) {
        NSString *renewValue = [AppUtils convertStringToCurrencyFormat:renew];
        lbRenew.text = [NSString stringWithFormat:@"%@đ", renewValue];
    }else{
        lbRenew.text = @"";
    }
    
    id setup = [info objectForKey:@"setup"];
    if (setup != nil && [setup isKindOfClass:[NSNumber class]]) {
        NSString *setupValue = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", [setup longValue]]];
        lbSetup.text = [NSString stringWithFormat:@"%@đ", setupValue];
        
    }else if (setup != nil && [setup isKindOfClass:[NSString class]]) {
        lbSetup.text = setup;
    }else{
        lbSetup.text = @"";
    }
    
    id transfer = [info objectForKey:@"transfer"];
    if (transfer != nil && [transfer isKindOfClass:[NSNumber class]]) {
        NSString *transferValue = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", [transfer longValue]]];
        lbTransfer.text = [NSString stringWithFormat:@"%@đ", transferValue];
        
    }else if (transfer != nil && [transfer isKindOfClass:[NSString class]]) {
        lbTransfer.text = transfer;
    }else{
        lbTransfer.text = @"";
    }
}

@end
