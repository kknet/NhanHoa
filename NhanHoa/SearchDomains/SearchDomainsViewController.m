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
#import "SearchDomainViewController.h"
#import "RenewedDomainViewController.h"
#import "WhoIsViewController.h"

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
    
    NSMutableArray *listBanners;
    UIFont *searchFont;
}
@end

@implementation SearchDomainsViewController
@synthesize viewHeader, icClose, lbHeader, icCart, bgHeader;
@synthesize scvContent, viewTop, tfSearch, lbWWW, icSearch, viewCheckMultiDomains, imgCheckMultiDomains, lbCheckMultiDomains, viewRenewDomain, imgRenewDomain, lbRenewDomain, viewTransferDomains, imgTransferDomain, lbTransferDomain, clvSlider, clvPosts, tbDomainsType;

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
    
    [self displayBannerPhotosIfNeed];
    [self createListDomainPriceIfNeed];
    
    [self reUpdateLayoutAfterPreparedData];
    
    [self registerObservers];
    
    if (tfSearch.text.length > 0) {
        icSearch.backgroundColor = [UIColor colorWithRed:(47/255.0) green:(124/255.0) blue:(215/255.0) alpha:1.0];
    }else{
        icSearch.backgroundColor = GRAY_200;
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    //  show keyboard
    [tfSearch becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
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
        make.bottom.equalTo(self.view);
    }];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Search domains"];
    tfSearch.placeholder = [appDelegate.localization localizedStringForKey:@"enter domain name"];
}

- (void)displayBannerPhotosIfNeed {
    //  show banner image
    NSArray *photos = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_banner"];
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
                NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString: link]];
                UIImage *image = [UIImage imageWithData:imgData];
                if (image != nil) {
                    hSliderView = (SCREEN_WIDTH - 2*padding) * image.size.height / image.size.width;
                    return;
                }
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
    
    id listPrice = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_price"];
    if (listPrice != nil && [listPrice isKindOfClass:[NSArray class]]) {
        [listData addObjectsFromArray: listPrice];
    }
}

- (void)reUpdateLayoutAfterPreparedData {
    [tbDomainsType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(listData.count * hCell + hSection);
    }];
    
    float hContent = padding + hTextfield + padding + sizeBlock;
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
    
    hContent += padding + (hSection + listData.count * hCell) + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: FALSE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)icSearchClick:(UIButton *)sender {
    [self.view endEditing: TRUE];
    
    if (tfSearch.text.length == 0) {
        return;
    }
    
    SearchDomainViewController *searchDomainVC = [[SearchDomainViewController alloc] init];
    searchDomainVC.strSearch = tfSearch.text;
    [self.navigationController pushViewController:searchDomainVC animated:YES];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)goToCheckMultiDomains {
    WhoIsViewController *whoisVC = [[WhoIsViewController alloc] initWithNibName:@"WhoIsViewController" bundle:nil];
    [self.navigationController pushViewController: whoisVC animated:TRUE];
}

- (void)goToRenewalDomains {
    RenewedDomainViewController *renewedVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
    [self.navigationController pushViewController: renewedVC animated:TRUE];
}

