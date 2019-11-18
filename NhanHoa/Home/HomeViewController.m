//
//  HomeViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchDomainsViewController.h"
#import "SearchMultiDomainsViewController.h"
#import "DomainsViewController.h"
#import "TopupViewController.h"
#import "PricingViewController.h"
#import "HomeMenuCell.h"
#import "HomeMenuObject.h"
#import "CartModel.h"
#import "AccountModel.h"
#import "AudioSessionUtils.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate, WebServiceUtilsDelegate>{
    NSMutableArray *listMenu;
    float hBanner;
    UITextField *tfNumber;
    float hMenu;
    int numOfLine;
    float hTabbar;
    float hSearch;
    float paddingY;
    float padding;
    float hWallet;
}
@end

@implementation HomeViewController
@synthesize viewSearch, tfSearch, btnSearch;
@synthesize viewWallet,viewMainWallet, imgMainWallet, lbMainWallet, lbMoney;
@synthesize viewRewards, imgRewards, lbRewards, lbRewardsPoints, clvMenu;
@synthesize imgBanner;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    numOfLine = 3;
    
    [self createDataForMenuView];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
    
    [WriteLogsUtils writeForGoToScreen: @"HomeViewController"];
    
    [[FIRMessaging messaging] subscribeToTopic:@"/topics/global"];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [self reupdateLayoutForIpadView];
    }
    
    [self showUserWalletView];
    [self createCartViewIfNeed];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showUserWalletView)
                                                 name:@"reloadBalanceInfo" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCallTokenResult:)
                                                 name:@"updateCallTokenResult" object:nil];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (self.navigationController.navigationBar.frame.size.height > 0) {
        [AppDelegate sharedInstance].hNav = self.navigationController.navigationBar.frame.size.height;
    }else{
        [AppDelegate sharedInstance].hNav = 50.0;
    }
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

- (NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {  value |= (0xFF & input[j]);  }  }  NSInteger theIndex = (i / 3) * 4;  output[theIndex + 0] = table[(value >> 18) & 0x3F];
        output[theIndex + 1] = table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6) & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0) & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]; }

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    [self.navigationController setNavigationBarHidden: NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showUserWalletView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    NSString *totalBalance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: totalBalance]) {
        totalBalance = [AppUtils convertStringToCurrencyFormat: totalBalance];
        lbMoney.text = [NSString stringWithFormat:@"%@VNĐ", totalBalance];
    }else{
        lbMoney.text = @"0VNĐ";
    }
    
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        points = [AppUtils convertStringToCurrencyFormat: points];
        lbRewardsPoints.text = [NSString stringWithFormat:@"%@VNĐ", points];
    }else{
        lbRewardsPoints.text = @"0VNĐ";
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

- (void)updateCallTokenResult: (NSNotification *)notif
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] object = %@", __FUNCTION__, @[[notif object]])];
    
    NSDictionary *object = [notif object];
    if ([object isKindOfClass:[NSDictionary class]])
    {
        id success = [object objectForKey:@"success"];
        if ([success boolValue] == TRUE) {
            [AppDelegate sharedInstance].callTokenReady = TRUE;
        }else{
            [AppDelegate sharedInstance].callTokenReady = FALSE;
        }
    }
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    [self getHeightBannerForIPAD];
    [clvMenu reloadData];
    
    [imgBanner mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hBanner);
    }];
}

- (void)reupdateLayoutForIpadView {
    [self getHeightBannerForIPAD];
    [clvMenu reloadData];
    
    [imgBanner mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hBanner);
    }];
}

