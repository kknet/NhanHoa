//
//  HomeSliderClvCell.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeSliderClvCell.h"

@implementation HomeSliderClvCell
@synthesize imgPicture;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [imgPicture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

@end
