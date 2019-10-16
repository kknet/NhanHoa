//
//  HomeSliderView.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeSliderView.h"
#import "HomeSliderClvCell.h"

@implementation HomeSliderView
@synthesize clvBanner, viewInfo, bgInfo, lbTitle, lbContent, icNext;
@synthesize hContentView, padding, hCollectionView, listImages;

- (void)setupUIForViewWithList: (NSArray *)contentList
{
    UIFont *textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
        {
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
        {
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            
        }else{
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
        }
    }else{
        textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
    }
    
    padding = 15.0;
    if (contentList.count > 0) {
        listImages = [[NSArray alloc] initWithArray: contentList];
        
        UIImage *firstImg = [contentList firstObject];
        hCollectionView = (SCREEN_WIDTH - 2*padding) * firstImg.size.height / firstImg.size.width;
    }else{
        listImages = [[NSArray alloc] init];
        
        hCollectionView = 120.0;
    }
    
    self.backgroundColor = [UIColor colorWithRed:(234/255.0) green:(239/255.0) blue:(247/255.0) alpha:1.0];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    clvBanner.collectionViewLayout = layout;
    clvBanner.delegate = self;
    clvBanner.dataSource = self;
    [clvBanner registerNib:[UINib nibWithNibName:@"HomeSliderClvCell" bundle:nil] forCellWithReuseIdentifier:@"HomeSliderClvCell"];
    
    clvBanner.showsHorizontalScrollIndicator = FALSE;
    clvBanner.pagingEnabled = TRUE;
    clvBanner.layer.cornerRadius = 10.0;
    clvBanner.clipsToBounds = TRUE;
    [clvBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7.5);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hCollectionView);
    }];
    
    UIImage *image = [UIImage imageNamed:@"bg_banner_item"];
    float hImage = (SCREEN_WIDTH - 2*padding) * image.size.height / image.size.width;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvBanner.mas_bottom).offset(10.0);
        make.left.right.equalTo(clvBanner);
        make.height.mas_equalTo(hImage);
    }];
    
    [bgInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewInfo);
    }];
    
    float wTitle = (SCREEN_WIDTH - 6*padding)/3;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewInfo);
        make.left.equalTo(viewInfo).offset(padding);
        make.width.mas_equalTo(wTitle);
    }];
    
    icNext.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(viewInfo.mas_centerY);
        make.right.equalTo(viewInfo).offset(-padding+5.0);
        make.width.height.mas_equalTo(35.0);
    }];
    
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewInfo);
        make.left.equalTo(lbTitle.mas_right).offset(2*padding);
        make.right.equalTo(icNext.mas_left).offset(-5.0);
    }];
    
    hContentView = 7.5 + hCollectionView + 10.0 + hImage + 7.5;
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return listImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeSliderClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSliderClvCell" forIndexPath:indexPath];
    
    cell.imgPicture.image = [listImages objectAtIndex: indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH - 2*padding, hCollectionView);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
