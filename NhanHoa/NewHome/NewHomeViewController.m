//
//  NewHomeViewController.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewHomeViewController.h"
#import "WithdrawalBonusAccountViewController.h"
#import "SearchDomainsViewController.h"
#import "TopupViewController.h"
#import "PromotionsViewController.h"
#import "ProfilesViewController.h"
#import "IntroduceHostingViewController.h"
#import "IntroduceEmailsViewController.h"
#import "IntroduceServersViewController.h"
#import "IntroduceSSLViewController.h"
#import "IntroduceVPSViewController.h"
#import "DomainsViewController.h"
#import "SearchMultiDomainsViewController.h"

#import "HomeHeaderView.h"
#import "HomeSliderView.h"
#import "HomePromotionView.h"
#import "HomeMenuClvCell.h"
#import "HomeExploreView.h"
#import "FLAnimatedImage.h"

#define NUM_OF_MENU 8

@interface NewHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate, HomeExploreViewDelegate, HomeHeaderViewDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    
    HomeHeaderView *viewHomeHeader;
    HomeSliderView *viewHomeSlider;
    HomePromotionView *viewPromotion;
    HomeExploreView *viewExplore;
    float hMenuCell;
    
    UILabel *lbBgStatus;
}

@end

@implementation NewHomeViewController
@synthesize scvContent, lbTop, clvMenu, lbCopyRight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
    
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif"]]];
//    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
//    imageView.animatedImage = image;
//    imageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
//    [self.view addSubview:imageView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    [appDelegate hideTabbarCustomSubviews:FALSE withDuration:TRUE];
    
    if (viewHomeHeader != nil) {
        [viewHomeHeader displayAccountInformation];
        [viewHomeHeader updateShoppingCartCount];
    }
}

- (void)setupUIForView
{
    padding = 15.0;
    float hTabbar = self.tabBarController.tabBar.frame.size.height;
    
    hMenuCell = 100.0;
    if (IS_IPHONE || IS_IPOD)
    {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            hMenuCell = 80.0;
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
            hMenuCell = 80.0;
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
            hMenuCell = 90.0;
        }
    }
    
    //  setup content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-hTabbar);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
    
    [self addHomeHeaderViewIfNeed];
    
    //  collection view
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    clvMenu.collectionViewLayout = layout;
    
    clvMenu.scrollEnabled = FALSE;
    clvMenu.delegate = self;
    clvMenu.dataSource = self;
    clvMenu.backgroundColor = UIColor.clearColor;
    [clvMenu registerNib:[UINib nibWithNibName:@"HomeMenuClvCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMenuClvCell"];
    [clvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHomeHeader.mas_bottom).offset(10.0);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(2*hMenuCell);
    }];
    
    //  add slider view
    [self addHomeSliderViewIfNeed];
    [self addHomePromotionsViewIfNeed];
    
    NSMutableAttributedString *copyright = [[NSMutableAttributedString alloc] initWithString:@"Copyright ® 2002 – 2019 Nhan Hoa Software Company. All Rights Reserved."];
    [copyright addAttribute:NSFontAttributeName value:viewHomeHeader.lbMainWallet.font range:NSMakeRange(0, copyright.length)];
    [copyright addAttribute:NSForegroundColorAttributeName value:UIColor.darkGrayColor range:NSMakeRange(0, copyright.length)];
    NSRange range = [copyright.string rangeOfString:@"Nhan Hoa Software Company"];
    if (range.location != NSNotFound) {
        [copyright addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
    }
    
    lbCopyRight.backgroundColor = viewPromotion.backgroundColor;
    lbCopyRight.attributedText = copyright;
    [lbCopyRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewPromotion.mas_bottom);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(70.0);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, viewHomeHeader.hContentView + 2*hMenuCell + viewHomeSlider.hContentView + viewPromotion.hContentView + 70.0 + 20.0);
}

