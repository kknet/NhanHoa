//
//  HostingViewController.m
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingViewController.h"
#import "HostingTbvCell.h"
#import "ChooseHostingPackgeView.h"
#import "CheckDomainForRegisterHostingView.h"

@interface HostingViewController ()<UITableViewDelegate, UITableViewDataSource, ChooseHostingPackgeViewDelegate, CheckDomainForRegisterHostingViewDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    
    ChooseHostingPackgeView *choosePackageView;
    CheckDomainForRegisterHostingView *checkDomainView;
    float hWindowsHostingCell;
}
@end

@implementation HostingViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvMenu, btnLinuxHosting, btnWindowsHosting, btnWordpressHosting, tbContent, lbMenu;
@synthesize curMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Register hosting"];
    
    [self updateMenuStateWithCurrentMenu: curMenu];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hMenu = 60.0;
    
    padding = 15.0;
    float hBTN = 45.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hMenu = 50.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hMenu = 55.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hMenu = 60.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    hWindowsHostingCell = padding + 40.0 + padding + 35.0*9 + padding + 1.0 + padding + hBTN + padding + 15.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    //  header
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
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    //  scrollview menu
    [scvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    float sizeContent = 0;
    
    btnWindowsHosting.titleLabel.font = btnLinuxHosting.titleLabel.font = btnWordpressHosting.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    float sizeText = [AppUtils getSizeWithText:@"Windows Hosting" withFont:btnWordpressHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnWindowsHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnWindowsHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    btnWindowsHosting.selected = TRUE;
    [btnWindowsHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu).offset(padding);
        make.top.equalTo(scvMenu);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hMenu-5.0);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Linux Hosting" withFont:btnLinuxHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnLinuxHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnLinuxHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnLinuxHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnWindowsHosting.mas_right).offset(padding);
        make.top.bottom.equalTo(btnWindowsHosting);
        make.width.mas_equalTo(sizeText);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Wordpress Hosting" withFont:btnWordpressHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText + padding;
    
    [btnWordpressHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnWordpressHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnWordpressHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnLinuxHosting.mas_right).offset(padding);
        make.top.bottom.equalTo(btnLinuxHosting);
        make.width.mas_equalTo(sizeText);
    }];
    
    lbMenu.backgroundColor = BLUE_COLOR;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWindowsHosting.mas_bottom);
        make.left.right.equalTo(btnWindowsHosting);
        make.height.mas_equalTo(5.0);
    }];
    scvMenu.contentSize = CGSizeMake(sizeContent, hMenu);
    scvMenu.showsHorizontalScrollIndicator = FALSE;
    
    [AppUtils addBoxShadowForView:scvMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  table content
    
    tbContent.showsVerticalScrollIndicator = FALSE;
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"HostingTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (appDelegate.safeAreaBottomPadding > 0) {
        [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scvMenu.mas_bottom).offset(padding);
            make.left.equalTo(self.view).offset(padding);
            make.right.equalTo(self.view).offset(-padding);
            make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
        }];
    }else{
        [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scvMenu.mas_bottom).offset(padding);
            make.left.equalTo(self.view).offset(padding);
            make.right.equalTo(self.view).offset(-padding);
            make.bottom.equalTo(self.view).offset(-padding);
        }];
    }
}


- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    
}

- (IBAction)btnWindowsHostingPress:(UIButton *)sender
{
    curMenu = eMenuWindowsHosting;
    [self updateMenuStateWithCurrentMenu: curMenu];
}

- (IBAction)btnLinuxHostingPress:(UIButton *)sender
{
    curMenu = eMenuLinuxHosting;
    [self updateMenuStateWithCurrentMenu: curMenu];
}

- (IBAction)btnWordpressHostingPress:(UIButton *)sender
{
    curMenu = eMenuWordpressHosting;
    [self updateMenuStateWithCurrentMenu: curMenu];
}

