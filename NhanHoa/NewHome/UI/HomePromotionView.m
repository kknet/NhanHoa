//
//  HomePromotionView.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomePromotionView.h"
#import "HomePromotionClvCell.h"

@implementation HomePromotionView
@synthesize lbTitle, btnAll, clvContent;
@synthesize hContentView, hCollectionView;

- (void)setupUIForView
{
    UIFont *textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
    
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            textFont = [UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium];
            
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
    
    self.backgroundColor = [UIColor colorWithRed:(251/255.0) green:(252/255.0) blue:(254/255.0) alpha:1.0];
    float padding = 15.0;
    float hBTN = 40.0;
    hCollectionView = 200.0;
    
    lbTitle.textColor = [UIColor colorWithRed:(48/255.0) green:(48/255.0) blue:(48/255.0) alpha:1.0];
    
    
    btnAll.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    [btnAll setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"All"]
            forState:UIControlStateNormal];
    [btnAll setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(padding);
        make.height.mas_equalTo(hBTN);
        make.width.mas_equalTo(80.0);
    }];
    
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(btnAll);
        make.right.equalTo(btnAll.mas_left);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    clvContent.collectionViewLayout = layout;
    clvContent.delegate = self;
    clvContent.dataSource = self;
    [clvContent registerNib:[UINib nibWithNibName:@"HomePromotionClvCell" bundle:nil] forCellWithReuseIdentifier:@"HomePromotionClvCell"];
    clvContent.backgroundColor = UIColor.clearColor;
    clvContent.showsHorizontalScrollIndicator = FALSE;
    clvContent.layer.cornerRadius = 10.0;
    clvContent.clipsToBounds = TRUE;
    
    [clvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnAll.mas_bottom);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self).offset(-padding);
    }];
    
    hContentView = padding + hBTN + hCollectionView + padding;
}


#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomePromotionClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePromotionClvCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.imgPromotion.image = [UIImage imageNamed:@"promotion_1"];
        cell.lbTitle.text = @"Giảm 5% tất cả sản phẩm tại 9tech.vn khi mua tên miền";
    }else{
        cell.imgPromotion.image = [UIImage imageNamed:@"promotion_2"];
        cell.lbTitle.text = @"Tặng máy chủ và gói quản lý";
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(240, hCollectionView);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
