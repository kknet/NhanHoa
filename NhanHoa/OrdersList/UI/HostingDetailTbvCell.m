//
//  HostingDetailTbvCell.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingDetailTbvCell.h"

@implementation HostingDetailTbvCell
@synthesize lbTitle, lbValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float leftSize = 140.0;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(leftSize);
    }];
    
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(lbTitle.mas_right);
        make.right.equalTo(self);
    }];
    
    lbTitle.font = lbValue.font = [AppDelegate sharedInstance].fontNormal;
    lbTitle.backgroundColor = UIColorFromRGB(0xeceff1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
