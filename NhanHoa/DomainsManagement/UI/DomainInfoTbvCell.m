//
//  DomainInfoTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainInfoTbvCell.h"

@implementation DomainInfoTbvCell
@synthesize viewWrap, lbID, lbIDValue, lbDomain, lbDomainValue, lbExpireDate, lbExpireDateValue, lbStatus, imgStatus, lbStatusValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    float hLabel = 25.0;
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:18.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:14.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
    }
    
    float leftSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Expiration date"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    viewWrap.layer.cornerRadius = 8.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    //  domain
    lbDomain.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Domain"];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewWrap.mas_centerY);
        make.left.equalTo(viewWrap).offset(padding);
        make.width.mas_equalTo(leftSize);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomain);
        make.left.equalTo(lbDomain.mas_right);
        make.right.equalTo(viewWrap).offset(-padding);
    }];
    
    //  id
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lbDomain.mas_top);
        make.left.right.equalTo(lbDomain);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbID);
        make.left.right.equalTo(lbDomainValue);
    }];
    
    //  expiration date
    lbExpireDate.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Expiration date"];
    [lbExpireDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.right.equalTo(lbDomain);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbExpireDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbExpireDate);
        make.left.right.equalTo(lbDomainValue);
    }];
    
    //  status
    lbStatus.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Status"];
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbExpireDate.mas_bottom);
        make.left.right.equalTo(lbExpireDate);
        make.height.mas_equalTo(hLabel);
    }];
    
    [imgStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbExpireDateValue);
        make.centerY.equalTo(lbStatus.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    [lbStatusValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgStatus.mas_right).offset(5.0);
        make.top.bottom.equalTo(lbStatus);
        make.right.equalTo(lbExpireDateValue);
    }];
    
    lbID.font = lbDomain.font = lbExpireDate.font = lbStatus.font = textFont;
    lbIDValue.font = lbDomainValue.font = lbExpireDateValue.font = lbStatusValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    
    lbID.textColor = lbDomain.textColor = lbExpireDate.textColor = lbStatus.textColor = lbIDValue.textColor = lbDomainValue.textColor = lbExpireDateValue.textColor = lbStatusValue.textColor = GRAY_100;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showContentWithDomainInfo: (NSDictionary *)info
{
//    "cus_id" = 127115;
//    domain = "truongvoky.com";
//    "ord_code" = ORD879872;
//    "ord_end_time" = 1624147200;
//    "ord_id" = 879872;
//    "ord_start_time" = 1592611200;
//    "service_id" = 23;
//    status = 2;
    
    NSString *ord_id = [info objectForKey:@"ord_id"];
    lbIDValue.text = (![AppUtils isNullOrEmpty: ord_id]) ? ord_id : @"";
    
    NSString *domain = [info objectForKey:@"domain"];
    lbDomainValue.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
    
    NSString *endTime = [info objectForKey:@"ord_end_time"];
    if (endTime != nil && ![endTime isEqualToString:@""] && [endTime isKindOfClass:[NSString class]]) {
        NSString *expireDate = [AppUtils getDateStringFromTimerInterval:(long)[endTime longLongValue]];
        lbExpireDateValue.text = SFM(@"%@: %@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Expires on"], expireDate);
    }else{
        lbExpireDateValue.text = SFM(@"%@: %@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Expires on"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating"]);
    }
    
    NSString *status = [info objectForKey:@"status"];
    if (status != nil && [status isKindOfClass:[NSString class]]) {
        NSString *content = [AppUtils getStatusValueWithCode: status];
        lbStatusValue.text = content;
        
        if ([status isEqualToString:@"2"]) {
            lbStatusValue.textColor = GREEN_COLOR;
            
        }else if ([status isEqualToString:@"3"]){
            lbStatusValue.textColor = NEW_PRICE_COLOR;
            
        }else{
            lbStatusValue.textColor = UIColor.orangeColor;
        }
    }else{
        lbStatusValue.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Undefined"];
        lbStatusValue.textColor = NEW_PRICE_COLOR;
    }
}

@end
