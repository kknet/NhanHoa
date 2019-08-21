//
//  RenewDomainDetailViewController.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RenewDomainDetailViewController.h"
#import "RenewDomainCartViewController.h"
#import "UpdatePassportViewController.h"
#import "DomainDNSViewController.h"
#import "SigningDomainViewController.h"
#import "UpdateDNSViewController.h"

@interface RenewDomainDetailViewController ()<WebServiceUtilsDelegate> {
    NSString *CMND_a;
    NSString *CMND_b;
    NSString *domain;
    NSString *domainId;
    NSString *domainType;
    NSString *cus_id;
    NSString *ban_khai;
    
    NSString *domain_signed_url;
    NSString *domain_signing_url;
    
    float padding;
    float paddingY;
    float hItem;
    float hBTN;
    BOOL zonedns;
}

@end

@implementation RenewDomainDetailViewController
@synthesize lbTopDomain, viewDetail, lbID, lbIDValue, lbDomain, lbDomainValue, lbServiceName, lbServiceNameValue, lbRegisterDate, lbRegisterDateValue, lbExpire, lbExpireDate, lbState, lbStateValue, btnRenewDomain, btnChangeDNS, btnUpdatePassport, lbNoData, btnSigning, lbWhoisProtect, swWhoisProtect, btnManagerDNS;
@synthesize ordId, cusId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Chi tiết tên miền";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen: @"RenewDomainDetailViewController"];
    
    btnChangeDNS.hidden = btnUpdatePassport.hidden = btnSigning.hidden = btnRenewDomain.hidden = btnManagerDNS.hidden = TRUE;
    domain_signed_url = domain_signing_url = @"";
    
    [self setEmptyValueForView];
    
    if (![AppUtils isNullOrEmpty: ordId]) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:@"Đang tải.." Interaction:NO];
        
        [self getDomainInfoWithOrdId: ordId];
    }else{
        lbNoData.hidden = FALSE;
        [self.view makeToast:[NSString stringWithFormat:@"ord_id không tồn tại"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
        [WriteLogsUtils writeLogContent:SFM(@"%@", @">>>>>>>>>>>> ord_id của tên miền không tồn tại <<<<<<<<<<<<<")];
    }
}

- (IBAction)btnRenewDomainPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(reNewDomain) withObject:nil afterDelay:0.05];
}

- (void)reNewDomain {
    btnRenewDomain.backgroundColor = BLUE_COLOR;
    [btnRenewDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils isNullOrEmpty: domain] && ![AppUtils isNullOrEmpty: cus_id] && ![AppUtils isNullOrEmpty: ordId]) {
        RenewDomainCartViewController *renewCartVC = [[RenewDomainCartViewController alloc] initWithNibName:@"RenewDomainCartViewController" bundle:nil];
        renewCartVC.domain = domain;
        renewCartVC.cus_id = cus_id;
        renewCartVC.ord_id = ordId;
        [self.navigationController pushViewController:renewCartVC animated:TRUE];
    }else{
        [self.view makeToast:@"Tên miền không tồn tại. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (IBAction)btnUpdatePassportPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(updatePassport) withObject:nil afterDelay:0.05];
}

- (void)updatePassport {
    btnUpdatePassport.backgroundColor = BLUE_COLOR;
    [btnUpdatePassport setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    UpdatePassportViewController *updateVC = [[UpdatePassportViewController alloc] initWithNibName:@"UpdatePassportViewController" bundle:nil];
    updateVC.cusId = cusId;
    updateVC.curCMND_a = CMND_a;
    updateVC.curCMND_b = CMND_b;
    updateVC.curBanKhai = ban_khai;
    updateVC.domainId = domainId;
    updateVC.domainType = domainType;
    updateVC.domain = domain;
    [self.navigationController pushViewController:updateVC animated:TRUE];
}

- (IBAction)btnChangeDNSPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(changeNDS) withObject:nil afterDelay:0.05];
}

- (IBAction)btnSigningPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    SigningDomainViewController *signingVC = [[SigningDomainViewController alloc] initWithNibName:@"SigningDomainViewController" bundle:nil];
    signingVC.domain_signing_url = signingVC.domain_signed_url = @"";
    
    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        signingVC.domain_signed_url = domain_signed_url;
        
    }else if (![AppUtils isNullOrEmpty: domain_signing_url]) {
        signingVC.domain_signing_url = domain_signing_url;
        
    }
    [self.navigationController pushViewController:signingVC animated:TRUE];
}

