//
//  PricingViewController.m
//  NhanHoa
//
//  Created by OS on 11/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PricingViewController.h"
#import "PricingDomainsTbvCell.h"

@interface PricingViewController ()<WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *appDelegate;
    float padding;
    float hCell;
    UIFont *textFont;
    
    TypePricingDomains eTypePrice;
}

@end

@implementation PricingViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, viewMenu, btnVietNamDomains, btnInternationalDomains, lbMenuActive, lbDomain, lbSetupFee, lbRenewFee, lbTransferFee, tbDomains;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

- (void)setupUIForView
{
    self.view.backgroundColor = GRAY_240;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 10.0;
    hCell = 70.0;
    float hMenu = 60.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hCell = 60.0;
        hMenu = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hCell = 65.0;
        hMenu = 55.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hCell = 70.0;
        hMenu = 60.0;
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    //  header
    lbHeader.textColor = GRAY_50;
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo( appDelegate.sizeCartCount);
    }];
    
    //  menu view
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    btnVietNamDomains.titleLabel.font = btnInternationalDomains.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    [btnVietNamDomains setTitleColor:GRAY_50 forState:UIControlStateSelected];
    [btnVietNamDomains setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [btnVietNamDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu);
        make.left.equalTo(viewMenu).offset(padding);
        make.right.equalTo(viewMenu.mas_centerX);
        make.bottom.equalTo(viewMenu).offset(-5.0);
    }];
    
    [btnInternationalDomains setTitleColor:GRAY_50 forState:UIControlStateSelected];
    [btnInternationalDomains setTitleColor:GRAY_100 forState:UIControlStateNormal];
    [btnInternationalDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnVietNamDomains);
        make.left.equalTo(viewMenu.mas_centerX);
        make.right.equalTo(viewMenu).offset(-padding);
    }];
    
    lbMenuActive.backgroundColor = BLUE_COLOR;
    [lbMenuActive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewMenu);
        make.left.right.equalTo(btnVietNamDomains);
        make.height.mas_equalTo(5.0);
    }];
    
    [AppUtils addBoxShadowForView:viewMenu color:GRAY_200 opacity:1.0 offsetX:1.0 offsetY:1.0];
    
    //  header view
    lbDomain.font = lbSetupFee.font = lbRenewFee.font = lbTransferFee.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-4.0];
    lbDomain.layer.cornerRadius = lbSetupFee.layer.cornerRadius = lbRenewFee.layer.cornerRadius = lbTransferFee.layer.cornerRadius = 5.0;
    lbDomain.backgroundColor = lbSetupFee.backgroundColor = lbRenewFee.backgroundColor = lbTransferFee.backgroundColor = UIColor.whiteColor;
    lbDomain.clipsToBounds = lbSetupFee.clipsToBounds = lbRenewFee.clipsToBounds = lbTransferFee.clipsToBounds = TRUE;
    lbDomain.textColor = lbSetupFee.textColor = lbRenewFee.textColor = lbTransferFee.textColor = GRAY_80;
    
    lbDomain.text = @" Tên miền ";
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10.0);
        make.top.equalTo(viewMenu.mas_bottom).offset(2*padding);
        make.height.mas_equalTo(35.0);
    }];
    
    lbSetupFee.text = @" Phí khởi tạo ";
    [lbSetupFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbDomain.mas_right).offset(7.0);
        make.top.bottom.equalTo(lbDomain);
    }];
    
    lbRenewFee.text = @" Phí gia hạn ";
    [lbRenewFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSetupFee.mas_right).offset(7.0);
        make.top.bottom.equalTo(lbSetupFee);
    }];
    
    lbTransferFee.text = @" Chuyển về ";
    [lbTransferFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbRenewFee.mas_right).offset(7.0);
        make.top.bottom.equalTo(lbRenewFee);
    }];
    
    //  table
    [tbDomains registerNib:[UINib nibWithNibName:@"PricingDomainsTbvCell" bundle:nil] forCellReuseIdentifier:@"PricingDomainsTbvCell"];
    tbDomains.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbDomains.backgroundColor = UIColor.whiteColor;
    tbDomains.showsVerticalScrollIndicator = FALSE;
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    tbDomains.layer.cornerRadius = 12.0;
    float bottomY = 2*padding;
    if (appDelegate.safeAreaBottomPadding > 0) {
        bottomY = appDelegate.safeAreaBottomPadding;
    }
    
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom).offset(2*padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-bottomY);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self updateCartCountForView];
    
    self.navigationController.navigationBarHidden = TRUE;
    
    lbHeader.text = @"Bảng giá tên miền";
    
    btnVietNamDomains.selected = TRUE;
    btnInternationalDomains.selected = FALSE;
    
    eTypePrice = eVietNamPricing;
    if (appDelegate.listPricingVN == nil) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading..."] Interaction:NO];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] getDomainsPricingList];
    }else{
        [tbDomains reloadData];
    }
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}


- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

- (IBAction)btnVietNamDomainsPress:(UIButton *)sender {
    if (eTypePrice == eVietNamPricing) {
        return;
    }
    
    [lbMenuActive mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewMenu);
        make.left.right.equalTo(btnVietNamDomains);
        make.height.mas_equalTo(5.0);
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    eTypePrice = eVietNamPricing;
    btnVietNamDomains.selected = TRUE;
    btnInternationalDomains.selected = FALSE;
    
    [tbDomains reloadData];
}

- (IBAction)btnInternationalDomainsPress:(UIButton *)sender {
    if (eTypePrice == eInternationalPricing) {
        return;
    }
    
    [lbMenuActive mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewMenu);
        make.left.right.equalTo(btnInternationalDomains);
        make.height.mas_equalTo(5.0);
    }];
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }];
    
    eTypePrice = eInternationalPricing;
    btnVietNamDomains.selected = FALSE;
    btnInternationalDomains.selected = TRUE;
    
    [tbDomains reloadData];
}

#pragma mark - WebServiceUtils Delegate
-(void)failedGetPricingListWithError:(NSString *)error {
    [ProgressHUD dismiss];
    [self.view makeToast:@"Không thể tải bảng giá tên miền vào lúc này" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)getPricingListSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [self displayDomainsListWithData: data];
    }
}

- (void)displayDomainsListWithData: (NSDictionary *)data {
    NSArray *qt = [data objectForKey:@"qt"];
    if (qt != nil && [qt isKindOfClass:[NSArray class]]) {
        appDelegate.listPricingQT = [[NSMutableArray alloc] initWithArray: qt];
    }
    
    NSArray *vn = [data objectForKey:@"vn"];
    if (vn != nil && [vn isKindOfClass:[NSArray class]]) {
        appDelegate.listPricingVN = [[NSMutableArray alloc] initWithArray: vn];
    }
    
    [tbDomains reloadData];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (eTypePrice == eVietNamPricing) {
        return appDelegate.listPricingVN.count;
    }else{
        return appDelegate.listPricingQT.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PricingDomainsTbvCell *cell = (PricingDomainsTbvCell *)[tableView dequeueReusableCellWithIdentifier:@"PricingDomainsTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info;
    if (eTypePrice == eVietNamPricing) {
        info = [appDelegate.listPricingVN objectAtIndex: indexPath.row];
        if (indexPath.row == appDelegate.listPricingVN.count - 1) {
            cell.lbSepa.hidden = TRUE;
        }else{
            cell.lbSepa.hidden = FALSE;
        }
    }else{
        info = [appDelegate.listPricingQT objectAtIndex: indexPath.row];
        if (indexPath.row == appDelegate.listPricingQT.count - 1) {
            cell.lbSepa.hidden = TRUE;
        }else{
            cell.lbSepa.hidden = FALSE;
        }
    }
    [cell showPricingContentWithInfo: info];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

@end
