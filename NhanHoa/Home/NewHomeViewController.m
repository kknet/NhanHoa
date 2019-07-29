//
//  NewHomeViewController.m
//  NhanHoa
//
//  Created by OS on 7/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewHomeViewController.h"
#import "HomeMenuObject.h"
#import "HomeMenuCell.h"

@interface NewHomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITextFieldDelegate>{
    NSMutableArray *listMenu;
    float hMenu;
    float hHeader;
    int numOfLine;
}

@end

@implementation NewHomeViewController
@synthesize viewSearch, tfSearch, icSearch;
@synthesize viewHeader;
@synthesize scvContent, viewWallet, viewMainWallet, imgMainWallet, lbMainWallet, lbMoneyMain, viewBonusWallet, imgBonusWallet, lbBonusWallet, lbMoneyBonus, lbSepa;
@synthesize clvMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    numOfLine = 4;
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
    float hNav = self.navigationController.navigationBar.frame.size.height;
    float hSearch = hStatusBar + hNav;
    
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
    hHeader = 70.0;
    viewHeader.backgroundColor = BORDER_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewSearch.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    //  scrollview content
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
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
    UITapGestureRecognizer *tapOnPoints = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPoints)];
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
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [clvMenu registerNib:[UINib nibWithNibName:@"HomeMenuCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMenuCell"];
    
    float hMenuView = [self getHeightOfMenuView];
    [clvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_bottom);
        make.left.equalTo(scvContent);
        //  make.bottom.equalTo(scvContent);
        make.height.mas_equalTo(hMenuView);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hWallet + hMenuView);
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
    HomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMenuCell" forIndexPath:indexPath];
    
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

@end
