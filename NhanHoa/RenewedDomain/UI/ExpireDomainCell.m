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
    
    lbNum.textColor = TITLE_COLOR;
    lbNum.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbNum.textAlignment = NSTextAlignmentLeft;
    [lbNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.width.mas_equalTo(30.0);
    }];
    
    lbName.textColor = TITLE_COLOR;
    lbName.font = [AppDelegate sharedInstance].fontRegular;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbNum.mas_right).offset(5.0);
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.right.equalTo(self).offset(-padding);
    }];
    
    lbState.font = [AppDelegate sharedInstance].fontMedium;
    lbState.textAlignment = NSTextAlignmentRight;
    [lbState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.mas_centerY).offset(2.0);
    }];
    
    lbDate.textColor = TITLE_COLOR;
    lbDate.font = [AppDelegate sharedInstance].fontDesc;
    lbDate.textAlignment = NSTextAlignmentLeft;
    [lbDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbState.mas_left).offset(-10.0);
        make.left.equalTo(self.lbName);
        make.centerY.equalTo(self.lbState.mas_centerY);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self.lbDate);
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
    
    NSString *endTime = [info objectForKey:@"ord_end_time"];
    if (endTime != nil && [endTime isKindOfClass:[NSString class]]) {
        NSString *expireDate = [AppUtils getDateStringFromTimerInterval:[endTime longLongValue]];
        lbDate.text = [NSString stringWithFormat:@"Hết hạn ngày %@", expireDate];
    }else{
        lbDate.text = @"Hết hạn ngày: -.-";
    }
    
    if (expire) {
        lbState.text = @"Sắp hết hạn";
        lbState.textColor = NEW_PRICE_COLOR;
    }else{
        lbState.text = @"Đã kích hoạt";
        lbState.textColor = GREEN_COLOR;
    }
    
//    "cus_id" = 127115;
//    domain = "nooplinux.com";
//    "ord_code" = ORD746763;
//    "ord_end_time" = 1567641600;
//    "ord_id" = 746763;
//    "ord_start_time" = 1536105600;
//    "service_id" = 2;
//    status = 2;
}

@end
