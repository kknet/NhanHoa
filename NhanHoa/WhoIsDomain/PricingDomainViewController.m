//
//  PricingDomainViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PricingDomainViewController.h"
#import "PriceDomainInfoCell.h"

@interface PricingDomainViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>{
    eTypeDomainPrice eTypePrice;
}

@end

@implementation PricingDomainViewController
@synthesize viewHeader, btnQT, btnVietnam, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_domains_pricing_list;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"PricingDomainViewController"];
    
    eTypePrice = eTypePriceVN;
    if ([AppDelegate sharedInstance].listPricingVN == nil) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:text_loading Interaction:NO];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] getDomainsPricingList];
    }else{
        [tbContent reloadData];
    }
}

- (void)setupUIForView {
    float padding = 15.0;
    float hMenu = 40.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    btnVietnam.titleLabel.font = btnQT.titleLabel.font = [AppDelegate sharedInstance].fontDesc;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hMenu = 55.0;
        padding = 30.0;
        btnVietnam.titleLabel.font = btnQT.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    }
    
    //  view menu
    viewHeader.layer.cornerRadius = hMenu/2;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hMenu);
    }];
    
    eTypePrice = eTypePriceVN;
    [btnVietnam setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnVietnam.backgroundColor = BLUE_COLOR;
    btnVietnam.layer.cornerRadius = hMenu/2;
    [btnVietnam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(viewHeader);
        make.right.equalTo(viewHeader.mas_centerX);
    }];
    
    [btnQT setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnQT.backgroundColor = UIColor.clearColor;
    btnQT.layer.cornerRadius = btnVietnam.layer.cornerRadius;
    [btnQT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader.mas_centerX);
        make.right.top.bottom.equalTo(viewHeader);
    }];
    
    //  table content
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent registerNib:[UINib nibWithNibName:@"PriceDomainInfoCell" bundle:nil] forCellReuseIdentifier:@"PriceDomainInfoCell"];
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.bottom.right.equalTo(self.view);
    }];
    [self createHeaderViewForTableView];
}

- (void)createHeaderViewForTableView {
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    float sizeItem = (SCREEN_WIDTH - 2*padding - 3*10.0)/4;
    
    UIView *tbHeader = [[UIView alloc] init];
    tbHeader.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40.0);
    
    UILabel *lbName = [[UILabel alloc] init];
    lbName.text = text_domains;
    lbName.textAlignment = NSTextAlignmentLeft;
    [tbHeader addSubview: lbName];
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tbHeader).offset(padding);
        make.top.bottom.equalTo(tbHeader);
        make.width.mas_equalTo(sizeItem-10.0);
    }];
    
    UILabel *lbRenew = [[UILabel alloc] init];
    lbRenew.text = text_registration_fee;
    lbRenew.textAlignment = NSTextAlignmentRight;
    [tbHeader addSubview: lbRenew];
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbName.mas_right).offset(10.0);
        make.top.bottom.equalTo(tbHeader);
        make.width.mas_equalTo(sizeItem+5);
    }];
    
    UILabel *lbSetup = [[UILabel alloc] init];
    lbSetup.text = text_renewal_fee;
    lbSetup.textAlignment = NSTextAlignmentRight;
    [tbHeader addSubview: lbSetup];
    [lbSetup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbRenew.mas_right).offset(10.0);
        make.top.bottom.equalTo(tbHeader);
        make.width.mas_equalTo(sizeItem+5);
    }];
    
    UILabel *lbTransfer = [[UILabel alloc] init];
    lbTransfer.text = text_transfer_to;
    lbTransfer.textAlignment = NSTextAlignmentRight;
    [tbHeader addSubview: lbTransfer];
    [lbTransfer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSetup.mas_right).offset(10.0);
        make.top.bottom.equalTo(tbHeader);
        make.right.equalTo(tbHeader).offset(-padding);
    }];
    
    float fontSize = [AppDelegate sharedInstance].fontMedium.pointSize;
    
    lbName.font = lbRenew.font = lbSetup.font = lbTransfer.font = [UIFont fontWithName:RobotoMedium size:fontSize-2];
    lbName.textColor = lbRenew.textColor = lbSetup.textColor = lbTransfer.textColor = TITLE_COLOR;
    
    tbContent.tableHeaderView = tbHeader;
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (eTypePrice == eTypePriceVN) {
        return [AppDelegate sharedInstance].listPricingVN.count;
    }else{
        return [AppDelegate sharedInstance].listPricingQT.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PriceDomainInfoCell *cell = (PriceDomainInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"PriceDomainInfoCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info;
    if (eTypePrice == eTypePriceVN) {
        info = [[AppDelegate sharedInstance].listPricingVN objectAtIndex: indexPath.row];
    }else{
        info = [[AppDelegate sharedInstance].listPricingQT objectAtIndex: indexPath.row];
    }
    [cell showContentWithInfo: info];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0;
}

#pragma mark - WebServiceUtils Delegate
-(void)failedGetPricingListWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    [self.view makeToast:cannot_get_domains_pricing duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getPricingListSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [self displayDomainsListWithData: data];
    }
}

- (void)displayDomainsListWithData: (NSDictionary *)data {
    NSArray *qt = [data objectForKey:@"qt"];
    if (qt != nil && [qt isKindOfClass:[NSArray class]]) {
        [AppDelegate sharedInstance].listPricingQT = [[NSMutableArray alloc] initWithArray: qt];
    }
    
    NSArray *vn = [data objectForKey:@"vn"];
    if (vn != nil && [vn isKindOfClass:[NSArray class]]) {
        [AppDelegate sharedInstance].listPricingVN = [[NSMutableArray alloc] initWithArray: vn];
    }
    
    [tbContent reloadData];
}

- (IBAction)btnViewNamPress:(UIButton *)sender {
    if (eTypePrice == eTypePriceVN) {
        return;
    }
    
    eTypePrice = eTypePriceVN;
    [btnVietnam setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnVietnam.backgroundColor = BLUE_COLOR;
    
    [btnQT setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnQT.backgroundColor = UIColor.clearColor;
    
    [tbContent reloadData];
}

- (IBAction)btnQTPress:(UIButton *)sender {
    if (eTypePrice == eTypePriceQT) {
        return;
    }
    
    eTypePrice = eTypePriceQT;
    [btnQT setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnQT.backgroundColor = BLUE_COLOR;
    
    [btnVietnam setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnVietnam.backgroundColor = UIColor.clearColor;
    
    [tbContent reloadData];
}

@end
