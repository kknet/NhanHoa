//
//  HomeSliderView.h
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeSliderView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *clvBanner;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UIImageView *bgInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIButton *icNext;

@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) float hCollectionView;
@property (nonatomic, assign) float padding;
@property (nonatomic, strong) NSArray *listImages;

- (void)setupUIForViewWithList: (NSArray *)contentList;

@property (nonatomic, strong) NSTimer *slideTimer;
@property (nonatomic, assign) int curIndex;

@end

NS_ASSUME_NONNULL_END
