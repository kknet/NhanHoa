//
//  OrderTbvCell.m
//  NhanHoa
//
//  Created by OS on 8/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderTbvCell.h"

@implementation OrderTbvCell
@synthesize lbServiceName, lbCustomer, lbMoney, lbSepa, lbStatus, icEdit, lbType, lbTime;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 10.0;
    float hItem = 35.0;
    
    float wButton = [AppUtils getSizeWithText:@"Cập nhật" withFont:[AppDelegate sharedInstance].fontMedium].width + 5;
    icEdit.titleLabel.font = [AppDelegate sharedInstance].fontMedium;
    [icEdit setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [icEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(5.0);
        make.width.mas_equalTo(wButton);
        make.height.mas_equalTo(35.0);
    }];
    
    lbServiceName.textColor = ORANGE_COLOR;
    lbServiceName.font = [AppDelegate sharedInstance].fontRegular;
    [lbServiceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(icEdit);
        make.right.equalTo(icEdit.mas_left).offset(-5.0);
    }];
    
    float maxSizeType = [AppUtils getSizeWithText:@"Khách hàng" withFont:[AppDelegate sharedInstance].fontDesc].width + 10.0;
    lbType.textColor = TITLE_COLOR;
    lbType.font = [AppDelegate sharedInstance].fontDesc;
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_centerX);
        make.width.mas_equalTo(maxSizeType);
        make.height.mas_equalTo(25.0);
    }];
    
    lbMoney.textColor = NEW_PRICE_COLOR;
    lbMoney.font = [AppDelegate sharedInstance].fontDesc;
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbType);
        make.right.equalTo(self).offset(-padding);
        make.left.equalTo(lbType.mas_right).offset(5.0);
    }];
    
    lbCustomer.textColor = ORANGE_COLOR;
    lbCustomer.font = [AppDelegate sharedInstance].fontDesc;
    [lbCustomer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbType);
        make.right.equalTo(lbType.mas_left).offset(-5.0);
        make.left.equalTo(self).offset(padding);
    }];
    
    lbTime.textColor = TITLE_COLOR;
    lbTime.font = [AppDelegate sharedInstance].fontDesc;
    [lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self).offset(-5.0);
        make.right.equalTo(self.mas_centerX);
        make.height.mas_equalTo(25.0);
    }];
    
    lbStatus.textColor = TITLE_COLOR;
    lbStatus.font = [AppDelegate sharedInstance].fontDesc;
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.bottom.equalTo(lbTime);
        make.right.equalTo(self).offset(-padding);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
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