- (void)addHomeSliderViewIfNeed {
    NSArray *listPhotos = @[[UIImage imageNamed:@"slider_1"], [UIImage imageNamed:@"slider_2"], [UIImage imageNamed:@"slider_3"]];
    
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"HomeSliderView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[HomeSliderView class]]) {
            viewHomeSlider = (HomeSliderView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: viewHomeSlider];
    [viewHomeSlider setupUIForViewWithList:listPhotos];
    
    [viewHomeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvMenu.mas_bottom);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(viewHomeSlider.hContentView);
    }];
}

- (void)addHomePromotionsViewIfNeed {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"HomePromotionView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[HomePromotionView class]]) {
            viewPromotion = (HomePromotionView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: viewPromotion];
    [viewPromotion setupUIForViewWithList:@[[UIImage imageNamed:@"promotion_1"], [UIImage imageNamed:@"promotion_2"], [UIImage imageNamed:@"promotion_3"], [UIImage imageNamed:@"promotion_4"]]];
    
    [viewPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHomeSlider.mas_bottom);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(viewPromotion.hContentView);
    }];
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return NUM_OF_MENU;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeMenuClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMenuClvCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case eMenuDomain:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Domains"];
            cell.imgType.image = [UIImage imageNamed:@"menu_domains"];
            break;
        }
        case eMenuCloudServer:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Cloud server"];
            cell.imgType.image = [UIImage imageNamed:@"menu_cloud_server"];
            break;
        }
        case eMenuVfone:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Vfone"];
            cell.imgType.image = [UIImage imageNamed:@"menu_vfone"];
            break;
        }
        case eMenuOrders:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Orders"];
            cell.imgType.image = [UIImage imageNamed:@"menu_invoices"];
            break;
        }
        case eMenuProfiles:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Profiles"];
            cell.imgType.image = [UIImage imageNamed:@"menu_profiles"];
            break;
        }
        case eMenuRegisterEmail:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Email"];
            cell.imgType.image = [UIImage imageNamed:@"menu_register_email"];
            break;
        }
        case eMenuHosting:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Hosting"];
            cell.imgType.image = [UIImage imageNamed:@"menu_hosting"];
            break;
        }
        case eMenuMore:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"More"];
            cell.imgType.image = [UIImage imageNamed:@"menu_more"];
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
    
    if (indexPath.row == eMenuDomain) {
        [self goToSearchDomainViewController];
        
    }else if (indexPath.row == eMenuCloudServer){
        [self goToCloudServerViewController];
        
    }else if (indexPath.row == eMenuProfiles){
        [self goToProfilesViewController];
        
    }else if (indexPath.row == eMenuRegisterEmail){
        [self goToRegisterEmailsViewController];
        
    }else if (indexPath.row == eMenuHosting){
        [self goToRegisterHostingViewController];
        
    }else if (indexPath.row == eMenuMore) {
        [self showExploreMenuForView];
    }
    
//    HomeMenuCell *cell = (HomeMenuCell *)[collectionView cellForItemAtIndexPath: indexPath];
//
//    NSString *title = cell.lbName.text;
//    if ([title isEqualToString: text_domains_pricing_list])
//    {
//        PricingDomainViewController *pricingVC = [[PricingDomainViewController alloc] initWithNibName:@"PricingDomainViewController" bundle:nil];
//        pricingVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: pricingVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_search_domains])
//    {
//
//    }else if ([title isEqualToString: text_top_up_into_account])
//    {
//        TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
//        topupVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: topupVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_bonus_account])
//    {
//        BonusAccountViewController *bonusAccVC = [[BonusAccountViewController alloc] initWithNibName:@"BonusAccountViewController" bundle:nil];
//        bonusAccVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: bonusAccVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_domains_management])
//    {
//        RenewedDomainViewController *renewedVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
//        renewedVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: renewedVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_customers_support])
//    {
//        SupportViewController *supportVC = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
//        supportVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: supportVC animated:TRUE];
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 2*padding)/4, hMenuCell);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (void)showExploreMenuForView {
    if (viewExplore == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"HomeExploreView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[HomeExploreView class]]) {
                viewExplore = (HomeExploreView *) currentObject;
                break;
            }
        }
        [appDelegate.window addSubview: viewExplore];
        viewExplore.delegate = self;
        [viewExplore setupUIForView];
        
        viewExplore.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    [self performSelector:@selector(startShowExploreView) withObject:nil afterDelay:0.2];
}

