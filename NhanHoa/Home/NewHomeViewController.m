//
//  NewHomeViewController.m
//  NhanHoa
//
//  Created by OS on 7/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewHomeViewController.h"
#import "TopupViewController.h"
#import "BonusAccountViewController.h"
#import "HomeMenuObject.h"
#import "NewHomeMenuCell.h"

@interface NewHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, UIScrollViewDelegate>{
    NSMutableArray *listMenu;
    float hTabbar;
    float hMenu;
    float hHeader;
    int numOfLine;
    float hSearch;
    float hNav;
}

@end

@implementation NewHomeViewController
@synthesize viewSearch, tfSearch, icSearch;
@synthesize imgBanner;
@synthesize scvContent, viewWallet, viewMainWallet, imgMainWallet, lbMainWallet, lbMoneyMain, viewBonusWallet, imgBonusWallet, lbBonusWallet, lbMoneyBonus, lbSepa;
@synthesize clvMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    numOfLine = 3;
    hTabbar = self.tabBarController.tabBar.frame.size.height;
    [self createDataForMenuView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
    
    [WriteLogsUtils writeForGoToScreen: @"NewHomeViewController"];
    [[FIRMessaging messaging] subscribeToTopic:@"/topics/global"];
    
    [self setupUIForView];
    
    [self showUserWalletView];
    [self createCartViewIfNeed];
}

- (void)showUserWalletView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSString *totalBalance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: totalBalance]) {
        totalBalance = [AppUtils convertStringToCurrencyFormat: totalBalance];
        lbMoneyMain.text = [NSString stringWithFormat:@"%@VNĐ", totalBalance];
    }else{
        lbMoneyMain.text = @"0VNĐ";
    }
    
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        points = [AppUtils convertStringToCurrencyFormat: points];
        lbMoneyBonus.text = [NSString stringWithFormat:@"%@VNĐ", points];
    }else{
        lbMoneyBonus.text = @"0VNĐ";
    }
}

- (void)createCartViewIfNeed {
    if ([AppDelegate sharedInstance].cartView == nil) {
        float hNav = self.navigationController.navigationBar.frame.size.height;
        
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"ShoppingCartView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[ShoppingCartView class]]) {
                [AppDelegate sharedInstance].cartView = (ShoppingCartView *) currentObject;
                break;
            }
        }
        [[AppDelegate sharedInstance].window addSubview: [AppDelegate sharedInstance].cartView];
        [[AppDelegate sharedInstance].cartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo([AppDelegate sharedInstance].window).offset([AppDelegate sharedInstance].hStatusBar);
            make.right.equalTo([AppDelegate sharedInstance].window);
            make.width.height.mas_equalTo(hNav);
        }];
        [[AppDelegate sharedInstance].cartView setupUIForView];
        [[AppDelegate sharedInstance] updateShoppingCartCount];
    }else{
        [[AppDelegate sharedInstance].window bringSubviewToFront:[AppDelegate sharedInstance].cartView];
    }
}

