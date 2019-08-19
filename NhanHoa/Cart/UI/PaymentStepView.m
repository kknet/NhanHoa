//
//  PaymentStepView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentStepView.h"

@implementation PaymentStepView
@synthesize lbOne, lbSepa1, lbTwo, lbSepa2, lbThree, lbSepa3, lbFour, lbProfile, lbConfirm, lbPayment, lbDone, btnStepOne, btnStepTwo, btnStepThree, btnStepFour;
@synthesize delegate;

- (void)setupUIForView {
    float padding = 3.0;
    float hStepIcon = 22.0;
    float hLabel = 20.0;
    float wButton = 80.0;
    float wSepa = 60.0;
    
    self.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    lbSepa2.textColor = lbSepa1.textColor = lbSepa3.textColor = GRAY_200;
    lbSepa2.text = lbSepa1.text = lbSepa3.text = @"--------";
    lbSepa2.clipsToBounds = lbTwo.clipsToBounds = lbOne.clipsToBounds = lbThree.clipsToBounds = lbFour.clipsToBounds = TRUE;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hStepIcon = 35.0;
        hLabel = 30.0;
        wButton = 120.0;
        wSepa = 100;
        
        lbSepa2.text = lbSepa1.text = lbSepa3.text = @"------------";
    }
    
    
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(wSepa);
        make.height.mas_equalTo(hStepIcon);
    }];
    
    lbTwo.backgroundColor = lbThree.backgroundColor = lbFour.backgroundColor = GRAY_200;
    lbTwo.layer.cornerRadius = lbOne.layer.cornerRadius = lbThree.layer.cornerRadius = lbFour.layer.cornerRadius = hStepIcon/2;
    
    [lbTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa2.mas_left).offset(-padding);
        make.centerY.equalTo(lbSepa2.mas_centerY);
        make.width.height.mas_equalTo(hStepIcon);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbTwo.mas_left).offset(-padding);
        make.top.bottom.equalTo(lbSepa2);
        make.width.equalTo(lbSepa2.mas_width);
    }];
    
    lbOne.backgroundColor = BLUE_COLOR;
    [lbOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbSepa1.mas_left).offset(-padding);
        make.top.bottom.equalTo(lbTwo);
        make.width.mas_equalTo(hStepIcon);
    }];
    
    [lbThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa2.mas_right).offset(padding);
        make.top.bottom.equalTo(lbTwo);
        make.width.mas_equalTo(hStepIcon);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbThree.mas_right).offset(padding);
        make.top.bottom.equalTo(lbSepa2);
        make.width.equalTo(lbSepa2.mas_width);
    }];
    
    [lbFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa3.mas_right).offset(padding);
        make.top.bottom.equalTo(lbTwo);
        make.width.mas_equalTo(hStepIcon);
    }];
    
    //  content
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbOne.mas_bottom);
        make.centerX.equalTo(lbOne.mas_centerX);
        make.height.mas_equalTo(hLabel);
        make.width.mas_equalTo(wButton);
    }];
    
    [lbConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbProfile);
        make.centerX.equalTo(lbTwo.mas_centerX);
        make.width.equalTo(lbProfile.mas_width);
    }];
    
    [lbPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbProfile);
        make.centerX.equalTo(lbThree.mas_centerX);
        make.width.equalTo(lbProfile.mas_width);
    }];
    
    [lbDone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbProfile);
        make.centerX.equalTo(lbFour.mas_centerX);
        make.width.equalTo(lbProfile.mas_width);
    }];
    
    [btnStepOne setTitle:@"" forState:UIControlStateNormal];
    [btnStepOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbOne);
        make.left.right.bottom.equalTo(lbProfile);
    }];
    
    [btnStepTwo setTitle:@"" forState:UIControlStateNormal];
    [btnStepTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTwo);
        make.left.right.bottom.equalTo(lbConfirm);
    }];
    
    [btnStepThree setTitle:@"" forState:UIControlStateNormal];
    [btnStepThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbThree);
        make.left.right.bottom.equalTo(lbPayment);
    }];
    
    [btnStepFour setTitle:@"" forState:UIControlStateNormal];
    [btnStepFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFour);
        make.left.right.bottom.equalTo(lbDone);
    }];
    
    lbProfile.font = lbConfirm.font = lbPayment.font = lbDone.font  = lbOne.font = lbTwo.font = lbThree.font = lbFour.font = [AppDelegate sharedInstance].fontNormal;
}

- (IBAction)btnStepOnePress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(pressOnMenuButton:)]) {
        [delegate pressOnMenuButton: ePaymentProfile];
    }
}

- (IBAction)btnStepTwoPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(pressOnMenuButton:)]) {
        [delegate pressOnMenuButton: ePaymentConfirm];
    }
}

- (IBAction)btnStepThreePress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(pressOnMenuButton:)]) {
        [delegate pressOnMenuButton: ePaymentCharge];
    }
}

- (IBAction)btnStepFourPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(pressOnMenuButton:)]) {
        [delegate pressOnMenuButton: ePaymentDone];
    }
}

- (void)updateUIForStep: (PaymentStep)step {
    if (step == ePaymentProfile) {
        lbProfile.textColor = lbOne.backgroundColor = BLUE_COLOR;
        lbSepa1.textColor = lbSepa2.textColor = lbSepa3.textColor = GRAY_200;
        lbTwo.backgroundColor = lbThree.backgroundColor = lbFour.backgroundColor = GRAY_200;
        lbConfirm.textColor = lbPayment.textColor = lbDone.textColor = GRAY_200;
        
    }else if (step == ePaymentConfirm) {
        lbProfile.textColor = lbConfirm.textColor = lbOne.backgroundColor = lbTwo.backgroundColor = lbSepa1.textColor = BLUE_COLOR;
        lbSepa2.textColor = lbSepa3.textColor = GRAY_200;
        lbThree.backgroundColor = lbFour.backgroundColor = GRAY_200;
        lbPayment.textColor = lbDone.textColor = GRAY_200;
        
    }else if (step == ePaymentCharge) {
        lbProfile.textColor = lbConfirm.textColor = lbPayment.textColor = lbOne.backgroundColor = lbTwo.backgroundColor = lbThree.backgroundColor = lbSepa1.textColor = lbSepa2.textColor = BLUE_COLOR;
        
        lbSepa3.textColor = lbFour.backgroundColor = lbDone.textColor = GRAY_200;
        
    }else{
        lbProfile.textColor = lbConfirm.textColor = lbPayment.textColor = lbDone.textColor = lbOne.backgroundColor = lbTwo.backgroundColor = lbThree.backgroundColor = lbFour.backgroundColor = lbSepa1.textColor = lbSepa2.textColor = lbSepa3.textColor = BLUE_COLOR;
    }
}

@end
