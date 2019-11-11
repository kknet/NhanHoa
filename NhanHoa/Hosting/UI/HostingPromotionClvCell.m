//
//  HostingPromotionClvCell.m
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingPromotionClvCell.h"

@implementation HostingPromotionClvCell
@synthesize imgPromotion;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [imgPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

@end
