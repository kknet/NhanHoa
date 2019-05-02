//
//  PaymentStepView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentStepView.h"

@implementation PaymentStepView
@synthesize lbOne, lbSepa1, lbTwo, lbSepa2, lbThree, lbSepa3, lbFour, lbProfile, lbConfirm, lbPayment, lbDone;

- (void)setupUIForView {
    float padding = 3.0;
    float hStepIcon = 22.0;
    
    UIColor *disableColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0];
    lbSepa2.textColor = disableColor;
    lbSepa2.text = @"--------";
    lbSepa2.clipsToBounds = TRUE;
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(60.0);
        make.height.mas_equalTo(20.0);
    }];
    
    lbTwo.clipsToBounds = TRUE;
    lbTwo.backgroundColor = disableColor;
    lbTwo.layer.cornerRadius = hStepIcon/2;
    [lbTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbSepa2.mas_left).offset(-padding);
        make.centerY.equalTo(self.lbSepa2.mas_centerY);
        make.width.height.mas_equalTo(hStepIcon);
    }];
    
    lbSepa1.textColor = disableColor;
    lbSepa1.text = lbSepa2.text;
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbTwo.mas_left).offset(-padding);
        make.top.bottom.equalTo(self.lbSepa2);
        make.width.equalTo(self.lbSepa2.mas_width);
    }];
    
    lbOne.clipsToBounds = TRUE;
    lbOne.backgroundColor = BLUE_COLOR;
    lbOne.layer.cornerRadius = hStepIcon/2;
    [lbOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lbSepa1.mas_left).offset(-padding);
        make.top.bottom.equalTo(self.lbTwo);
        make.width.mas_equalTo(hStepIcon);
    }];
    
    lbThree.clipsToBounds = TRUE;
    lbThree.backgroundColor = disableColor;
    lbThree.layer.cornerRadius = hStepIcon/2;
    [lbThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbSepa2.mas_right).offset(padding);
        make.top.bottom.equalTo(self.lbTwo);
        make.width.mas_equalTo(hStepIcon);
    }];
    
    lbSepa3.textColor = disableColor;
    lbSepa3.text = lbSepa2.text;
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbThree.mas_right).offset(padding);
        make.top.bottom.equalTo(self.lbSepa2);
        make.width.equalTo(self.lbSepa2.mas_width);
    }];
    
    lbFour.clipsToBounds = TRUE;
    lbFour.backgroundColor = disableColor;
    lbFour.layer.cornerRadius = hStepIcon/2;
    [lbFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbSepa3.mas_right).offset(padding);
        make.top.bottom.equalTo(self.lbTwo);
        make.width.mas_equalTo(hStepIcon);
    }];
    
    //  content
    lbProfile.font = [UIFont fontWithName:RobotoRegular size:15.0];
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOne.mas_bottom);
        make.centerX.equalTo(self.lbOne.mas_centerX);
        make.height.mas_equalTo(20.0);
        make.width.mas_equalTo(80.0);
    }];
    
    lbConfirm.font = lbProfile.font;
    [lbConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbProfile);
        make.centerX.equalTo(self.lbTwo.mas_centerX);
        make.width.equalTo(self.lbProfile.mas_width);
    }];
    
    lbPayment.font = lbProfile.font;
    [lbPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbProfile);
        make.centerX.equalTo(self.lbThree.mas_centerX);
        make.width.equalTo(self.lbProfile.mas_width);
    }];
    
    lbDone.font = lbProfile.font;
    [lbDone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbProfile);
        make.centerX.equalTo(self.lbFour.mas_centerX);
        make.width.equalTo(self.lbProfile.mas_width);
    }];
}

@end
