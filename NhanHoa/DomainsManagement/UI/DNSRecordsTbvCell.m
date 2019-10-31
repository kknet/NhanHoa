//
//  DNSRecordsTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSRecordsTbvCell.h"

@implementation DNSRecordsTbvCell

@synthesize viewWrap, lbDomain, lbDomainValue, lbType, lbTypeValue, lbValue, lbValueValue, lbMX, lbMXValue, lbTTL, lbTTLValue, icDetail;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    float padding = 10.0;
    float hContent = 28.0;
    float hTitle = 18.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:16.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:14.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:16.0];
    }
    
    viewWrap.clipsToBounds = TRUE;
    viewWrap.layer.cornerRadius = 8.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    lbDomain.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = textFont;
    lbDomain.textColor = lbType.textColor = lbValue.textColor = lbMX.textColor = lbTTL.textColor = GRAY_150;
    
    lbDomainValue.font = lbTypeValue.font = lbValueValue.font = lbMXValue.font = lbTTLValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize+3];
    lbDomainValue.textColor = lbTypeValue.textColor = lbValueValue.textColor = lbMXValue.textColor = lbTTLValue.textColor = GRAY_80;
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap).offset(padding);
        make.right.equalTo(viewWrap.mas_centerX).offset(-padding/2);
        make.bottom.equalTo(viewWrap.mas_centerY).offset(-4.0);
        make.height.mas_equalTo(hContent);
    }];
    
    lbDomain.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Name"]);
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainValue);
        make.bottom.equalTo(lbDomainValue.mas_top);
        make.height.mas_equalTo(hTitle);
    }];
    
    //  type value
    [lbTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap.mas_centerX).offset(padding);
        make.top.bottom.equalTo(lbDomainValue);
        make.right.equalTo(viewWrap).offset(-padding);
    }];
    
    lbType.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Type"]);
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbTypeValue);
        make.top.bottom.equalTo(lbDomain);
    }];
    
    //  value
    lbValue.text = SFM(@"%@:", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Value"]);
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainValue);
        make.top.equalTo(lbDomainValue.mas_bottom).offset(4.0);
        make.height.mas_equalTo(hTitle);
    }];
    
    [lbValueValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbValue);
        make.top.equalTo(lbValue.mas_bottom);
        make.height.mas_equalTo(hContent);
    }];
                                
    //  mx
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTypeValue);
        make.top.bottom.equalTo(lbValue);
        make.width.mas_equalTo(SCREEN_WIDTH/4);
    }];
    
    [lbMXValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbMX);
        make.top.bottom.equalTo(lbValueValue);
    }];
    
    //  TTL
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMX.mas_right);
        make.top.bottom.equalTo(lbMX);
        make.right.equalTo(lbTypeValue);
    }];
    
    [lbTTLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbTTL);
        make.top.bottom.equalTo(lbMXValue);
    }];
    
    icDetail.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [icDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(viewWrap);
        make.width.height.mas_equalTo(30.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDNSRecordContentWithInfo: (NSDictionary *)info {
    if (info != nil && [info isKindOfClass:[NSDictionary class]]) {
        NSString *record_name = [info objectForKey:@"record_name"];
        lbDomainValue.text = (![AppUtils isNullOrEmpty: record_name]) ? record_name : @"";
        
        NSString *record_type = [info objectForKey:@"record_type"];
        lbTypeValue.text = (![AppUtils isNullOrEmpty: record_type]) ? record_type : @"";
        
        NSString *record_value = [info objectForKey:@"record_value"];
        lbValueValue.text = (![AppUtils isNullOrEmpty: record_value]) ? record_value : @"";
        
        NSString *record_mx = [info objectForKey:@"record_mx"];
        lbMXValue.text = (![AppUtils isNullOrEmpty: record_mx]) ? record_mx : @"";
        
        NSString *record_ttl = [info objectForKey:@"record_ttl"];
        lbTTLValue.text = (![AppUtils isNullOrEmpty: record_ttl]) ? record_ttl : @"";
        
        /*
         "record_id" = 709276;
         "record_mx" = "<null>";
         "record_name" = "@";
         "record_ttl" = 3600;
         "record_type" = A;
         "record_value" = "172.104.55.77";
         */
    }else{
        lbDomainValue.text = lbTypeValue.text = lbValueValue.text = lbMXValue.text = lbTTLValue.text = @"";
    }
}

@end
