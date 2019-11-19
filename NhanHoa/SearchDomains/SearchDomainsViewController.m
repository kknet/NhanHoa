//
//  SearchDomainsViewController.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchDomainsViewController.h"
#import "SuggestDomainCell.h"
#import "HomeSliderClvCell.h"
#import "SearchResultsViewController.h"
#import "DomainsViewController.h"
#import "SearchMultiDomainsViewController.h"
#import "PricingViewController.h"

@interface SearchDomainsViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate>
{
    AppDelegate *appDelegate;
    NSMutableArray *listData;
    
    float padding;
    float hCell;
    float hSection;
    float hTextfield;
    float sizeBlock;
    float hSliderView;
    float hPostView;
    float hTopView;
    
    NSMutableArray *listBanners;
    UIFont *textFont;
}
@end

@implementation SearchDomainsViewController
@synthesize viewHeader, icClose, lbHeader, icCart, bgHeader, lbCount;
@synthesize scvContent, viewTop, imgBGBottom, tfSearch, lbWWW, icClear, viewCheckMultiDomains, imgCheckMultiDomains, lbCheckMultiDomains, viewRenewDomain, imgRenewDomain, lbRenewDomain, viewTransferDomains, imgTransferDomain, lbTransferDomain, clvSlider, clvPosts, tbDomainsType, imgSearch;

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
    [self updateCartCountForView];
    
    [self displayBannerPhotosIfNeed];
    [self createListDomainPriceIfNeed];
    [self reUpdateLayoutAfterPreparedDataWithAnimation: FALSE];

    [self registerObservers];

    icClear.hidden = (tfSearch.text.length > 0)? FALSE : TRUE;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    //  show keyboard
    //  [tfSearch becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
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

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
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

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Search domains"];
    tfSearch.placeholder = [[appDelegate.localization localizedStringForKey:@"Enter domain name"] lowercaseString];
}

- (void)displayBannerPhotosIfNeed {
    //  show banner image
    NSArray *photos = [appDelegate.userInfo objectForKey:@"list_banner"];
    if ([photos isKindOfClass:[NSArray class]] && photos.count > 0) {
        if (listBanners == nil) {
            listBanners = [[NSMutableArray alloc] init];
        }else{
            [listBanners removeAllObjects];
        }
        [listBanners addObjectsFromArray: photos];
        
        //  get height of first photo
        NSDictionary *info = [photos firstObject];
        if ([info isKindOfClass:[NSDictionary class]]) {
            NSString *link = [info objectForKey:@"image"];
            if (![AppUtils isNullOrEmpty: link]) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString: link]];
                    UIImage *image = [UIImage imageWithData:imgData];
                    if (image != nil) {
                        hSliderView = (SCREEN_WIDTH - 2*padding) * image.size.height / image.size.width;
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self reUpdateLayoutAfterPreparedDataWithAnimation: TRUE];
                        });
                        return;
                    }
                });
            }
        }
    }
    hSliderView = 0;
}

- (void)createListDomainPriceIfNeed {
    if (listData == nil) {
        listData = [[NSMutableArray alloc] init];
    }else{
        [listData removeAllObjects];
    }
    
    id listPrice = [appDelegate.userInfo objectForKey:@"list_price"];
    if (listPrice != nil && [listPrice isKindOfClass:[NSArray class]]) {
        [listData addObjectsFromArray: listPrice];
    }
}

- (void)reUpdateLayoutAfterPreparedDataWithAnimation: (BOOL)animation {
    [tbDomainsType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(listData.count * hCell + hSection);
    }];
    
    float hContent = hTopView + sizeBlock/2;
    if (hSliderView > 0) {
        hContent += (padding + hSliderView);
        
        [clvSlider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewRenewDomain.mas_bottom).offset(padding);
            make.height.mas_equalTo(hSliderView);
        }];
    }else{
        [clvSlider mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewRenewDomain.mas_bottom);
            make.height.mas_equalTo(hSliderView);
        }];
    }
    
    if (hPostView > 0) {
        hContent += (padding + hPostView);
    }else{
        [clvPosts mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(clvSlider.mas_bottom);
        }];
    }
    
    if (animation) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    hContent += padding + (hSection + listData.count * hCell) + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: FALSE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

- (IBAction)icClearClick:(UIButton *)sender {
    [self.view endEditing: TRUE];
    icClear.hidden = TRUE;
    tfSearch.text = @"";
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)goToCheckMultiDomains {
    SearchMultiDomainsViewController *searchMultisVC = [[SearchMultiDomainsViewController alloc] initWithNibName:@"SearchMultiDomainsViewController" bundle:nil];
    [self.navigationController pushViewController: searchMultisVC animated:TRUE];
}

