//
//  ChooseHostingPackgeView.m
//  NhanHoa
//
//  Created by Khai Leo on 11/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChooseHostingPackgeView.h"

@implementation ChooseHostingPackgeView
@synthesize lbBackground, viewContent, lbTitle, tbContent, btnConfirm;
@synthesize hContentView, padding;

- (void)setupUIForViewWithInfo: (NSArray *)infos
{
    float padding = 15.0;
    float hBTN = 45.0;
    float hCell = 70.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    }
    
    hContentView = padding + 50.0 + padding + infos.count * hCell + 2*padding + hBTN + 2*padding;
    
    self.backgroundColor = UIColor.clearColor;
    
    lbBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [lbBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    viewContent.backgroundColor = UIColor.whiteColor;
    viewContent.layer.cornerRadius = 10.0;
    viewContent.clipsToBounds = TRUE;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hContentView);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContent).offset(padding);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirm.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-4];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewContent).offset(-2*padding);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbContent.backgroundColor = ORANGE_COLOR;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.left.right.equalTo(btnConfirm);
        make.bottom.equalTo(btnConfirm.mas_top).offset(-padding);
    }];
}

- (void)showContentInfoView {
    float originY = SCREEN_HEIGHT - hContentView + padding;
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(originY);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
