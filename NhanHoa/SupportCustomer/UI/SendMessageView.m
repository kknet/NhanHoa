//
//  SendMessageView.m
//  NhanHoa
//
//  Created by Khai Leo on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SendMessageView.h"

@implementation SendMessageView
@synthesize viewHeader, icClose, lbHeader, lbEmail, tfEmail, lbContent,tvContent, btnSend, btnReset;
@synthesize delegate;

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hBTN = 45.0;
    float hLabel = 30.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hBTN = 55.0;
        hLabel = 40.0;
    }
    
    self.clipsToBounds = TRUE;
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    self.userInteractionEnabled = TRUE;
    [self addGestureRecognizer: tapOnScreen];
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.bottom.equalTo(viewHeader);
        make.width.mas_equalTo([AppDelegate sharedInstance].hNav);
    }];
    
    lbHeader.font = [AppDelegate sharedInstance].fontBTN;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icClose);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250);
    }];
    
    //  email
    lbEmail.text = text_email_address;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(2*padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom);
        make.left.right.equalTo(lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  content
    lbContent.text = text_question_content;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfEmail.mas_bottom ).offset(padding);
        make.left.right.equalTo(tfEmail);
        make.height.equalTo(lbEmail.mas_height);
    }];
    
    tvContent.text = @"";
    tvContent.layer.borderWidth = 1.0;
    tvContent.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tvContent.layer.borderColor = BORDER_COLOR.CGColor;
    [tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbContent.mas_bottom);
        make.left.right.equalTo(lbContent);
        make.height.mas_equalTo(3*[AppDelegate sharedInstance].hTextfield);
    }];
    
    //  footer button
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    btnReset.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    [btnReset setTitle:text_reset forState:UIControlStateNormal];
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self).offset(-padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    [btnSend setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSend.backgroundColor = BLUE_COLOR;
    btnSend.layer.borderColor = BLUE_COLOR.CGColor;
    [btnSend setTitle:text_send_message forState:UIControlStateNormal];
    [btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnReset.mas_right).offset(padding);
        make.top.bottom.equalTo(btnReset);
        make.right.equalTo(self).offset(-padding);
    }];
    
    btnReset.layer.cornerRadius = btnSend.layer.cornerRadius = hBTN/2;
    btnReset.layer.borderWidth = btnSend.layer.borderWidth = 1.0;
    
    btnReset.titleLabel.font = btnSend.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    lbEmail.font = tfEmail.font = lbContent.font = tvContent.font = [AppDelegate sharedInstance].fontRegular;
}

- (IBAction)btnResetPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:OLD_PRICE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startResetAllValue) withObject:nil afterDelay:0.05];
}

- (void)startResetAllValue {
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    tfEmail.text = tvContent.text = @"";
}

- (IBAction)btnSendPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:OLD_PRICE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startSendMessage) withObject:nil afterDelay:0.05];
}

- (void)startSendMessage {
    btnSend.backgroundColor = BLUE_COLOR;
    [btnSend setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfEmail.text]) {
        [self makeToast:pls_enter_your_email duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tvContent.text]) {
        [self makeToast:pls_enter_question_content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([delegate respondsToSelector:@selector(startToSendMessageWithEmail:content:)]) {
        [delegate startToSendMessageWithEmail:tfEmail.text content:tvContent.text];
    }
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if ([delegate respondsToSelector:@selector(closeSendMessageView)]) {
        [delegate closeSendMessageView];
    }
}
@end
