//
//  DomainDetailsViewController.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainDetailsViewController.h"
#import "SigningDomainViewController.h"
#import "UpdatePassportViewController.h"
#import "UpdateDNSViewController.h"
#import "DNSRecordsViewController.h"
//  #import "DomainDNSViewController.h"
#import "RenewDomainCartViewController.h"
#import "DomainDetailTbvCell.h"
#import "KLCustomSwitch.h"

@interface DomainDetailsViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate, KLCustomSwitchDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    float hBTN;
    UIFont *textFont;
    float hCell;
    float hLargeCell;
    
    BOOL zonedns;
    NSDictionary *domainInfo;
    KLCustomSwitch *swWhoIsProtect;
    
    NSString *domainType;
    float hTableView;
    
    NSString *domain_signed_url;
    NSString *domain_signing_url;
    
    NSString *domain;
    NSString *domainId;
    NSString *cus_id;
    
    BOOL supportWhoIsProtect;
    BOOL isWhoIs;
}
@end

@implementation DomainDetailsViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvContent, tbContent, btnRenewal, btnSignature, btnUpdatePassport, btnChangeNameServer, btnDNSRecordsManagement;
@synthesize ordId, cusId;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self showContentWithCurrentLanguage];
    supportWhoIsProtect = FALSE;
    
    if (![AppUtils isNullOrEmpty: ordId]) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading..."] Interaction:NO];
        
        [self getDomainInfoWithOrdId: ordId];
    }else{
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"ord_id does not exists"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:2.0];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [swWhoIsProtect removeFromSuperview];
    swWhoIsProtect = nil;
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Domain details"];
    
    [btnRenewal setTitle:[appDelegate.localization localizedStringForKey:@"Renewal domain"]
                forState:UIControlStateNormal];
    
    [btnSignature setTitle:[appDelegate.localization localizedStringForKey:@"Signature"]
                  forState:UIControlStateNormal];
    
    [btnUpdatePassport setTitle:[appDelegate.localization localizedStringForKey:@"Update passport"]
                       forState:UIControlStateNormal];
    
    [btnChangeNameServer setTitle:[appDelegate.localization localizedStringForKey:@"Change Name Server"]
                         forState:UIControlStateNormal];
    
    [btnDNSRecordsManagement setTitle:[appDelegate.localization localizedStringForKey:@"DNS Records management"]
                             forState:UIControlStateNormal];
}

- (void)dismissViewController {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 45.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = 18.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(18.0);
    }];
    
    //  scrollview content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    scvContent.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(4.0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    //  table
    hCell = 15.0 + 25.0 + 15.0;
    hLargeCell = hCell + 25.0;
    
    hTableView = 6*hCell + hLargeCell;
    
    [tbContent registerNib:[UINib nibWithNibName:@"DomainDetailTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainDetailTbvCell"];
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.scrollEnabled = FALSE;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    //  footer buttons
    btnRenewal.backgroundColor = btnSignature.backgroundColor = btnUpdatePassport.backgroundColor = btnChangeNameServer.backgroundColor = btnDNSRecordsManagement.backgroundColor = BLUE_COLOR;
    
    btnRenewal.layer.cornerRadius = btnSignature.layer.cornerRadius = btnUpdatePassport.layer.cornerRadius = btnChangeNameServer.layer.cornerRadius = btnDNSRecordsManagement.layer.cornerRadius = 8.0;
    
    btnRenewal.titleLabel.font = btnSignature.titleLabel.font = btnUpdatePassport.titleLabel.font = btnChangeNameServer.titleLabel.font = btnDNSRecordsManagement.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    
    btnRenewal.clipsToBounds = btnSignature.clipsToBounds = btnUpdatePassport.clipsToBounds = btnChangeNameServer.clipsToBounds = btnDNSRecordsManagement.clipsToBounds = TRUE;
    
    [btnRenewal setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnRenewal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tbContent.mas_bottom).offset(2*padding);
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnSignature setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSignature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnRenewal.mas_bottom).offset(10.0);
        make.left.right.equalTo(btnRenewal);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnUpdatePassport setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnUpdatePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnSignature.mas_bottom).offset(10.0);
        make.left.right.equalTo(btnSignature);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnChangeNameServer setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnChangeNameServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnUpdatePassport.mas_bottom).offset(10.0);
        make.left.right.equalTo(btnUpdatePassport);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnDNSRecordsManagement setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnDNSRecordsManagement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnChangeNameServer.mas_bottom).offset(10.0);
        make.left.right.equalTo(btnChangeNameServer);
        make.height.mas_equalTo(hBTN);
    }];
    
    float hContent = hTableView + 2*padding + hBTN + padding + hBTN + padding + hBTN + padding + hBTN + padding + hBTN + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnRenewalPress:(UIButton *)sender
{
    id cusId = [domainInfo objectForKey:@"cus_id"];
    if (cusId != nil && [cusId isKindOfClass:[NSString class]]) {
        cus_id = cusId;
    }else if (cusId != nil && [cusId isKindOfClass:[NSNumber class]]) {
        cus_id = SFM(@"%ld", [cusId longValue]);
    }
    
    if (![AppUtils isNullOrEmpty: cus_id]) {
        RenewDomainCartViewController *renewCartVC = [[RenewDomainCartViewController alloc] initWithNibName:@"RenewDomainCartViewController" bundle:nil];
        renewCartVC.domain = domain;
        renewCartVC.cus_id = cus_id;
        renewCartVC.ord_id = ordId;
        [self.navigationController pushViewController:renewCartVC animated:TRUE];
    }
}

