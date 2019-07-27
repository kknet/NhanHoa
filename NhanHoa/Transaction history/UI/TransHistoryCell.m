//
//  TransHistoryCell.m
//  NhanHoa
//
//  Created by Khai Leo on 6/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "TransHistoryCell.h"

@implementation TransHistoryCell
@synthesize imgType, lbTime, lbMoney, lbTitle, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 10.0;
    
    imgType.clipsToBounds = TRUE;
    imgType.layer.cornerRadius = 34.0/2;
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(padding);
        make.bottom.equalTo(self.mas_centerY).offset(-4.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbTitle.mas_right);
        make.top.equalTo(self.mas_centerY).offset(4.0);
        make.width.mas_equalTo(130.0);
    }];
    
    [lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle);
        make.top.equalTo(self.lbMoney);
        make.right.equalTo(self.lbMoney.mas_left).offset(-padding);
    }];
    
    lbSepa.backgroundColor = BORDER_COLOR;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    lbTime.textColor = UIColor.grayColor;
    lbMoney.textColor = lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [AppDelegate sharedInstance].fontMedium;
    lbTime.font = [AppDelegate sharedInstance].fontDesc;
    lbMoney.font = [AppDelegate sharedInstance].fontRegular;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayDataWithInfo: (NSDictionary *)info {
    NSString *amount = [info objectForKey:@"amount"];
    if (![AppUtils isNullOrEmpty: amount]) {
        NSString *strAmount = [AppUtils convertStringToCurrencyFormat: amount];
        NSString *type = [info objectForKey:@"type"];
        if ([type isKindOfClass:[NSString class]]) {
            if ([type isEqualToString:@"0"]) {
                lbMoney.text = [NSString stringWithFormat:@"+%@VNĐ", strAmount];
                lbMoney.textColor = GREEN_COLOR;
            }else{
                lbMoney.text = [NSString stringWithFormat:@"-%@VNĐ", strAmount];
                lbMoney.textColor = NEW_PRICE_COLOR;
            }
        }else if ([type isKindOfClass:[NSNumber class]]) {
            if ([type intValue] == 0) {
                lbMoney.text = [NSString stringWithFormat:@"+%@VNĐ", strAmount];
                lbMoney.textColor = GREEN_COLOR;
            }else{
                lbMoney.text = [NSString stringWithFormat:@"-%@VNĐ", strAmount];
                lbMoney.textColor = NEW_PRICE_COLOR;
            }
        }
    }
    NSString *content = [info objectForKey:@"content"];
    lbTitle.text = (![AppUtils isNullOrEmpty: content])? content : @"";
    
    id time = [info objectForKey:@"time"];
    if ([time isKindOfClass:[NSString class]]) {
        NSString *dateTime = [AppUtils getDateTimeStringFromTimerInterval:(long)[time longLongValue]];
        lbTime.text = (![AppUtils isNullOrEmpty: dateTime])? dateTime : @"";
        
    }else if ([time isKindOfClass:[NSNumber class]]) {
        NSLog(@"number");
    }
}

@end
