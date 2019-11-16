//
//  HomeHeaderView.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeHeaderView.h"
#import "CartModel.h"

@implementation HomeHeaderView

@synthesize lbHello, icCart, lbCount, viewWallet, lbMainWallet, lbMainMoney, icMainMoney, lbSepa, lbBonusWallet, lbBonusMoney, icBonusMoney, lbTopup, icTopup, lbPromotion, icPromotion, lbTrans, icTrans, icWithdraw, lbWithdraw, imgBanner, viewMainWallet, viewBonusWallet;
@synthesize hContentView, delegate;

- (void)setupUIForView {
    self.backgroundColor = UIColor.clearColor;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float padding = 15.0;
    UIFont *titleFont = [UIFont fontWithName:RobotoBold size:22.0];
    float sizeIcon = 20.0;
    float smallPadding = 10.0;
    float moreHeight = 65.0;
    float sizeButton = 60.0;
    float hWallet = 90.0;
    float marginY = 15.0;
    float hCartIcon = 40.0;
    
    //  edge for buttons
    icTopup.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    icWithdraw.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    icPromotion.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    icTrans.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        titleFont = [UIFont fontWithName:RobotoBold size:18.0];
        hWallet = 70.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        sizeIcon = 18.0;
        moreHeight = 45.0;
        marginY = 5.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
        titleFont = [UIFont fontWithName:RobotoBold size:20.0];
        hWallet = 80.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        sizeIcon = 20.0;
        moreHeight = 55.0;
        marginY = 5.0;
        
        icTopup.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        icWithdraw.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        icPromotion.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
        icTrans.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        titleFont = [UIFont fontWithName:RobotoBold size:22.0];
        hWallet = 90.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        sizeIcon = 22.0;
        moreHeight = 65.0;
        marginY = 15.0;
        
        icTopup.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
        icWithdraw.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        icPromotion.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        icTrans.imageEdgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    }
    
    UIImage *banner = [UIImage imageNamed:@"ic_bg"];
    float hBanner = SCREEN_WIDTH*banner.size.height / banner.size.width;
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(hStatus);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hBanner);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBanner).offset(5.0);
        make.right.equalTo(self).offset(-padding+5.0);
        make.width.height.mas_equalTo(hCartIcon);
    }];
    
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.clipsToBounds = TRUE;
    lbCount.text = @"1";
    lbCount.layer.cornerRadius = [AppDelegate sharedInstance].sizeCartCount/2;
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].sizeCartCount);
    }];
    
    lbHello.textColor = UIColor.whiteColor;
    lbHello.font = titleFont;
    [lbHello mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(icCart);
        make.right.equalTo(icCart.mas_left).offset(-padding);
    }];
    
    //  view wallet
    lbMainWallet.font = lbBonusWallet.font = [UIFont fontWithName:RobotoRegular size:titleFont.pointSize-4];
    lbMainMoney.font = lbBonusMoney.font = [UIFont fontWithName:RobotoMedium size:titleFont.pointSize-3];
    
    lbMainWallet.textColor = lbBonusWallet.textColor = GRAY_100;
    lbMainMoney.textColor = lbBonusMoney.textColor = GRAY_50;
    
    viewWallet.layer.cornerRadius = 15.0;
    //  viewWallet.layer.borderColor = GRAY_200.CGColor;
    //  viewWallet.layer.borderWidth = 1.0;
    
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbHello.mas_bottom).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hWallet);
    }];
    
    lbSepa.backgroundColor = GRAY_200;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWallet.mas_centerX);
        make.top.equalTo(lbMainWallet);
        make.bottom.equalTo(lbMainMoney);
        make.width.mas_equalTo(1.0);
    }];
    
    //  main wallet
    UITapGestureRecognizer *tapOnMainWallet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnViewMainWallet)];
    [viewMainWallet addGestureRecognizer: tapOnMainWallet];
    
    [viewMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(viewWallet);
        make.right.equalTo(lbSepa.mas_left);
    }];

    lbMainWallet.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Main wallet"];
    [lbMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWallet).offset(smallPadding);
        make.bottom.equalTo(viewWallet.mas_centerY).offset(-3.0);
    }];

    [icMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa.mas_left).offset(-smallPadding);
        make.centerY.equalTo(lbMainWallet.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];

    [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWallet.mas_centerY).offset(3.0);
        make.left.equalTo(lbMainWallet);
        make.right.equalTo(lbSepa.mas_left).offset(-smallPadding);
    }];


    //  bonus wallet
    UITapGestureRecognizer *tapOnBonusWallet = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnViewBonusWallet)];
    [viewBonusWallet addGestureRecognizer: tapOnBonusWallet];
    
    [viewBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(viewWallet);
        make.left.equalTo(lbSepa.mas_right);
    }];

    lbBonusWallet.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Bonus wallet"];
    [lbBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa.mas_right).offset(smallPadding);
        make.bottom.equalTo(lbMainWallet);
    }];

    [icBonusMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewWallet).offset(-smallPadding);
        make.centerY.equalTo(lbBonusWallet.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];

    [lbBonusMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMainMoney);
        make.left.equalTo(lbBonusWallet);
        make.right.equalTo(icBonusMoney);
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
        //  make.height.mas_equalTo(hLabel);
    }];
    
    [icTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(icWithdraw.mas_left).offset(-originX);
        make.top.equalTo(icWithdraw);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbTopup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbWithdraw);
        make.centerX.equalTo(icTopup.mas_centerX);
    }];
    
    [icPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icWithdraw.mas_right).offset(originX);
        make.top.equalTo(icWithdraw);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbWithdraw);
        make.centerX.equalTo(icPromotion.mas_centerX);
    }];
    
    [icTrans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icPromotion.mas_right).offset(originX);
        make.top.equalTo(icPromotion);
        make.width.height.mas_equalTo(sizeButton);
    }];
    
    [lbTrans mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPromotion);
        make.centerX.equalTo(icTrans.mas_centerX);
    }];
    
    hContentView = hStatus + hCartIcon + 10.0 + hWallet + marginY + sizeButton + moreHeight;
    
    [self addCurvePathForViewWithHeight: hContentView];
    
    lbTopup.font = lbWithdraw.font = lbPromotion.font = lbTrans.font = [UIFont fontWithName:RobotoRegular size:titleFont.pointSize-4];
}

- (void)whenTapOnViewMainWallet {
    if ([delegate respondsToSelector:@selector(selectOnMainWallet)]) {
        [delegate selectOnMainWallet];
    }
}

- (void)whenTapOnViewBonusWallet {
    if ([delegate respondsToSelector:@selector(selectOnBonusWallet)]) {
        [delegate selectOnBonusWallet];
    }
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
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5, 1);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(16/255.0) green:(102/255.0) blue:(220/255.0) alpha:1].CGColor, (id)[UIColor colorWithRed:(13/255.0) green:(87/255.0) blue:(191/255.0) alpha:1.0].CGColor];
    
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
        lbMainMoney.text = [NSString stringWithFormat:@"%@vnđ", balance];
    }else{
        lbMainMoney.text = @"0vnđ";
    }
    
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        points = [AppUtils convertStringToCurrencyFormat: points];
        lbBonusMoney.text = [NSString stringWithFormat:@"%@vnđ", points];
    }else{
        lbBonusMoney.text = @"0vnđ";
    }
}

- (void)updateShoppingCartCount {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
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
