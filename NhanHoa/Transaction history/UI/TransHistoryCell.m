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
        make.width.height.mas_equalTo(34.0);
    }];
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(5.0);
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbTitle.mas_right);
        make.top.equalTo(self.mas_centerY).offset(2.0);
        make.width.mas_equalTo(70.0);
    }];
    
    [lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle);
        make.top.equalTo(self.lbMoney);
        make.right.equalTo(self.lbMoney.mas_left).offset(-5.0);
    }];
    
    lbSepa.backgroundColor = BORDER_COLOR;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbTitle);
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    lbTime.textColor = lbMoney.textColor = lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [AppDelegate sharedInstance].fontMedium;
    lbTime.font = lbMoney.font = [AppDelegate sharedInstance].fontDesc;
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
                lbMoney.text = [NSString stringWithFormat:@"-%@VNĐ", strAmount];
            }else{
                lbMoney.text = [NSString stringWithFormat:@"+%@VNĐ", strAmount];
            }
        }else if ([type isKindOfClass:[NSNumber class]]) {
            if ([type intValue] == 0) {
                lbMoney.text = [NSString stringWithFormat:@"-%@VNĐ", strAmount];
            }else{
                lbMoney.text = [NSString stringWithFormat:@"+%@VNĐ", strAmount];
            }
        }
    }
    
    NSString *content = [info objectForKey:@"content"];
    lbTitle.text = (![AppUtils isNullOrEmpty: content])? content : @"";
    
    id time = [info objectForKey:@"time"];
    if ([time isKindOfClass:[NSString class]]) {
        [AppUtils getDateTimeStringNotHaveSecondsFromDate: ]
        + (NSString *)getCurrentDateTimeNotHaveSecondsFromDate: (NSDate *)date
        
        [AppUtils get]
        NSLog(@"string");
    }else if ([time isKindOfClass:[NSNumber class]]) {
        NSLog(@"number");
    }
    
//    amount = 10000;
//    content = "N\U1ea1p ti\U1ec1n v\U00e0o t\U00e0i kho\U1ea3n qua APP";
//    time = 1560182158;
//    type = 0;
}

@end