- (IBAction)swWhoisProtectChanged:(UISwitch *)sender {
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    sender.enabled = FALSE;
    [self performSelector:@selector(enableSwitchWhoisProtect) withObject:nil afterDelay:1.0];
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s] whois protect value = %d", __FUNCTION__, sender.on)];
    [[WebServiceUtils getInstance] updateWhoisProtectForDomain:domain domainId:domainId protectValue:sender.on];
}

- (IBAction)btnManagerDNSPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(goToViewManagementDNSRecords) withObject:nil afterDelay:0.05];
}

- (void)goToViewManagementDNSRecords {
    btnManagerDNS.backgroundColor = BLUE_COLOR;
    [btnManagerDNS setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils isNullOrEmpty: lbTopDomain.text]) {
        DomainDNSViewController *domainDNSVC = [[DomainDNSViewController alloc] initWithNibName:@"DomainDNSViewController" bundle:nil];
        domainDNSVC.domainName = domain;
        domainDNSVC.supportDNSRecords = zonedns;
        [self.navigationController pushViewController:domainDNSVC animated:TRUE];
        
    }else{
        [self.view makeToast:@"Tên miền không tồn tại. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (void)enableSwitchWhoisProtect {
    swWhoisProtect.enabled = TRUE;
}

- (void)changeNDS {
    btnChangeDNS.backgroundColor = BLUE_COLOR;
    [btnChangeDNS setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils isNullOrEmpty: lbTopDomain.text]) {
        UpdateDNSViewController *updateDNSVC = [[UpdateDNSViewController alloc] initWithNibName:@"UpdateDNSViewController" bundle:nil];
        updateDNSVC.domain = lbTopDomain.text;
        [self.navigationController pushViewController:updateDNSVC animated:TRUE];
    }else{
        [self.view makeToast:@"Tên miền không tồn tại. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}


- (void)setEmptyValueForView {
    lbTopDomain.text = lbIDValue.text = lbDomainValue.text = lbServiceNameValue.text = lbRegisterDateValue.text = lbExpireDate.text = lbStateValue.text = @"";
    lbWhoisProtect.hidden = swWhoisProtect.hidden = TRUE;
}

- (void)getDomainInfoWithOrdId: (NSString *)ord_id {
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getDomainInfoWithOrdId: ord_id];
}

- (void)processDomainInfoWithData: (NSDictionary *)info {
    if (info != nil && [info isKindOfClass:[NSDictionary class]]) {
        [self displayDomainInfoWithData: info];
        
    }else if (info != nil && [info isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)info count] > 0) {
            [self displayDomainInfoWithData: [(NSArray *)info firstObject]];
        }
    }
}

