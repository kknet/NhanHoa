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
        make.top.equalTo(self.viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.bottom.equalTo(self.viewHeader);
        make.width.mas_equalTo([AppDelegate sharedInstance].hNav);
    }];
    
    lbHeader.font = [AppDelegate sharedInstance].fontBTN;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.width.mas_equalTo(200);
    }];
    
    //  email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom).offset(2*padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    [AppUtils setBorderForTextfield:tfEmail borderColor:BORDER_COLOR];
    tfEmail.keyboardType = UIKeyboardTypeEmailAddress;
    [tfEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom);
        make.left.right.equalTo(self.lbEmail);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  content
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfEmail.mas_bottom ).offset(padding);
        make.left.right.equalTo(self.tfEmail);
        make.height.equalTo(self.lbEmail.mas_height);
    }];
    
    tvContent.text = @"";
    tvContent.layer.borderWidth = 1.0;
    tvContent.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tvContent.layer.borderColor = BORDER_COLOR.CGColor;
    [tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbContent.mas_bottom);
        make.left.right.equalTo(self.lbContent);
        make.height.mas_equalTo(3*[AppDelegate sharedInstance].hTextfield);
    }];
    
    //  footer button
    
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnReset.layer.cornerRadius = 45.0/2;
    btnReset.backgroundColor = OLD_PRICE_COLOR;
    btnReset.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    btnReset.layer.borderWidth = 1.0;
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self).offset(-padding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnSend setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSend.layer.cornerRadius = btnReset.layer.cornerRadius;
    btnSend.backgroundColor = BLUE_COLOR;
    btnSend.layer.borderColor = BLUE_COLOR.CGColor;
    btnSend.layer.borderWidth = 1.0;
    [btnSend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnReset.mas_right).offset(padding);
        make.top.bottom.equalTo(self.btnReset);
        make.right.equalTo(self).offset(-padding);
    }];
    
    btnReset.titleLabel.font = btnSend.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    tfEmail.font = tvContent.font = [AppDelegate sharedInstance].fontRegular;
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
        [self makeToast:@"Vui lòng nhập email của bạn" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tvContent.text]) {
        [self makeToast:@"Vui lòng nhập nội dung muốn gửi" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
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
