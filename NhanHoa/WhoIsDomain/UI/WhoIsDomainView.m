//
//  WhoIsDomainView.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsDomainView.h"

@implementation WhoIsDomainView
@synthesize viewContent, lbDomain, lbDomainValue, lbStatus, lbStatusValue, lbRegisterName, lbRegisterNameValue, lbOwner, lbOwnerValue, lbIssueDate, lbIssueDateValue, lbExpiredDate, lbExpiredDateValue, lbDNS, lbDNSValue, lbDNSSEC, lbDNSSECValue;
@synthesize hLabel, sizeLeft;

- (void)setupUIForView {
    if (hLabel == 0) {
        hLabel = 35.0;
    }
    
    sizeLeft = [AppUtils getSizeWithText:@"Quản lý tại nhà đăng ký" withFont:[UIFont fontWithName:RobotoRegular size:15.0]].width + 5.0;
    
    float padding = 15.0;
    viewContent.layer.cornerRadius = 6.0;
    viewContent.layer.borderWidth = 1.0;
    viewContent.layer.borderColor = BORDER_COLOR.CGColor;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewContent);
        make.left.equalTo(self.viewContent).offset(padding);
        make.width.mas_equalTo(self.sizeLeft);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDomain);
        make.left.equalTo(self.lbDomain.mas_right);
        make.right.equalTo(self.viewContent).offset(-padding);
    }];
    
    [lbIssueDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomain);
        make.top.equalTo(self.lbDomain.mas_bottom);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbIssueDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbIssueDate);
        make.left.right.equalTo(self.lbDomainValue);
    }];
    
    [lbExpiredDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbIssueDate);
        make.top.equalTo(self.lbIssueDate.mas_bottom);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbExpiredDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbExpiredDate);
        make.left.right.equalTo(self.lbIssueDateValue);
    }];
    
    [lbOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbExpiredDate);
        make.top.equalTo(self.lbExpiredDate.mas_bottom);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbOwnerValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbOwner);
        make.left.right.equalTo(self.lbExpiredDateValue);
    }];
    
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOwner.mas_bottom);
        make.left.right.equalTo(self.lbOwner);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbStatusValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbStatus);
        make.left.right.equalTo(self.lbOwnerValue);
    }];
    
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbStatus.mas_bottom);
        make.left.right.equalTo(self.lbStatus);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbRegisterNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbRegisterName);
        make.left.right.equalTo(self.lbStatusValue);
    }];
    
    [lbDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterName.mas_bottom);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbDNSValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDNS);
        make.left.right.equalTo(self.lbRegisterNameValue);
    }];
    
    [lbDNSSEC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDNS.mas_bottom);
        make.left.right.equalTo(self.lbDNS);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbDNSSECValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDNSSEC);
        make.left.right.equalTo(self.lbDNSValue);
    }];
    
    lbDomain.font = lbDomainValue.font = lbIssueDate.font = lbIssueDateValue.font = lbExpiredDate.font = lbExpiredDateValue.font = lbOwner.font = lbOwnerValue.font = lbStatus.font = lbStatusValue.font = lbRegisterName.font = lbRegisterNameValue.font = lbDNS.font = lbDNSValue.font = lbDNSSEC.font = lbDNSSECValue.font = [UIFont fontWithName:RobotoRegular size:15.0];
}

- (float)showContentOfDomainWithInfo: (NSDictionary *)info {
    NSString *domain = [info objectForKey:@"domain"];
    NSString *dns = [info objectForKey:@"dns"];
    NSString *start = [info objectForKey:@"start"];
    NSString *expired = [info objectForKey:@"expired"];
    NSString *registrar = [info objectForKey:@"registrar"];
    NSString *status = [info objectForKey:@"status"];
    NSString *dnssec = [info objectForKey:@"dnssec"];
    
    lbDomainValue.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
    lbIssueDateValue.text = (![AppUtils isNullOrEmpty: start]) ? start : @"";
    lbExpiredDateValue.text = (![AppUtils isNullOrEmpty: expired]) ? expired : @"";
    lbRegisterNameValue.text = (![AppUtils isNullOrEmpty: registrar]) ? registrar : @"";
    
    float maxSize = SCREEN_WIDTH - 
    
    float registrarHeight = [AppUtils getSizeWithText:registrar withFont:lbRegisterNameValue.font andMaxWidth:(SCREEN_WIDTH - 2*pad)]
    
    
    
    
    status = [status stringByReplacingOccurrencesOfString:@" " withString:@""];
    status = [status stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    lbStatusValue.text = status;
    
    dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
    dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    lbDNSValue.text = dns;
    
    lbDNSSECValue.text = (![AppUtils isNullOrEmpty: dnssec]) ? dnssec : @"";
    return 0;
}

- (void)resetAllValueForView {
    lbDomainValue.text = lbStatusValue.text = lbRegisterNameValue.text = lbOwnerValue.text = lbIssueDateValue.text = lbExpiredDateValue.text = lbDNSValue.text = lbDNSSECValue.text = @"";
}

@end