- (void)getHeightBannerForIPAD {
    int numLine = [self getNumLineForMenuList];
    float heightScreen = [DeviceUtils getHeightOfScreen];
    
    if ([DeviceUtils isLandscapeMode]) {
        hMenu = 100.0;
        hBanner = heightScreen - (hSearch + paddingY + hWallet + paddingY + hTabbar + numLine*hMenu);
    }else{
        hBanner = (heightScreen - hSearch - hTabbar)/2;
        hMenu = (int)((heightScreen - (hSearch + hBanner + paddingY + hWallet + paddingY + hTabbar))/numLine);
    }
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return listMenu.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMenuCell" forIndexPath:indexPath];
    
    HomeMenuObject *menu = [listMenu objectAtIndex: indexPath.row];
    cell.lbName.text = menu.menuName;
    cell.imgType.image = [UIImage imageNamed: menu.menuIcon];
    
    if ((indexPath.row + 1) % numOfLine == 0) {
        cell.lbSepaRight.hidden = TRUE;
    }else{
        cell.lbSepaRight.hidden = FALSE;
    }
    [cell reUpdateLayoutForCell];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
    
    HomeMenuCell *cell = (HomeMenuCell *)[collectionView cellForItemAtIndexPath: indexPath];
    
    NSString *title = cell.lbName.text;
    if ([title isEqualToString: text_register_domains]) {
        SearchDomainsViewController *registerDomainVC = [[SearchDomainsViewController alloc] initWithNibName:@"SearchDomainsViewController" bundle:nil];
        registerDomainVC.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController: registerDomainVC animated:TRUE];
        
    }else if ([title isEqualToString: text_domains_pricing_list])
    {
        PricingViewController *pricingVC = [[PricingViewController alloc] initWithNibName:@"PricingViewController" bundle:nil];
        pricingVC.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController: pricingVC animated:TRUE];
        
    }else if ([title isEqualToString: text_search_domains])
    {
        SearchMultiDomainsViewController *whoIsVC = [[SearchMultiDomainsViewController alloc] initWithNibName:@"SearchMultiDomainsViewController" bundle:nil];
        whoIsVC.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController: whoIsVC animated:TRUE];
        
    }else if ([title isEqualToString: text_top_up_into_account])
    {
        TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
        topupVC.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController: topupVC animated:TRUE];
        
    }else if ([title isEqualToString: text_bonus_account])
    {
        
        
    }else if ([title isEqualToString: text_domains_management])
    {
        DomainsViewController *renewedVC = [[DomainsViewController alloc] initWithNibName:@"DomainsViewController" bundle:nil];
        renewedVC.hidesBottomBarWhenPushed = TRUE;
        [self.navigationController pushViewController: renewedVC animated:TRUE];
        
    }else if ([title isEqualToString: text_draw_bonuses])
    {
        
        
    }else if ([title isEqualToString: text_profiles_list])
    {
        
        
    }else if ([title isEqualToString: text_customers_support])
    {
        
    }
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

#pragma mark - Other functions

- (void)createDataForMenuView {
    if (listMenu == nil) {
        listMenu = [[NSMutableArray alloc] init];
    }else{
        [listMenu removeAllObjects];
    }
    
    HomeMenuObject *regDomain = [[HomeMenuObject alloc] initWithName:text_register_domains icon:@"menu_domain" type:eRegisterDomain];
    [listMenu addObject: regDomain];
    
    HomeMenuObject *renewDomain = [[HomeMenuObject alloc] initWithName:text_domains_pricing_list icon:@"menu_reorder_domain" type:ePricingDomain];
    [listMenu addObject: renewDomain];
    
    HomeMenuObject *searchDomain = [[HomeMenuObject alloc] initWithName:text_search_domains icon:@"menu_search_domain" type:eSearchDomain];
    [listMenu addObject: searchDomain];
    
    HomeMenuObject *recharge = [[HomeMenuObject alloc] initWithName:text_top_up_into_account icon:@"menu_recharge" type:eRecharge];
    [listMenu addObject: recharge];
    
    HomeMenuObject *rewardsPoints = [[HomeMenuObject alloc] initWithName:text_bonus_account icon:@"menu_bonus" type:eRewardsPoints];
    [listMenu addObject: rewardsPoints];
    
    HomeMenuObject *managerDomains = [[HomeMenuObject alloc] initWithName:text_domains_management icon:@"menu_list_domain" type:eManagerDomain];
    [listMenu addObject: managerDomains];
    
    HomeMenuObject *withdrawal = [[HomeMenuObject alloc] initWithName:text_draw_bonuses icon:@"menu_withdrawal" type:eWithdrawal];
    [listMenu addObject: withdrawal];
    
    HomeMenuObject *profile = [[HomeMenuObject alloc] initWithName:text_profiles_list icon:@"menu_profile" type:eProfile];
    [listMenu addObject: profile];
    
    HomeMenuObject *support = [[HomeMenuObject alloc] initWithName:text_customers_support icon:@"menu_support" type:eSupport];
    [listMenu addObject: support];
    
}