- (IBAction)btnSignaturePress:(UIButton *)sender {
    SigningDomainViewController *signingVC = [[SigningDomainViewController alloc] initWithNibName:@"SigningDomainViewController" bundle:nil];
    signingVC.domain_signing_url = signingVC.domain_signed_url = @"";
    
    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        signingVC.domain_signed_url = domain_signed_url;
        
    }else if (![AppUtils isNullOrEmpty: domain_signing_url]) {
        signingVC.domain_signing_url = domain_signing_url;
        
    }
    [self.navigationController pushViewController:signingVC animated:TRUE];
}

- (IBAction)btnUpdatePassportPress:(UIButton *)sender
{
    //  get CMND
    NSString *CMND_a = [domainInfo objectForKey:@"cmnd_a"];
    NSString *CMND_b = [domainInfo objectForKey:@"cmnd_b"];
    NSString *ban_khai = [domainInfo objectForKey:@"bankhai"];
    
    NSString *domain = [domainInfo objectForKey:@"domain_name"];
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

- (IBAction)btnChangeNameServerPress:(UIButton *)sender {
    UpdateDNSViewController *updateDNSVC = [[UpdateDNSViewController alloc] initWithNibName:@"UpdateDNSViewController" bundle:nil];
    updateDNSVC.domain = domain;
    [self.navigationController pushViewController:updateDNSVC animated:TRUE];
}

- (IBAction)btnDNSRecordsManagement:(UIButton *)sender {
    DNSRecordsViewController *recordsDNSVC = [[DNSRecordsViewController alloc] initWithNibName:@"DNSRecordsViewController" bundle:nil];
    recordsDNSVC.domainName = domain;
    recordsDNSVC.supportDNSRecords = zonedns;
    [self.navigationController pushViewController:recordsDNSVC animated:TRUE];
}

#pragma mark - Whois Protect
-(void)switchValueChangedOn {
    swWhoIsProtect.enabled = FALSE;
    [self performSelector:@selector(enableSwitchWhoisProtect) withObject:nil afterDelay:1.0];
    
    NSString *domain = [domainInfo objectForKey:@"domain_name"];
    [[WebServiceUtils getInstance] updateWhoisProtectForDomain:domain domainId:domainId protectValue:TRUE];
}

-(void)switchValueChangedOff {
    swWhoIsProtect.enabled = FALSE;
    [self performSelector:@selector(enableSwitchWhoisProtect) withObject:nil afterDelay:1.0];
    
    [[WebServiceUtils getInstance] updateWhoisProtectForDomain:domain domainId:domainId protectValue:FALSE];
}

- (void)enableSwitchWhoisProtect {
    swWhoIsProtect.enabled = TRUE;
}

#pragma mark - Webservice utils & functions
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
    domainInfo = [[NSDictionary alloc] initWithDictionary: info];
    
    domain = [domainInfo objectForKey:@"domain_name"];
    domainType = [domainInfo objectForKey:@"domain_type"];
    domainId = [domainInfo objectForKey:@"domain_id"];

    isWhoIs = FALSE;
    id isProtect = [domainInfo objectForKey:@"domain_whois_protect"];
    if ([isProtect isKindOfClass:[NSString class]])
    {
        supportWhoIsProtect = TRUE;
        if ([isProtect isEqualToString:@"1"]) {
            isWhoIs = TRUE;
        }else{
            isWhoIs = FALSE;
        }
    }
    
    if (supportWhoIsProtect) {
        hTableView = 6*hCell + hLargeCell;
    }else{
        hTableView = 5*hCell + hLargeCell;
    }
    [tbContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    
    [self updateFooterMenuWithDomainType: domainType];
    
    //  get domain_signed_url
    domain_signed_url = [domainInfo objectForKey:@"domain_signed_url"];
    domain_signing_url = [domainInfo objectForKey:@"domain_signing_url"];

    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        [btnSignature setTitle:[appDelegate.localization localizedStringForKey:@"Signed contract"] forState:UIControlStateNormal];

    }else if (![AppUtils isNullOrEmpty: domain_signing_url]){
        [btnSignature setTitle:[appDelegate.localization localizedStringForKey:@"Signing contract"] forState:UIControlStateNormal];
    }
    
    [tbContent reloadData];
}

