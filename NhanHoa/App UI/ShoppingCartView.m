//
//  ShoppingCartView.m
//  NhanHoa
//
//  Created by lam quang quan on 6/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ShoppingCartView.h"

@implementation ShoppingCartView
@synthesize btnCart, lbCount;

- (void)setupUIForView {
    self.backgroundColor = UIColor.clearColor;
    [btnCart setImage:[UIImage imageNamed:@"cart.png"] forState:UIControlStateNormal];
    btnCart.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [btnCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.clipsToBounds = TRUE;
    lbCount.layer.cornerRadius = 20.0/2;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnCart).offset(3.0);
        make.right.equalTo(self.btnCart).offset(-3.0);
        make.width.height.mas_equalTo(20.0);
    }];
}


- (IBAction)btnCartPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [[AppDelegate sharedInstance] showCartScreenContent];
}

@end
