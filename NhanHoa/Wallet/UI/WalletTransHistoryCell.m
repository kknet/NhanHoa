//
//  WalletTransHistoryCell.m
//  NhanHoa
//
//  Created by OS on 10/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WalletTransHistoryCell.h"

@implementation WalletTransHistoryCell
@synthesize viewWrap, lbTitle, lbValue, lbMoney, imgType;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 10.0;
    self.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    viewWrap.backgroundColor = UIColor.whiteColor;
    viewWrap.layer.cornerRadius = 10.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(viewWrap.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-1];
    lbMoney.textColor = GRAY_50;
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(viewWrap.mas_centerY);
        make.height.mas_equalTo(40.0);
        make.width.mas_equalTo(140);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_80;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
        make.left.equalTo(imgType.mas_right).offset(5.0);
        make.right.equalTo(lbMoney.mas_left).offset(-5.0);
    }];
    
    lbValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbValue.textColor = GRAY_150;
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(2.0);
        make.left.equalTo(imgType.mas_right).offset(5.0);
        make.right.equalTo(lbMoney.mas_left).offset(-5.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