- (void)goToRenewalDomains {
    DomainsViewController *domainsVC = [[DomainsViewController alloc] initWithNibName:@"DomainsViewController" bundle:nil];
    [self.navigationController pushViewController: domainsVC animated:TRUE];
}

- (void)goToPricingDomainsView {
    PricingViewController *pricingsVC = [[PricingViewController alloc] initWithNibName:@"PricingViewController" bundle:nil];
    [self.navigationController pushViewController: pricingsVC animated:TRUE];
}

- (void)setupUIForView
{
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float sizeIcon = 40.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        icClear.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hTextfield = 45.0;
        sizeIcon = 30.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        icClear.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        hTextfield = 48.0;
        sizeIcon = 35.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        icClear.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        hTextfield = 50.0;
        sizeIcon = 40.0;
    }
    
    hSection = 50.0;
    hCell = 90.0;
    padding = 15.0;
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    [bgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewHeader);
    }];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40);
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
    
    self.view.backgroundColor = GRAY_240;
    
    //  content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.delegate = self;
    scvContent.backgroundColor = UIColor.clearColor;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    sizeBlock = (SCREEN_WIDTH - 4*padding)/3;
    
    UIImage *imgBottom = [UIImage imageNamed:@"bg_search_domains_bottom"];
    hTopView = SCREEN_WIDTH * imgBottom.size.height / imgBottom.size.width;
    
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTopView);
    }];
    viewTop.backgroundColor = UIColor.clearColor;
    
    [imgBGBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewTop);
    }];
    
    tfSearch.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-1];
    tfSearch.layer.cornerRadius = 12.0;
    tfSearch.delegate = self;
    tfSearch.returnKeyType = UIReturnKeySearch;
    tfSearch.textColor = GRAY_80;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.top.equalTo(viewTop).offset(padding);
        make.height.mas_equalTo(hTextfield);
    }];
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldDidChange)
       forControlEvents:UIControlEventEditingChanged];
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (10.0 + 20.0 + 55.0), hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    tfSearch.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfSearch.rightViewMode = UITextFieldViewModeAlways;
    
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(10.0);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    [icClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfSearch);
        make.top.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(hTextfield);
    }];
    
    lbWWW.font = tfSearch.font;
    lbWWW.textColor = BLUE_COLOR;
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgSearch.mas_right);
        make.top.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(55.0);
    }];
    
    //  three top views
    viewRenewDomain.layer.cornerRadius = viewCheckMultiDomains.layer.cornerRadius = viewTransferDomains.layer.cornerRadius = 10.0;
    lbRenewDomain.font = lbCheckMultiDomains.font = lbTransferDomain.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-5];
    lbRenewDomain.textColor = lbCheckMultiDomains.textColor = lbTransferDomain.textColor = GRAY_80;
    
    //  view renew domain
    UITapGestureRecognizer *tapOnRenew = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToRenewalDomains)];
    [viewRenewDomain addGestureRecognizer: tapOnRenew];
    
    [viewRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom).offset(-sizeBlock/2);
        make.centerX.equalTo(viewTop.mas_centerX);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewRenewDomain color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewRenewDomain.mas_centerY).offset(-3.0);
        make.centerX.equalTo(viewRenewDomain.mas_centerX);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain.mas_centerY).offset(2.0);
        make.left.equalTo(viewRenewDomain).offset(2.0);
        make.right.equalTo(viewRenewDomain).offset(-2.0);
        make.bottom.equalTo(viewRenewDomain);
    }];
    
    //  view check multi domains
    UITapGestureRecognizer *tapOnCheckDomains = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToCheckMultiDomains)];
    [viewCheckMultiDomains addGestureRecognizer: tapOnCheckDomains];
    
    [viewCheckMultiDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain);
        make.right.equalTo(viewRenewDomain.mas_left).offset(-padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewCheckMultiDomains color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgCheckMultiDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewCheckMultiDomains.mas_centerY).offset(-3.0);
        make.centerX.equalTo(viewCheckMultiDomains.mas_centerX);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbCheckMultiDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewCheckMultiDomains.mas_centerY).offset(2.0);
        make.left.equalTo(viewCheckMultiDomains).offset(2.0);
        make.right.equalTo(viewCheckMultiDomains).offset(-2.0);
        make.bottom.equalTo(viewCheckMultiDomains);
    }];
    
    //  view transfer domains
    UITapGestureRecognizer *tapOnPricing = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToPricingDomainsView)];
    [viewTransferDomains addGestureRecognizer: tapOnPricing];
    
    [viewTransferDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain);
        make.left.equalTo(viewRenewDomain.mas_right).offset(padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewTransferDomains color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewTransferDomains.mas_centerY).offset(-3.0);
        make.centerX.equalTo(viewTransferDomains.mas_centerX);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTransferDomains.mas_centerY).offset(2.0);
        make.left.equalTo(viewTransferDomains).offset(2.0);
        make.right.equalTo(viewTransferDomains).offset(-2.0);
        make.bottom.equalTo(viewTransferDomains);
    }];
    
    //  collection view slider
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    clvSlider.collectionViewLayout = layout;
    clvSlider.delegate = self;
    clvSlider.dataSource = self;
    [clvSlider registerNib:[UINib nibWithNibName:@"HomeSliderClvCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSliderClvCell"];
    
    clvSlider.showsHorizontalScrollIndicator = FALSE;
    clvSlider.pagingEnabled = TRUE;
    clvSlider.layer.cornerRadius = 10.0;
    clvSlider.clipsToBounds = TRUE;
    
    [clvSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(0.0);
    }];
    
    [clvPosts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvSlider.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(0.0);
    }];
    
    [tbDomainsType registerNib:[UINib nibWithNibName:@"SuggestDomainCell" bundle:nil] forCellReuseIdentifier:@"SuggestDomainCell"];
    tbDomainsType.backgroundColor = UIColor.clearColor;
    tbDomainsType.separatorStyle = UITableViewCellSelectionStyleNone;
    tbDomainsType.delegate = self;
    tbDomainsType.dataSource = self;
    tbDomainsType.scrollEnabled = NO;
    [tbDomainsType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvPosts.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(0.0);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)searchTextfieldDidChange {
    icClear.hidden = (tfSearch.text.length > 0)? FALSE : TRUE;
}

