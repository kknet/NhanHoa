//
//  SearchResultViewController.m
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DomainAvailableTbvCell.h"
#import "DomainUnavailableTbvCell.h"
#import "DomainNotSupportTbvCell.h"
#import "CartModel.h"

@interface SearchResultViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>{
    AppDelegate *appDelegate;
    float padding;
    float hBTN;
    UIFont *textFont;
    UIFont *fontForGetHeight;
    float hCell;
    
    NSMutableArray *listResults;
    float leftMaxSize;
    
    float hUnavailable;
}

@end

@implementation SearchResultViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, tbResult, viewFooter, btnContinue, lbSepa;
@synthesize strSearch, listSearch;

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
    
    //  prepare result array
    if (listResults == nil) {
        listResults = [[NSMutableArray alloc] init];
    }
    [listResults removeAllObjects];
    
    [self updateCartCountForView];
    [self checkToEnableContinueButton];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Checking..."] Interaction:FALSE];
    
    [self checkWhoIsForListDomains];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView)
                                                 name:@"afterAddOrderSuccessfully" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)popToRootView {
    [self.navigationController popToRootViewControllerAnimated: TRUE];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Search results"];
    [btnContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"]
                 forState:UIControlStateNormal];
}

- (void)checkToEnableContinueButton {
    if ([[CartModel getInstance] countItemInCart] > 0) {
        btnContinue.enabled = TRUE;
        btnContinue.backgroundColor = BLUE_COLOR;
    }else{
        btnContinue.enabled = FALSE;
        btnContinue.backgroundColor = OLD_PRICE_COLOR;
    }
}

- (void)setupUIForView
{
    self.view.backgroundColor = GRAY_235;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 53.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    fontForGetHeight = [UIFont fontWithName:RobotoRegular size:16.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:14.0];
        hBTN = 45.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:15.0];
        hBTN = 50.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:16.0];
        hBTN = 53.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    leftMaxSize = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Registration date"] withFont:fontForGetHeight andMaxWidth:SCREEN_WIDTH].width + 10.0;
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_80;
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
    
    //  footer view
    float hFooter;
    if (appDelegate.safeAreaBottomPadding > 0) {
        hFooter = padding + hBTN + appDelegate.safeAreaBottomPadding;
    }else{
        hFooter = padding + hBTN + padding;
    }
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hFooter);
    }];
    
    lbSepa.backgroundColor = GRAY_220;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewFooter);
        make.height.mas_equalTo(2.0);
    }];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.cornerRadius = 8.0;
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    btnContinue.clipsToBounds = TRUE;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewFooter).offset(padding);
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  tableview result
    [tbResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(viewFooter.mas_top);
    }];
    
    //  table
    UIImage *bg = [UIImage imageNamed:@"domain-search-availabel"];
    float hBG = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    
    hCell = hBG + 70.0 + 15.0;
    
    bg = [UIImage imageNamed:@"domain-search-unavailable"];
    hUnavailable = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    
    tbResult.showsVerticalScrollIndicator = FALSE;
    tbResult.clipsToBounds = TRUE;
    tbResult.layer.cornerRadius = 12.0;
    [tbResult registerNib:[UINib nibWithNibName:@"DomainAvailableTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainAvailableTbvCell"];
    [tbResult registerNib:[UINib nibWithNibName:@"DomainUnavailableTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainUnavailableTbvCell"];
    [tbResult registerNib:[UINib nibWithNibName:@"DomainNotSupportTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainNotSupportTbvCell"];
    tbResult.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbResult.backgroundColor = UIColor.clearColor;
    tbResult.delegate = self;
    tbResult.dataSource = self;
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

- (void)checkWhoIsForListDomains {
    if (listSearch.count > 0) {
        NSString *domain = [listSearch firstObject];
        [listSearch removeObjectAtIndex: 0];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] searchDomainWithName:domain type:1];
    }else{
        [ProgressHUD dismiss];
        [tbResult reloadData];
    }
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listResults.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //  check available domain
    NSDictionary *info = [listResults objectAtIndex: indexPath.row];
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        DomainAvailableTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainAvailableTbvCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell displayContentWithInfo: info];
        
        cell.btnBuy.tag = (int)indexPath.row;
        [cell.btnBuy addTarget:self
                        action:@selector(clickOnBuyDomain:)
              forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    }else if (available != nil && [available isKindOfClass:[NSString class]] && [available isEqualToString:@"not support"]){
        DomainNotSupportTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainNotSupportTbvCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *domain = [info objectForKey:@"domain"];
        cell.lbDomain.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
        
        cell.lbContent.text = SFM(@"%@\n%@!", [appDelegate.localization localizedStringForKey:@"Sorry"], [appDelegate.localization localizedStringForKey:@"This domain name is not supported yet"]);
        
        return cell;

    }else{
        DomainUnavailableTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainUnavailableTbvCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell displayContentWithInfo: info];
        
        return cell;
        
        
//        cell.btnChoose.enabled = TRUE;
//        [cell.btnChoose setTitle:text_view_info forState:UIControlStateNormal];
//        cell.btnChoose.backgroundColor = ORANGE_COLOR;
//        cell.lbPrice.text = @"";
//
//
//        [cell showPriceForDomainCell: FALSE];
//
//        cell.btnWarning.hidden = TRUE;
//
//        cell.btnChoose.tag = indexPath.row;
//
//        [cell.btnChoose removeTarget:self
//                              action:@selector(chooseThisDomain:)
//                    forControlEvents:UIControlEventTouchUpInside];
//
//        [cell.btnChoose addTarget:self
//                           action:@selector(viewInfoOfDomain:)
//                 forControlEvents:UIControlEventTouchUpInside];
        
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = [listResults objectAtIndex: indexPath.row];
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        return hCell;
        
    }else if (available != nil && [available isKindOfClass:[NSString class]] && [available isEqualToString:@"not support"]){
        return (hUnavailable + 15.0);
    }else{
        return [self getHeightForRowWithInfo: info];
    }
}