- (void)startShowExploreView {
    [UIView animateWithDuration:0.2 animations:^{
        viewExplore.viewContent.frame = CGRectMake(0, SCREEN_HEIGHT-viewExplore.hContent, SCREEN_WIDTH, viewExplore.hContent);
    }];
}

#pragma mark - ExploreViewDelegate
- (void)closeExploreView {
    viewExplore.lbTransparent.hidden = TRUE;
    [UIView animateWithDuration:0.3 animations:^{
        viewExplore.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, viewExplore.hContent);
        
    }completion:^(BOOL finished) {
        [viewExplore removeFromSuperview];
        viewExplore = nil;
    }];
}

-(void)selectedMenuFromExploreView:(ExploreType)menu {
    viewExplore.lbTransparent.hidden = TRUE;
    [UIView animateWithDuration:0.3 animations:^{
        viewExplore.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, viewExplore.hContent);
        
    }completion:^(BOOL finished) {
        [viewExplore removeFromSuperview];
        viewExplore = nil;
        
        switch (menu) {
            case eExploreDomain:{
                [self goToSearchDomainViewController];
                break;
            }
            case eExploreCloudServer:{
                [self goToCloudServerViewController];
                break;
            }
            case eExploreVfone:{
                break;
            }
            case eExploreOrders:{
                break;
            }
            case eExploreProfiles:{
                [self goToProfilesViewController];
                break;
            }
            case eExploreEmail:{
                [self goToRegisterEmailsViewController];
                break;
            }
            case eExploreHosting:{
                [self goToRegisterHostingViewController];
                break;
            }
            case eExploreSSL:{
                [self goToRegisterSSLViewController];
                break;
            }
            case eExploreVPS:{
                [self goToRegisterVPSViewController];
                break;
            }
            case eExploreManagerDomains:{
                [self goToDomainsManagementViewController];
                break;
            }
            case eExplorePricingDomains:{
                break;
            }
            case eExploreCheckDomains:{
                [self goToSearchMultiDomainsViewController];
                break;
            }
                
            default:
                break;
        }
    }];
}

- (void)goToSearchDomainViewController {
    SearchDomainsViewController *searchDomainsVC = [[SearchDomainsViewController alloc] initWithNibName:@"SearchDomainsViewController" bundle:nil];
    searchDomainsVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: searchDomainsVC animated:TRUE];
}

- (void)goToCloudServerViewController {
    IntroduceServersViewController *serversVC = [[IntroduceServersViewController alloc] initWithNibName:@"IntroduceServersViewController" bundle:nil];
    serversVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: serversVC animated:TRUE];
}

- (void)goToProfilesViewController {
    ProfilesViewController *profileVC = [[ProfilesViewController alloc] initWithNibName:@"ProfilesViewController" bundle:nil];
    profileVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: profileVC animated:TRUE];
}

- (void)goToRegisterEmailsViewController {
    IntroduceEmailsViewController *emailVC = [[IntroduceEmailsViewController alloc] initWithNibName:@"IntroduceEmailsViewController" bundle:nil];
    emailVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: emailVC animated:TRUE];
}

- (void)goToRegisterHostingViewController {
    IntroduceHostingViewController *hostingVC = [[IntroduceHostingViewController alloc] initWithNibName:@"IntroduceHostingViewController" bundle:nil];
    hostingVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: hostingVC animated:TRUE];
}

