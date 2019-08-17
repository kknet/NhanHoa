//
//  ExpireDomainCell.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ExpireDomainCell.h"

@implementation ExpireDomainCell
@synthesize lbNum, lbName, lbDate, lbState, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
    }
    
    lbNum.textColor = TITLE_COLOR;
    lbNum.font = [AppDelegate sharedInstance].fontMedium;
    lbNum.textAlignment = NSTextAlignmentLeft;
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.width.mas_equalTo(30.0);
    }];
    
    lbName.textColor = TITLE_COLOR;
    lbName.font = [AppDelegate sharedInstance].fontMedium;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbNum.mas_right).offset(5.0);
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    lbState.font = [AppDelegate sharedInstance].fontMediumDesc;
    lbState.textAlignment = NSTextAlignmentRight;
    [lbState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.mas_centerY).offset(2.0);
    }];
    
    lbDate.textColor = TITLE_COLOR;
    lbDate.font = [AppDelegate sharedInstance].fontNormal;
    lbDate.textAlignment = NSTextAlignmentLeft;
    [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbState.mas_left).offset(-10.0);
        make.left.equalTo(lbName);
        make.centerY.equalTo(lbState.mas_centerY);
    }];
    
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(lbDate);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showContentWithDomainInfo: (NSDictionary *)info withExpire: (BOOL)expire {
    NSString *domain = [info objectForKey:@"domain"];
    lbName.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
    
    NSString *status = [info objectForKey:@"status"];
    if (status != nil && [status isKindOfClass:[NSString class]]) {
        NSString *content = [AppUtils getStatusValueWithCode: status];
        lbState.text = content;
        
        if ([status isEqualToString:@"2"]) {
            lbState.textColor = GREEN_COLOR;
            
        }else if ([status isEqualToString:@"3"]){
            lbState.textColor = NEW_PRICE_COLOR;
            
        }else{
            lbState.textColor = UIColor.orangeColor;
        }
    }else{
        lbState.text = @"Chưa xác định";
        lbState.textColor = NEW_PRICE_COLOR;
    }
    
    NSString *endTime = [info objectForKey:@"ord_end_time"];
    if (endTime != nil && ![endTime isEqualToString:@""] && [endTime isKindOfClass:[NSString class]]) {
        NSString *expireDate = [AppUtils getDateStringFromTimerInterval:[endTime longLongValue]];
        lbDate.text = [NSString stringWithFormat:@"Hết hạn: %@", expireDate];
    }else{
        lbDate.text = @"Hết hạn ngày: Đang cập nhật";
    }
}

@end
