//
//  HomePromotionView.h
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomePromotionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAll;
@property (weak, nonatomic) IBOutlet UICollectionView *clvContent;

@property (nonatomic, assign) float hCollectionView;
@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) float padding;

@property (nonatomic, strong) NSArray *listImages;
- (void)setupUIForViewWithList:(NSArray *)photos;

@end

NS_ASSUME_NONNULL_END
