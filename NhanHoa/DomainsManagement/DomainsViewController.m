//
//  DomainsViewController.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainsViewController.h"
#import "DomainDetailsViewController.h"
#import "DomainInfoTbvCell.h"

typedef enum TypeForGetDomain{
    eGetAllDomain,
    eGetAboutExpireDomain,
}TypeForGetDomain;

@interface DomainsViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, WebServiceUtilsDelegate, UITextFieldDelegate>
{
    AppDelegate *appDelegate;
    UIFont *textFont;
    float padding;
    float hTextfield;
    float hCell;
    float hSection;
    float hTop;
    
    TypeForGetDomain type;
    BOOL searching;
    
    NSTimer *searchTimer;
    NSMutableArray *listSearch;
    UIColor *activeMenuColor;
}
@end

@implementation DomainsViewController
@synthesize scvContent, imgTop, viewHeader, icBack, lbHeader, icCart, lbCount, tfSearch, imgSearch, scvMenu, btnAll, btnAboutExpire, tbDomains, lbNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

- (void)setupUIForView
{
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hTextfield = 50.0;
    
    activeMenuColor = [UIColor colorWithRed:(228/255.0) green:(236/255.0)
                                       blue:(247/255.0) alpha:1.0];
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hTextfield = 42.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hTextfield = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hTextfield = 50.0;
    }
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.backgroundColor = UIColor.clearColor;
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    UIImage *bgTop = [UIImage imageNamed:@"bg_wallet_small"];
    hTop = SCREEN_WIDTH * bgTop.size.height / bgTop.size.width;
    [imgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTop);
    }];
    
    //  header view
    viewHeader.backgroundColor = UIColor.clearColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus);
        make.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.navigationController.navigationBar.frame.size.height);
    }];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
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
    lbCount.layer.cornerRadius =  appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo( appDelegate.sizeCartCount);
    }];
    
    //  search textfield
    tfSearch.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    tfSearch.layer.cornerRadius = 15.0;
    tfSearch.delegate = self;
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.textColor = GRAY_80;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgTop).offset(padding);
        make.right.equalTo(imgTop).offset(-padding);
        make.centerY.equalTo(imgTop.mas_bottom).offset(-padding/2);
        make.height.mas_equalTo(hTextfield);
    }];
    [AppUtils addBoxShadowForView:tfSearch color:GRAY_200 opacity:1.0 offsetX:1.5 offsetY:1.5];
    
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldChanged:)
       forControlEvents:UIControlEventEditingChanged];
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (padding + 18.0 + padding), hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    tfSearch.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfSearch.rightViewMode = UITextFieldViewModeAlways;
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(padding);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    //  scrollview menu
    scvMenu.contentSize = CGSizeMake(SCREEN_WIDTH-2*padding, hTextfield);
    scvMenu.backgroundColor = UIColor.clearColor;
    [scvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgTop).offset(padding);
        make.right.equalTo(imgTop).offset(-padding);
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
        make.height.mas_equalTo(hTextfield);
    }];
    
    btnAll.titleLabel.font = btnAboutExpire.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-3];
    btnAll.layer.cornerRadius = btnAboutExpire.layer.cornerRadius = 17.0;
    
    float sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"All"] withFont:btnAll.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    float hBTN = 33.0;
    [btnAll setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnAll.backgroundColor = activeMenuColor;
    [btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu);
        make.centerY.equalTo(scvMenu.mas_centerY);
        make.height.mas_equalTo(hBTN);
        make.width.mas_equalTo(sizeText);
    }];
    
    //  pending menu button
    sizeText = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"About to expire"] withFont:btnAboutExpire.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
    
    [btnAboutExpire setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnAboutExpire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnAll.mas_right).offset(padding/2);
        make.top.bottom.equalTo(btnAll);
        make.width.mas_equalTo(sizeText);
    }];
    
    //  table
    hCell = 130.0;
    hSection = 50.0;
    
    [tbDomains registerNib:[UINib nibWithNibName:@"DomainInfoTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainInfoTbvCell"];
    tbDomains.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbDomains.backgroundColor = UIColor.clearColor;
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    tbDomains.scrollEnabled = FALSE;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgTop).offset(padding/2);
        make.right.equalTo(imgTop).offset(-padding/2);
        make.top.equalTo(scvMenu.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    
    float hNoData = SCREEN_HEIGHT - (hTop + padding + hTextfield);
    lbNoData.textColor = GRAY_150;
    lbNoData.hidden = TRUE;
    lbNoData.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgTop).offset(padding/2);
        make.right.equalTo(imgTop).offset(-padding/2);
        make.top.equalTo(scvMenu.mas_bottom);
        make.height.mas_equalTo(hNoData);
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self updateCartCountForView];
    
    if (listSearch == nil) {
        listSearch = [[NSMutableArray alloc] init];
    }else{
        [listSearch removeAllObjects];
    }
    [self showContentWithCurrentLanguage];
    
    type = eGetAllDomain;
    [self getDomainsWasRegisteredWithType: eGetAllDomain];
    
    //  register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Domains management"];
    tfSearch.placeholder = [appDelegate.localization localizedStringForKey:@"Search domain..."];
    lbNoData.text = [appDelegate.localization localizedStringForKey:@"No data"];
    
    [btnAll setTitle:[appDelegate.localization localizedStringForKey:@"All"]
            forState:UIControlStateNormal];
    [btnAboutExpire setTitle:[appDelegate.localization localizedStringForKey:@"About to expire"]
                    forState:UIControlStateNormal];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}


- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnAllPress:(UIButton *)sender {
    if (type == eGetAllDomain) {
        return;
    }
    type = eGetAllDomain;
    tfSearch.text = @"";
    searching = FALSE;
    
    [tbDomains mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    btnAll.backgroundColor = activeMenuColor;
    [btnAll setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    btnAboutExpire.backgroundColor = UIColor.clearColor;
    [btnAboutExpire setTitleColor:GRAY_150 forState:UIControlStateNormal];
    
    if (appDelegate.listAllDomains != nil) {
        if (appDelegate.listAllDomains.count > 0) {
            lbNoData.hidden = TRUE;
            tbDomains.hidden = FALSE;
        }else{
            lbNoData.hidden = FALSE;
            tbDomains.hidden = TRUE;
        }
        [tbDomains reloadData];
        [self reUpdateLayoutAfterPreparedData];
    }else{
        [tbDomains reloadData];
        [self getDomainsWasRegisteredWithType: type];
    }
}

- (IBAction)btnAboutToExpirePress:(UIButton *)sender {
    if (type == eGetAboutExpireDomain) {
        return;
    }
    type = eGetAboutExpireDomain;
    
    tfSearch.text = @"";
    searching = FALSE;
    
    [tbDomains mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    btnAll.backgroundColor = UIColor.clearColor;
    [btnAll setTitleColor:GRAY_150 forState:UIControlStateNormal];
    
    btnAboutExpire.backgroundColor = activeMenuColor;
    [btnAboutExpire setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    if (appDelegate.listExpireDomains != nil) {
        if ([AppDelegate sharedInstance].listExpireDomains.count > 0) {
            lbNoData.hidden = TRUE;
            tbDomains.hidden = FALSE;
        }else{
            lbNoData.hidden = FALSE;
            tbDomains.hidden = TRUE;
        }
        [tbDomains reloadData];
        [self reUpdateLayoutAfterPreparedData];
    }else{
        [tbDomains reloadData];
        [self getDomainsWasRegisteredWithType: type];
    }
}

- (void)searchTextfieldChanged: (UITextField *)textfield {
    if (textfield.text.length > 0) {
        searching = TRUE;
        
        if (searchTimer) {
            [searchTimer invalidate];
            searchTimer = nil;
        }
        searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(searchOnRegisteredDomains:) userInfo:textfield.text repeats:FALSE];
        
    }else{
        searching = FALSE;
        lbNoData.hidden = TRUE;
        tbDomains.hidden = FALSE;
        [tbDomains reloadData];
        [self reUpdateLayoutAfterPreparedData];
    }
}

- (void)searchOnRegisteredDomains: (NSTimer *)timer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"domain CONTAINS[cd] %@", timer.userInfo];
    
    NSArray *filter;
    if (type == eGetAllDomain) {
        filter = [appDelegate.listAllDomains filteredArrayUsingPredicate: predicate];
    }else{
        filter = [appDelegate.listExpireDomains filteredArrayUsingPredicate: predicate];
    }
    
    if (filter.count > 0) {
        [listSearch removeAllObjects];
        [listSearch addObjectsFromArray: filter];
        
        [tbDomains reloadData];
        lbNoData.hidden = TRUE;
        tbDomains.hidden = FALSE;
    }else{
        [listSearch removeAllObjects];
        lbNoData.hidden = FALSE;
        tbDomains.hidden = TRUE;
    }
    
    [self reUpdateLayoutAfterPreparedData];
}

- (void)getDomainsWasRegisteredWithType: (int)type
{
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading..."] Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getDomainsWasRegisteredWithType: type];
}

#pragma mark - WebServiceUtils delegate

-(void)failedGetDomainsWasRegisteredWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Can not get domains list. Please try again!"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

- (void)getDomainsWasRegisteredSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    if (data != nil && [data isKindOfClass:[NSArray class]]) {
        [self displayDomainsListWithData: (NSArray *)data];
    }
}