#pragma mark - UIScrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestDomainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestDomainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listData objectAtIndex: indexPath.row];
    NSString *name = [info objectForKey:@"name"];
    id price = [info objectForKey:@"price"];
    
    NSString *content;
    if ([name hasSuffix:@".vn"]) {
        content = SFM(@"%@ %@", register_vietnam_domains, name);
    }else{
        content = SFM(@"%@ %@", register_international_domains, name);
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
    NSRange range = [content rangeOfString: name];
    [attr addAttribute:NSForegroundColorAttributeName value:ORANGE_COLOR range:range];
    cell.lbDomain.attributedText = attr;
    
    if ([price isKindOfClass:[NSNumber class]]) {
        NSString *strPrice = SFM(@"%d", [price intValue]);
        cell.lbPrice.text = SFM(@"%@đ/%@", [AppUtils convertStringToCurrencyFormat: strPrice], text_year);
        
    }else if ([price isKindOfClass:[NSString class]]) {
        cell.lbPrice.text = SFM(@"%@đ/%@", [AppUtils convertStringToCurrencyFormat: (NSString *)price], text_year);
        
    }else{
        cell.lbPrice.text = @"Giá liên hệ";
    }
    
    NSString *image = name;
    if ([image hasPrefix:@"."]) {
        image = [image substringFromIndex: 1];
    }
    cell.imgType.image = [UIImage imageNamed: image];
    
    
    cell.padding = padding;
    cell.hItem = hCell;
    //  [AppUtils addBoxShadowForView:cell.viewParent color:GRAY_100 opacity:0.8 offsetX:1.0 offsetY:1.0];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hSection)];
    sectionView.backgroundColor = UIColor.clearColor;
    
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Many options with attractive offers"];
    lbTitle.textColor = GRAY_50;
    lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [sectionView addSubview: lbTitle];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sectionView).offset(padding);
        make.top.bottom.equalTo(sectionView);
        make.right.equalTo(sectionView).offset(-padding);
    }];
    
    return sectionView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return listBanners.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeSliderClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSliderClvCell" forIndexPath:indexPath];
    
    NSDictionary *info = [listBanners objectAtIndex: indexPath.row];
    NSString *link = [info objectForKey:@"image"];
    
    //  download content
    cell.icWaiting.hidden = FALSE;
    [cell.icWaiting startAnimating];
    [cell.imgPicture sd_setImageWithURL:[NSURL URLWithString:link] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [cell.icWaiting stopAnimating];
        cell.icWaiting.hidden = TRUE;
    }];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH - 2*padding, hSliderView);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [tfSearch resignFirstResponder];
        
        if (tfSearch.text.length > 0) {
            SearchResultsViewController *searchResultsVC = [[SearchResultsViewController alloc] init];
            searchResultsVC.strSearch = tfSearch.text;
            [self.navigationController pushViewController:searchResultsVC animated:YES];
        }
    }
    return TRUE;
}

@end