- (void)clickOnBuyDomain:(UIButton *)sender {
    int index = (int)sender.tag;
    if (listResults.count > index) {
        NSDictionary *info = [listResults objectAtIndex: index];
        BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: info];
        if (exists) {
            [[CartModel getInstance] removeDomainFromCart: info];
            [sender setTitle:[appDelegate.localization localizedStringForKey:@"Select"] forState:UIControlStateNormal];
            sender.backgroundColor = BLUE_COLOR;
            
        }else{
            [[CartModel getInstance] addDomainToCart: info];
            [sender setTitle:[appDelegate.localization localizedStringForKey:@"Unselect"] forState:UIControlStateNormal];
            sender.backgroundColor = ORANGE_COLOR;
        }
        
        float widthBTN = [AppUtils getSizeWithText:sender.currentTitle withFont:sender.titleLabel.font].width + 20.0;
        [sender mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(widthBTN);
        }];
        
        [self updateCartCountForView];
        [self checkToEnableContinueButton];
    }
}

- (float)getHeightForRowWithInfo: (NSDictionary *)info {
    float hItem = 45.0;
    
    float hRow = hUnavailable + hItem*3;    //  this is height for domain rows, registration row and expiration date

    float maxSzie = SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize);
    
    //  height for owner
    NSString *owner = [info objectForKey:@"owner"];
    float height = [AppUtils getSizeWithText:owner withFont:fontForGetHeight andMaxWidth:maxSzie].height + 5.0;
    if (height < hItem) {
        height = hItem;
    }
    hRow += height;
    
    //  height for status
    NSString *status = [info objectForKey:@"status"];
    status = [status stringByReplacingOccurrencesOfString:@" " withString:@""];
    status = [status stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    
    height = [AppUtils getSizeWithText:status withFont:fontForGetHeight andMaxWidth:maxSzie].height + 5.0;
    if (height < hItem) {
        height = hItem;
    }
    hRow += height;
    
    //  height for registrar
    NSString *registrar = [info objectForKey:@"registrar"];
    height = [AppUtils getSizeWithText:registrar withFont:fontForGetHeight andMaxWidth:maxSzie].height + 5.0;
    if (height < hItem) {
        height = hItem;
    }
    hRow += height;
    
    //  height for dns
    NSString *dns = [info objectForKey:@"dns"];
    dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
    dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    height = [AppUtils getSizeWithText:dns withFont:fontForGetHeight andMaxWidth:maxSzie].height + 5.0;
    if (height < hItem) {
        height = hItem;
    }
    hRow += height;
    
    //  height for dns
    NSString *dnssec = [info objectForKey:@"dnssec"];
    dnssec = [dnssec stringByReplacingOccurrencesOfString:@" " withString:@""];
    dnssec = [dnssec stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    height = [AppUtils getSizeWithText:dnssec withFont:fontForGetHeight andMaxWidth:maxSzie].height + 5.0;
    if (height < hItem) {
        height = hItem;
    }
    hRow += height;
    
    hRow += 15.0;   //  15.0 is padding bottom of cell
    
    return hRow;
}


#pragma mark - WebServicesUtilDelegate
- (void)failedToSearchDomainWithError:(NSString *)error {
    if ([error isKindOfClass:[NSDictionary class]]) {
        [listResults addObject: error];
    }
    [self checkWhoIsForListDomains];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [listResults addObject: data];
    }
    [self checkWhoIsForListDomains];
}

@end