- (void)setupUIForView
{
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
    
    hTextfield = 42.0;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hNav = self.navigationController.navigationBar.frame.size.height;
    
    searchFont = [UIFont fontWithName:RobotoMedium size:21.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        searchFont = [UIFont fontWithName:RobotoMedium size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        searchFont = [UIFont fontWithName:RobotoMedium size:19.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        searchFont = [UIFont fontWithName:RobotoMedium size:21.0];
    }
    
    hSection = 50.0;
    hCell = 90.0;
    padding = 15.0;
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    
    [bgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewHeader);
    }];
    
    lbHeader.font = [UIFont fontWithName:RobotoRegular size:searchFont.pointSize];
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
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    //  content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.delegate = self;
    scvContent.backgroundColor = [UIColor colorWithRed:(245/255.0) green:(245/255.0)
                                                  blue:(245/255.0) alpha:1.0];
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    sizeBlock = (SCREEN_WIDTH - 4*padding)/3;
    float hTop = padding + hTextfield + padding + sizeBlock*2/3;
    
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTop);
    }];
    [self addCurvePathForViewWithHeight:hTop forView:viewTop];
    viewTop.backgroundColor = UIColor.clearColor;
    
    tfSearch.font = searchFont;
    tfSearch.layer.cornerRadius = hTextfield/2;
    tfSearch.delegate = self;
    tfSearch.returnKeyType = UIReturnKeySearch;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.top.equalTo(viewTop).offset(padding);
        make.height.mas_equalTo(hTextfield);
    }];
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldDidChange)
       forControlEvents:UIControlEventEditingChanged];
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60.0, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    tfSearch.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfSearch.rightViewMode = UITextFieldViewModeAlways;
    
    float searchPadding = 3.0;
    icSearch.layer.cornerRadius = (hTextfield - 2*searchPadding)/2;
    icSearch.backgroundColor = [UIColor colorWithRed:(47/255.0) green:(124/255.0) blue:(215/255.0) alpha:1.0];
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfSearch).offset(-searchPadding);
        make.top.equalTo(tfSearch).offset(searchPadding);
        make.bottom.equalTo(tfSearch).offset(-searchPadding);
        make.width.mas_equalTo(hTextfield-2*searchPadding);
    }];
    
    lbWWW.font = searchFont;
    lbWWW.textColor = BLUE_COLOR;
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch);
        make.top.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(60.0);
    }];
    
    //  three top views
    viewRenewDomain.layer.cornerRadius = viewCheckMultiDomains.layer.cornerRadius = viewTransferDomains.layer.cornerRadius = 8.0;
    lbRenewDomain.font = [UIFont fontWithName:RobotoRegular size:searchFont.pointSize-4];
    lbRenewDomain.textColor = GRAY_80;
    
    //  view renew domain
    UITapGestureRecognizer *tapOnRenew = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToRenewalDomains)];
    [viewRenewDomain addGestureRecognizer: tapOnRenew];
    
    [viewRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(padding + hTextfield + padding);
        make.centerX.equalTo(viewTop.mas_centerX);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewRenewDomain color:GRAY_100 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewRenewDomain.mas_centerY).offset(-3.0);
        make.centerX.equalTo(viewRenewDomain.mas_centerX);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain.mas_centerY).offset(2.0);
        make.left.equalTo(viewRenewDomain).offset(2.0);
        make.right.equalTo(viewRenewDomain).offset(-2.0);
    }];
    
    //  view check multi domains
    UITapGestureRecognizer *tapOnCheckDomains = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToCheckMultiDomains)];
    [viewCheckMultiDomains addGestureRecognizer: tapOnCheckDomains];
    
    [viewCheckMultiDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain);
        make.right.equalTo(viewRenewDomain.mas_left).offset(-padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewCheckMultiDomains color:GRAY_100 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgCheckMultiDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewCheckMultiDomains.mas_centerY).offset(-3.0);
        make.centerX.equalTo(viewCheckMultiDomains.mas_centerX);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbCheckMultiDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewCheckMultiDomains.mas_centerY).offset(2.0);
        make.left.equalTo(viewCheckMultiDomains).offset(2.0);
        make.right.equalTo(viewCheckMultiDomains).offset(-2.0);
    }];
    
    //  view transfer domains
    [viewTransferDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenewDomain);
        make.left.equalTo(viewRenewDomain.mas_right).offset(padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewTransferDomains color:GRAY_100 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewTransferDomains.mas_centerY).offset(-3.0);
        make.centerX.equalTo(viewTransferDomains.mas_centerX);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTransferDomains.mas_centerY).offset(2.0);
        make.left.equalTo(viewTransferDomains).offset(2.0);
        make.right.equalTo(viewTransferDomains).offset(-2.0);
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
        make.left.right.equalTo(viewTop);
        make.height.mas_equalTo(0.0);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
}

- (void)addCurvePathForViewWithHeight: (float)height forView: (UIView *)view {
    float hCurve = 15.0;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, height-hCurve)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, height-hCurve) controlPoint:CGPointMake(SCREEN_WIDTH/2, height+hCurve)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = UIColor.clearColor.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(27/255.0) green:(100/255.0) blue:(202/255.0) alpha:1].CGColor, (id)[UIColor colorWithRed:(29/255.0) green:(104/255.0) blue:(209/255.0) alpha:1.0].CGColor];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
}

- (void)searchTextfieldDidChange {
    if (tfSearch.text.length > 0) {
        icSearch.backgroundColor = [UIColor colorWithRed:(47/255.0) green:(124/255.0) blue:(215/255.0) alpha:1.0];
    }else{
        icSearch.backgroundColor = GRAY_200;
    }
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
    }
    
    NSString *image = name;
    if ([image hasPrefix:@"."]) {
        image = [image substringFromIndex: 1];
    }
    cell.imgType.image = [UIImage imageNamed: image];
    
    
    cell.padding = padding;
    cell.hItem = hCell;
    [AppUtils addBoxShadowForView:cell.viewParent color:GRAY_100 opacity:0.8 offsetX:1.0 offsetY:1.0];
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hSection)];
    sectionView.backgroundColor = UIColor.clearColor;
    
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Many options with attractive offers"];
    lbTitle.textColor = GRAY_50;
    lbTitle.font = [UIFont fontWithName:RobotoBold size:searchFont.pointSize];
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
            SearchDomainViewController *searchDomainVC = [[SearchDomainViewController alloc] init];
            searchDomainVC.strSearch = tfSearch.text;
            [self.navigationController pushViewController:searchDomainVC animated:YES];
        }
    }
    return TRUE;
}

@end
