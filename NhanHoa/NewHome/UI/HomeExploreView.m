//
//  HomeExploreView.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeExploreView.h"
#import "HomeMenuClvCell.h"

@implementation HomeExploreView
@synthesize lbTransparent, viewContent, lbTitle, clvMenu, lbBottom;
@synthesize hCell, wCell, hContent, delegate;

- (void)setupUIForView {
    self.backgroundColor = UIColor.clearColor;
    
    UITapGestureRecognizer *tapToClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    lbTransparent.userInteractionEnabled = TRUE;
    [lbTransparent addGestureRecognizer: tapToClose];
    
    lbTransparent.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [lbTransparent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    hCell = 70.0;
    wCell = 60.0;
    
    float padding = 15.0;
    float hTitle = 50.0;
    
    hContent = 10.0 + hTitle + 10.0 + (hCell*3 + 2*15.0) + 10.0;
    
    viewContent.layer.cornerRadius = 10.0;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.equalTo(self).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
        make.height.mas_equalTo(hContent);
    }];
    
    lbTitle.text = SFM(@"%@ Nhân Hòa", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Explore"]);
    lbTitle.font = [UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.top.equalTo(viewContent).offset(10.0);
        make.height.mas_equalTo(hTitle);
    }];
    
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
        make.top.equalTo(lbTitle.mas_bottom).offset(10.0);
        make.left.equalTo(viewContent).offset(padding+5.0);
        make.right.equalTo(viewContent).offset(-padding-5.0);
        make.bottom.equalTo(viewContent).offset(-10.0);
    }];
    
    lbBottom.backgroundColor = viewContent.backgroundColor;
    [lbBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(viewContent);
        make.height.mas_equalTo(25.0);
    }];
}

- (void)closeView {
    if ([delegate respondsToSelector:@selector(closeExploreView)]) {
        [delegate closeExploreView];
    }
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 12;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeMenuClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMenuClvCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case eExploreDomain:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Domains"];
            cell.imgType.image = [UIImage imageNamed:@"menu_domains"];
            break;
        }
        case eExploreCloudServer:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Cloud server"];
            cell.imgType.image = [UIImage imageNamed:@"menu_cloud_server"];
            break;
        }
        case eExploreVfone:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Vfone"];
            cell.imgType.image = [UIImage imageNamed:@"menu_vfone"];
            break;
        }
        case eExploreOrders:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Invoices"];
            cell.imgType.image = [UIImage imageNamed:@"menu_invoices"];
            break;
        }
        case eExploreProfiles:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Profiles"];
            cell.imgType.image = [UIImage imageNamed:@"menu_profiles"];
            break;
        }
        case eExploreEmail:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Register email"];
            cell.imgType.image = [UIImage imageNamed:@"menu_register_email"];
            break;
        }
        case eExploreHosting:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Hosting"];
            cell.imgType.image = [UIImage imageNamed:@"menu_hosting"];
            break;
        }
        case eExploreSSL:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"SSL"];
            cell.imgType.image = [UIImage imageNamed:@"menu_more"];
            break;
        }
        case eExploreVPS:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"VPS"];
            cell.imgType.image = [UIImage imageNamed:@"menu_more"];
            break;
        }
        case eExploreManagerDomains:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Domains management"];
            cell.imgType.image = [UIImage imageNamed:@"menu_more"];
            break;
        }
        case eExplorePricingDomains:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Pricing domains"];
            cell.imgType.image = [UIImage imageNamed:@"menu_more"];
            break;
        }
        case eExploreCheckDomains:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Search domains"];
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
    return CGSizeMake(wCell, hCell);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
