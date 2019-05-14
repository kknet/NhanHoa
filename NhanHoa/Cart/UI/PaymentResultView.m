//
//  PaymentResultView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentResultView.h"

@implementation PaymentResultView
@synthesize lbContent, imgResult;

- (void)setupUIForView {
    float padding = 15.0;
    
    [imgResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(70.0);
    }];
    
    lbContent.textColor = TITLE_COLOR;
    lbContent.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgResult.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
    }];
}

@end
