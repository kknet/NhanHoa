//
//  CheckDomainForRegisterHostingView.m
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CheckDomainForRegisterHostingView.h"

@implementation CheckDomainForRegisterHostingView
@synthesize lbBackground, viewContent, lbTitle, tfDomain, btnRegister, viewResult, lbResult;
@synthesize hContentView, padding;
@synthesize delegate;

- (void)setupUIForView
{
    self.backgroundColor = UIColor.clearColor;
    
    padding = 15.0;
    float hBTN = 50.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hBTN = 50.0;
    }
    
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    lbBackground.userInteractionEnabled = TRUE;
    [lbBackground addGestureRecognizer: tapClose];
    
    lbBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [lbBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    hContentView = padding + 50.0 + padding + hBTN + padding + (2*hBTN) + padding + hBTN + 2*padding;
    
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
    
    tfDomain.textColor = GRAY_80;
    tfDomain.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-2];
    tfDomain.borderStyle = UITextBorderStyleNone;
    tfDomain.layer.borderColor = GRAY_150.CGColor;
    tfDomain.layer.borderWidth = 1.0;
    tfDomain.layer.cornerRadius = 5.0;
    [tfDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(hBTN);
    }];
    tfDomain.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hBTN)];
    tfDomain.leftViewMode = UITextFieldViewModeAlways;
    
    tfDomain.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hBTN)];
    tfDomain.rightViewMode = UITextFieldViewModeAlways;
    
    //  view search result
    viewResult.layer.cornerRadius = 5.0;
    viewResult.clipsToBounds = TRUE;
    viewResult.hidden = TRUE;
    [viewResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfDomain.mas_bottom).offset(padding);
        make.left.right.equalTo(tfDomain);
        make.height.mas_equalTo(2*hBTN);
    }];
    
    lbResult.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-4];
    [lbResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewResult).offset(padding);
        make.right.equalTo(viewResult).offset(-padding);
        make.centerY.equalTo(viewResult.mas_centerY);
    }];
    
    [btnRegister setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Register hosting"] forState:UIControlStateNormal];
    btnRegister.backgroundColor = BLUE_COLOR;
    [btnRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnRegister.layer.cornerRadius = 8.0;
    btnRegister.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    [btnRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewContent).offset(-2*padding);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)closeView {
    if (tfDomain.isFirstResponder) {
        NSLog(@"keyboard dang duoc show");
        [self endEditing: TRUE];
    }else{
        [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(SCREEN_HEIGHT);
        }];
        [UIView animateWithDuration:0.1 animations:^{
            [self layoutIfNeeded];
        }completion:^(BOOL finished) {
            lbBackground.hidden = TRUE;
            if ([delegate respondsToSelector:@selector(closeCheckDomainView)]) {
                [delegate closeCheckDomainView];
            }
        }];
    }
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    float originY = SCREEN_HEIGHT - (hContentView + keyboardHeight) + padding;
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(originY);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    float originY = SCREEN_HEIGHT - hContentView + padding;
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(originY);
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

- (IBAction)btnRegisterPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(confirmAfterCheckDomainView)]) {
        [delegate confirmAfterCheckDomainView];
    }
}

@end
