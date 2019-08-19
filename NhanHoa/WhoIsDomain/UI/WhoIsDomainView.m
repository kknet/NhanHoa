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
    padding = 15.0;
    sizeLeft = [AppUtils getSizeWithText:text_creation_date withFont:[AppDelegate sharedInstance].fontMediumDesc].width + 10.0;
    
    if ([DeviceUtils isScreen320] || [DeviceUtils isScreen375]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        hLabel = 40.0;
        sizeLeft = SCREEN_WIDTH/3 - 50.0;
    }
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        //  make.bottom.equalTo(self);
        make.bottom.equalTo(lbDNSSECValue.mas_bottom).offset(padding);
    }];
    
    lbDomain.text = SFM(@"%@:", text_domains);
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContent).offset(padding);
        make.left.equalTo(viewContent).offset(padding);
        make.width.mas_equalTo(sizeLeft);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomain);
        make.left.equalTo(lbDomain.mas_right);
        make.right.equalTo(viewContent).offset(-padding);
    }];
    
    lbIssueDate.text = SFM(@"%@:", text_creation_date);
    [lbIssueDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomain);
        make.top.equalTo(lbDomain.mas_bottom).offset(mTop);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbIssueDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbIssueDate);
        make.left.right.equalTo(lbDomainValue);
    }];
    
    lbExpiredDate.text = SFM(@"%@:", text_expiration_date);
    [lbExpiredDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbIssueDate);
        make.top.equalTo(lbIssueDate.mas_bottom).offset(mTop);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbExpiredDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbExpiredDate);
        make.left.right.equalTo(lbIssueDateValue);
    }];
    
    lbOwnerValue.numberOfLines = 10;
    [lbOwnerValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbExpiredDate.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbExpiredDateValue);
        make.height.mas_greaterThanOrEqualTo(hLabel);
    }];
    
    lbOwner.text = text_owner;
    [lbOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbExpiredDate);
        make.centerY.equalTo(lbOwnerValue.mas_centerY);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbStatusValue.numberOfLines = 0;
    [lbStatusValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbOwnerValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbOwnerValue);
        //  make.height.mas_greaterThanOrEqualTo(hLabel);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbStatus.text = text_status;
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbStatusValue.mas_centerY);
        make.left.right.equalTo(lbOwner);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbRegisterNameValue.numberOfLines = 10;
    [lbRegisterNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.equalTo(self.lbRegisterName);
        make.top.equalTo(lbStatusValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbStatusValue);
        make.height.mas_greaterThanOrEqualTo(hLabel);
    }];
    
    lbRegisterName.text = text_registrar;
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbRegisterNameValue.mas_centerY);
        make.left.right.equalTo(lbStatus);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbDNSValue.numberOfLines = 10;
    [lbDNSValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.equalTo(self.lbDNS);
        make.top.equalTo(lbRegisterNameValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbRegisterNameValue);
        make.height.mas_greaterThanOrEqualTo(hLabel);
    }];
    
    lbDNS.text = text_name_servers;
    [lbDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbDNSValue.mas_centerY);
        make.left.right.equalTo(lbRegisterName);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbDNSSECValue.numberOfLines = 10;
    [lbDNSSECValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.bottom.equalTo(self.lbDNSSEC);
        make.top.equalTo(lbDNSValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbDNSValue);
        make.height.mas_greaterThanOrEqualTo(hLabel);
    }];
    
    lbDNSSEC.text = text_DNSSEC;
    [lbDNSSEC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbDNSSECValue.mas_centerY);
        make.left.right.equalTo(lbDNS);
        make.height.mas_equalTo(hLabel);
    }];
    
    if (!IS_IPHONE && !IS_IPOD) {
        lbDomain.font = lbIssueDate.font = lbExpiredDate.font = lbOwner.font = lbStatus.font = lbRegisterName.font = lbDNS.font = lbDNSSEC.font = lbDomainValue.font = [AppDelegate sharedInstance].fontMediumDesc;
        lbIssueDateValue.font = lbExpiredDateValue.font = lbOwnerValue.font = lbStatusValue.font = lbRegisterNameValue.font = lbDNSValue.font = lbDNSSECValue.font = [AppDelegate sharedInstance].fontNormal;
        
    }else{
        lbDomain.font = lbIssueDate.font = lbExpiredDate.font = lbOwner.font = lbStatus.font = lbRegisterName.font = lbDNS.font = lbDNSSEC.font = lbDomainValue.font = [AppDelegate sharedInstance].fontMediumDesc;
        lbIssueDateValue.font = lbExpiredDateValue.font = lbOwnerValue.font = lbStatusValue.font = lbRegisterNameValue.font = lbDNSValue.font = lbDNSSECValue.font = [AppDelegate sharedInstance].fontNormal;
    }
    
    lbDomain.textColor = lbIssueDate.textColor = lbIssueDateValue.textColor = lbExpiredDate.textColor = lbExpiredDateValue.textColor = lbOwner.textColor = lbOwnerValue.textColor = lbStatus.textColor = lbStatusValue.textColor = lbRegisterName.textColor = lbRegisterNameValue.textColor = lbDNS.textColor = lbDNSValue.textColor = lbDNSSEC.textColor = lbDNSSECValue.textColor = TITLE_COLOR;
    
    lbDomainValue.textColor = BLUE_COLOR;
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
        make.top.equalTo(lbExpiredDate.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbExpiredDateValue);
        make.height.mas_equalTo(hOwner);
    }];
    
    float sizeText = 2*SCREEN_WIDTH/3;
    
    float hStatus = [AppUtils getSizeWithText:lbStatusValue.text withFont:lbStatusValue.font andMaxWidth: sizeText].height + 10.0;
    if (hStatus < hLabel) {
        hStatus = hLabel;
    }
    [lbStatusValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbOwnerValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbExpiredDateValue);
        make.height.mas_equalTo(hStatus);
    }];
    
    float hRegistrarName = [AppUtils getSizeWithText:lbRegisterNameValue.text withFont:lbRegisterNameValue.font andMaxWidth:sizeText].height + 10.0;
    if (hRegistrarName < hLabel) {
        hRegistrarName = hLabel;
    }
    [lbRegisterNameValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbStatusValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbExpiredDateValue);
        make.height.mas_equalTo(hRegistrarName);
    }];
    
    float hDNS = [AppUtils getSizeWithText:lbDNSValue.text withFont:lbDNSValue.font andMaxWidth:sizeText].height + 10.0;
    if (hDNS < hLabel) {
        hDNS = hLabel;
    }
    [lbDNSValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRegisterNameValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbExpiredDateValue);
        make.height.mas_equalTo(hDNS);
    }];
    
    float hDNSSec = [AppUtils getSizeWithText:lbDNSSECValue.text withFont:lbDNSSECValue.font andMaxWidth:sizeText].height + 10.0;
    if (hDNSSec < hLabel) {
        hDNSSec = hLabel;
    }
    [lbDNSSECValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDNSValue.mas_bottom).offset(mTop);
        make.left.right.equalTo(lbExpiredDateValue);
        make.height.mas_equalTo(hDNSSec);
    }];
    
    return padding + hLabel + (mTop + hLabel) + (mTop + hLabel) + (mTop + hOwner) + (mTop + hStatus) + (mTop + hRegistrarName) + (mTop + hDNS) + (mTop + hDNSSec) + padding;
}

- (void)resetAllValueForView {
    lbDomainValue.text = lbStatusValue.text = lbRegisterNameValue.text = lbOwnerValue.text = lbIssueDateValue.text = lbExpiredDateValue.text = lbDNSValue.text = lbDNSSECValue.text = @"";
}


@end
