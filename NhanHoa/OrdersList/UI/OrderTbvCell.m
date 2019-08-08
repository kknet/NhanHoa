//
//  OrderTbvCell.m
//  NhanHoa
//
//  Created by OS on 8/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderTbvCell.h"

@implementation OrderTbvCell
@synthesize lbSepa, lbDomain, lbMoney, lbService, lbStatus, lbTime;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 10.0;
    
    lbService.textColor = BLUE_COLOR;
    lbService.font = [AppDelegate sharedInstance].fontMedium;
    [lbService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self).offset(5.0);
        make.height.mas_equalTo(30.0);
    }];
    
    lbMoney.textColor = NEW_PRICE_COLOR;
    lbMoney.font = [AppDelegate sharedInstance].fontDesc;
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbService.mas_bottom);
        make.right.equalTo(lbService);
        make.width.mas_equalTo(140.0);
        make.height.mas_equalTo(20.0);
    }];
    
    lbDomain.textColor = lbTime.textColor = lbTime.textColor = lbStatus.textColor = TITLE_COLOR;
    lbDomain.font = lbTime.font = lbTime.font = lbStatus.font  = [AppDelegate sharedInstance].fontDesc;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbMoney);
        make.left.equalTo(lbService);
        make.left.equalTo(lbMoney.mas_left).offset(-5.0);
    }];
    
    [lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.equalTo(lbDomain);
        make.right.equalTo(self.mas_centerX).offset(30.0);
        make.height.mas_equalTo(20.0);
    }];
    
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTime.mas_right).offset(5.0);
        make.top.bottom.equalTo(lbTime);
        make.right.equalTo(lbMoney);
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
