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
#import "ExpireDomainObject.h"

typedef enum TypeSelectDomain{
    eAllDomain,
    eExpireDomain,
}TypeSelectDomain;

@interface RenewedDomainViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listAll;
    NSMutableArray *listExpire;
    TypeSelectDomain type;
}

@end

@implementation RenewedDomainViewController
@synthesize viewMenu, btnAllDomain, btnExpireDomain, tbDomain, btnPriceList;
@synthesize padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    [self createDemoDatas];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    type = eAllDomain;
    self.title = @"Tên miền đã đăng ký";
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (tbDomain.frame.size.height >= tbDomain.contentSize.height) {
        tbDomain.scrollEnabled = FALSE;
    }else{
        tbDomain.scrollEnabled = TRUE;
    }
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
    [tbDomain reloadData];
    
    [btnAllDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = BLUE_COLOR;
    
    [btnExpireDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = UIColor.clearColor;
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
    [tbDomain reloadData];
    
    [btnExpireDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnExpireDomain.backgroundColor = BLUE_COLOR;
    
    [btnAllDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnAllDomain.backgroundColor = UIColor.clearColor;
}

- (IBAction)btnPriceListPress:(UIButton *)sender {
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
    
    [btnAllDomain setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomain.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnAllDomain.backgroundColor = BLUE_COLOR;
    btnAllDomain.layer.cornerRadius = hMenu/2;
    [btnAllDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.viewMenu);
        make.right.equalTo(self.viewMenu.mas_centerX);
    }];
    
    [btnExpireDomain setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomain.titleLabel.font = btnAllDomain.titleLabel.font;
    btnExpireDomain.backgroundColor = UIColor.clearColor;
    btnExpireDomain.layer.cornerRadius = hMenu/2;
    [btnExpireDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewMenu.mas_centerX);
        make.right.top.bottom.equalTo(self.viewMenu);
    }];
    
    NSAttributedString *titleAttrStr = [AppUtils generateTextWithContent:@"Bảng giá duy trì tên miền 2019" font:[UIFont fontWithName:RobotoMedium size:16.0] color:[UIColor colorWithRed:(223/255.0) green:(126/255.0) blue:(35/255.0) alpha:1.0] image:[UIImage imageNamed:@"list_price"] size:20.0 imageFirst:TRUE];
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
}

- (void)createDemoDatas {
    listAll = [[NSMutableArray alloc] init];
    
    ExpireDomainObject *domain1 = [[ExpireDomainObject alloc] init];
    domain1.domainName = @"nhim.design";
    domain1.registerDate = @"20/04/2018";
    domain1.state = @"Đã kích hoạt";
    [listAll addObject: domain1];
    
    ExpireDomainObject *domain2 = [[ExpireDomainObject alloc] init];
    domain2.domainName = @"nhim.vn";
    domain2.registerDate = @"20/06/2014";
    domain2.state = @"Hết hạn";
    [listAll addObject: domain2];
    
    ExpireDomainObject *domain3 = [[ExpireDomainObject alloc] init];
    domain3.domainName = @"nhim.com.vn";
    domain3.registerDate = @"19/02/2017";
    domain3.state = @"Đã kích hoạt";
    [listAll addObject: domain3];
    
    ExpireDomainObject *domain4 = [[ExpireDomainObject alloc] init];
    domain4.domainName = @"nongquadi.com";
    domain4.registerDate = @"08/04/2015";
    domain4.state = @"Sắp hết hạn";
    [listAll addObject: domain4];
    
    ExpireDomainObject *domain5 = [[ExpireDomainObject alloc] init];
    domain5.domainName = @"lanhquadi.com.vn";
    domain5.registerDate = @"18/04/2017";
    domain5.state = @"Đã kích hoạt";
    [listAll addObject: domain5];
    
    ExpireDomainObject *domain6 = [[ExpireDomainObject alloc] init];
    domain6.domainName = @"atadi.vn";
    domain6.registerDate = @"28/03/2017";
    domain6.state = @"Sắp hết hạn";
    [listAll addObject: domain6];
    
    ExpireDomainObject *domain7 = [[ExpireDomainObject alloc] init];
    domain7.domainName = @"caphesuadasaigon.com";
    domain7.registerDate = @"31/07/2015";
    domain7.state = @"Sắp hết hạn";
    [listAll addObject: domain7];
    
    ExpireDomainObject *domain8 = [[ExpireDomainObject alloc] init];
    domain8.domainName = @"travelcheap.com.vn";
    domain8.registerDate = @"28/04/2016";
    domain8.state = @"Đã kích hoạt";
    [listAll addObject: domain8];
    
    
    listExpire = [[NSMutableArray alloc] init];
    
    ExpireDomainObject *domain9 = [[ExpireDomainObject alloc] init];
    domain9.domainName = @"nongquadi.com";
    domain9.registerDate = @"08/04/2015";
    domain9.state = @"Sắp hết hạn";
    [listExpire addObject: domain9];
    
    ExpireDomainObject *domain10 = [[ExpireDomainObject alloc] init];
    domain10.domainName = @"atadi.vn";
    domain10.registerDate = @"28/03/2017";
    domain10.state = @"Sắp hết hạn";
    [listExpire addObject: domain10];
    
    ExpireDomainObject *domain11 = [[ExpireDomainObject alloc] init];
    domain11.domainName = @"caphesuadasaigon.com";
    domain11.registerDate = @"31/07/2015";
    domain11.state = @"Sắp hết hạn";
    [listExpire addObject: domain11];
    
    ExpireDomainObject *domain12 = [[ExpireDomainObject alloc] init];
    domain12.domainName = @"travelcheap.com.vn";
    domain12.registerDate = @"28/04/2016";
    domain12.state = @"Sắp hết hạn";
    [listExpire addObject: domain12];
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
    ExpireDomainObject *domain;
    if (type == eAllDomain) {
        domain = [listAll objectAtIndex: indexPath.row];
    }else{
        domain = [listExpire objectAtIndex: indexPath.row];
    }
    cell.lbName.text = domain.domainName;
    cell.lbNum.text = [NSString stringWithFormat:@"%d", (int)indexPath.row + 1];
    cell.lbDate.text = [NSString stringWithFormat:@"Ngày đăng ký: %@", domain.registerDate];
    cell.lbState.text = domain.state;
    
    if ([domain.state isEqualToString:@"Sắp hết hạn"]) {
        cell.lbState.textColor = NEW_PRICE_COLOR;
        
    }else if ([domain.state isEqualToString:@"Hết hạn"]) {
        cell.lbState.textColor = UIColor.grayColor;
        
    }else{
        cell.lbState.textColor = [UIColor colorWithRed:(28/255.0) green:(289/255.0) blue:(91/255.0) alpha:1.0];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ExpireDomainObject *domain;
    if (type == eAllDomain) {
        domain = [listAll objectAtIndex: indexPath.row];
    }else{
        domain = [listExpire objectAtIndex: indexPath.row];
    }
    
    RenewDomainDetailViewController *domainDetailVC = [[RenewDomainDetailViewController alloc] initWithNibName:@"RenewDomainDetailViewController" bundle:nil];
    domainDetailVC.domainObj = domain;
    [self.navigationController pushViewController: domainDetailVC animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}



@end
