//
//  RenewedDomainViewController.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RenewedDomainViewController.h"
#import "RenewDomainDetailViewController.h"
#import "ExpireDomainCell.h"
#import "WebServices.h"
#import "AccountModel.h"

typedef enum TypeSelectDomain{
    eAllDomain,
    eExpireDomain,
}TypeSelectDomain;

@interface RenewedDomainViewController ()<UITableViewDelegate, UITableViewDataSource, PriceListViewDelegate, WebServicesDelegate>{
    NSMutableArray *listAll;
    NSMutableArray *listExpire;
    TypeSelectDomain type;
    WebServices *webService;
    BOOL gettedAll;
    BOOL gettedExpire;
}

@end

@implementation RenewedDomainViewController
@synthesize viewMenu, btnAllDomain, btnExpireDomain, tbDomain, btnPriceList, priceView, lbNoData;
@synthesize padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"RenewedDomainViewController"];
    
    type = eAllDomain;
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    self.title = @"Tên miền đã đăng ký";
    
    lbNoData.hidden = TRUE;
    [self getDomainsWasRegisteredWithType: 0];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (tbDomain.frame.size.height >= tbDomain.contentSize.height) {
        tbDomain.scrollEnabled = FALSE;
    }else{
        tbDomain.scrollEnabled = TRUE;
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    
    [priceView removeFromSuperview];
    priceView = nil;
}

- (IBAction)btnAllDomainPress:(UIButton *)sender {
    if (type == eAllDomain) {
        return;
    }
    [tbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.viewMenu);
        make.top.equalTo(self.viewMenu.mas_bottom).offset(self.padding);
        make.bottom.equalTo(self.btnPriceList.mas_top);
    }];
    
    type = eAllDomain;
    
    [btnAllDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = BLUE_COLOR;
    
    [btnExpireDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = UIColor.clearColor;
    
    if (gettedAll) {
        if (listAll.count > 0) {
            lbNoData.hidden = TRUE;
            tbDomain.hidden = FALSE;
        }else{
            lbNoData.hidden = FALSE;
            tbDomain.hidden = TRUE;
        }
        [tbDomain reloadData];
    }else{
        [tbDomain reloadData];
        [self getDomainsWasRegisteredWithType: eAllDomain];
    }
}

- (IBAction)btnExpirePress:(UIButton *)sender {
    if (type == eExpireDomain) {
        return;
    }
    [tbDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.viewMenu);
        make.top.equalTo(self.viewMenu.mas_bottom).offset(self.padding);
        make.bottom.equalTo(self.view);
    }];
    
    type = eExpireDomain;
    [btnExpireDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = BLUE_COLOR;
    
    [btnAllDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = UIColor.clearColor;
    
    if (gettedExpire) {
        if (listExpire.count > 0) {
            lbNoData.hidden = TRUE;
            tbDomain.hidden = FALSE;
        }else{
            lbNoData.hidden = FALSE;
            tbDomain.hidden = TRUE;
        }
        [tbDomain reloadData];
    }else{
        [tbDomain reloadData];
        [self getDomainsWasRegisteredWithType: eExpireDomain];
    }
}

- (IBAction)btnPriceListPress:(UIButton *)sender {
    if (priceView == nil) {
        [self addPriceListViewForMainView];
    }
    priceView.delegate = self;
    [self reupdateFrameForViewPrice];
    
    if ([AppDelegate sharedInstance].domainsPrice == nil) {
        [self getPriceListForDomains];
        [priceView showWaitingView: TRUE];
    }
}

- (void)addPriceListViewForMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PriceListView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PriceListView class]]) {
            priceView = (PriceListView *) currentObject;
            break;
        }
    }
    priceView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    [priceView setupUIForView];
    priceView.clipsToBounds = TRUE;
    [[AppDelegate sharedInstance].window addSubview: priceView];
}