- (void)createDataForMenuView {
    listMenu = [[NSMutableArray alloc] init];
    
    HomeMenuObject *regDomain = [[HomeMenuObject alloc] initWithName:@"Đăng ký tên miền" icon:@"menu_domain" type:eRegisterDomain];
    [listMenu addObject: regDomain];
    
    HomeMenuObject *renewDomain = [[HomeMenuObject alloc] initWithName:@"Bảng giá tên miền" icon:@"menu_reorder_domain" type:ePricingDomain];
    [listMenu addObject: renewDomain];
    
    HomeMenuObject *searchDomain = [[HomeMenuObject alloc] initWithName:@"Kiểm tra tên miền" icon:@"menu_search_domain" type:eSearchDomain];
    [listMenu addObject: searchDomain];
    
    HomeMenuObject *recharge = [[HomeMenuObject alloc] initWithName:@"Nạp tiền vào tài khoản" icon:@"menu_recharge" type:eRecharge];
    [listMenu addObject: recharge];
    
    HomeMenuObject *rewardsPoints = [[HomeMenuObject alloc] initWithName:@"Tài khoản thưởng" icon:@"menu_bonus" type:eRewardsPoints];
    [listMenu addObject: rewardsPoints];
    
    HomeMenuObject *managerDomains = [[HomeMenuObject alloc] initWithName:@"Quản lý tên miền" icon:@"menu_list_domain" type:eManagerDomain];
    [listMenu addObject: managerDomains];
    
    HomeMenuObject *withdrawal = [[HomeMenuObject alloc] initWithName:@"Rút tiền thưởng" icon:@"menu_withdrawal" type:eWithdrawal];
    [listMenu addObject: withdrawal];
    
    HomeMenuObject *profile = [[HomeMenuObject alloc] initWithName:@"Danh sách hồ sơ" icon:@"menu_profile" type:eProfile];
    [listMenu addObject: profile];
    
    HomeMenuObject *support = [[HomeMenuObject alloc] initWithName:@"Hỗ trợ khách hàng" icon:@"menu_support" type:eSupport];
    [listMenu addObject: support];
    
    HomeMenuObject *Orders = [[HomeMenuObject alloc] initWithName:@"Danh sách đơn hàng" icon:@"menu_support" type:eSupport];
    [listMenu addObject: Orders];
    
    HomeMenuObject *Hosting = [[HomeMenuObject alloc] initWithName:@"Đăng ký Hosting" icon:@"menu_support" type:eSupport];
    [listMenu addObject: Hosting];
    
    HomeMenuObject *SSL = [[HomeMenuObject alloc] initWithName:@"Đăng ký SSL" icon:@"menu_support" type:eSupport];
    [listMenu addObject: SSL];
    
    HomeMenuObject *Email = [[HomeMenuObject alloc] initWithName:@"Đăng ký Email" icon:@"menu_support" type:eSupport];
    [listMenu addObject: Email];
    
    HomeMenuObject *VPS = [[HomeMenuObject alloc] initWithName:@"Đăng ký VPS" icon:@"menu_support" type:eSupport];
    [listMenu addObject: VPS];
    
    HomeMenuObject *CloudServer = [[HomeMenuObject alloc] initWithName:@"Đăng ký Cloud Server" icon:@"menu_support" type:eSupport];
    [listMenu addObject: CloudServer];
}

