//
//  HomeViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeViewController.h"
#import "RegisterDomainViewController.h"
#import "WhoIsViewController.h"
#import "RenewedDomainViewController.h"
#import "CartViewController.h"
#import "TopupViewController.h"
#import "BonusAccountViewController.h"
#import "WithdrawalBonusAccountViewController.h"
#import "ProfileManagerViewController.h"
#import "SupportViewController.h"
#import "NotifyViewController.h"
#import "HomeMenuCell.h"
#import "HomeMenuObject.h"
#import "CartModel.h"
#import "AccountModel.h"
#import <CommonCrypto/CommonDigest.h>

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    NSMutableArray *listMenu;
    float hBanner;
}

@end

@implementation NSString (MD5)
- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (int)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

@implementation HomeViewController
@synthesize viewSearch, tfSearch, icNotify, icClear, btnSearch, icCart, lbCount;
@synthesize viewWallet,viewMainWallet, imgMainWallet, lbMainWallet, lbMoney;
@synthesize viewRewards, imgRewards, lbRewards, lbRewardsPoints, clvMenu;
@synthesize hMenu, viewBanner;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createDataForMenuView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
    
    [WriteLogsUtils writeForGoToScreen: @"HomeViewController"];
    
    [self setupUIForView];
    
    //  Show cart item
    [[CartModel getInstance] displayCartInfoWithView: lbCount];
    [self showUserWalletView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (self.navigationController.navigationBar.frame.size.height > 0) {
        [AppDelegate sharedInstance].hNav = self.navigationController.navigationBar.frame.size.height;
    }else{
        [AppDelegate sharedInstance].hNav = 50.0;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden: NO];
    [viewBanner.slideTimer invalidate];
    viewBanner.slideTimer = nil;
    [viewBanner removeFromSuperview];
    viewBanner = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)icNotifyClick:(UIButton *)sender {
    NotifyViewController *notifyVC = [[NotifyViewController alloc] initWithNibName:@"NotifyViewController" bundle:nil];
    notifyVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:notifyVC animated:YES];
}

- (IBAction)icClearClick:(UIButton *)sender {
}

- (IBAction)icCartClick:(UIButton *)sender {
    CartViewController *cartVC = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
    cartVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: cartVC animated:YES];
}

- (void)addBannerImageForView
{
    if ([AppDelegate sharedInstance].userInfo != nil)
    {
        float paddingY = 10.0;
        if (viewBanner == nil) {
            NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"BannerSliderView" owner:nil options:nil];
            for(id currentObject in toplevelObject){
                if ([currentObject isKindOfClass:[BannerSliderView class]]) {
                    viewBanner = (BannerSliderView *) currentObject;
                    break;
                }
            }
            [self.view addSubview: viewBanner];
        }
        [viewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.viewSearch.mas_bottom);
            make.bottom.equalTo(self.viewWallet.mas_top).offset(-paddingY);
        }];
        
        viewBanner.hBanner = hBanner;
        [viewBanner setupUIForView];
        [viewBanner showBannersForSliderView];
    }
}

- (void)showUserWalletView {
    NSString *totalBalance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: totalBalance]) {
        totalBalance = [AppUtils convertStringToCurrencyFormat: totalBalance];
        lbMoney.text = [NSString stringWithFormat:@"%@ VNĐ", totalBalance];
    }else{
        lbMoney.text = @"0 VNĐ";
    }
    
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        lbRewardsPoints.text = [NSString stringWithFormat:@"%@ điểm", points];
    }else{
        lbRewardsPoints.text = @"0 điểm";
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
    
    if (indexPath.row == eSearchDomain || indexPath.row == eManagerDomain || indexPath.row == eSupport) {
        cell.lbSepaRight.hidden = YES;
    }else {
        cell.lbSepaRight.hidden = NO;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case eRegisterDomain:{
            RegisterDomainViewController *registerDomainVC = [[RegisterDomainViewController alloc] initWithNibName:@"RegisterDomainViewController" bundle:nil];
            registerDomainVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: registerDomainVC animated:YES];
            
            break;
        }
        case eRenewDomain:{
            RenewedDomainViewController *renewedVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
            renewedVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: renewedVC animated:YES];
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
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH/3, hMenu);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

#pragma mark - Other functions

- (void)createDataForMenuView {
    listMenu = [[NSMutableArray alloc] init];
    
    HomeMenuObject *regDomain = [[HomeMenuObject alloc] initWithName:@"Đăng ký tên miền" icon:@"menu_domain" type:eRegisterDomain];
    [listMenu addObject: regDomain];
    
    HomeMenuObject *renewDomain = [[HomeMenuObject alloc] initWithName:@"Gia hạn tên miền" icon:@"menu_reorder_domain" type:eRenewDomain];
    [listMenu addObject: renewDomain];
    
    HomeMenuObject *searchDomain = [[HomeMenuObject alloc] initWithName:@"Tìm kiếm tên miền" icon:@"menu_search_domain" type:eSearchDomain];
    [listMenu addObject: searchDomain];
    
    HomeMenuObject *recharge = [[HomeMenuObject alloc] initWithName:@"Nạp tiền vào tài khoản" icon:@"menu_recharge" type:eRecharge];
    [listMenu addObject: recharge];
    
    HomeMenuObject *rewardsPoints = [[HomeMenuObject alloc] initWithName:@"Tài khoản thưởng" icon:@"menu_bonus" type:eRewardsPoints];
    [listMenu addObject: rewardsPoints];
    
    HomeMenuObject *managerDomains = [[HomeMenuObject alloc] initWithName:@"Quản lý tên miền" icon:@"menu_list_domain" type:eManagerDomain];
    [listMenu addObject: managerDomains];
    
    HomeMenuObject *withdrawal = [[HomeMenuObject alloc] initWithName:@"Rút tiền thưởng" icon:@"menu_withdrawal" type:eWithdrawal];
    [listMenu addObject: withdrawal];
    
    HomeMenuObject *profile = [[HomeMenuObject alloc] initWithName:@"Hồ sơ cá nhân" icon:@"menu_profile" type:eProfile];
    [listMenu addObject: profile];
    
    HomeMenuObject *support = [[HomeMenuObject alloc] initWithName:@"Hỗ trợ khách hàng" icon:@"menu_support" type:eSupport];
    [listMenu addObject: support];
    
}

