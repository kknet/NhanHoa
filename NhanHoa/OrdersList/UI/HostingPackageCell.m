//
//  HostingPackageCell.m
//  NhanHoa
//
//  Created by OS on 8/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingPackageCell.h"

@implementation HostingPackageCell
@synthesize lbContent, lbSepa, imgTick;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [imgTick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(5.0);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(imgTick.mas_right).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
    }];
    
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
    
    lbContent.font = [AppDelegate sharedInstance].fontNormal;
    lbContent.textColor = TITLE_COLOR;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