- (void)setupUIForView {
    self.view.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    //  self.edgesForExtendedLayout = UIRectEdgeNone;
    hTabbar = self.tabBarController.tabBar.frame.size.height;
    paddingY = 10.0;
    padding = 20.0;
    hWallet = 55.0;
    if ([DeviceUtils isiPhoneXAndNewer]) {
        hWallet = 70.0;
    }
    
    float hStatusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hTextfield = 34.0;
    float hNav = self.navigationController.navigationBar.frame.size.height;
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
        make.top.equalTo(viewSearch).offset(hStatusBar+(hSearch - hStatusBar - hTextfield)/2);
        make.left.equalTo(viewSearch).offset(padding);
        make.right.equalTo(viewSearch.mas_right).offset(-hNav);
        make.height.mas_equalTo(hTextfield);
    }];
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    tfSearch.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfSearch.rightViewMode = UITextFieldViewModeAlways;
    
    [AppUtils setPlaceholder:@"Tìm kiếm tên miền" textfield:tfSearch color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    
    //  image search
    btnSearch.imageEdgeInsets = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(hTextfield);
    }];
    
    //
    UIImage *banner = [AccountModel getBannerPhotoFromUser];
    imgBanner.image = banner;
    hBanner = SCREEN_WIDTH * banner.size.height / banner.size.width;
    
    int numLine = [self getNumLineForMenuList];
    hMenu = (SCREEN_HEIGHT - (hSearch + hBanner + paddingY + hWallet + paddingY + hTabbar))/numLine;
    if (hMenu < 100 && (IS_IPHONE || IS_IPOD)) {
        if ([DeviceUtils isScreen320]) {
            hMenu = 80.0;
        }else if ([DeviceUtils isScreen375]){
            hMenu = 92;
        }else{
            hMenu = 100.0;
        }
        paddingY = 5.0;
        hBanner = SCREEN_HEIGHT - (hTabbar + 3*hMenu + hWallet + 2*paddingY + hSearch);
    }
    if (!IS_IPHONE && !IS_IPOD) {
        [self getHeightBannerForIPAD];
    }
    
    [imgBanner mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(viewSearch.mas_bottom);
        //  make.bottom.equalTo(viewWallet.mas_top).offset(-paddingY);
        make.height.mas_equalTo(hBanner);
    }];
    
    //  wallet info view
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBanner.mas_bottom).offset(paddingY);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hWallet);
    }];
    
    UITapGestureRecognizer *tapOnMainWallet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnMainWallet)];
    viewMainWallet.userInteractionEnabled = TRUE;
    [viewMainWallet addGestureRecognizer: tapOnMainWallet];
    
    [viewMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(viewWallet);
        make.right.equalTo(viewWallet.mas_centerX);
    }];
    
    [imgMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMainWallet).offset(10.0);
        make.centerY.equalTo(viewMainWallet.mas_centerY);
        make.width.height.mas_equalTo(36.0);
    }];
    
    
    lbMainWallet.textColor = lbRewards.textColor = TITLE_COLOR;
    lbMoney.textColor = lbRewardsPoints.textColor = ORANGE_COLOR;
    lbMainWallet.font = lbRewards.font = [AppDelegate sharedInstance].fontNormal;
    lbMoney.font = lbRewardsPoints.font = [AppDelegate sharedInstance].fontRegular;
    
    lbMainWallet.text = [NSString stringWithFormat:@"%@: ", text_main_account];
    lbMoney.text = @"";
    
    if (!IS_IPHONE && !IS_IPOD) {
        lbMainWallet.font = [UIFont fontWithName:RobotoRegular size:18.0];
        lbMoney.font = [UIFont fontWithName:RobotoRegular size:24.0];
        
        float sizeText = [AppUtils getSizeWithText:text_main_account withFont:lbMainWallet.font].width + 10.0;
        [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgMainWallet.mas_right).offset(5.0);
            make.top.bottom.equalTo(viewMainWallet);
            make.width.mas_equalTo(sizeText);
        }];
        
        [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbMainWallet.mas_right).offset(5.0);
            make.top.bottom.equalTo(lbMainWallet);
            make.right.equalTo(viewMainWallet).offset(-5.0);
        }];
    }else{
        [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgMainWallet.mas_right).offset(5.0);
            make.bottom.equalTo(viewMainWallet.mas_centerY);
            make.right.equalTo(viewMainWallet);
        }];
        
        [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(lbMainWallet);
            make.top.equalTo(viewMainWallet.mas_centerY);
        }];
        
    }
    
    //  rewards view
    UITapGestureRecognizer *tapOnPoints = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPoints)];
    viewRewards.userInteractionEnabled = TRUE;
    [viewRewards addGestureRecognizer: tapOnPoints];
    
    [viewRewards mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(viewWallet);
        make.left.equalTo(viewWallet.mas_centerX);
    }];
    
    [imgRewards mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewRewards).offset(10.0);
        make.centerY.equalTo(viewRewards.mas_centerY);
        make.width.equalTo(imgMainWallet.mas_width);
        make.height.equalTo(imgMainWallet.mas_height);
    }];
    
    lbRewards.text = [NSString stringWithFormat:@"%@:", text_bonus_money];
    if (!IS_IPHONE && !IS_IPOD) {
        lbRewards.font = [UIFont fontWithName:RobotoRegular size:18.0];
        lbRewardsPoints.font = [UIFont fontWithName:RobotoRegular size:24.0];
        
        float sizeText = [AppUtils getSizeWithText:text_bonus_money withFont:lbRewards.font].width + 10.0;
        [lbRewards mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgRewards.mas_right).offset(5.0);
            make.top.bottom.equalTo(viewRewards);
            make.width.mas_equalTo(sizeText);
        }];
        
        [lbRewardsPoints mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbRewards.mas_right).offset(5.0);
            make.top.bottom.equalTo(lbRewards);
            make.right.equalTo(viewRewards).offset(-5.0);
        }];
    }else{
        [lbRewards mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgRewards.mas_right).offset(5.0);
            make.bottom.equalTo(viewRewards.mas_centerY);
            make.right.equalTo(viewRewards);
        }];
        
        lbRewardsPoints.text = @"";
        [lbRewardsPoints mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(lbRewards);
            make.top.equalTo(viewRewards.mas_centerY);
        }];
    }
    
    //  collection view
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    clvMenu.collectionViewLayout = layout;
    
    clvMenu.delegate = self;
    clvMenu.dataSource = self;
    clvMenu.backgroundColor = UIColor.whiteColor;
    [clvMenu registerNib:[UINib nibWithNibName:@"HomeMenuCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMenuCell"];
    [clvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_bottom).offset(paddingY);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-hTabbar);
    }];
}

