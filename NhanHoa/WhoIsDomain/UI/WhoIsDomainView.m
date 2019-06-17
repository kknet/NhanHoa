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
@synthesize hLabel, sizeLeft, padding, mTop;

- (void)setupUIForView {
    mTop = 5.0;
    hLabel = 35.0;
    
    sizeLeft = [AppUtils getSizeWithText:@"Ngày đăng ký" withFont:[UIFont fontWithName:RobotoRegular size:16.0]].width + 10.0;
    
    padding = 15.0;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        //  make.bottom.equalTo(self);
        make.bottom.equalTo(self.lbDNSSECValue.mas_bottom).offset(self.padding);
    }];
    
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewContent).offset(self.padding);
        make.left.equalTo(self.viewContent).offset(self.padding);
        make.width.mas_equalTo(self.sizeLeft);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDomain);
        make.left.equalTo(self.lbDomain.mas_right);
        make.right.equalTo(self.viewContent).offset(-self.padding);
    }];
    
    [lbIssueDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomain);
        make.top.equalTo(self.lbDomain.mas_bottom).offset(self.mTop);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbIssueDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbIssueDate);
        make.left.right.equalTo(self.lbDomainValue);
    }];
    
    [lbExpiredDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbIssueDate);
        make.top.equalTo(self.lbIssueDate.mas_bottom).offset(self.mTop);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    [lbExpiredDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbExpiredDate);
        make.left.right.equalTo(self.lbIssueDateValue);
    }];
    
    lbOwnerValue.numberOfLines = 10;
    [lbOwnerValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.equalTo(self.lbOwner);
        make.top.equalTo(self.lbExpiredDate.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbExpiredDateValue);
        make.height.mas_greaterThanOrEqualTo(self.hLabel);
    }];
    
    [lbOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbExpiredDate);
        make.centerY.equalTo(self.lbOwnerValue.mas_centerY);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbStatusValue.numberOfLines = 10;
    [lbStatusValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOwnerValue.mas_bottom).offset(self.mTop);
        //  make.top.equalTo(self.lbStatus);
        make.left.right.equalTo(self.lbOwnerValue);
        make.height.mas_greaterThanOrEqualTo(self.hLabel);
    }];
    
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbStatusValue.mas_centerY);
        make.left.right.equalTo(self.lbOwner);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbRegisterNameValue.numberOfLines = 10;
    [lbRegisterNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.equalTo(self.lbRegisterName);
        make.top.equalTo(self.lbStatusValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbStatusValue);
        make.height.mas_greaterThanOrEqualTo(self.hLabel);
    }];
    
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbRegisterNameValue.mas_centerY);
        make.left.right.equalTo(self.lbStatus);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    
    
    lbDNSValue.numberOfLines = 10;
    [lbDNSValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.equalTo(self.lbDNS);
        make.top.equalTo(self.lbRegisterNameValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbRegisterNameValue);
        make.height.mas_greaterThanOrEqualTo(self.hLabel);
    }];
    
    [lbDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbDNSValue.mas_centerY);
        make.left.right.equalTo(self.lbRegisterName);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    lbDNSSECValue.numberOfLines = 10;
    [lbDNSSECValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.bottom.equalTo(self.lbDNSSEC);
        make.top.equalTo(self.lbDNSValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbDNSValue);
        make.height.mas_greaterThanOrEqualTo(self.hLabel);
    }];
    
    [lbDNSSEC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbDNSSECValue.mas_centerY);
        make.left.right.equalTo(self.lbDNS);
        make.height.mas_equalTo(self.hLabel);
    }];
    
    //  lbDomain.font = lbIssueDate.font = lbIssueDateValue.font = lbExpiredDate.font = lbExpiredDateValue.font = lbOwner.font = lbOwnerValue.font = lbStatus.font = lbStatusValue.font = lbRegisterName.font = lbRegisterNameValue.font = lbDNS.font = lbDNSValue.font = lbDNSSEC.font = lbDNSSECValue.font = [UIFont fontWithName:RobotoRegular size:16.0];
    
    lbDomain.font = lbIssueDate.font = lbExpiredDate.font = lbOwner.font = lbStatus.font = lbRegisterName.font = lbDNS.font = lbDNSSEC.font = [UIFont fontWithName:RobotoMedium size:16.0];
    
    lbIssueDateValue.font = lbExpiredDateValue.font = lbOwnerValue.font = lbStatusValue.font = lbRegisterNameValue.font = lbDNSValue.font = lbDNSSECValue.font = [UIFont fontWithName:RobotoRegular size:16.0];
    
    lbDomain.textColor = lbIssueDate.textColor = lbIssueDateValue.textColor = lbExpiredDate.textColor = lbExpiredDateValue.textColor = lbOwner.textColor = lbOwnerValue.textColor = lbStatus.textColor = lbStatusValue.textColor = lbRegisterName.textColor = lbRegisterNameValue.textColor = lbDNS.textColor = lbDNSValue.textColor = lbDNSSEC.textColor = lbDNSSECValue.textColor = TITLE_COLOR;
    
    lbDomainValue.textColor = BLUE_COLOR;
    lbDomainValue.font = [AppDelegate sharedInstance].fontMedium;
}