- (void)updateMenuStateWithCurrentMenu: (HostingMenuType)menu {
    if (menu == eMenuWindowsHosting) {
        btnWindowsHosting.selected = TRUE;
        btnLinuxHosting.selected = btnWordpressHosting.selected = FALSE;
        
        [lbMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnWindowsHosting.mas_bottom);
            make.left.right.equalTo(btnWindowsHosting);
            make.height.mas_equalTo(5.0);
        }];
    }else if (menu == eMenuLinuxHosting) {
        btnLinuxHosting.selected = TRUE;
        btnWindowsHosting.selected = btnWordpressHosting.selected = FALSE;
        
        [lbMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnLinuxHosting.mas_bottom);
            make.left.right.equalTo(btnLinuxHosting);
            make.height.mas_equalTo(5.0);
        }];
        
    }else{
        btnWordpressHosting.selected = TRUE;
        btnLinuxHosting.selected = btnWindowsHosting.selected = FALSE;
        
        [lbMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnWordpressHosting.mas_bottom);
            make.left.right.equalTo(btnWordpressHosting);
            make.height.mas_equalTo(5.0);
        }];
    }
    
    if (curMenu == eMenuWindowsHosting) {
        scvMenu.contentOffset = CGPointMake(0, 0);
        
    }else if (curMenu == eMenuWordpressHosting){
        scvMenu.contentOffset = CGPointMake(scvMenu.contentSize.width - SCREEN_WIDTH, 0);
        
    }
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HostingTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"Sinh Viên";
        cell.lbPrice.text = @"Chỉ với 54.000 đ/tháng";
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"Cá Nhân";
        cell.lbPrice.text = @"Chỉ với 78.000 đ/tháng";
        
    }else if (indexPath.row == 2){
        cell.lbTitle.text = @"Cá Nhân +";
        cell.lbPrice.text = @"Chỉ với 90.000 đ/tháng";
        
    }else if (indexPath.row == 3){
        cell.lbTitle.text = @"Doanh Nghiệp";
        cell.lbPrice.text = @"Chỉ với 120.000 đ/tháng";
        
    }else if (indexPath.row == 4){
        cell.lbTitle.text = @"Thương Mại Điện Tử";
        cell.lbPrice.text = @"Chỉ với 169.000 đ/tháng";
        
    }else if (indexPath.row == 5){
        cell.lbTitle.text = @"Chuyên Nghiệp";
        cell.lbPrice.text = @"Chỉ với 257.000 đ/tháng";
    }
    
    cell.btnBuy.tag = indexPath.row;
    [cell.btnBuy addTarget:self
                    action:@selector(onBuyButtonPress:)
          forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hWindowsHostingCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1;
}

- (void)onBuyButtonPress: (UIButton *)sender {
    if (choosePackageView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"ChooseHostingPackgeView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[ChooseHostingPackgeView class]]) {
                choosePackageView = (ChooseHostingPackgeView *) currentObject;
                break;
            }
        }
        choosePackageView.delegate = self;
        [appDelegate.window addSubview: choosePackageView];
    }
    [choosePackageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(appDelegate.window);
    }];
    [choosePackageView setupUIForViewWithInfo:[self getListTimeInfoForCurrentPackage]];
    
    if (sender.tag == eWindowsHostingStudent) {
        choosePackageView.lbDesc.text = @"Gói Sinh viên";
        
    }else if (sender.tag == eWindowsHostingPersonal){
        choosePackageView.lbDesc.text = @"Gói Cá nhân";
        
    }else if (sender.tag == eWindowsHostingPersonalPlus){
        choosePackageView.lbDesc.text = @"Gói Cá nhân+";
        
    }else if (sender.tag == eWindowsHostingBusiness){
        choosePackageView.lbDesc.text = @"Gói Doanh nghiệp";
        
    }else if (sender.tag == eWindowsHostingECommerce){
        choosePackageView.lbDesc.text = @"Gói Thương mại điện tử";
        
    }else if (sender.tag == eWindowsHostingProfessional){
        choosePackageView.lbDesc.text = @"Gói Chuyên nghiệp";
    }
    
    [choosePackageView performSelector:@selector(showContentInfoView) withObject:nil afterDelay:0.05];
}

- (NSArray *)getListTimeInfoForCurrentPackage {
    NSMutableArray *times = [[NSMutableArray alloc] init];
    
    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:@"6", @"month", @"36000", @"price", @"432000", @"total", nil];
    [times addObject: info];
    
    NSDictionary *info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"12", @"month", @"32400", @"price", @"777000", @"total", nil];
    [times addObject: info1];
    
    NSDictionary *info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"36", @"month", @"30600", @"price", @"1101600", @"total", nil];
    [times addObject: info2];
    
    NSDictionary *info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"48", @"month", @"28800", @"price", @"1382400", @"total", nil];
    [times addObject: info3];
    
    NSDictionary *info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"60", @"month", @"27000", @"price", @"1620000", @"total", nil];
    [times addObject: info4];
    
    return times;
}

#pragma mark - Choose Package Hosting delegate
-(void)closeChooseHostingPackageView {
    if (choosePackageView) {
        [choosePackageView removeFromSuperview];
        choosePackageView = nil;
    }
}

-(void)confirmAfterChooseHostingPackageView {
    if (choosePackageView) {
        [choosePackageView removeFromSuperview];
        choosePackageView = nil;
    }
    //  show check domain view after choose hosting package
    if (checkDomainView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"CheckDomainForRegisterHostingView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[CheckDomainForRegisterHostingView class]]) {
                checkDomainView = (CheckDomainForRegisterHostingView *) currentObject;
                break;
            }
        }
        checkDomainView.delegate = self;
        [appDelegate.window addSubview: checkDomainView];
    }
    [checkDomainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(appDelegate.window);
    }];
    [checkDomainView setupUIForView];
    [checkDomainView performSelector:@selector(showContentInfoView) withObject:nil afterDelay:0.05];
}

#pragma mark - CheckDomainViewDelegate
-(void)closeCheckDomainView {
    if (checkDomainView) {
        [checkDomainView removeFromSuperview];
        checkDomainView = nil;
    }
}

-(void)confirmAfterCheckDomainView {
    if (checkDomainView) {
        [checkDomainView removeFromSuperview];
        checkDomainView = nil;
    }
}

@end