- (void)goToRegisterSSLViewController {
    IntroduceSSLViewController *registerSSLVC = [[IntroduceSSLViewController alloc] initWithNibName:@"IntroduceSSLViewController" bundle:nil];
    registerSSLVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: registerSSLVC animated:TRUE];
}

- (void)goToRegisterVPSViewController {
    IntroduceVPSViewController *registerVPSVC = [[IntroduceVPSViewController alloc] initWithNibName:@"IntroduceVPSViewController" bundle:nil];
    registerVPSVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: registerVPSVC animated:TRUE];
}

- (void)goToDomainsManagementViewController {
    DomainsViewController *domainsVC = [[DomainsViewController alloc] initWithNibName:@"DomainsViewController" bundle:nil];
    domainsVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController:domainsVC animated:TRUE];
}

- (void)goToSearchMultiDomainsViewController {
    SearchMultiDomainsViewController *searchMultiVC = [[SearchMultiDomainsViewController alloc] initWithNibName:@"SearchMultiDomainsViewController" bundle:nil];
    searchMultiVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController:searchMultiVC animated:TRUE];
}

#pragma mark - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
        
    }else if (scrollView.contentOffset.y > 5.0){
        if (lbBgStatus == nil) {
            lbBgStatus = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [UIApplication sharedApplication].statusBarFrame.size.height)];
            lbBgStatus.backgroundColor = [UIColor colorWithRed:(23/255.0) green:(92/255.0) blue:(188/255.0) alpha:1.0];
            [self.view addSubview: lbBgStatus];
        }
        lbBgStatus.hidden = FALSE;
    }else{
        lbBgStatus.hidden = TRUE;
    }
    
    if (scrollView.contentOffset.y > (viewHomeHeader.icCart.frame.origin.y + viewHomeHeader.icCart.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height))
    {
        //  NSLog(@"HIDE");
    }else{
        //  NSLog(@"SHOW");
    }
}

#pragma mark - HomeHeader Delegate
- (void)addHomeHeaderViewIfNeed {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[HomeHeaderView class]]) {
            viewHomeHeader = (HomeHeaderView *) currentObject;
            break;
        }
    }
    viewHomeHeader.delegate = self;
    [scvContent addSubview: viewHomeHeader];
    [viewHomeHeader setupUIForView];
    
    [viewHomeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(viewHomeHeader.hContentView);
    }];
    
    //  add target
    [viewHomeHeader.icMainMoney addTarget:self
                                   action:@selector(selectOnTopupHeaderMenu)
                         forControlEvents:UIControlEventTouchUpInside];
    
    [viewHomeHeader.icBonusMoney addTarget:self
                                    action:@selector(selectOnWithdrawHeaderMenu)
                          forControlEvents:UIControlEventTouchUpInside];
    
    [viewHomeHeader.icCart addTarget:self
                              action:@selector(onIconCartClicked)
                    forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectOnTopupHeaderMenu {
    TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    topupVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: topupVC animated:TRUE];
}

-(void)selectOnWithdrawHeaderMenu {
    WithdrawalBonusAccountViewController *withdrawVC = [[WithdrawalBonusAccountViewController alloc] initWithNibName:@"WithdrawalBonusAccountViewController" bundle:nil];
    withdrawVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: withdrawVC animated:TRUE];
}

-(void)selectOnPromotionHeaderMenu {
    PromotionsViewController *promotionsVC = [[PromotionsViewController alloc] initWithNibName:@"PromotionsViewController" bundle:nil];
    promotionsVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController: promotionsVC animated:TRUE];
}

-(void)selectOnTransactionHeaderMenu {
//    TransHistoryViewController *transactionsVC = [[TransHistoryViewController alloc] initWithNibName:@"TransHistoryViewController" bundle:nil];
//    transactionsVC.hidesBottomBarWhenPushed = TRUE;
//    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
//    [self.navigationController pushViewController: transactionsVC animated:TRUE];
}

- (void)onIconCartClicked {
    [appDelegate showCartScreenContent];
}

@end
