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
@synthesize hContentView, hCollectionView, listImages, padding;

- (void)setupUIForViewWithList:(NSArray *)photos
{
    UIFont *titleFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (IS_IPHONE || IS_IPOD) {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            titleFont = [UIFont fontWithName:RobotoMedium size:19.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
            titleFont = [UIFont fontWithName:RobotoMedium size:20.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
            titleFont = [UIFont fontWithName:RobotoMedium size:22.0];
        }
    }
    
    self.backgroundColor = [UIColor colorWithRed:(251/255.0) green:(252/255.0) blue:(254/255.0) alpha:1.0];
    padding = 15.0;
    float hBTN = 40.0;
    
    if (photos.count > 0) {
        listImages = [[NSArray alloc] initWithArray: photos];
        
        UIImage *firstImg = [photos firstObject];
        float realWidth = (SCREEN_WIDTH - 2*padding)*2/3;
        float realHeight = realWidth * firstImg.size.height / firstImg.size.width;
        hCollectionView = realHeight + 50.0;    //  50 is title's height
        
    }else{
        listImages = [[NSArray alloc] init];
        
        hCollectionView = 200.0;
    }
    
    lbTitle.textColor = GRAY_50;
    
    
    btnAll.titleLabel.font = [UIFont fontWithName:RobotoRegular size:(titleFont.pointSize-2)];
    [btnAll setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"All"]
            forState:UIControlStateNormal];
    [btnAll setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(padding);
        make.height.mas_equalTo(hBTN);
        make.width.mas_equalTo(80.0);
    }];
    
    lbTitle.font = titleFont;
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
    return listImages.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomePromotionClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePromotionClvCell" forIndexPath:indexPath];
    cell.imgPromotion.image = [listImages objectAtIndex: indexPath.row];
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"Giảm 5% tất cả sản phẩm tại 9tech.vn khi mua tên miền";
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"Tặng máy chủ và gói quản lý chuyên nghiệp";
        
    }else if (indexPath.row == 2){
        cell.lbTitle.text = SFM(@"Đăng ký tên miền ngay\n để xây dựng thương hiệu của bạn trên Internet");
        
    }else{
        cell.lbTitle.text = SFM(@"NHAN HOA APP\n Ứng dụng đăng ký và quản lý tên miền được ưa chuộng nhất hiện nay");
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] selected index = %d", __FUNCTION__, (int)indexPath.row)];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH - 2*padding)*2/3, hCollectionView);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
