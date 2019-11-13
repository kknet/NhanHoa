//
//  HomeExploreView.h
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    eExploreDomain,
    eExploreCloudServer,
    eExploreVfone,
    eExploreOrders,
    eExploreProfiles,
    eExploreEmail,
    eExploreHosting,
    eExploreSSL,
    eExploreVPS,
    eExploreManagerDomains,
    eExplorePricingDomains,
    eExploreCheckDomains,
}ExploreType;

NS_ASSUME_NONNULL_BEGIN


@protocol HomeExploreViewDelegate <NSObject>
@optional
- (void)closeExploreView;
- (void)selectedMenuFromExploreView: (ExploreType)menu;
@end

@interface HomeExploreView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) id<HomeExploreViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lbTransparent;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *clvMenu;
@property (weak, nonatomic) IBOutlet UILabel *lbBottom;

@property (nonatomic, assign) float hContent;
@property (nonatomic, assign) float hCell;
@property (nonatomic, assign) float wCell;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
