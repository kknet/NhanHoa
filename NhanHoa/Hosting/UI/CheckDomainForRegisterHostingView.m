//
//  CheckDomainForRegisterHostingView.m
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CheckDomainForRegisterHostingView.h"

@implementation CheckDomainForRegisterHostingView
@synthesize lbBackground, viewContent, lbTitle, tfDomain, btnRegister, viewResult, imgResult, lbResult, icCheck, icBack;
@synthesize hContentView, padding, hImgResult;
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
    
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboardView)];
    viewContent.userInteractionEnabled = TRUE;
    [viewContent addGestureRecognizer: tapClose];
    
    lbBackground.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [lbBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    float hResultView = 300;
    hContentView = padding + 50.0 + padding + hBTN + padding + hResultView + padding + hBTN + 2*padding;
    
    viewContent.backgroundColor = UIColor.whiteColor;
    viewContent.layer.cornerRadius = 10.0;
    viewContent.clipsToBounds = TRUE;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hContentView);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContent).offset(padding);
        make.left.equalTo(viewContent);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContent).offset(padding);
        make.left.equalTo(icBack.mas_right).offset(5.0);
        make.right.equalTo(viewContent).offset(-40.0 - 5.0);
        make.height.mas_equalTo(50.0);
    }];
    
    icCheck.layer.cornerRadius = 10.0;
    icCheck.backgroundColor = BLUE_COLOR;
    icCheck.imageEdgeInsets = UIEdgeInsetsMake(14, 14, 14, 14);
    [icCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.width.height.mas_equalTo(hBTN);
    }];
    
    tfDomain.textColor = GRAY_150;
    tfDomain.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-2];
    tfDomain.borderStyle = UITextBorderStyleNone;
    tfDomain.layer.borderColor = GRAY_200.CGColor;
    tfDomain.layer.borderWidth = 1.0;
    tfDomain.layer.cornerRadius = 5.0;
    [tfDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(icCheck.mas_left).offset(-10.0);
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
        make.top.equalTo(tfDomain.mas_bottom);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(hResultView);
    }];
    
    hImgResult = 80.0;
    [imgResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewResult).offset(3*padding);
        make.centerX.equalTo(viewResult.mas_centerX);
        make.height.mas_equalTo(hImgResult);
        make.width.mas_equalTo(0);
    }];
    
    
    lbResult.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbResult.textColor = GRAY_150;
    [lbResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgResult.mas_bottom).offset(padding);
        make.left.equalTo(viewResult).offset(padding);
        make.right.equalTo(viewResult).offset(-padding);
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
}

- (void)closeKeyboardView {
    [self endEditing: TRUE];
}

- (void)closeView {
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

- (void)showContentInfoView {
    float originY = SCREEN_HEIGHT - hContentView + padding;
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(originY);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        [tfDomain becomeFirstResponder];
    }];
}

- (IBAction)btnRegisterPress:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(confirmAfterCheckDomainView)]) {
        [delegate confirmAfterCheckDomainView];
    }
}

- (IBAction)icCheckClick:(UIButton *)sender
{
    [self endEditing: TRUE];
    viewResult.hidden = FALSE;
    
    UIImage *imgOK = [UIImage imageNamed:@"search_domain_ok"];
    float wImage = hImgResult * imgOK.size.width / imgOK.size.height;
    imgResult.image = imgOK;
    [imgResult mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(wImage);
    }];
    
    lbResult.text = SFM(@"%@!\n%@", @"Tên miền này đã được đăng ký", @"Bạn có thể sử dụng tên miền này để đăng ký hosting");
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self closeView];
}

@end