- (void)reupdateFrameForViewPrice {
    [UIView animateWithDuration:0.25 animations:^{
        self.priceView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (void)setupUIForView {
    padding = 15.0;
    float hMenu = 40.0;
    
    viewMenu.layer.cornerRadius = hMenu/2;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(hMenu);
    }];
    
    btnAllDomain.titleLabel.font = btnExpireDomain.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    [btnAllDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = BLUE_COLOR;
    btnAllDomain.layer.cornerRadius = hMenu/2;
    [btnAllDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.viewMenu);
        make.right.equalTo(self.viewMenu.mas_centerX);
    }];
    
    [btnExpireDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = UIColor.clearColor;
    btnExpireDomain.layer.cornerRadius = hMenu/2;
    [btnExpireDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewMenu.mas_centerX);
        make.right.top.bottom.equalTo(self.viewMenu);
    }];
    
    NSAttributedString *titleAttrStr = [AppUtils generateTextWithContent:@"Bảng giá duy trì tên miền 2019" font:[AppDelegate sharedInstance].fontMedium color:[UIColor colorWithRed:(223/255.0) green:(126/255.0) blue:(35/255.0) alpha:1.0] image:[UIImage imageNamed:@"list_price"] size:20.0 imageFirst:TRUE];
    [btnPriceList setAttributedTitle:titleAttrStr forState:UIControlStateNormal];
    
    btnPriceList.backgroundColor = [UIColor colorWithRed:(223/255.0) green:(126/255.0) blue:(35/255.0) alpha:0.3];
    [btnPriceList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50.0);
    }];
    
    tbDomain.separatorStyle = UITableViewCellSelectionStyleNone;
    tbDomain.delegate = self;
    tbDomain.dataSource = self;
    [tbDomain registerNib:[UINib nibWithNibName:@"ExpireDomainCell" bundle:nil] forCellReuseIdentifier:@"ExpireDomainCell"];
    [tbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.viewMenu);
        make.top.equalTo(self.viewMenu.mas_bottom).offset(self.padding);
        make.bottom.equalTo(self.btnPriceList.mas_top);
    }];
    
    lbNoData.text = text_no_data;
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
    lbNoData.textAlignment = NSTextAlignmentCenter;
    lbNoData.textColor = UIColor.grayColor;
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tbDomain);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnPriceList.mas_top);
    }];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:list_domain_func]) {
        [self.view makeToast:@"Không thể lấy danh sách tên miền. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([link isEqualToString: domain_pricing_func]) {
        [self.view makeToast:@"Không thể lấy bảng giá tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
        [priceView showWaitingView: FALSE];
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:list_domain_func]) {
        if (data != nil && [data isKindOfClass:[NSArray class]]) {
            [self displayDomainsListWithData: (NSArray *)data];
        }
    }else if ([link isEqualToString: domain_pricing_func]) {
        [self saveDomainPricing: data];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> function = %@ & responeCode = %d", __FUNCTION__, link, responeCode] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)getDomainsWasRegisteredWithType: (int)type
{
    //  type = 1: list domain sắp hết hạn
    //  type = 0: default [all]
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang tải.." Interaction:NO];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:list_domain_mod forKey:@"mod"];
    [jsonDict setObject:[AccountModel getCusUsernameOfUser] forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:[NSNumber numberWithInt: type] forKey:@"type"];
    
    [webService callWebServiceWithLink:list_domain_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)displayDomainsListWithData: (NSArray *)domains {
    if (type == eAllDomain) {
        gettedAll = TRUE;
        
        if (listAll == nil) {
            listAll = [[NSMutableArray alloc] init];
        }else{
            [listAll removeAllObjects];
        }
        
        if (domains != nil && domains.count > 0) {
            [listAll addObjectsFromArray: domains];
            tbDomain.hidden = FALSE;
            lbNoData.hidden = TRUE;
        }else{
            tbDomain.hidden = TRUE;
            lbNoData.hidden = FALSE;
        }
        [tbDomain reloadData];
    }else{
        gettedExpire = TRUE;
        
        if (listExpire == nil) {
            listExpire = [[NSMutableArray alloc] init];
        }else{
            [listExpire removeAllObjects];
        }
        
        if (domains != nil && domains.count > 0) {
            [listExpire addObjectsFromArray: domains];
            tbDomain.hidden = FALSE;
            lbNoData.hidden = TRUE;
        }else{
            tbDomain.hidden = TRUE;
            lbNoData.hidden = FALSE;
        }
        [tbDomain reloadData];
    }
}

- (void)getPriceListForDomains {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:domain_pricing_mod forKey:@"mod"];
    [webService callWebServiceWithLink:domain_pricing_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)saveDomainPricing: (NSDictionary *)data {
    [priceView showWaitingView: FALSE];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [AppDelegate sharedInstance].domainsPrice = [[NSDictionary alloc] initWithDictionary: data];
        [priceView prepareToDisplayData];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (type == eAllDomain) {
        return listAll.count;
    }else{
        return listExpire.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpireDomainCell *cell = (ExpireDomainCell *)[tableView dequeueReusableCellWithIdentifier:@"ExpireDomainCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *domain;
    if (type == eAllDomain) {
        domain = [listAll objectAtIndex: indexPath.row];
        [cell showContentWithDomainInfo:domain withExpire:FALSE];
    }else{
        domain = [listExpire objectAtIndex: indexPath.row];
        [cell showContentWithDomainInfo:domain withExpire:TRUE];
    }
    cell.lbNum.text = [NSString stringWithFormat:@"%d.", (int)indexPath.row + 1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *domain;
    if (type == eAllDomain) {
        domain = [listAll objectAtIndex: indexPath.row];
    }else{
        domain = [listExpire objectAtIndex: indexPath.row];
    }
    NSString *ord_id = [domain objectForKey:@"ord_id"];
    NSString *cus_id = [domain objectForKey:@"cus_id"];
    
    if (![AppUtils isNullOrEmpty: ord_id] && ![AppUtils isNullOrEmpty: cus_id]) {
        RenewDomainDetailViewController *domainDetailVC = [[RenewDomainDetailViewController alloc] initWithNibName:@"RenewDomainDetailViewController" bundle:nil];
        domainDetailVC.ordId = ord_id;
        domainDetailVC.cusId = cus_id;
        [self.navigationController pushViewController: domainDetailVC animated:YES];
    }else{
        [self.view makeToast:[NSString stringWithFormat:@"ord_id không tồn tại"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65.0;
}

#pragma mark - Price list view delegate
-(void)onCloseViewDomainPrice {
    [UIView animateWithDuration:0.25 animations:^{
        self.priceView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    }];
}



@end
