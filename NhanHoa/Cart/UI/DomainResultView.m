//
//  DomainResultView.m
//  NhanHoa
//
//  Created by Khai Leo on 6/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainResultView.h"

@implementation DomainResultView
@synthesize lbContent, imgStatus;


- (void)setupUIForView {
    self.backgroundColor = UIColor.whiteColor;
    [imgStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(7.5);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(85.0);
    }];
    
    lbContent.numberOfLines = 5;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgStatus.mas_bottom);
        make.left.equalTo(self).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
        make.bottom.equalTo(self).offset(-7.5);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
