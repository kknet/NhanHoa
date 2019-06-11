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
#import "UpdateDNSViewController.h"

@interface RenewDomainDetailViewController ()<WebServiceUtilsDelegate> {
    NSString *CMND_a;
    NSString *CMND_b;
    NSString *domain;
}

@end

@implementation RenewDomainDetailViewController
@synthesize lbTopDomain, viewDetail, lbID, lbIDValue, lbDomain, lbDomainValue, lbServiceName, lbServiceNameValue, lbRegisterDate, lbRegisterDateValue, lbExpire, lbExpireDate, lbState, lbStateValue, btnRenewDomain, btnChangeDNS, btnUpdatePassport, lbNoData;
@synthesize ordId, cusId, padding, hItem;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Chi tiết tên miền";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen: @"RenewDomainDetailViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
    [self setEmptyValueForView];
    
    if (![AppUtils isNullOrEmpty: ordId]) {
        [self getDomainInfoWithOrdId: ordId];
    }else{
        lbNoData.hidden = FALSE;
        [self.view makeToast:[NSString stringWithFormat:@"ord_id không tồn tại"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
        [WriteLogsUtils writeLogContent:SFM(@"%@", @">>>>>>>>>>>> ord_id của tên miền không tồn tại <<<<<<<<<<<<<") toFilePath:[AppDelegate sharedInstance].logFilePath];
    }
}

- (IBAction)btnRenewDomainPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (![AppUtils isNullOrEmpty: domain]) {
        RenewDomainCartViewController *renewCartVC = [[RenewDomainCartViewController alloc] initWithNibName:@"RenewDomainCartViewController" bundle:nil];
        renewCartVC.domain = domain;
        [self.navigationController pushViewController:renewCartVC animated:TRUE];
    }else{
        [self.view makeToast:@"Tên miền không tồn tại. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (IBAction)btnUpdatePassportPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    UpdatePassportViewController *updateVC = [[UpdatePassportViewController alloc] initWithNibName:@"UpdatePassportViewController" bundle:nil];
    updateVC.cusId = cusId;
    updateVC.curCMND_a = CMND_a;
    updateVC.curCMND_b = CMND_b;
    [self.navigationController pushViewController:updateVC animated:TRUE];
}

- (IBAction)btnChangeDNSPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (![AppUtils isNullOrEmpty: lbTopDomain.text]) {
        UpdateDNSViewController *updateDNSVC = [[UpdateDNSViewController alloc] initWithNibName:@"UpdateDNSViewController" bundle:nil];
        updateDNSVC.domain = lbTopDomain.text;
        [self.navigationController pushViewController:updateDNSVC animated:TRUE];
    }else{
        [self.view makeToast:@"Tên miền không tồn tại. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (void)setEmptyValueForView {
    lbIDValue.text = lbDomainValue.text = lbServiceNameValue.text = lbRegisterDateValue.text = lbExpireDate.text = lbStateValue.text = @"";
}

- (void)getDomainInfoWithOrdId: (NSString *)ord_id {
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
    domain = [info objectForKey:@"domain_name"];
    lbTopDomain.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
    
    //  reupdate frame for top label
    float sizeText = [AppUtils getSizeWithText:domain withFont:lbTopDomain.font andMaxWidth:SCREEN_WIDTH].width;
    [lbTopDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40.0);
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
    
    NSString *endTime = [info objectForKey:@"end_time"];
    if ([endTime isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: endTime]) {
        NSString *endDate = [AppUtils getDateStringFromTimerInterval:(long)[endTime longLongValue]];
        lbExpireDate.text = endDate;
        
        //  check expire
        long curTime = (long)[[NSDate date] timeIntervalSince1970];
        if (curTime >= [endTime longLongValue]) {
            lbStateValue.attributedText = [AppUtils generateTextWithContent:@"Hết hạn" font:[AppDelegate sharedInstance].fontMedium color:[UIColor darkGrayColor] image:[UIImage imageNamed:@"info_red"] size:20.0 imageFirst:TRUE];
            
        }else if ([endTime longLongValue] - curTime < 30*24*60*60){
            lbStateValue.attributedText = [AppUtils generateTextWithContent:@"Sắp hết hạn" font:[AppDelegate sharedInstance].fontMedium color:NEW_PRICE_COLOR image:[UIImage imageNamed:@"info_red"] size:20.0 imageFirst:TRUE];
        }else{
            lbStateValue.attributedText = [AppUtils generateTextWithContent:@"Đã kích hoạt" font:[AppDelegate sharedInstance].fontMedium color:GREEN_COLOR image:[UIImage imageNamed:@"tick_green"] size:20.0 imageFirst:TRUE];
        }
    }else{
        lbExpireDate.text = @"";
        lbStateValue.text = @"N/A";
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
    [viewDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTopDomain.mas_centerY);
        make.left.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(hView);
    }];
    
    //  service name
    [lbServiceNameValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomainValue);
        make.top.equalTo(self.lbServiceName.mas_centerY).offset(-10.0);
        make.height.mas_equalTo(hContent);
    }];
    
    //  get CMND
    CMND_a = [info objectForKey:@"cmnd_a"];
    CMND_b = [info objectForKey:@"cmnd_b"];
}


