//
//  HomeHeaderView.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

@synthesize lbHello, icCall, viewWallet, lbMainWallet, lbMainMoney, icMainMoney, lbSepa, lbBonusWallet, lbBonusMoney, icBonusMoney, lbTopup, icTopup, lbPromotion, icPromotion, lbTrans, icTrans;
@synthesize hContentView;

- (void)setupUIForView {
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    float hItem = 50.0;
    
    icCall.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self).offset(-padding);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbHello.textColor = UIColor.whiteColor;
    lbHello.font = [AppDelegate sharedInstance].fontBold;
    [lbHello mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(icCall);
        make.right.equalTo(icCall.mas_left).offset(-padding);
    }];
    
    //  view wallet
    lbMainWallet.font = lbBonusWallet.font = [AppDelegate sharedInstance].fontNormal;
    lbMainMoney.font = lbBonusMoney.font = [AppDelegate sharedInstance].fontMedium;
    
    icMainMoney.imageEdgeInsets = icBonusMoney.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    lbMainWallet.textColor = lbBonusWallet.textColor = GRAY_200;
    lbMainWallet.textColor = lbBonusWallet.textColor = [UIColor colorWithRed:(50/255.0) green:(50/255.0)
                                                                        blue:(50/255.0) alpha:1.0];
    float sizeIcon = 30.0;
    viewWallet.layer.cornerRadius = 10.0;
    viewWallet.layer.borderColor = GRAY_200.CGColor;
    viewWallet.layer.borderWidth = 1.0;
    
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbHello.mas_bottom).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(2*hItem + 1.0);
    }];
    
    //  main wallet
    [icMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewWallet).offset(-padding + 3.0);
        make.top.equalTo(viewWallet).offset((hItem - sizeIcon)/2);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icMainMoney.mas_left).offset(-5.0);
        make.top.bottom.equalTo(icMainMoney);
    }];
    
    [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(padding);
        make.top.bottom.equalTo(icMainMoney);
        make.right.equalTo(lbMainMoney.mas_left).offset(-5.0);
    }];
    
    lbSepa.backgroundColor = GRAY_200;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(padding);
        make.right.equalTo(viewWallet).offset(-padding);
        make.centerY.equalTo(viewWallet.mas_centerY);
        make.height.mas_equalTo(1.0);
    }];
    
    //  bonus wallet
    [icBonusMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icMainMoney);
        make.top.equalTo(lbSepa.mas_bottom).offset((hItem - sizeIcon)/2);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbBonusMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icBonusMoney.mas_left).offset(-5.0);
        make.top.bottom.equalTo(icBonusMoney);
    }];
    
    [lbBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(padding);
        make.top.bottom.equalTo(icBonusMoney);
        make.right.equalTo(lbBonusMoney.mas_left).offset(-5.0);
    }];
    
    //  buttons
    icTopup.imageEdgeInsets = icPromotion.imageEdgeInsets = icTrans.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    
    float sizeButton = 50.0;
    float originX = (SCREEN_WIDTH - 3*sizeButton)/6;
    
    [icPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_bottom).offset(10.0);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icPromotion.mas_bottom).offset(-3.0);
        make.centerX.equalTo(icPromotion.mas_centerX);
        make.width.mas_equalTo(80.0);
        make.height.mas_equalTo(20.0);
    }];
    
    [icTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(originX);
        make.top.equalTo(icPromotion);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPromotion);
        make.centerX.equalTo(icTopup.mas_centerX);
        make.width.equalTo(lbPromotion.mas_width);
    }];
    
    [icTrans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-originX);
        make.top.equalTo(icPromotion);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbTrans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPromotion);
        make.centerX.equalTo(icTrans.mas_centerX);
        make.width.equalTo(lbPromotion.mas_width);
    }];
    
    hContentView = 35.0 + 10.0 + (2*hItem + 1.0) + 10.0 + sizeButton + 20.0 + 40.0;
}

@end
