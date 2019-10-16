//
//  HomeHeaderView.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

@synthesize lbHello, icCall, viewWallet, lbMainWallet, lbMainMoney, icMainMoney, lbSepa, lbBonusWallet, lbBonusMoney, icBonusMoney, lbTopup, icTopup, lbPromotion, icPromotion, lbTrans, icTrans, icWithdraw, lbWithdraw, imgBanner;
@synthesize hContentView, delegate;

- (void)setupUIForView {
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    float hItem = 45.0;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    UIFont *textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
        {
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
        {
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
            
        }else{
            textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
        }
    }else{
        textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightMedium];
    }
    
    
    UIImage *banner = [UIImage imageNamed:@"home_banner"];
    float hBanner = SCREEN_WIDTH*banner.size.height / banner.size.width;
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(hStatus);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hBanner);
    }];
    
    icCall.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBanner).offset(5.0);
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
    lbMainWallet.font = lbBonusWallet.font = textFont;
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
        make.right.equalTo(viewWallet).offset(-5.0 + 3.0);
        make.top.equalTo(viewWallet).offset((hItem - sizeIcon)/2);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icMainMoney.mas_left).offset(-5.0);
        make.top.bottom.equalTo(icMainMoney);
    }];
    
    lbMainWallet.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Main wallet"];
    [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(5.0);
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
        make.left.equalTo(viewWallet).offset(5.0);
        make.top.bottom.equalTo(icBonusMoney);
        make.right.equalTo(lbBonusMoney.mas_left).offset(-5.0);
    }];
    
    //  buttons
    icTopup.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    icWithdraw.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    icPromotion.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    icTrans.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    
    float sizeButton = 50.0;
    float originX = (SCREEN_WIDTH - 4*sizeButton)/5;
    
    [icWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_bottom).offset(5.0);
        make.right.equalTo(self.mas_centerX).offset(-originX/2);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbWithdraw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icWithdraw.mas_bottom).offset(-3.0);
        make.centerX.equalTo(icWithdraw.mas_centerX);
        make.height.mas_equalTo(20.0);
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
    
    hContentView = hStatus + 35.0 + 10.0 + (2*hItem + 1.0) + 5.0 + sizeButton + 20.0 + 25.0;
    
    [self addCurvePathForViewWithHeight: hContentView];
}

- (void)addCurvePathForViewWithHeight: (float)height {
    float hCurve = 16.0;
    
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
    gradientLayer.backgroundColor = UIColor.greenColor.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    gradientLayer.startPoint = CGPointMake(1, 1);
    gradientLayer.endPoint = CGPointMake(0, 0);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(18/255.0) green:(101/255.0) blue:(203/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(41/255.0) green:(122/255.0) blue:(218/255.0) alpha:1.0].CGColor];
    
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
