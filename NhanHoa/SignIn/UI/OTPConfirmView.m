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

- (void)setupUIForView {
    float padding = 20.0;
    float sizeBox = 50.0;
    float hBTN = 45.0;
    float wBTN = 200.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 40.0;
        sizeBox= 70.0;
        hBTN = 55.0;
        wBTN = 350.0;
    }
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [AppDelegate sharedInstance].fontBTN;
    lbTitle.text = text_enter_confirm_code;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50.0);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(40.0);
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
    
    btnConfirm.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnConfirm.layer.cornerRadius = 5.0;
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnConfirm setTitle:text_confirm forState:UIControlStateNormal];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfChar3.mas_bottom).offset(2*padding);
        make.centerX.equalTo(self.mas_centerX);
        make.width.mas_equalTo(wBTN);
        make.height.mas_equalTo(hBTN);
    }];
    
    float widthText = [AppUtils getSizeWithText:did_not_receive_otp_code withFont:[AppDelegate sharedInstance].fontRegular].width + 5;
    float widthBTN = [AppUtils getSizeWithText:text_resend withFont:[AppDelegate sharedInstance].fontRegular].width;
    float originX = (SCREEN_WIDTH - widthText - widthBTN)/2;
    
    lbNotReceived.textColor = UIColor.grayColor;
    lbNotReceived.font = [AppDelegate sharedInstance].fontBTN;
    lbNotReceived.text = did_not_receive_otp_code;
    [lbNotReceived mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnConfirm.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(originX);
        make.width.mas_equalTo(widthText);
        make.height.mas_equalTo(40.0);
    }];
    
    [btnResend setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnResend.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnResend setTitle:text_resend forState:UIControlStateNormal];
    [btnResend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbNotReceived);
        make.left.equalTo(lbNotReceived.mas_right);
        make.width.mas_equalTo(widthBTN);
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
        [self makeToast:pls_enter_confirm_code duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(confirmOTPWithCode:)]) {
        NSString *code = SFM(@"%@%@%@%@", tfChar1.text, tfChar2.text, tfChar3.text, tfChar4.text);
        [delegate confirmOTPWithCode: code];
    }
}

@end