- (int)getNumLineForMenuList {
    int result = (int)(listMenu.count / numOfLine);
    int plus = listMenu.count % numOfLine;
    if (plus > 0) {
        result += 1;
    }
    return result;
}

- (void)whenTapOnMainWallet {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    topupVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: topupVC animated:YES];
}

- (void)whenTapOnPoints {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

- (IBAction)btnSearchPress:(UIButton *)sender {
    
}

#pragma mark - Webservice Delegate

-(void)loginSucessfulWithData:(NSDictionary *)data {
    if (![AppDelegate sharedInstance].callTokenReady) {
        if (![AppUtils isNullOrEmpty: [AppDelegate sharedInstance].callToken]) {
            NSString *token = [NSString stringWithFormat:@"ios%@", [AppDelegate sharedInstance].callToken];
            [WriteLogsUtils writeLogContent:SFM(@"[%s] UPDATE TOKEN FOR CALL: %@", __FUNCTION__, token)];
            
            [[WebServiceUtils getInstance] updateTokenForCallWithToken: token];
        }else{
            [WriteLogsUtils writeLogContent:SFM(@"[%s] WARNING!!!!!!!!!!!! CAN NOT GET TOKEN FOR CALL", __FUNCTION__)];
        }
    }
    
    //  save password for get acc voip (used when app was killed)
    [AccountModel storePasswordForAccount];
}

@end