- (void)displayDomainInfoWithData: (NSDictionary *)info {
    id zonednsObj = [info objectForKey:@"zonedns"];
    if ([zonednsObj isKindOfClass:[NSNumber class]]) {
        if ([zonednsObj intValue] == 1) {
            zonedns = TRUE;
        }else{
            zonedns = FALSE;
        }
    }else if ([zonednsObj isKindOfClass:[NSString class]]) {
        if ([zonednsObj isEqualToString:@"1"]) {
            zonedns = TRUE;
        }else{
            zonedns = FALSE;
        }
    }
    
    domainType = [info objectForKey:@"domain_type"];
    [self updateFooterMenuWithDomainType: domainType];
    
    domainId = [info objectForKey:@"domain_id"];
    
    domain = [info objectForKey:@"domain_name"];
    lbTopDomain.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
    
    id cusId = [info objectForKey:@"cus_id"];
    if (cusId != nil && [cusId isKindOfClass:[NSString class]]) {
        cus_id = cusId;
    }else if (cusId != nil && [cusId isKindOfClass:[NSNumber class]]) {
        cus_id = [NSString stringWithFormat:@"%ld", [cusId longValue]];
    }
    
    //  reupdate frame for top label
    float sizeText = [AppUtils getSizeWithText:domain withFont:lbTopDomain.font andMaxWidth:SCREEN_WIDTH].width;
    float hTop = 40.0;
    if ([DeviceUtils isScreen320]) {
        hTop = 25.0;
    }
    [lbTopDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(hTop);
        make.width.mas_equalTo(sizeText + 10.0);
    }];
    
    
    lbIDValue.text = ordId;
    
    lbDomainValue.text = domain;
    
    NSString *serviceName = [info objectForKey:@"service_name"];
    lbServiceNameValue.text = (![AppUtils isNullOrEmpty: serviceName]) ? serviceName : @"";
    
    NSString *startTime = [info objectForKey:@"start_time"];
    if ([startTime isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: startTime]) {
        NSString *startDate = [AppUtils getDateStringFromTimerInterval:(long)[startTime longLongValue]];
        lbRegisterDateValue.text = startDate;
    }else{
        lbRegisterDateValue.text = @"";
    }
    
    NSString *statusCode = [info objectForKey:@"status"];
    if (![AppUtils isNullOrEmpty: statusCode]) {
        lbStateValue.text = [AppUtils getStatusValueWithCode: statusCode];
        if ([statusCode isEqualToString:@"2"]) {
            lbStateValue.textColor = GREEN_COLOR;
            
        }else if ([statusCode isEqualToString:@"3"] || [statusCode isEqualToString:@"6"]){
            lbStateValue.textColor = NEW_PRICE_COLOR;
            
        }else{
            lbStateValue.textColor = UIColor.orangeColor;
        }
    }else{
        lbStateValue.text = @"Chưa xác định";
        lbStateValue.textColor = NEW_PRICE_COLOR;
    }
    
    NSString *endTime = [info objectForKey:@"end_time"];
    if ([endTime isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: endTime]) {
        NSString *endDate = [AppUtils getDateStringFromTimerInterval:(long)[endTime longLongValue]];
        lbExpireDate.text = endDate;
    }else{
        lbExpireDate.text = @"Đang cập nhật";
    }
    
    //  get size of content
    float maxSize = (SCREEN_WIDTH - 2*padding)/2 + 20;
    float hContent = hItem;
    if (![AppUtils isNullOrEmpty: serviceName]) {
        float hText = [AppUtils getSizeWithText:serviceName withFont:lbServiceNameValue.font andMaxWidth:maxSize].height;
        if (hText > hContent) {
            hContent = hText;
        }
    }
    
    float hView = padding + hItem + hItem + (hItem/2 - 10.0) + hContent + hItem + hItem + hItem + padding;
    if (![AppUtils checkDomainIsNationalDomain: domain]) {
        hView += hItem;
    }
    
    [viewDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTopDomain.mas_centerY);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hView);
    }];
    
    //  service name
//    [lbServiceNameValue mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.lbDomainValue);
//        make.top.equalTo(self.lbServiceName.mas_centerY).offset(-10.0);
//        make.height.mas_equalTo(hContent);
//    }];
    
    //  get CMND
    CMND_a = [info objectForKey:@"cmnd_a"];
    CMND_b = [info objectForKey:@"cmnd_b"];
    ban_khai = [info objectForKey:@"bankhai"];
    
    //  get domain_signed_url
    domain_signed_url = [info objectForKey:@"domain_signed_url"];
    domain_signing_url = [info objectForKey:@"domain_signing_url"];
    
    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        [btnSigning setTitle:text_signed_contract forState:UIControlStateNormal];
        
    }else if (![AppUtils isNullOrEmpty: domain_signing_url]){
        [btnSigning setTitle:text_signing_contract forState:UIControlStateNormal];
    }
    
    //  check whois protect
    id isProtect = [info objectForKey:@"domain_whois_protect"];
    if ([isProtect isKindOfClass:[NSString class]]) {
        lbWhoisProtect.hidden = swWhoisProtect.hidden = FALSE;
        if ([isProtect isEqualToString:@"1"]) {
            swWhoisProtect.on = TRUE;
        }else{
            swWhoisProtect.on = FALSE;
        }
    }
}