- (void)setupUIForView {
    self.view.backgroundColor = [UIColor colorWithRed:(242/255.0) green:(242/255.0) blue:(242/255.0) alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float paddingY = 10.0;
    float padding = 20.0;
    float hWallet = 70.0;
    float hSearch = 70.0;
    
    [viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hSearch);
    }];
    float statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.viewSearch);
        make.top.equalTo(self.viewSearch).offset(statusBarHeight);
        make.width.mas_equalTo(hSearch - statusBarHeight);
    }];
    
    lbCount.clipsToBounds = TRUE;
    lbCount.layer.cornerRadius = 20.0/2;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icCart).offset(3.0);
        make.right.equalTo(self.icCart).offset(-3.0);
        make.width.height.mas_equalTo(20.0);
    }];
    
    icNotify.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [icNotify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icCart);
        make.right.equalTo(self.icCart.mas_left);
        make.width.equalTo(self.icCart.mas_width);
    }];
    
    float hTextfield = 34.0;
    tfSearch.backgroundColor = [UIColor colorWithRed:(40/255.0) green:(123/255.0) blue:(229/255.0) alpha:1.0];
    tfSearch.font = [UIFont fontWithName:@"HelveticateNeue" size:15.0];
    tfSearch.layer.cornerRadius = hTextfield/2;
    tfSearch.textColor = BORDER_COLOR;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewSearch).offset(padding);
        make.right.equalTo(self.icNotify.mas_left);
        make.centerY.equalTo(self.icNotify.mas_centerY);
        make.height.mas_equalTo(hTextfield);
    }];
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    tfSearch.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hTextfield, hTextfield)];
    tfSearch.rightViewMode = UITextFieldViewModeAlways;
    
    [AppUtils setPlaceholder:@"Tìm kiếm" textfield:tfSearch color:[UIColor colorWithRed:(210/255.0) green:(210/255.0) blue:(210/255.0) alpha:1.0]];
    
    //  image search
    btnSearch.imageEdgeInsets = UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5);
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hTextfield);
    }];
    
    hMenu = 100;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    clvMenu.collectionViewLayout = layout;
    
    clvMenu.delegate = self;
    clvMenu.dataSource = self;
    clvMenu.backgroundColor = UIColor.blackColor;
    [clvMenu registerNib:[UINib nibWithNibName:@"HomeMenuCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMenuCell"];
    
    [clvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(3*self.hMenu);
    }];
    
    //  wallet info view
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.clvMenu.mas_top).offset(-paddingY);
        make.left.right.equalTo(self.view);
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
    
    lbMainWallet.text = @"Tài khoản chính";
    lbMainWallet.textColor = TITLE_COLOR;
    lbMainWallet.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgMainWallet.mas_right).offset(5.0);
        make.bottom.equalTo(self.viewMainWallet.mas_centerY);
        make.right.equalTo(self.viewMainWallet);
    }];
    
    lbMoney.text = @"1.200.000 VND";
    lbMoney.textColor = ORANGE_COLOR;
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbMainWallet);
        make.top.equalTo(self.viewMainWallet.mas_centerY);
    }];
    
    //  rewards view
    UITapGestureRecognizer *tapOnPoints = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnPoints)];
    viewRewards.userInteractionEnabled = TRUE;
    [viewRewards addGestureRecognizer: tapOnPoints];
    
    [viewRewards mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.viewWallet);
        make.left.equalTo(self.viewWallet.mas_centerX);
    }];
    
    [imgRewards mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewRewards).offset(10.0);
        make.centerY.equalTo(self.viewRewards.mas_centerY);
        make.width.equalTo(self.imgMainWallet.mas_width);
        make.height.equalTo(self.imgMainWallet.mas_height);
    }];
    
    lbRewards.text = @"Điểm thưởng";
    lbRewards.textColor = TITLE_COLOR;
    lbRewards.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbRewards mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgRewards.mas_right).offset(5.0);
        make.bottom.equalTo(self.viewRewards.mas_centerY);
        make.right.equalTo(self.viewRewards);
    }];
    
    lbRewardsPoints.text = @"76 điểm";
    lbRewardsPoints.textColor = ORANGE_COLOR;
    lbRewardsPoints.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbRewardsPoints mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRewards);
        make.top.equalTo(self.viewRewards.mas_centerY);
    }];
    
    hBanner = SCREEN_HEIGHT - (self.tabBarController.tabBar.frame.size.height + 3*hMenu + hWallet + 2*paddingY + hSearch);
    [self addBannerImageForView];
}

- (void)whenTapOnMainWallet {
    TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
    topupVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: topupVC animated:YES];
}

- (void)whenTapOnPoints {
    BonusAccountViewController *bonusAccVC = [[BonusAccountViewController alloc] initWithNibName:@"BonusAccountViewController" bundle:nil];
    bonusAccVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: bonusAccVC animated:YES];
}


@end
