//
//  CartMoreInfoView.m
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartMoreInfoView.h"
#import "CartMoreInfoClvCell.h"

@implementation CartMoreInfoView
@synthesize lbTitle, clvInfo;
@synthesize hContentView, padding, hCollectionView;

- (void)setupUIForView {
    padding = 15.0;
    self.backgroundColor = GRAY_240;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size: 18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size: 20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size: 22.0];
    }
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_100;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    hCollectionView = 5.0 + 40.0 + 50.0 + 45.0 + 15.0;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    clvInfo.collectionViewLayout = layout;
    clvInfo.delegate = self;
    clvInfo.dataSource = self;
    [clvInfo registerNib:[UINib nibWithNibName:@"CartMoreInfoClvCell" bundle:nil] forCellWithReuseIdentifier:@"CartMoreInfoClvCell"];
    clvInfo.showsHorizontalScrollIndicator = FALSE;
    
    clvInfo.backgroundColor = UIColor.clearColor;
    [clvInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hCollectionView);
    }];
    
    hContentView = 50.0 + hCollectionView + padding;
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CartMoreInfoClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CartMoreInfoClvCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"Hosting";
        cell.lbContent.text = @"Dịch vụ lưu trữ web chuyên nghiệp, máy chủ với đường truyền tốc độ cao";
        cell.lbPrice.text = SFM(@"%@\n%@", @"Giá chỉ từ", @"36.0000đ/tháng");
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"Email";
        cell.lbContent.text = @"Giải pháp email chuyên nghiệp vận hành trên một máy chủ độc lập, với địa chỉ IP riêng và control panel quản trị riêng";
        cell.lbPrice.text = SFM(@"%@\n%@", @"Giá chỉ từ", @"350.0000đ/tháng");
        
    }else{
        cell.lbTitle.text = @"Máy chủ";
        cell.lbContent.text = @"Hệ thống server vật lý sử dụng 100% ổ cứng SSD đảm bảo tốc độ truy xuất vượt trội lên tới 40 lần so với ổ cứng thông thường";
        cell.lbPrice.text = SFM(@"%@\n%@", @"Giá chỉ từ", @"860.0000đ/tháng");
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(280, hCollectionView);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
