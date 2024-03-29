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
    
    float padding = 15.0;
    float hTitle = 50.0;
    
    wCell = SCREEN_WIDTH/4;
    hCell = 100.0;
    if (IS_IPHONE || IS_IPOD)
    {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            hCell = 80.0;
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
            hCell = 80.0;
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
            hCell = 90.0;
        }
    }
    
    hContent = 10.0 + hTitle + 10.0 + (hCell*3 + 2*15.0) + 10.0 + [AppDelegate sharedInstance].safeAreaBottomPadding;
    
    viewContent.layer.cornerRadius = 15.0;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.right.equalTo(self);
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
    layout.minimumLineSpacing = 0.0;
    layout.minimumInteritemSpacing = 0;
    clvMenu.collectionViewLayout = layout;
    
    clvMenu.scrollEnabled = FALSE;
    clvMenu.delegate = self;
    clvMenu.dataSource = self;
    clvMenu.backgroundColor = UIColor.clearColor;
    [clvMenu registerNib:[UINib nibWithNibName:@"HomeMenuClvCell" bundle:nil] forCellWithReuseIdentifier:@"HomeMenuClvCell"];
    [clvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(10.0);
        make.left.equalTo(viewContent).offset(0);
        make.right.equalTo(viewContent).offset(-0);
        make.bottom.equalTo(viewContent).offset(-10.0-[AppDelegate sharedInstance].safeAreaBottomPadding);
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
    return 9;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeMenuClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMenuClvCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case eExploreDomain:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Domains"];
            cell.imgType.image = [UIImage imageNamed:@"menu_domains"];
            break;
        }
        case eExploreHosting:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Hosting"];
            cell.imgType.image = [UIImage imageNamed:@"menu_hosting"];
            break;
        }
        case eExploreCloudVPS:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Cloud VPS"];
            cell.imgType.image = [UIImage imageNamed:@"menu_vps"];
            break;
        }
        case eExploreCloudServer:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Cloud server"];
            cell.imgType.image = [UIImage imageNamed:@"menu_cloud_server"];
            break;
        }
        case eExploreManagerDomains:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Domain management"];
            cell.imgType.image = [UIImage imageNamed:@"menu_domains_management"];
            break;
        }
            
        case eExploreEmail:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Email"];
            cell.imgType.image = [UIImage imageNamed:@"menu_register_email"];
            break;
        }
            
        case eExploreOrders:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Orders"];
            cell.imgType.image = [UIImage imageNamed:@"menu_invoices"];
            break;
        }
            
        case eExploreSSL:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"SSL"];
            cell.imgType.image = [UIImage imageNamed:@"menu_ssl"];
            break;
        }
            
        case eExploreProfiles:{
            cell.lbMenu.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Profiles"];
            cell.imgType.image = [UIImage imageNamed:@"menu_profiles"];
            break;
        }
        
        default:
            break;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([delegate respondsToSelector:@selector(selectedMenuFromExploreView:)]) {
        [delegate selectedMenuFromExploreView: (ExploreType)indexPath.row];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(wCell, hCell);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
