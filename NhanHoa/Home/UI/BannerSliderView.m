//
//  BannerSliderView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BannerSliderView.h"

@implementation BannerSliderView
@synthesize scvBanner, pageControl, slideTimer, listBanners, hBanner;

- (void)setupUIForView {
    scvBanner.backgroundColor = UIColor.whiteColor;
    scvBanner.pagingEnabled = TRUE;
    scvBanner.scrollEnabled = FALSE;
    scvBanner.delegate = self;
    scvBanner.showsHorizontalScrollIndicator = FALSE;
    [scvBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    pageControl.userInteractionEnabled = FALSE;
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(38.0);
    }];
}

- (void)showBannersForSliderView {
    if ([AppDelegate sharedInstance].userInfo != nil) {
        pageControl.hidden = FALSE;
        
        NSArray *banners = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_banner"];
        if (banners != nil && [banners isKindOfClass:[NSArray class]]) {
            listBanners = [[NSArray alloc] initWithArray: banners];
            
            for (int index=0; index<listBanners.count; index++) {
                NSDictionary *banner = [listBanners objectAtIndex: index];
                
                UIImageView *imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(index*SCREEN_WIDTH, 0, SCREEN_WIDTH, hBanner)];
                imgBanner.contentMode = UIViewContentModeScaleAspectFill;
                imgBanner.clipsToBounds = TRUE;
                imgBanner.tag = index;
                [scvBanner addSubview: imgBanner];
                
                //  Add target
                imgBanner.userInteractionEnabled = TRUE;
                UITapGestureRecognizer *tapOnBanner = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnBannerImage:)];
                [imgBanner addGestureRecognizer: tapOnBanner];
                
                NSString *image = [banner objectForKey:@"image"];
                [imgBanner sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"banner.jpg"]];
            }
            //  for page control
            if (listBanners.count > 1) {
                pageControl.hidden = FALSE;
            }else{
                pageControl.hidden = TRUE;
            }
            
            pageControl.numberOfPages = listBanners.count;
            pageControl.currentPage = 0;
            scvBanner.contentSize = CGSizeMake(SCREEN_WIDTH*listBanners.count, hBanner);
            
            slideTimer = [NSTimer scheduledTimerWithTimeInterval:TIME_FOR_SLIDER target:self selector:@selector(nextSlider) userInfo:nil repeats:TRUE];
        }
        
    }else{
        pageControl.hidden = TRUE;
        
        UIImageView *imgBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hBanner)];
        imgBanner.image = [UIImage imageNamed:@"banner.jpg"];
        imgBanner.contentMode = UIViewContentModeScaleAspectFill;
        imgBanner.clipsToBounds = TRUE;
        [scvBanner addSubview: imgBanner];
        scvBanner.contentSize = CGSizeMake(SCREEN_WIDTH, hBanner);
    }
}

- (void)whenTapOnBannerImage:(UITapGestureRecognizer *)recognizer {
    int index = (int)recognizer.view.tag;
    if (index < listBanners.count) {
        NSDictionary *info = [listBanners objectAtIndex: index];
        NSString *url = [info objectForKey:@"url"];
        if (![AppUtils isNullOrEmpty: url]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];
        }
    }
}

- (void)nextSlider {
    int curPage = (int)pageControl.currentPage;
    if (curPage == listBanners.count-1) {
        [scvBanner setContentOffset:CGPointMake(0, 0) animated:TRUE];
    }else{
        [scvBanner setContentOffset:CGPointMake((curPage+1)*SCREEN_WIDTH, 0) animated:TRUE];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width; // you need to have a **iVar** with getter for scrollView
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    pageControl.currentPage = page; // you need to have a **iVar** with getter for pageControl
}

@end
