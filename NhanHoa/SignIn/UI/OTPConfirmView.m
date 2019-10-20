//
//  OTPConfirmView.m
//  NhanHoa
//
//  Created by Khai Leo on 6/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OTPConfirmView.h"

@implementation OTPConfirmView

@synthesize lbTitle, tfChar1, tfChar2, tfChar3, tfChar4, btnConfirm, btnResend, lbNotReceived, delegate;

- (void)setupUIForView
{
    self.backgroundColor = BORDER_COLOR;
    
    float sizeBox = 70.0;
    float hBTN = 55.0;
    float padding = 20.0;
    
    UIFont *titleFont = [UIFont fontWithName:RobotoRegular size:28.0];
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:24.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        titleFont = [UIFont fontWithName:RobotoRegular size:22.0];
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        sizeBox = 50.0;
        hBTN = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        titleFont = [UIFont fontWithName:RobotoRegular size:24.0];
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        sizeBox = 55.0;
        hBTN = 52.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        titleFont = [UIFont fontWithName:RobotoRegular size:26.0];
        textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        sizeBox = 60.0;
        hBTN = 55.0;
    }
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = titleFont;
    lbTitle.text = [[[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter confirm code"] uppercaseString];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([UIApplication sharedApplication].statusBarFrame.size.height + 30.0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(60.0);
    }];
    
    //  char 2
    tfChar2.returnKeyType = UIReturnKeyNext;
    [tfChar2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.width.height.mas_equalTo(sizeBox);
    }];
    [tfChar2 addTarget:self
                action:@selector(onTextfieldDidChange:)
      forControlEvents:UIControlEventEditingChanged];
    
    //  char 1
    tfChar1.returnKeyType = UIReturnKeyNext;
    [tfChar1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfChar2);
        make.right.equalTo(tfChar2.mas_left).offset(-padding);
        make.width.equalTo(tfChar2.mas_width);
    }];
    [tfChar1 addTarget:self
                action:@selector(onTextfieldDidChange:)
      forControlEvents:UIControlEventEditingChanged];
    
    //  char 3
    tfChar3.returnKeyType = UIReturnKeyNext;
    [tfChar3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfChar2);
        make.left.equalTo(tfChar2.mas_right).offset(padding);
        make.width.equalTo(tfChar2.mas_width);
    }];
    [tfChar3 addTarget:self
                action:@selector(onTextfieldDidChange:)
      forControlEvents:UIControlEventEditingChanged];
    
    //  char 4
    tfChar4.returnKeyType = UIReturnKeyDone;
    [tfChar4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(tfChar3);
        make.left.equalTo(tfChar3.mas_right).offset(padding);
        make.width.equalTo(tfChar3.mas_width);
    }];
    [tfChar4 addTarget:self
                action:@selector(onTextfieldDidChange:)
      forControlEvents:UIControlEventEditingChanged];
    
    btnConfirm.titleLabel.font = textFont;
    btnConfirm.layer.cornerRadius = 5.0;
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnConfirm setTitle:text_confirm forState:UIControlStateNormal];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfChar3.mas_bottom).offset(2*padding);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(200.0);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbNotReceived.textColor = UIColor.grayColor;
    lbNotReceived.font = textFont;
    lbNotReceived.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Did not receive OTP code?"];
    [lbNotReceived mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnConfirm.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    
    [btnResend setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnResend.titleLabel.font = textFont;
    [btnResend setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Resend"]
               forState:UIControlStateNormal];
    [btnResend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbNotReceived.mas_bottom);
        make.left.right.equalTo(lbNotReceived);
        make.height.mas_equalTo(hBTN);
    }];
    
    tfChar1.textColor = tfChar2.textColor = tfChar3.textColor = tfChar4.textColor = TITLE_COLOR;
    tfChar1.font = tfChar2.font = tfChar3.font = tfChar4.font = [UIFont fontWithName:RobotoMedium size:30.0];
    tfChar1.keyboardType = tfChar2.keyboardType = tfChar3.keyboardType = tfChar4.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)onTextfieldDidChange: (UITextField *)textfield {
    //  avoid pass value
    if (textfield.text.length > 1) {
        return;
    }
    
    if (textfield == tfChar1) {
        if (textfield.text.length > 0) {
            [tfChar2 becomeFirstResponder];
        }
    }else if (textfield == tfChar2) {
        if (textfield.text.length > 0) {
            [tfChar3 becomeFirstResponder];
        }
    }else if (textfield == tfChar3) {
        if (textfield.text.length > 0) {
            [tfChar4 becomeFirstResponder];
        }
    }
}

- (IBAction)btnResendPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onResendOTPPress)]) {
        [delegate onResendOTPPress];
    }
}

- (IBAction)btnConfirmPress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfChar1.text] || [AppUtils isNullOrEmpty: tfChar2.text] || [AppUtils isNullOrEmpty: tfChar3.text] || [AppUtils isNullOrEmpty: tfChar4.text])
    {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter confirm code"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(confirmOTPWithCode:)]) {
        NSString *code = SFM(@"%@%@%@%@", tfChar1.text, tfChar2.text, tfChar3.text, tfChar4.text);
        [delegate confirmOTPWithCode: code];
    }
}

@end