-(void)failedToUpdateWhoisProtect:(NSString *)error {
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    
    //  reset value if failed to update
    BOOL state = !swWhoIsProtect.curState;
    if (state) {
        [swWhoIsProtect setUIForOnState];
    }else{
        [swWhoIsProtect setUIForOffState];
    }
    swWhoIsProtect.enabled = TRUE;
}

-(void)updateWhoisProtectSuccessfulWithData:(NSDictionary *)data {
    NSString *message = [data objectForKey:@"message"];
    if (![AppUtils isNullOrEmpty: message]) {
        [self.view makeToast:message duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }else{
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Updated"] duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
    swWhoIsProtect.enabled = TRUE;
}

-(void)failedGetDomainInfoWithError:(NSString *)error
{
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)getDomainInfoSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self processDomainInfoWithData: data];
}

- (void)updateFooterMenuWithDomainType: (NSString *)domainType {
    //  btnChangeDNS.hidden = btnRenewDomain.hidden = btnManagerDNS.hidden = FALSE;
    float hContent = 0;
    if (![AppUtils isNullOrEmpty: domainType] && [domainType isEqualToString:domainvn_type]) {
        hContent = hTableView + 2*padding + hBTN + padding + hBTN + padding + hBTN + padding + hBTN + padding + hBTN + padding;
        
        //  btnUpdatePassport.hidden = btnSigning.hidden = FALSE;
        
//        if (IS_IPHONE || IS_IPOD) {
//            [btnChangeDNS mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(btnManagerDNS);
//                make.bottom.equalTo(btnManagerDNS.mas_top).offset(-paddingY);
//                make.height.equalTo(btnManagerDNS.mas_height);
//            }];
//        }else{
//            [btnChangeDNS mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(btnManagerDNS);
//                make.right.equalTo(self.view.mas_centerX).offset(-paddingY/2);
//                make.bottom.equalTo(btnManagerDNS.mas_top).offset(-paddingY);
//                make.height.mas_equalTo(hBTN);
//            }];
//
//            [btnUpdatePassport mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(self.view.mas_centerX).offset(paddingY/2);
//                make.right.equalTo(btnManagerDNS);
//                make.top.bottom.equalTo(btnChangeDNS);
//            }];
//
//            [btnRenewDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(btnChangeDNS);
//                make.bottom.equalTo(btnChangeDNS.mas_top).offset(-paddingY);
//                make.height.mas_equalTo(hBTN);
//            }];
//
//            [btnSigning mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.right.equalTo(btnUpdatePassport);
//                make.top.bottom.equalTo(btnRenewDomain);
//            }];
//        }
    }else{
//        btnUpdatePassport.hidden = btnSigning.hidden = TRUE;
        
        hContent = hTableView + 2*padding + hBTN + padding + hBTN + padding + hBTN + padding;
        
        [btnSignature mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnRenewal.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        [btnUpdatePassport mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnSignature.mas_bottom);
            make.height.mas_equalTo(0);
        }];
    }
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (supportWhoIsProtect) {
        return 7;
    }else{
        return 6;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DomainDetailTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainDetailTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"ORD ID"];
            cell.lbValue.text = ordId;
            cell.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(244/255.0)
                                                    blue:(246/255.0) alpha:1.0];
            cell.lbSepa.hidden = TRUE;
            break;
        }
        case 1:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Domain"];
            cell.lbValue.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
            
            break;
        }
        case 2:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Service name"];
            
            NSString *serviceName = [domainInfo objectForKey:@"service_name"];
            cell.lbValue.text = (![AppUtils isNullOrEmpty: serviceName]) ? serviceName : @"";
            
            break;
        }
        case 3:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Creation date"];
            
            NSString *startTime = [domainInfo objectForKey:@"start_time"];
            if ([startTime isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: startTime]) {
                NSString *startDate = [AppUtils getDateStringFromTimerInterval:(long)[startTime longLongValue]];
                cell.lbValue.text = startDate;
            }else{
                cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Updating"];
            }
            
            break;
        }
        case 4:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Expiration date"];
            
            NSString *endTime = [domainInfo objectForKey:@"end_time"];
            if ([endTime isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: endTime]) {
                NSString *endDate = [AppUtils getDateStringFromTimerInterval:(long)[endTime longLongValue]];
                cell.lbValue.text = endDate;
            }else{
                cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Updating"];
            }
            
            break;
        }
        case 5:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Status"];
            
            NSString *statusCode = [domainInfo objectForKey:@"status"];
            if (![AppUtils isNullOrEmpty: statusCode]) {
                cell.lbValue.text = [AppUtils getStatusValueWithCode: statusCode];
                if ([statusCode isEqualToString:@"2"]) {
                    cell.lbValue.textColor = GREEN_COLOR;
                    
                }else if ([statusCode isEqualToString:@"3"] || [statusCode isEqualToString:@"6"]){
                    cell.lbValue.textColor = NEW_PRICE_COLOR;
                    
                }else{
                    cell.lbValue.textColor = UIColor.orangeColor;
                }
            }else{
                cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Undefined"];
                cell.lbValue.textColor = NEW_PRICE_COLOR;
            }
            
            break;
        }
        case 6:{
            cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Whois Protect"];
            cell.lbValue.text = @"";
            
            //  check whois protect
            if (swWhoIsProtect == nil) {
                float originX = (SCREEN_WIDTH - padding - 60.0);
                swWhoIsProtect = [[KLCustomSwitch alloc] initWithState:isWhoIs frame:CGRectMake(originX, (hCell - 30.0)/2, 60.0, 30.0)];
                swWhoIsProtect.delegate = self;
                [cell addSubview: swWhoIsProtect];
            }
            
            break;
        }
        default:
            break;
    }
    
    if ([cell.lbTitle.text isEqualToString:[appDelegate.localization localizedStringForKey:@"Status"]]) {
        cell.imgStatus.hidden = FALSE;
    }else{
        cell.imgStatus.hidden = TRUE;
    }
    
    [cell updateFrameWithContentValue];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

#pragma mark - UIScrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scvContent.contentOffset = CGPointZero;
    }
}

@end
