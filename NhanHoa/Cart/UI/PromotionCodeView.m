//
//  PromotionCodeView.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PromotionCodeView.h"

@implementation PromotionCodeView
@synthesize lbTitle, tfCode, btnApply, lbSepa, lbResult;

- (void)setupUIForView {
    float padding = 15.0;
    
    tfCode.layer.borderWidth = 1.0;
    tfCode.layer.cornerRadius = 38.0/2;
    tfCode.layer.borderColor = ORANGE_COLOR.CGColor;
    [tfCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(38.0);
    }];
    
    float btnPadding = 2.0;
    btnApply.layer.borderWidth = 1.0;
    btnApply.layer.cornerRadius = 38.0/2;
    btnApply.layer.borderColor = ORANGE_COLOR.CGColor;
    [btnApply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfCode.mas_right).offset(-btnPadding);
        make.top.equalTo(self.tfCode).offset(btnPadding);
        make.bottom.equalTo(self.tfCode).offset(-btnPadding);
        make.width.mas_equalTo(80.0);
    }];
    
    lbResult.textColor = NEW_PRICE_COLOR;
    lbResult.font = [UIFont fontWithName:RobotoThinItalic size:14.0];
    [lbResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfCode);
        make.top.equalTo(self.tfCode.mas_bottom);
        make.height.mas_equalTo(30.0);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tfCode);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

@end
