//
//  WhoIsDomainView.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsDomainView.h"

@implementation WhoIsDomainView
@synthesize lbTitle, viewContent, lbRegistrarInfo, lbSepa1, lbDomain, lbDomainValue, lbStatus, lbStatusValue, lbRegisterName, lbRegisterNameValue, lbOwner, lbOwnerValue, lbDomainLocking, lbDomainLockingValue, btnMoreInfo, lbImportantDates, lbSepa2, lbIssueDate, lbIssueDateValue, lbExpiredDate, lbExpiredDateValue, lbNameServers, lbSepa3, lbDNS, lbDNSValue, lbDNSSEC, lbDNSSECValue;

- (void)setupUIForView {
    lbTitle.textColor = BLUE_COLOR;
    lbTitle.backgroundColor = UIColor.whiteColor;
    lbTitle.font = [UIFont fontWithName:RobotoBold size:16.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20.0);
        make.centerX.equalTo(self.mas_centerX);
        make.height.mas_equalTo(30.0);
    }];
    float padding = 15.0;
    viewContent.layer.cornerRadius = 6.0;
    viewContent.layer.borderWidth = 1.0;
    viewContent.layer.borderColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0].CGColor;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_centerY);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self).offset(-padding);
    }];
    
    lbRegistrarInfo.textColor = TITLE_COLOR;
    lbRegistrarInfo.font = [UIFont fontWithName:RobotoMedium size:18.0];
    [lbRegistrarInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewContent).offset(padding);
        make.right.equalTo(self.viewContent).offset(-padding);
        make.top.equalTo(self.viewContent).offset(2*padding);
        make.height.mas_equalTo(25.0);
    }];
    
    lbSepa1.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRegistrarInfo);
        make.top.equalTo(self.lbRegistrarInfo.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    lbDomain.textColor = [UIColor colorWithRed:80/255.0 green:80/255.0 blue:80/255.0 alpha:1.0];
    lbDomain.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepa1.mas_bottom);
        make.left.equalTo(self.lbSepa1);
        make.right.equalTo(self.viewContent.mas_centerX).offset(-35.0);
        make.height.mas_equalTo(25.0);
    }];
    
    lbDomainValue.textColor = TITLE_COLOR;
    lbDomainValue.font = [UIFont fontWithName:RobotoMedium size:14.0];
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDomain);
        make.left.equalTo(self.lbDomain.mas_right).offset(5.0);
        make.right.equalTo(self.viewContent).offset(-padding);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    
    lbStatus.textColor = lbDomain.textColor;
    lbStatus.font = lbDomain.font;
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomainValue.mas_bottom);
        make.left.right.equalTo(self.lbDomain);
        make.height.mas_equalTo(25.0);
    }];
    
    lbStatusValue.textColor = lbDomainValue.textColor;
    lbStatusValue.font = lbDomainValue.font;
    [lbStatusValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbStatus);
        make.left.right.equalTo(self.lbDomainValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    
    lbRegisterName.textColor = lbDomain.textColor;
    lbRegisterName.font = lbDomain.font;
    [lbRegisterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbStatusValue.mas_bottom);
        make.left.right.equalTo(self.lbStatus);
        make.height.mas_equalTo(25.0);
    }];
    
    lbRegisterNameValue.textColor = lbDomainValue.textColor;
    lbRegisterNameValue.font = lbDomainValue.font;
    [lbRegisterNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterName);
        make.left.right.equalTo(self.lbStatusValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    
    lbOwner.textColor = lbDomain.textColor;
    lbOwner.font = lbDomain.font;
    [lbOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterNameValue.mas_bottom);
        make.left.right.equalTo(self.lbStatus);
        make.height.mas_equalTo(25.0);
    }];
    
    lbOwnerValue.textColor = lbDomainValue.textColor;
    lbOwnerValue.font = lbDomainValue.font;
    [lbOwnerValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOwner);
        make.left.right.equalTo(self.lbRegisterNameValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    lbDomainLocking.textColor = lbDomain.textColor;
    lbDomainLocking.font = lbDomain.font;
    [lbDomainLocking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOwnerValue.mas_bottom);
        make.left.right.equalTo(self.lbOwner);
        make.height.mas_equalTo(25.0);
    }];
    
    lbDomainLockingValue.textColor = OLD_PRICE_COLOR;
    lbDomainLockingValue.font = lbDomainValue.font;
    [lbDomainLockingValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomainLocking);
        make.left.equalTo(self.lbOwnerValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    btnMoreInfo.titleLabel.font = [UIFont fontWithName:RobotoMediumItalic size:16.0];
    [btnMoreInfo setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnMoreInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbDomainLockingValue.mas_right).offset(10.0);
        make.centerY.equalTo(self.lbDomainLocking.mas_centerY);
        make.width.mas_equalTo(100.0);
        make.height.equalTo(self.lbDomainLocking.mas_height);
    }];
    
    //  inportant dates
    lbImportantDates.textColor = lbRegistrarInfo.textColor;
    lbImportantDates.font = lbRegistrarInfo.font;
    [lbImportantDates mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRegistrarInfo);
        make.top.equalTo(self.lbDomainLockingValue.mas_bottom).offset(padding);
        make.height.equalTo(self.lbRegistrarInfo.mas_height);
    }];
    
    lbSepa2.backgroundColor = lbSepa1.backgroundColor;
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbSepa1);
        make.top.equalTo(self.lbImportantDates.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    lbIssueDate.textColor = lbDomainValue.textColor;
    lbIssueDate.font = lbDomainValue.font;
    [lbIssueDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomainLocking);
        make.top.equalTo(self.lbSepa2.mas_bottom).offset(10.0);
        make.height.mas_equalTo(25.0);
    }];
    
    lbIssueDateValue.textColor = lbDomainValue.textColor;
    lbIssueDateValue.font = lbDomainValue.font;
    [lbIssueDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbIssueDate);
        make.left.right.equalTo(self.lbOwnerValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    lbExpiredDate.textColor = lbDomainValue.textColor;
    lbExpiredDate.font = lbDomainValue.font;
    [lbExpiredDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbIssueDate);
        make.top.equalTo(self.lbIssueDateValue.mas_bottom);
        make.height.mas_equalTo(25.0);
    }];
    
    lbExpiredDateValue.textColor = lbDomainValue.textColor;
    lbExpiredDateValue.font = lbDomainValue.font;
    [lbExpiredDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbExpiredDate);
        make.left.right.equalTo(self.lbIssueDateValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    //  servers name
    lbNameServers.textColor = lbRegistrarInfo.textColor;
    lbNameServers.font = lbRegistrarInfo.font;
    [lbNameServers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRegistrarInfo);
        make.top.equalTo(self.lbExpiredDate.mas_bottom).offset(padding);
        make.height.equalTo(self.lbRegistrarInfo.mas_height);
    }];
    
    lbSepa3.backgroundColor = lbSepa1.backgroundColor;
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbSepa1);
        make.top.equalTo(self.lbNameServers.mas_bottom);
        make.height.mas_equalTo(1.0);
    }];
    
    lbDNS.textColor = lbDomainValue.textColor;
    lbDNS.font = lbDomainValue.font;
    [lbDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbExpiredDate);
        make.top.equalTo(self.lbSepa3.mas_bottom).offset(10.0);
        make.height.mas_equalTo(25.0);
    }];
    
    lbDNSValue.textColor = lbDomainValue.textColor;
    lbDNSValue.font = lbDomainValue.font;
    lbDNSValue.numberOfLines = 10;
    lbDNSValue.text = @"abd.com\ndef.com.vn\ngoogle.com.vn";
    [lbDNSValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDNS);
        make.left.right.equalTo(self.lbIssueDateValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
    
    lbDNSSEC.textColor = lbDomainValue.textColor;
    lbDNSSEC.font = lbDomainValue.font;
    [lbDNSSEC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDNS);
        make.top.equalTo(self.lbDNSValue.mas_bottom);
        make.height.mas_equalTo(25.0);
    }];
    
    lbDNSSECValue.textColor = lbDomainValue.textColor;
    lbDNSSECValue.font = lbDomainValue.font;
    [lbDNSSECValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDNSSEC);
        make.left.right.equalTo(self.lbDNSValue);
        make.height.mas_greaterThanOrEqualTo(25.0);
        //make.height.mas_equalTo(25.0);
    }];
}

@end
