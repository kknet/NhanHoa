//
//  DomainDetailsViewController.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainDetailsViewController.h"
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
    
    [self showContentWithCurrentLanguage];
    
    if (![AppUtils isNullOrEmpty: ordId]) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading..."] Interaction:NO];
        
        [self getDomainInfoWithOrdId: ordId];
    }else{
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"ord_id does not exists"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:2.0];
    }
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Domain details"];
    
    [btnRenewal setTitle:[appDelegate.localization localizedStringForKey:@"Renewal domain"]
                forState:UIControlStateNormal];
    
    [btnSignature setTitle:[appDelegate.localization localizedStringForKey:@"Signature"]
                  forState:UIControlStateNormal];
    
    [btnUpdatePassport setTitle:[appDelegate.localization localizedStringForKey:@"Update passport"]
                       forState:UIControlStateNormal];
    
    [btnChangeNameServer setTitle:[appDelegate.localization localizedStringForKey:@"DNS Records management"]
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
    viewHeader.backgroundColor = UIColor.clearColor;
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
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    //  table
    hCell = 15.0 + 25.0 + 15.0;
    hLargeCell = hCell + 25.0;
    
    float hTableView = 6*hCell + hLargeCell;
    
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
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnRenewalPress:(UIButton *)sender {
}

- (IBAction)btnSignaturePress:(UIButton *)sender {
}

- (IBAction)btnUpdatePassportPress:(UIButton *)sender {
}

- (IBAction)btnChangeNameServerPress:(UIButton *)sender {
}

- (IBAction)btnDNSRecordsManagement:(UIButton *)sender {
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
    [tbContent reloadData];
    
//    domainType = [info objectForKey:@"domain_type"];
//    [self updateFooterMenuWithDomainType: domainType];
//
//    domainId = [info objectForKey:@"domain_id"];
//
//    id cusId = [info objectForKey:@"cus_id"];
//    if (cusId != nil && [cusId isKindOfClass:[NSString class]]) {
//        cus_id = cusId;
//    }else if (cusId != nil && [cusId isKindOfClass:[NSNumber class]]) {
//        cus_id = [NSString stringWithFormat:@"%ld", [cusId longValue]];
//    }
//
//    //  reupdate frame for top label
//    float sizeText = [AppUtils getSizeWithText:domain withFont:lbTopDomain.font andMaxWidth:SCREEN_WIDTH].width;
//    float hTop = 40.0;
//    if ([DeviceUtils isScreen320]) {
//        hTop = 25.0;
//    }
//    [lbTopDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view).offset(padding);
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.height.mas_equalTo(hTop);
//        make.width.mas_equalTo(sizeText + 10.0);
//    }];
//
//    //  get size of content
//    float maxSize = (SCREEN_WIDTH - 2*padding)/2 + 20;
//    float hContent = hItem;
//    if (![AppUtils isNullOrEmpty: serviceName]) {
//        float hText = [AppUtils getSizeWithText:serviceName withFont:lbServiceNameValue.font andMaxWidth:maxSize].height;
//        if (hText > hContent) {
//            hContent = hText;
//        }
//    }
//
//    float hView = padding + hItem + hItem + (hItem/2 - 10.0) + hContent + hItem + hItem + hItem + padding;
//    if (![AppUtils checkDomainIsNationalDomain: domain]) {
//        hView += hItem;
//    }
//
//    [viewDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.lbTopDomain.mas_centerY);
//        make.left.equalTo(self.view).offset(padding);
//        make.right.equalTo(self.view).offset(-padding);
//        make.height.mas_equalTo(hView);
//    }];
//
//
//    //  get CMND
//    CMND_a = [info objectForKey:@"cmnd_a"];
//    CMND_b = [info objectForKey:@"cmnd_b"];
//    ban_khai = [info objectForKey:@"bankhai"];
//
//    //  get domain_signed_url
//    domain_signed_url = [info objectForKey:@"domain_signed_url"];
//    domain_signing_url = [info objectForKey:@"domain_signing_url"];
//
//    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
//        [btnSigning setTitle:text_signed_contract forState:UIControlStateNormal];
//
//    }else if (![AppUtils isNullOrEmpty: domain_signing_url]){
//        [btnSigning setTitle:text_signing_contract forState:UIControlStateNormal];
//    }
//
    
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

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
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
            
            NSString *domain = [domainInfo objectForKey:@"domain_name"];
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
            BOOL isWhoIs = FALSE;
            id isProtect = [domainInfo objectForKey:@"domain_whois_protect"];
            if ([isProtect isKindOfClass:[NSString class]])
            {
                if ([isProtect isEqualToString:@"1"]) {
                    isWhoIs = TRUE;
                }else{
                    isWhoIs = FALSE;
                }
            }
            
            float originX = (SCREEN_WIDTH - padding - 60.0);
            swWhoIsProtect = [[KLCustomSwitch alloc] initWithState:isWhoIs frame:CGRectMake(originX, (hCell - 30.0)/2, 60.0, 30.0)];
            swWhoIsProtect.delegate = self;
            [cell addSubview: swWhoIsProtect];
            
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