- (float)showContentOfDomainWithInfo: (NSDictionary *)info {
    NSString *domain = [info objectForKey:@"domain"];
    NSString *dns = [info objectForKey:@"dns"];
    NSString *start = [info objectForKey:@"start"];
    NSString *expired = [info objectForKey:@"expired"];
    NSString *registrar = [info objectForKey:@"registrar"];
    NSString *status = [info objectForKey:@"status"];
    NSString *dnssec = [info objectForKey:@"dnssec"];
    NSString *owner = [info objectForKey:@"owner"];
    
    lbDomainValue.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
    lbIssueDateValue.text = (![AppUtils isNullOrEmpty: start]) ? start : @"";
    lbExpiredDateValue.text = (![AppUtils isNullOrEmpty: expired]) ? expired : @"";
    lbRegisterNameValue.text = (![AppUtils isNullOrEmpty: registrar]) ? registrar : @"";
    lbOwnerValue.text = (![AppUtils isNullOrEmpty: owner]) ? owner : @"";
    lbDNSSECValue.text = (![AppUtils isNullOrEmpty: dnssec]) ? dnssec : @"";
    
    //  status
    status = [status stringByReplacingOccurrencesOfString:@" " withString:@""];
    status = [status stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    lbStatusValue.text = status;
    
    //  Name server
    dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
    dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    lbDNSValue.text = dns;
    
    [lbOwnerValue sizeToFit];
    float hOwner = lbOwnerValue.frame.size.height;
    if (hOwner < hLabel) {
        hOwner = hLabel;
    }
    [lbOwnerValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbExpiredDate.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbExpiredDateValue);
        make.height.mas_equalTo(hOwner);
    }];
    
    [lbStatusValue sizeToFit];
    float hStatus = lbStatusValue.frame.size.height;
    if (hStatus < hLabel) {
        hStatus = hLabel;
    }
    [lbStatusValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOwnerValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbExpiredDateValue);
        make.height.mas_equalTo(hStatus);
    }];
    
    [lbRegisterNameValue sizeToFit];
    float hRegistrarName = lbRegisterNameValue.frame.size.height;
    if (hRegistrarName < hLabel) {
        hRegistrarName = hLabel;
    }
    [lbRegisterNameValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbStatusValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbExpiredDateValue);
        make.height.mas_equalTo(hRegistrarName);
    }];
    
    [lbDNSValue sizeToFit];
    float hDNS = lbDNSValue.frame.size.height;
    if (hDNS < hLabel) {
        hDNS = hLabel;
    }
    [lbDNSValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterNameValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbExpiredDateValue);
        make.height.mas_equalTo(hDNS);
    }];
    
    [lbDNSSECValue sizeToFit];
    float hDNSSec = lbDNSSECValue.frame.size.height;
    if (hDNSSec < hLabel) {
        hDNSSec = hLabel;
    }
    [lbDNSSECValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDNSValue.mas_bottom).offset(self.mTop);
        make.left.right.equalTo(self.lbExpiredDateValue);
        make.height.mas_equalTo(hDNSSec);
    }];
    
    return padding + hLabel + (mTop + hLabel) + (mTop + hLabel) + (mTop + hOwner) + (mTop + hStatus) + (mTop + hRegistrarName) + (mTop + hDNS) + (mTop + hDNSSec) + padding;
}

- (void)resetAllValueForView {
    lbDomainValue.text = lbStatusValue.text = lbRegisterNameValue.text = lbOwnerValue.text = lbIssueDateValue.text = lbExpiredDateValue.text = lbDNSValue.text = lbDNSSECValue.text = @"";
}


@end
