//
//  HomeSliderView.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeSliderView.h"

@implementation HomeSliderView
@synthesize clvBanner, viewInfo, bgInfo, lbTitle, lbContent, icNext;
@synthesize hContentView;

- (void)setupUIForView {
    float padding = 15.0;
    self.backgroundColor = [UIColor colorWithRed:(248/255.0) green:(248/255.0)
                                            blue:(250/255.0) alpha:1.0];
    clvBanner.backgroundColor = UIColor.grayColor;
    [clvBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(100.0);
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
    
    hContentView = padding + 100.0 + 10.0 + hImage + padding;
}

@end
