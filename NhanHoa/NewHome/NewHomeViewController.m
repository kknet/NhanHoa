//
//  NewHomeViewController.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewHomeViewController.h"
#import "TopupViewController.h"

#import "HomeHeaderView.h"
#import "HomeSliderView.h"
#import "HomePromotionView.h"
#import "HomeMenuClvCell.h"
#import "HomeExploreView.h"

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
}

@end

@implementation NewHomeViewController
@synthesize scvContent, lbTop, clvMenu, lbCopyRight;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [viewHomeHeader displayAccountInformation];
}

- (void)setupUIForView
{
    padding = 15.0;
    float hTabbar = self.tabBarController.tabBar.frame.size.height;
    
    //  setup content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
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
    hMenuCell = 80.0;
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
        make.top.equalTo(viewHomeHeader.mas_bottom);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(2*hMenuCell);
    }];
    
    //  add slider view
    [self addHomeSliderViewIfNeed];
    [self addHomePromotionsViewIfNeed];
    
    NSMutableAttributedString *copyright = [[NSMutableAttributedString alloc] initWithString:@"Copyright ® 2002 – 2019 Nhan Hoa Software Company. All Rights Reserved."];
    [copyright addAttribute:NSFontAttributeName value:appDelegate.fontDesc range:NSMakeRange(0, copyright.length)];
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
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, viewHomeHeader.hContentView + 2*hMenuCell + viewHomeSlider.hContentView + viewPromotion.hContentView + 70.0);
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
    [viewPromotion setupUIForView];
    
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
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Invoices"];
            cell.imgType.image = [UIImage imageNamed:@"menu_invoices"];
            break;
        }
        case eMenuProfiles:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Profiles"];
            cell.imgType.image = [UIImage imageNamed:@"menu_profiles"];
            break;
        }
        case eMenuRegisterEmail:{
            cell.lbMenu.text = [appDelegate.localization localizedStringForKey:@"Register email"];
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
        
        
    }else if (indexPath.row == eMenuMore) {
        [self showExploreMenuForView];
    }
    
//    HomeMenuCell *cell = (HomeMenuCell *)[collectionView cellForItemAtIndexPath: indexPath];
//
//    NSString *title = cell.lbName.text;
//    if ([title isEqualToString: text_register_domains]) {
//        RegisterDomainViewController *registerDomainVC = [[RegisterDomainViewController alloc] initWithNibName:@"RegisterDomainViewController" bundle:nil];
//        registerDomainVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: registerDomainVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_domains_pricing_list])
//    {
//        PricingDomainViewController *pricingVC = [[PricingDomainViewController alloc] initWithNibName:@"PricingDomainViewController" bundle:nil];
//        pricingVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: pricingVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_search_domains])
//    {
//        WhoIsViewController *whoIsVC = [[WhoIsViewController alloc] initWithNibName:@"WhoIsViewController" bundle:nil];
//        whoIsVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: whoIsVC animated:TRUE];
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
//    }else if ([title isEqualToString: text_draw_bonuses])
//    {
//        WithdrawalBonusAccountViewController *withdrawVC = [[WithdrawalBonusAccountViewController alloc] initWithNibName:@"WithdrawalBonusAccountViewController" bundle:nil];
//        withdrawVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: withdrawVC animated:TRUE];
//
//    }else if ([title isEqualToString: text_profiles_list])
//    {
//        ProfileManagerViewController *profileVC = [[ProfileManagerViewController alloc] initWithNibName:@"ProfileManagerViewController" bundle:nil];
//        profileVC.hidesBottomBarWhenPushed = TRUE;
//        [self.navigationController pushViewController: profileVC animated:TRUE];
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
        viewExplore.viewContent.frame = CGRectMake(5, SCREEN_HEIGHT-viewExplore.hContent, SCREEN_WIDTH-10, viewExplore.hContent);
    }];
}

- (void)closeExploreView {
    viewExplore.lbTransparent.hidden = TRUE;
    [UIView animateWithDuration:0.3 animations:^{
        viewExplore.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, viewExplore.hContent);
        
    }completion:^(BOOL finished) {
        [viewExplore removeFromSuperview];
        viewExplore = nil;
    }];
}

#pragma mark - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
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
}

-(void)selectOnTopupHeaderMenu {
    TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    topupVC.hidesBottomBarWhenPushed = TRUE;
    [self.navigationController pushViewController: topupVC animated:TRUE];
}

-(void)selectOnWithdrawHeaderMenu {
    
}

-(void)selectOnPromotionHeaderMenu {
    
}

-(void)selectOnTransactionHeaderMenu {
    
}

@end
