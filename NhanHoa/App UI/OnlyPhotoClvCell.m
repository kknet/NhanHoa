//
//  OnlyPhotoClvCell.m
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OnlyPhotoClvCell.h"

@implementation OnlyPhotoClvCell
@synthesize imgPromotion;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [imgPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

@end
