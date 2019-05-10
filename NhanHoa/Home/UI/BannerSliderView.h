//
//  BannerSliderView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannerSliderView : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scvBanner;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSArray *listBanners;
@property (nonatomic, strong) NSTimer *slideTimer;
@property (nonatomic, assign) float hBanner;

- (void)setupUIForView;
- (void)showBannersForSliderView;

@end