- (void)displayDomainsListWithData: (NSArray *)domains {
    if (type == eGetAllDomain) {
        if (domains != nil && domains.count > 0) {
            appDelegate.listAllDomains = [[NSMutableArray alloc] initWithArray: domains];
            
            tbDomains.hidden = FALSE;
            lbNoData.hidden = TRUE;
        }else{
            appDelegate.listAllDomains = [[NSMutableArray alloc] init];
            
            tbDomains.hidden = TRUE;
            lbNoData.hidden = FALSE;
        }
        [tbDomains reloadData];
    }else{
        if (domains != nil && domains.count > 0) {
            appDelegate.listExpireDomains = [[NSMutableArray alloc] initWithArray: domains];
            tbDomains.hidden = FALSE;
            lbNoData.hidden = TRUE;
            
        }else{
            appDelegate.listExpireDomains = [[NSMutableArray alloc] init];
            
            tbDomains.hidden = TRUE;
            lbNoData.hidden = FALSE;
        }
        [tbDomains reloadData];
    }
    
    [self reUpdateLayoutAfterPreparedData];
}

- (void)reUpdateLayoutAfterPreparedData {
    float hTableView;
    if (searching) {
        hTableView = hSection + listSearch.count * hCell;
    }else{
        if (type == eGetAllDomain) {
            hTableView = hSection + appDelegate.listAllDomains.count * hCell;
        }else{
            hTableView = hSection + appDelegate.listExpireDomains.count * hCell;
        }
    }
    [tbDomains mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    
    float hContent = hTop + hTextfield/2 + padding + hTextfield + padding + hTableView;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

#pragma mark - UIScrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (type == eGetAllDomain) {
        if (searching) {
            return listSearch.count;
        }else{
            return appDelegate.listAllDomains.count;
        }
    }else{
        if (searching) {
            return listSearch.count;
        }else{
            return appDelegate.listExpireDomains.count;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DomainInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainInfoTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *domain;
    if (type == eGetAllDomain) {
        if (searching) {
            domain = [listSearch objectAtIndex: indexPath.row];
        }else{
            domain = [appDelegate.listAllDomains objectAtIndex: indexPath.row];
        }
        [cell showContentWithDomainInfo: domain];
    }else{
        if (searching) {
            domain = [listSearch objectAtIndex: indexPath.row];
        }else{
            domain = [appDelegate.listExpireDomains objectAtIndex: indexPath.row];
        }
        [cell showContentWithDomainInfo: domain];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *domain;
    if (searching) {
        domain = [listSearch objectAtIndex: indexPath.row];
    }else{
        if (type == eGetAllDomain) {
            domain = [appDelegate.listAllDomains objectAtIndex: indexPath.row];
        }else{
            domain = [appDelegate.listExpireDomains objectAtIndex: indexPath.row];
        }
    }
    
    NSString *ord_id = [domain objectForKey:@"ord_id"];
    NSString *cus_id = [domain objectForKey:@"cus_id"];

    if (![AppUtils isNullOrEmpty: ord_id] && ![AppUtils isNullOrEmpty: cus_id])
    {
        DomainDetailsViewController *domainDetailVC = [[DomainDetailsViewController alloc] initWithNibName:@"DomainDetailsViewController" bundle:nil];
        domainDetailVC.ordId = ord_id;
        domainDetailVC.cusId = cus_id;
        [self.navigationController pushViewController: domainDetailVC animated:YES];
    }else{
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"ord_id does not exists"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(padding/2, 0, SCREEN_WIDTH-padding, hSection)];
    
    UILabel *lbSection = [[UILabel alloc] init];
    lbSection.textColor = GRAY_50;
    lbSection.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [viewSection addSubview: lbSection];
    [lbSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewSection);
    }];
    
    if (searching) {
        lbSection.text = SFM(@"%@ %@ (%d)", [appDelegate.localization localizedStringForKey:@"All"], [[appDelegate.localization localizedStringForKey:@"domains"] lowercaseString], (int)listSearch.count);
    }else {
        if (type == eGetAllDomain) {
            lbSection.text = SFM(@"%@ %@ (%d)", [appDelegate.localization localizedStringForKey:@"All"], [[appDelegate.localization localizedStringForKey:@"domains"] lowercaseString], (int)appDelegate.listAllDomains.count);
        }else{
            lbSection.text = SFM(@"%@ %@ (%d)", [appDelegate.localization localizedStringForKey:@"All"], [[appDelegate.localization localizedStringForKey:@"domains"] lowercaseString], (int)appDelegate.listExpireDomains.count);
        }
    }
    
    return viewSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hSection;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

@end
