//
//  EmailsViewController.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "EmailsViewController.h"
#import "EmailHostingTbvCell.h"
#import "ChooseEmailPackageView.h"
#import "CheckDomainForRegisterHostingView.h"

@interface EmailsViewController ()<UITableViewDelegate, UITableViewDataSource, ChooseEmailPackageViewDelegate, CheckDomainForRegisterHostingViewDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    float hEmailHostingCell;
    
    ChooseEmailPackageView *chooseEmailPackageView;
    CheckDomainForRegisterHostingView *checkDomainView;
}
@end

@implementation EmailsViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvMenu, btnHosting, btnGoogle, btnMicrosoft, btnServer, tbContent, lbMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

- (IBAction)btnHostingPress:(UIButton *)sender {
}

- (IBAction)btnGooglePress:(UIButton *)sender {
}

- (IBAction)btnMicrosoftPress:(UIButton *)sender {
}

- (IBAction)btnServerPress:(UIButton *)sender {
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hMenu = 60.0;
    float hBTN = 45.0;
    padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        hMenu = 50.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        hMenu = 55.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 53.0;
        hMenu = 60.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    hEmailHostingCell = padding + 40.0 + padding + 35.0*4 + padding + 1.0 + padding + hBTN + padding + 15.0;
    
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
    
    btnHosting.titleLabel.font = btnGoogle.titleLabel.font = btnMicrosoft.titleLabel.font = btnServer.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    float sizeText = [AppUtils getSizeWithText:@"E.Hosting" withFont:btnHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    btnHosting.selected = TRUE;
    [btnHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu).offset(padding);
        make.top.equalTo(scvMenu);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hMenu-5.0);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"E.Google" withFont:btnGoogle.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnGoogle setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnGoogle setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnGoogle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnHosting.mas_right).offset(padding);
        make.top.bottom.equalTo(btnHosting);
        make.width.mas_equalTo(sizeText);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"E.Microsoft" withFont:btnMicrosoft.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText + padding;
    
    [btnMicrosoft setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnMicrosoft setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnMicrosoft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnGoogle.mas_right).offset(padding);
        make.top.bottom.equalTo(btnGoogle);
        make.width.mas_equalTo(sizeText);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"E.Server riêng" withFont:btnServer.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText + padding;
    
    [btnServer setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnServer setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnMicrosoft.mas_right).offset(padding);
        make.top.bottom.equalTo(btnMicrosoft);
        make.width.mas_equalTo(sizeText);
    }];
    
    lbMenu.backgroundColor = BLUE_COLOR;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnHosting.mas_bottom);
        make.left.right.equalTo(btnHosting);
        make.height.mas_equalTo(5.0);
    }];
    scvMenu.contentSize = CGSizeMake(sizeContent, hMenu);
    scvMenu.showsHorizontalScrollIndicator = FALSE;
    
    [AppUtils addBoxShadowForView:scvMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  table content
    
    tbContent.showsVerticalScrollIndicator = FALSE;
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"EmailHostingTbvCell" bundle:nil] forCellReuseIdentifier:@"EmailHostingTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvMenu.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EmailHostingTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmailHostingTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"CLASSIC 1";
        cell.lbPrice.text = @"50.000 đ/tháng";
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"CLASSIC 2";
        cell.lbPrice.text = @"100.000 đ/tháng";
        
    }else if (indexPath.row == 2){
        cell.lbTitle.text = @"CLASSIC 3";
        cell.lbPrice.text = @"145.000 đ/tháng";
        
    }else if (indexPath.row == 3){
        cell.lbTitle.text = @"BASIC 1";
        cell.lbPrice.text = @"180.000 đ/tháng";
        
    }else if (indexPath.row == 4){
        cell.lbTitle.text = @"BASIC 2";
        cell.lbPrice.text = @"300.000 đ/tháng";
        
    }else if (indexPath.row == 5){
        cell.lbTitle.text = @"BASIC 3";
        cell.lbPrice.text = @"450.000 đ/tháng";
    }
    
    cell.btnBuy.tag = indexPath.row;
    [cell.btnBuy addTarget:self
                    action:@selector(onBuyButtonPress:)
          forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hEmailHostingCell;
}

- (void)onBuyButtonPress: (UIButton *)sender {
    if (chooseEmailPackageView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"ChooseEmailPackageView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[ChooseEmailPackageView class]]) {
                chooseEmailPackageView = (ChooseEmailPackageView *) currentObject;
                break;
            }
        }
        chooseEmailPackageView.delegate = self;
        [appDelegate.window addSubview: chooseEmailPackageView];
    }
    [chooseEmailPackageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(appDelegate.window);
    }];
    [chooseEmailPackageView setupUIForViewWithInfo:[self getListTimeInfoForCurrentPackage]];
    
    if (sender.tag == 0) {
        chooseEmailPackageView.lbDesc.text = @"CLASSIC 1";
        
    }else if (sender.tag == 1){
        chooseEmailPackageView.lbTitle.text = @"CLASSIC 2";
        
    }else if (sender.tag == 2){
        chooseEmailPackageView.lbTitle.text = @"CLASSIC 3";
        
    }else if (sender.tag == 3){
        chooseEmailPackageView.lbTitle.text = @"BASIC 1";
        
    }else if (sender.tag == 4){
        chooseEmailPackageView.lbTitle.text = @"BASIC 2";
        
    }else if (sender.tag == 5){
        chooseEmailPackageView.lbTitle.text = @"BASIC 3";
    }
    
    [chooseEmailPackageView performSelector:@selector(showContentInfoView) withObject:nil afterDelay:0.05];
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

#pragma mark - ChooseEmailPackageViewDelegate
-(void)closeChooseEmailPackageView {
    if (chooseEmailPackageView) {
        [chooseEmailPackageView removeFromSuperview];
        chooseEmailPackageView = nil;
    }
}

-(void)confirmAfterChooseEmailPackageView {
    if (chooseEmailPackageView) {
        [chooseEmailPackageView removeFromSuperview];
        chooseEmailPackageView = nil;
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
