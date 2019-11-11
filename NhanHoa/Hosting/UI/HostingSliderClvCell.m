//
//  HostingSliderClvCell.m
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingSliderClvCell.h"

@implementation HostingSliderClvCell
@synthesize lbTitle, lbContent, imgSlider;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    self.layer.cornerRadius = 10.0;
    self.clipsToBounds = TRUE;
    
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(70.0);
    }];
    
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lbContent.mas_top);
        make.left.right.equalTo(lbContent);
        make.height.mas_equalTo(45.0);
    }];
    
    [imgSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(lbTitle.mas_top);
    }];
}

@end