- (void)setupUIForView {
    self.view.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    //  self.edgesForExtendedLayout = UIRectEdgeNone;
    float paddingY = 10.0;
    float padding = 20.0;
    float hWallet = 55.0;
    if ([DeviceUtils isiPhoneXAndNewer]) {
        hWallet = 70.0;
    }
    
    float hStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hTextfield = 34.0;
    hNav = self.navigationController.navigationBar.frame.size.height;
    hSearch = hStatusBar + hNav;
    
    [viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hSearch);
    }];
    
    tfSearch.backgroundColor = [UIColor colorWithRed:(40/255.0) green:(123/255.0) blue:(229/255.0) alpha:1.0];
    tfSearch.font = [AppDelegate sharedInstance].fontDesc;
    tfSearch.layer.cornerRadius = hTextfield/2;
    tfSearch.textColor = tfSearch.tintColor = BORDER_COLOR;
    
    tfSearch.delegate = self;
    tfSearch.returnKeyType = UIReturnKeyDone;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewSearch).offset(hStatusBar+(hSearch - hStatusBar - hTextfield)/2);
        make.left.equalTo(self.viewSearch).offset(padding);
        make.right.equalTo(self.viewSearch.mas_right).offset(-hNav);
        make.height.mas_equalTo(hTextfield);
    }];
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    tfSearch.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfSearch.rightViewMode = UITextFieldViewModeAlways;
    
    [AppUtils setPlaceholder:@"Tìm kiếm tên miền" textfield:tfSearch color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    
    //  image search
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hTextfield);
    }];
    
    //  header view
    NSArray *arr = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_banner"];
    if (arr.count > 0) {
        NSDictionary *info = [arr firstObject];
        NSString *image = [info objectForKey:@"image"];
        
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:image]];
        UIImage *banner = [UIImage imageWithData: imgData];
        hHeader = SCREEN_WIDTH * banner.size.height / banner.size.width;
        imgBanner.image = banner;
    }
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(viewSearch.mas_bottom);
        make.height.mas_equalTo(hHeader);
    }];
    
    //  scrollview content
    scvContent.showsVerticalScrollIndicator = FALSE;
    scvContent.showsHorizontalScrollIndicator = FALSE;
    scvContent.delegate = self;
    scvContent.backgroundColor = UIColor.whiteColor;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBanner.mas_bottom);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  wallet info view
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hWallet);
    }];
    
    UITapGestureRecognizer *tapOnMainWallet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnMainWallet)];
    viewMainWallet.userInteractionEnabled = TRUE;
    [viewMainWallet addGestureRecognizer: tapOnMainWallet];
    
    [viewMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.viewWallet);
        make.right.equalTo(self.viewWallet.mas_centerX);
    }];
    
    [imgMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewMainWallet).offset(10.0);
        make.centerY.equalTo(self.viewMainWallet.mas_centerY);
        make.width.height.mas_equalTo(36.0);
    }];
    
    
    lbMainWallet.textColor = lbBonusWallet.textColor = TITLE_COLOR;
    lbMainWallet.font = lbBonusWallet.font = [AppDelegate sharedInstance].fontNormal;
    
    lbMoneyMain.textColor = lbMoneyBonus.textColor = ORANGE_COLOR;
    lbMoneyMain.font = lbMoneyBonus.font = [AppDelegate sharedInstance].fontMediumDesc;
    
    lbMainWallet.text = @"Tài khoản chính";
    [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgMainWallet.mas_right).offset(5.0);
        make.bottom.equalTo(self.viewMainWallet.mas_centerY);
        make.right.equalTo(self.viewMainWallet);
    }];
    
    lbMoneyMain.text = @"";
    [lbMoneyMain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbMainWallet);
        make.top.equalTo(self.viewMainWallet.mas_centerY);
    }];
    
    //  rewards view
    UITapGestureRecognizer *tapOnPoints = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBonusAccount)];
    viewBonusWallet.userInteractionEnabled = TRUE;
    [viewBonusWallet addGestureRecognizer: tapOnPoints];
    
    [viewBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.viewWallet);
        make.left.equalTo(self.viewWallet.mas_centerX);
    }];
    
    [imgBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewBonusWallet).offset(10.0);
        make.centerY.equalTo(self.viewBonusWallet.mas_centerY);
        make.width.equalTo(self.imgMainWallet.mas_width);
        make.height.equalTo(self.imgMainWallet.mas_height);
    }];
    
    lbBonusWallet.text = @"Tiền thưởng";
    [lbBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgBonusWallet.mas_right).offset(5.0);
        make.bottom.equalTo(self.viewBonusWallet.mas_centerY);
        make.right.equalTo(self.viewBonusWallet);
    }];
    
    lbMoneyBonus.text = @"";
    [lbMoneyBonus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbBonusWallet);
        make.top.equalTo(self.viewBonusWallet.mas_centerY);
    }];
    
    lbSepa.text = @"";
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(viewWallet);
        make.height.mas_equalTo(2.0);
    }];
    
    hMenu = 100;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    clvMenu.collectionViewLayout = layout;
    
    clvMenu.delegate = self;
    clvMenu.dataSource = self;
    clvMenu.backgroundColor = UIColor.whiteColor;
    [clvMenu registerNib:[UINib nibWithNibName:@"NewHomeMenuCell" bundle:nil] forCellWithReuseIdentifier:@"NewHomeMenuCell"];
    
    float hMenuView = [self getHeightOfMenuView];
    clvMenu.scrollEnabled = FALSE;
    [clvMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_bottom);
        make.left.equalTo(scvContent);
        //  make.bottom.equalTo(scvContent);
        make.height.mas_equalTo(hMenuView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hWallet + hMenuView);
}

