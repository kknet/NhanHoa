//
//  PaymentMethodCell.m
//  NhanHoa
//
//  Created by admin on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentMethodCell.h"

@implementation PaymentMethodCell
@synthesize imgType, lbTitle, imgChoose, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float sizeIcon = 40.0;
    float sizeTick = 20.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
        sizeIcon = 30.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        sizeTick = 30.0;
    }
    
    [imgChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-10.0);
        make.width.height.mas_equalTo(sizeTick);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontRegular;
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.numberOfLines = 2;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgType.mas_right).offset(padding);
        make.right.equalTo(self.imgChoose.mas_left).offset(-padding);
        make.top.bottom.equalTo(self);
    }];
    
    lbSepa.text = @"";
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
