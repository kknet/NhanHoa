//
//  HostingDetailSelectTbvCell.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingDetailSelectTbvCell.h"

@implementation HostingDetailSelectTbvCell
@synthesize lbTitle, tfValue, imgArr, btnChoose;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float leftSize = 140.0;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.height.mas_equalTo(leftSize);
    }];
    
    [tfValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTitle.mas_right).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfValue.mas_right);
        make.centerY.equalTo(tfValue.mas_centerY);
        make.width.mas_equalTo(18.0);
        make.height.mas_equalTo(14.0);
    }];
    
    [btnChoose setTitle:@"" forState:UIControlStateNormal];
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfValue);
    }];
    
    lbTitle.textColor = tfValue.textColor = TITLE_COLOR;
    lbTitle.font = tfValue.font = [AppDelegate sharedInstance].fontNormal;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