- (void)updateFooterMenuWithDomainType: (NSString *)domainType {
    btnChangeDNS.hidden = btnRenewDomain.hidden = btnManagerDNS.hidden = FALSE;
    
    if (![AppUtils isNullOrEmpty: domainType] && [domainType isEqualToString:domainvn_type]) {
        btnUpdatePassport.hidden = btnSigning.hidden = FALSE;
        
        if (IS_IPHONE || IS_IPOD) {
            [btnChangeDNS mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btnManagerDNS);
                make.bottom.equalTo(btnManagerDNS.mas_top).offset(-paddingY);
                make.height.equalTo(btnManagerDNS.mas_height);
            }];
        }else{
            [btnChangeDNS mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btnManagerDNS);
                make.right.equalTo(self.view.mas_centerX).offset(-paddingY/2);
                make.bottom.equalTo(btnManagerDNS.mas_top).offset(-paddingY);
                make.height.mas_equalTo(hBTN);
            }];
            
            [btnUpdatePassport mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_centerX).offset(paddingY/2);
                make.right.equalTo(btnManagerDNS);
                make.top.bottom.equalTo(btnChangeDNS);
            }];
            
            [btnRenewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btnChangeDNS);
                make.bottom.equalTo(btnChangeDNS.mas_top).offset(-paddingY);
                make.height.mas_equalTo(hBTN);
            }];
            
            [btnSigning mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btnUpdatePassport);
                make.top.bottom.equalTo(btnRenewDomain);
            }];
        }
    }else{
        btnUpdatePassport.hidden = btnSigning.hidden = TRUE;
        
        if (IS_IPHONE || IS_IPOD) {
            [btnRenewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(btnChangeDNS);
                make.bottom.equalTo(btnChangeDNS.mas_top).offset(-paddingY);
                make.height.equalTo(btnChangeDNS.mas_height);
            }];
            
        }else{
            [btnRenewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(btnManagerDNS);
                make.right.equalTo(self.view.mas_centerX).offset(-paddingY/2);
                make.bottom.equalTo(btnManagerDNS.mas_top).offset(-paddingY);
                make.height.mas_equalTo(hBTN);
            }];
            
            [btnChangeDNS mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_centerX).offset(paddingY/2);
                make.right.equalTo(btnManagerDNS);
                make.top.bottom.equalTo(btnRenewDomain);
            }];
        }
        
        
    }
}