- (void)setupUIForView {
    padding = 15.0;
    hItem = 40.0;
    
    lbTopDomain.backgroundColor = UIColor.whiteColor;
    
    float fontSize = [AppDelegate sharedInstance].fontBold.pointSize;
    lbTopDomain.font = [UIFont fontWithName:RobotoBold size:(fontSize + 2)];
    lbTopDomain.textColor = BLUE_COLOR;
    [lbTopDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(40.0);
    }];
    
    viewDetail.layer.cornerRadius = 5.0;
    viewDetail.layer.borderWidth = 1.0;
    viewDetail.layer.borderColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0].CGColor;
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTopDomain.mas_centerY);
        make.left.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(270.0);
    }];
    
    lbID.textColor = lbIDValue.textColor = lbDomain.textColor = lbDomainValue.textColor = lbServiceName.textColor = lbServiceNameValue.textColor = lbRegisterDate.textColor = lbRegisterDateValue.textColor = lbExpire.textColor = lbExpireDate.textColor = lbState.textColor = lbStateValue.textColor = TITLE_COLOR;
    
    lbID.font = lbDomain.font = lbServiceName.font = lbRegisterDate.font = lbExpire.font = lbState.font = [AppDelegate sharedInstance].fontRegular;
    
    lbIDValue.font = lbDomainValue.font = lbServiceNameValue.font = lbRegisterDateValue.font = lbExpireDate.font = lbStateValue.font = [AppDelegate sharedInstance].fontMedium;
    
    //  ID
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.viewDetail).offset(self.padding);
        make.right.equalTo(self.viewDetail.mas_centerX).offset(-30.0);
        make.height.mas_equalTo(self.hItem);
    }];
    
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbID.mas_right).offset(10.0);
        make.top.bottom.equalTo(self.lbID);
        make.right.equalTo(self.viewDetail.mas_right).offset(-self.padding);
    }];
    
    //  domain name
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbID.mas_bottom);
        make.left.right.equalTo(self.lbID);
        make.height.mas_equalTo(self.hItem);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbIDValue);
        make.top.bottom.equalTo(self.lbDomain);
    }];
    
    //  service name
    [lbServiceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomain.mas_bottom);
        make.left.right.equalTo(self.lbDomain);
        make.height.mas_equalTo(self.hItem);
    }];
    
    [lbServiceNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomainValue);
        make.top.equalTo(self.lbServiceName);
        make.height.mas_equalTo(2*self.hItem);
    }];
    
    //  registered date
    [lbRegisterDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbServiceNameValue.mas_bottom);
        make.left.right.equalTo(self.lbServiceName);
        make.height.mas_equalTo(self.hItem);
    }];
    
    [lbRegisterDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbServiceNameValue);
        make.top.equalTo(self.lbRegisterDate);
        make.height.mas_equalTo(self.hItem);
    }];
    
    //  expire date
    [lbExpire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterDate.mas_bottom);
        make.left.right.equalTo(self.lbRegisterDate);
        make.height.mas_equalTo(self.hItem);
    }];
    
    [lbExpireDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRegisterDateValue);
        make.top.equalTo(self.lbExpire);
        make.height.mas_equalTo(self.hItem);
    }];
    
    //  state
    [lbState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbExpire.mas_bottom);
        make.left.right.equalTo(self.lbExpire);
        make.height.mas_equalTo(self.hItem);
    }];
    
    [lbStateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbExpireDate);
        make.top.bottom.equalTo(self.lbState);
    }];
    
    float hBTN = 45.0;
    
    btnChangeDNS.titleLabel.font = btnUpdatePassport.titleLabel.font = btnRenewDomain.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    btnChangeDNS.backgroundColor = btnUpdatePassport.backgroundColor = btnRenewDomain.backgroundColor = BLUE_COLOR;
    btnChangeDNS.layer.cornerRadius = btnUpdatePassport.layer.cornerRadius = btnRenewDomain.layer.cornerRadius = hBTN/2;
    
    [btnChangeDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.bottom.equalTo(self.view).offset(-2*self.padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnUpdatePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnChangeDNS);
        make.bottom.equalTo(self.btnChangeDNS.mas_top).offset(-self.padding);
        make.height.equalTo(self.btnChangeDNS.mas_height);
    }];
    
    [btnRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnUpdatePassport);
        make.bottom.equalTo(self.btnUpdatePassport.mas_top).offset(-self.padding);
        make.height.equalTo(self.btnUpdatePassport.mas_height);
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
}

-(void)getDomainInfoSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    [self processDomainInfoWithData: data];
}

@end
