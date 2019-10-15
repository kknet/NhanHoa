//
//  NewHomeViewController.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewHomeViewController.h"
#import "HomeHeaderView.h"
#import "HomeSliderView.h"
#import "HomeMenuClvCell.h"

#define NUM_OF_MENU 8

@interface NewHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate>{
    float hStatus;
    float padding;
    float hCurve;
    CAGradientLayer *gradientLayer;
    
    HomeHeaderView *viewHomeHeader;
    HomeSliderView *viewHomeSlider;
    float hMenuCell;
    
    AppDelegate *appDelegate;
    
    CGFloat lastContentOffset;
}

@end

@implementation NewHomeViewController
@synthesize viewBanner, imgBanner, scvContent, lbTop, clvMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
}

- (void)setupUIForView
{
    hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    
    //  setup content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
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
    
    //  scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hStatus + 20.0 + viewHomeHeader.hContentView + 2*hMenuCell + viewHomeSlider.hContentView);
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    //  add curver path
    [self setupForBannerViewWithHeight: viewHomeHeader.hContentView];
}

- (void)addHomeHeaderViewIfNeed {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"HomeHeaderView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[HomeHeaderView class]]) {
            viewHomeHeader = (HomeHeaderView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: viewHomeHeader];
    [viewHomeHeader setupUIForView];
    
    [viewHomeHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus + 20.0);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(viewHomeHeader.hContentView);
    }];
}

- (void)addHomeSliderViewIfNeed {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"HomeSliderView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[HomeSliderView class]]) {
            viewHomeSlider = (HomeSliderView *) currentObject;
            break;
        }
    }
    [scvContent addSubview: viewHomeSlider];
    [viewHomeSlider setupUIForView];
    
    [viewHomeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvMenu.mas_bottom);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(viewHomeSlider.hContentView);
    }];
}

- (void)setupForBannerViewWithHeight: (float)height
{
    hCurve = 30.0;
    
    UIImage *banner = [UIImage imageNamed:@"home_banner"];
    float hBanner = SCREEN_WIDTH*banner.size.height / banner.size.width;
    
    viewBanner.backgroundColor = UIColor.clearColor;
    viewBanner.clipsToBounds = TRUE;
    [viewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(height + hCurve);
    }];
    
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewBanner).offset(hStatus);
        make.left.right.equalTo(viewBanner);
        make.height.mas_equalTo(hBanner);
    }];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, height)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, height) controlPoint:CGPointMake(SCREEN_WIDTH/2, height+hCurve)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = UIColor.greenColor.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height+hCurve);
    gradientLayer.startPoint = CGPointMake(1, 1);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(18/255.0) green:(101/255.0) blue:(203/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0].CGColor];
    
    [viewBanner.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
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

#pragma mark - UIScrollView

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (lastContentOffset > scrollView.contentOffset.y) {
        NSLog(@"UPPPPP");
    } else {
        //  NSLog(@"%f", scrollView.contentOffset.y);
        
        hCurve = 30.0;
        
        UIImage *banner = [UIImage imageNamed:@"home_banner"];
        
        float height = viewHomeHeader.hContentView - scrollView.contentOffset.y;
        NSLog(@"height: %f", height);
        
        [viewBanner mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height + hCurve);
        }];
        [self.view layoutIfNeeded];
        
        [gradientLayer removeFromSuperlayer];
        
        UIBezierPath *path = [UIBezierPath new];
        [path moveToPoint: CGPointMake(0, 0)];
        [path addLineToPoint: CGPointMake(0, height)];
        [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, height) controlPoint:CGPointMake(SCREEN_WIDTH/2, height+hCurve)];
        [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
        [path closePath];
        
        //Add gradient layer to top view
        
        CAShapeLayer *shapeLayer = [CAShapeLayer new];
        shapeLayer.path = path.CGPath;
        
        gradientLayer = [CAGradientLayer layer];
        gradientLayer.backgroundColor = UIColor.greenColor.CGColor;
        gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height+hCurve);
        gradientLayer.startPoint = CGPointMake(1, 1);
        gradientLayer.endPoint = CGPointMake(0, 0);
        gradientLayer.colors = @[(id)[UIColor colorWithRed:(18/255.0) green:(101/255.0) blue:(203/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0].CGColor];
        
        [viewBanner.layer insertSublayer:gradientLayer atIndex:0];
        gradientLayer.mask = shapeLayer;
        
        
    }
    
    lastContentOffset = scrollView.contentOffset.y;
//
//    NSLog(@"%f", scrollView.contentOffset.y);
//    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
//    if(translation.y > 0)
//    {
//        NSLog(@"down");
//        // react to dragging down
//    } else
//    {
//        NSLog(@"up");
//        // react to dragging up
//    }
}

@end