- (void)setupUIForView {
    padding = 15.0;
    hItem = 40.0;
    float hTop = 40.0;
    hBTN = 45.0;
    paddingY = padding;
    
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            paddingY = padding = 5.0;
            hItem = 35.0;
            hTop = 25.0;
            hBTN = 40.0;
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            paddingY = padding = 10.0;
            hItem = 35.0;
            hTop = 25.0;
        }
        
    }else{
        padding = 30.0;
        hItem = 50.0;
        hBTN = 55.0;
        paddingY = 15.0;
    }
    
    
    lbTopDomain.backgroundColor = UIColor.whiteColor;
    
    float fontSize = [AppDelegate sharedInstance].fontBold.pointSize;
    lbTopDomain.font = [UIFont fontWithName:RobotoBold size:(fontSize + 2)];
    lbTopDomain.textColor = BLUE_COLOR;
    [lbTopDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(hTop);
    }];
    
    viewDetail.layer.cornerRadius = 5.0;
    viewDetail.layer.borderWidth = 1.0;
    viewDetail.layer.borderColor = GRAY_230.CGColor;
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTopDomain.mas_centerY);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(270.0);
    }];
    
    lbID.textColor = lbIDValue.textColor = lbDomain.textColor = lbDomainValue.textColor = lbServiceName.textColor = lbServiceNameValue.textColor = lbRegisterDate.textColor = lbRegisterDateValue.textColor = lbExpire.textColor = lbExpireDate.textColor = lbState.textColor = lbStateValue.textColor = lbWhoisProtect.textColor = TITLE_COLOR;
    
    lbID.font = lbDomain.font = lbServiceName.font = lbRegisterDate.font = lbExpire.font = lbState.font = lbWhoisProtect.font = [AppDelegate sharedInstance].fontRegular;
    
    lbIDValue.font = lbDomainValue.font = lbServiceNameValue.font = lbRegisterDateValue.font = lbExpireDate.font = lbStateValue.font = [AppDelegate sharedInstance].fontMedium;
    
    //  ID
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(viewDetail).offset(padding);
        make.right.equalTo(viewDetail.mas_centerX).offset(-30.0);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbID.mas_right).offset(10.0);
        make.top.bottom.equalTo(lbID);
        make.right.equalTo(viewDetail.mas_right).offset(-padding);
    }];
    
    //  domain name
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbID.mas_bottom);
        make.left.right.equalTo(lbID);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbIDValue);
        make.top.bottom.equalTo(lbDomain);
    }];
    
    //  service name
    [lbServiceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.right.equalTo(lbDomain);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbServiceNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainValue);
        make.top.equalTo(lbServiceName);
        //  make.height.mas_equalTo(2*self.hItem);
        make.height.mas_greaterThanOrEqualTo(hItem);
    }];
    
    //  registered date
    [lbRegisterDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbServiceNameValue.mas_bottom);
        make.left.right.equalTo(lbServiceName);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbRegisterDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbServiceNameValue);
        make.top.equalTo(lbRegisterDate);
        make.height.mas_equalTo(hItem);
    }];
    
    //  expire date
    [lbExpire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRegisterDate.mas_bottom);
        make.left.right.equalTo(lbRegisterDate);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbExpireDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbRegisterDateValue);
        make.top.equalTo(lbExpire);
        make.height.mas_equalTo(hItem);
    }];
    
    //  state
    [lbState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbExpire.mas_bottom);
        make.left.right.equalTo(lbExpire);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbStateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbExpireDate);
        make.top.bottom.equalTo(lbState);
    }];
    
    //  whois protect state
    [lbWhoisProtect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbState.mas_bottom);
        make.left.right.equalTo(lbState);
        make.height.mas_equalTo(hItem);
    }];
    
    [swWhoisProtect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbExpireDate);
        make.centerY.equalTo(lbWhoisProtect.mas_centerY);
        make.width.mas_equalTo(49.0);
        make.height.mas_equalTo(31.0);
    }];
    
    btnChangeDNS.titleLabel.font = btnUpdatePassport.titleLabel.font = btnSigning.titleLabel.font = btnRenewDomain.titleLabel.font = btnManagerDNS.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    btnChangeDNS.backgroundColor = btnUpdatePassport.backgroundColor = btnSigning.backgroundColor = btnRenewDomain.backgroundColor = btnManagerDNS.backgroundColor = BLUE_COLOR;
    btnChangeDNS.layer.cornerRadius = btnUpdatePassport.layer.cornerRadius = btnSigning.layer.cornerRadius = btnRenewDomain.layer.cornerRadius = btnManagerDNS.layer.cornerRadius = hBTN/2;
    
    btnChangeDNS.layer.borderColor = btnUpdatePassport.layer.borderColor = btnSigning.layer.borderColor = btnRenewDomain.layer.borderColor = btnManagerDNS.layer.borderColor = BLUE_COLOR.CGColor;
    btnChangeDNS.layer.borderWidth = btnUpdatePassport.layer.borderWidth = btnSigning.layer.borderWidth = btnRenewDomain.layer.borderWidth = btnManagerDNS.layer.borderWidth = 1.0;

    [btnManagerDNS setTitle:text_dns_record_management forState:UIControlStateNormal];
    [btnManagerDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnChangeDNS setTitle:text_change_name_server forState:UIControlStateNormal];
    [btnChangeDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnManagerDNS);
        make.bottom.equalTo(btnManagerDNS.mas_top).offset(-paddingY);
        make.height.equalTo(btnManagerDNS.mas_height);
    }];
    
    [btnUpdatePassport setTitle:text_update_passport forState:UIControlStateNormal];
    [btnUpdatePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnChangeDNS);
        make.bottom.equalTo(btnChangeDNS.mas_top).offset(-paddingY);
        make.height.equalTo(btnChangeDNS.mas_height);
    }];
    
    [btnSigning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnUpdatePassport);
        make.bottom.equalTo(btnUpdatePassport.mas_top).offset(-paddingY);
        make.height.equalTo(btnUpdatePassport.mas_height);
    }];
    
    [btnRenewDomain setTitle:text_renew_domains forState:UIControlStateNormal];
    [btnRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(btnSigning);
        make.bottom.equalTo(btnSigning.mas_top).offset(-paddingY);
        make.height.equalTo(btnSigning.mas_height);
    }];
    
    lbNoData.hidden = TRUE;
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
    lbNoData.textAlignment = NSTextAlignmentCenter;
    lbNoData.textColor = TITLE_COLOR;
    lbNoData.text = @"Không lấy được dữ liệu";
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - Webservice delegate

-(void)failedGetDomainInfoWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
}

-(void)getDomainInfoSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    [self processDomainInfoWithData: data];
}

-(void)failedToUpdateWhoisProtect:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    
    //  reset value if failed to update
    swWhoisProtect.on = !swWhoisProtect.on;
    swWhoisProtect.enabled = TRUE;
}

-(void)updateWhoisProtectSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    NSString *message = [data objectForKey:@"message"];
    if (![AppUtils isNullOrEmpty: message]) {
        [self.view makeToast:message duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }else{
        [self.view makeToast:@"Cập nhật thành công" duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
    swWhoisProtect.enabled = TRUE;
}

@end
