//
//  HomeHeaderView.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

@synthesize lbHello, icCart, lbCount, viewWallet, lbMainWallet, lbMainMoney, icMainMoney, lbSepa, lbBonusWallet, lbBonusMoney, icBonusMoney, lbTopup, icTopup, lbPromotion, icPromotion, lbTrans, icTrans, icWithdraw, lbWithdraw, imgBanner;
@synthesize hContentView, delegate;

- (void)setupUIForView {
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 20.0;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float smallPadding = 15.0;
    float hItem = 50.0;
    float sizeIcon = 30.0;
    float sizeButton = 50.0;
    float hLabel = 20.0;
    float marginY = 5.0;
    float moreHeight = 40.0;
    float hIcon = 45.0;
    
    UIFont *textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
    UIFont *titleFont = [UIFont systemFontOfSize:23.0 weight:UIFontWeightBold];
    
    //  edge for buttons
    icTopup.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    icWithdraw.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    icPromotion.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    icTrans.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    
    if (IS_IPHONE || IS_IPOD)
    {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            titleFont = [UIFont systemFontOfSize:19.0 weight:UIFontWeightMedium];
            padding = 15.0;
            
            smallPadding = 5.0;
            hItem = 45.0;
            moreHeight = 25.0;
            hIcon = 35.0;
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
            textFont = [UIFont systemFontOfSize:17.0 weight:UIFontWeightRegular];
            titleFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            padding = 15.0;
            
            moreHeight = 25.0;
            hIcon = 35.0;
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
            textFont = [UIFont systemFontOfSize:18.0 weight:UIFontWeightRegular];
            titleFont = [UIFont systemFontOfSize:21.0 weight:UIFontWeightMedium];
            
            sizeButton = 60.0;
            hLabel = 30.0;
            marginY = 15.0;
            
            icTopup.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
            icWithdraw.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
            icPromotion.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
            icTrans.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        }
    }
    
    
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            hItem = 45.0;
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            hItem = 50.0;
        }
    }
    
    UIImage *banner = [UIImage imageNamed:@"ic_bg"];
    float hBanner = SCREEN_WIDTH*banner.size.height / banner.size.width;
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(hStatus);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hBanner);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBanner).offset(5.0);
        make.right.equalTo(self).offset(-padding);
        make.width.height.mas_equalTo(hIcon);
    }];
    
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.clipsToBounds = TRUE;
    lbCount.text = @"1";
    lbCount.layer.cornerRadius = 20.0/2;
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo(20.0);
    }];
    
    lbHello.textColor = UIColor.whiteColor;
    lbHello.font = titleFont;
    [lbHello mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(icCart);
        make.right.equalTo(icCart.mas_left).offset(-padding);
    }];
    
    //  view wallet
    lbMainWallet.font = lbBonusWallet.font = textFont;
    lbMainMoney.font = lbBonusMoney.font = [UIFont systemFontOfSize:textFont.pointSize weight:UIFontWeightSemibold];
    
    icMainMoney.imageEdgeInsets = icBonusMoney.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    lbMainWallet.textColor = lbBonusWallet.textColor = GRAY_100;
    lbMainWallet.textColor = lbBonusWallet.textColor = GRAY_50;
    
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
        make.right.equalTo(viewWallet).offset(-smallPadding + 3.0);
        make.top.equalTo(viewWallet).offset((hItem - sizeIcon)/2);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icMainMoney.mas_left).offset(-5.0);
        make.top.bottom.equalTo(icMainMoney);
    }];
    
    lbMainWallet.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Main wallet"];
    [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(smallPadding);
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
    
    lbBonusWallet.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Bonus wallet"];
    [lbBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(smallPadding);
        make.top.bottom.equalTo(icBonusMoney);
        make.right.equalTo(lbBonusMoney.mas_left).offset(-5.0);
    }];
    
    //  buttons
    float originX = (SCREEN_WIDTH - 4*sizeButton)/5;
    
    [icWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_bottom).offset(marginY);
        make.right.equalTo(self.mas_centerX).offset(-originX/2);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icWithdraw.mas_bottom).offset(-3.0);
        make.centerX.equalTo(icWithdraw.mas_centerX);
        make.height.mas_equalTo(hLabel);
    }];
    
    [icTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icWithdraw.mas_left).offset(-originX);
        make.top.equalTo(icWithdraw);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbWithdraw);
        make.centerX.equalTo(icTopup.mas_centerX);
    }];
    
    [icPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icWithdraw.mas_right).offset(originX);
        make.top.equalTo(icWithdraw);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbWithdraw);
        make.centerX.equalTo(icPromotion.mas_centerX);
    }];
    
    [icTrans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icPromotion.mas_right).offset(originX);
        make.top.equalTo(icPromotion);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbTrans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPromotion);
        make.centerX.equalTo(icTrans.mas_centerX);
    }];
    
    hContentView = hStatus + hIcon + 10.0 + (2*hItem + 1.0) + marginY + sizeButton + hLabel + moreHeight;
    
    [self addCurvePathForViewWithHeight: hContentView];
    
    lbTopup.font = lbWithdraw.font = lbPromotion.font = lbTrans.font = [UIFont systemFontOfSize:(textFont.pointSize-2) weight:UIFontWeightThin];
}

- (void)addCurvePathForViewWithHeight: (float)height {
    float hCurve = 20.0;
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, height-hCurve)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH, height-hCurve) controlPoint:CGPointMake(SCREEN_WIDTH/2, height)];
    [path addLineToPoint: CGPointMake(SCREEN_WIDTH, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = UIColor.clearColor.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    gradientLayer.startPoint = CGPointMake(0.25, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    //  gradientLayer.colors = @[(id)[UIColor colorWithRed:(18/255.0) green:(101/255.0) blue:(203/255.0) alpha:0].CGColor, (id)[UIColor colorWithRed:(23/255.0) green:(92/255.0) blue:(188/255.0) alpha:1.0].CGColor];
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(23/255.0) green:(92/255.0) blue:(188/255.0) alpha:1].CGColor, (id)[UIColor colorWithRed:(18/255.0) green:(101/255.0) blue:(203/255.0) alpha:0.8].CGColor];
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
}

- (void)displayAccountInformation {
    //  display name
    NSString *realName = [AccountModel getCusRealName];
    if (![AppUtils isNullOrEmpty: realName]) {
        lbHello.text = SFM(@"%@ %@!", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Hi"], realName);
    }else{
        lbHello.text = @"";
    }
    
    //  display money
    NSString *balance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: balance]) {
        balance = [AppUtils convertStringToCurrencyFormat: balance];
        lbMainMoney.text = [NSString stringWithFormat:@"%@VNĐ", balance];
    }else{
        lbMainMoney.text = @"0VNĐ";
    }
    
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        points = [AppUtils convertStringToCurrencyFormat: points];
        lbBonusMoney.text = [NSString stringWithFormat:@"%@VNĐ", points];
    }else{
        lbBonusMoney.text = @"0VNĐ";
    }
}

- (IBAction)icTopupClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(selectOnTopupHeaderMenu)]) {
        [delegate selectOnTopupHeaderMenu];
    }
}

- (IBAction)icWithdrawClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(selectOnWithdrawHeaderMenu)]) {
        [delegate selectOnWithdrawHeaderMenu];
    }
}

- (IBAction)icPromotionsClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(selectOnPromotionHeaderMenu)]) {
        [delegate selectOnPromotionHeaderMenu];
    }
}

- (IBAction)icTransactionClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(selectOnTransactionHeaderMenu)]) {
        [delegate selectOnTransactionHeaderMenu];
    }
}

@end