- (void)changeNumOfLine {
    if (numOfLine == 3) {
        numOfLine = 4;
    }else{
        numOfLine = 3;
    }
    [self setupUIForView];
    [clvMenu reloadData];
    [self showUserWalletView];
}

- (void)whenTapOnMainWallet {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    topupVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: topupVC animated:YES];
}

- (void)whenTapOnBonusAccount {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    BonusAccountViewController *bonusAccVC = [[BonusAccountViewController alloc] initWithNibName:@"BonusAccountViewController" bundle:nil];
    bonusAccVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: bonusAccVC animated:YES];
}

- (float)getHeightOfMenuView {
    int numLine = (int)listMenu.count/numOfLine;
    float surPlus = listMenu.count % numOfLine;
    if (surPlus > 0) {
        numLine++;
    }
    return numLine * hMenu;
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return listMenu.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NewHomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewHomeMenuCell" forIndexPath:indexPath];
    
    HomeMenuObject *menu = [listMenu objectAtIndex: indexPath.row];
    cell.lbName.text = menu.menuName;
    cell.imgType.image = [UIImage imageNamed: menu.menuIcon];
    
    if ((indexPath.row + 1) % numOfLine == 0) {
        cell.lbSepaRight.hidden = TRUE;
    }else{
        cell.lbSepaRight.hidden = FALSE;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
    /*
    switch (indexPath.row) {
        case eRegisterDomain:{
            RegisterDomainViewController *registerDomainVC = [[RegisterDomainViewController alloc] initWithNibName:@"RegisterDomainViewController" bundle:nil];
            registerDomainVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: registerDomainVC animated:YES];
            
            break;
        }
        case ePricingDomain:{
            PricingDomainViewController *pricingVC = [[PricingDomainViewController alloc] initWithNibName:@"PricingDomainViewController" bundle:nil];
            pricingVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: pricingVC animated:YES];
            break;
        }
        case eSearchDomain:{
            WhoIsViewController *whoIsVC = [[WhoIsViewController alloc] initWithNibName:@"WhoIsViewController" bundle:nil];
            whoIsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: whoIsVC animated:YES];
            break;
        }
        case eRecharge:{
            TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
            topupVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: topupVC animated:YES];
            break;
        }
        case eRewardsPoints:{
            BonusAccountViewController *bonusAccVC = [[BonusAccountViewController alloc] initWithNibName:@"BonusAccountViewController" bundle:nil];
            bonusAccVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: bonusAccVC animated:YES];
            break;
        }
        case eManagerDomain:{
            RenewedDomainViewController *renewedVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
            renewedVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: renewedVC animated:YES];
            break;
        }
        case eWithdrawal:{
            WithdrawalBonusAccountViewController *withdrawVC = [[WithdrawalBonusAccountViewController alloc] initWithNibName:@"WithdrawalBonusAccountViewController" bundle:nil];
            withdrawVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: withdrawVC animated:YES];
            break;
        }
        case eProfile:{
            ProfileManagerViewController *profileVC = [[ProfileManagerViewController alloc] initWithNibName:@"ProfileManagerViewController" bundle:nil];
            profileVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: profileVC animated:YES];
            break;
        }
        case eSupport:{
            SupportViewController *supportVC = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
            supportVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: supportVC animated:YES];
            
            break;
        }
        default:
        break;
    }   */
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/numOfLine, hMenu);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

#pragma mark - Scrollview delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    
    if(translation.y > 0)
    {
        NSLog(@"react to dragging down");
        // react to dragging down
    } else
    {
        NSLog(@"react to dragging up");
        // react to dragging up
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if(translation.y > 0)
    {
        // react to dragging down
        if (scrollView.frame.origin.y + fabs(scrollView.contentOffset.y) < (viewSearch.frame.origin.y + hSearch + hHeader)){
            float newOriginY = scvContent.frame.origin.y + fabs(scrollView.contentOffset.y);
            scvContent.frame = CGRectMake(scvContent.frame.origin.x, newOriginY, scvContent.frame.size.width, SCREEN_HEIGHT-(newOriginY + self.tabBarController.tabBar.frame.size.height));
            scvContent.contentOffset = CGPointMake(0, 0);
            
            imgBanner.frame = CGRectMake(0, viewSearch.frame.origin.y+hSearch, imgBanner.frame.size.width, newOriginY - (viewSearch.frame.origin.y+hSearch));
        }else{
            imgBanner.frame = CGRectMake(0, viewSearch.frame.origin.y+hSearch, imgBanner.frame.size.width, hHeader);
            
            scvContent.frame = CGRectMake(scrollView.frame.origin.x, imgBanner.frame.origin.y + hHeader, scrollView.frame.size.width, SCREEN_HEIGHT-(hSearch + hHeader + self.tabBarController.tabBar.frame.size.height));
            scvContent.contentOffset = CGPointMake(0, 0);
        }
    } else
    {
        //  react to dragging up
        if (scrollView.frame.origin.y - scrollView.contentOffset.y > (viewSearch.frame.origin.y + hSearch)) {
            float newOriginY = scvContent.frame.origin.y-scrollView.contentOffset.y;
            scvContent.contentOffset = CGPointMake(0, 0);
            scvContent.frame = CGRectMake(scvContent.frame.origin.x, newOriginY, scvContent.frame.size.width, SCREEN_HEIGHT-(newOriginY + self.tabBarController.tabBar.frame.size.height));
            
            imgBanner.frame = CGRectMake(0, viewSearch.frame.origin.y+hSearch, imgBanner.frame.size.width, newOriginY - imgBanner.frame.origin.y);
        }else{
            imgBanner.frame = CGRectMake(0, viewSearch.frame.origin.y+hSearch, imgBanner.frame.size.width, 0);
            scvContent.contentOffset = CGPointMake(0, 0);
            scvContent.frame = CGRectMake(scrollView.frame.origin.x, imgBanner.frame.origin.y, scrollView.frame.size.width, SCREEN_HEIGHT-(hSearch + self.tabBarController.tabBar.frame.size.height));
            
        }
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if(translation.y > 0){
        if (scrollView.frame.origin.y > imgBanner.frame.origin.y) {
            [UIView animateWithDuration:0.2 animations:^{
                imgBanner.frame = CGRectMake(imgBanner.frame.origin.x, viewSearch.frame.origin.y+hSearch, imgBanner.frame.size.width, hHeader);
                scrollView.frame = CGRectMake(scrollView.frame.origin.x, imgBanner.frame.origin.y+hHeader, scrollView.frame.size.width, SCREEN_HEIGHT-(hSearch + hHeader + self.tabBarController.tabBar.frame.size.height));
            }];
        }
        NSLog(@"react to dragging down");

    } else {
        if (scrollView.frame.origin.y < imgBanner.frame.origin.y + hHeader) {
            [UIView animateWithDuration:0.2 animations:^{
                imgBanner.frame = CGRectMake(imgBanner.frame.origin.x, viewSearch.frame.origin.y+hSearch, imgBanner.frame.size.width, 0);
                scrollView.frame = CGRectMake(scrollView.frame.origin.x, imgBanner.frame.origin.y, scrollView.frame.size.width, SCREEN_HEIGHT-(hSearch + self.tabBarController.tabBar.frame.size.height));
            }];
        }

        NSLog(@"react to dragging up");
    }
}

@end
