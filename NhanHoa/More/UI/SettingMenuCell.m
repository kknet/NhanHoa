//
//  SettingMenuCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SettingMenuCell.h"

@implementation SettingMenuCell
@synthesize lbName, imgSepa, imgType, imgArrow;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    float sizeIcon = 35.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        sizeIcon = 50.0;
    }
    
    imgType.backgroundColor = UIColor.clearColor;
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbName.font = [AppDelegate sharedInstance].fontRegular;
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgType.mas_right).offset(15.0);
        make.right.equalTo(imgArrow.mas_left).offset(-5.0);
        make.top.bottom.equalTo(imgType);
    }];
    
    imgSepa.backgroundColor = GRAY_240;
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgType);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
