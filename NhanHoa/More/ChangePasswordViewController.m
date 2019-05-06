//
//  ChangePasswordViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize lbOldPass, tfOldPass, lbNewPass, tfNewPass, lbConfirm, tfConfirm, btnSave, btnCancel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.title = @"Đổi mật khẩu";
}

- (void)setupUIForView {
    float padding = 15.0;
    float hTextfield = 38.0;
    
    //  Old password
    lbOldPass.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbOldPass.textColor = TITLE_COLOR;
    [lbOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.view).offset(10.0);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    tfOldPass.secureTextEntry = TRUE;
    tfOldPass.font = [UIFont fontWithName:RobotoRegular size:17.0];
    tfOldPass.layer.cornerRadius = 5.0;
    tfOldPass.layer.borderColor = BORDER_COLOR.CGColor;
    tfOldPass.layer.borderWidth = 1.0;
    [tfOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOldPass.mas_bottom);
        make.left.right.equalTo(self.lbOldPass);
        make.height.mas_equalTo(hTextfield);
    }];
    tfOldPass.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, hTextfield)];
    tfOldPass.leftViewMode = UITextFieldViewModeAlways;
    
    //  New password
    lbNewPass.font = lbOldPass.font;
    lbNewPass.textColor = TITLE_COLOR;
    [lbNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfOldPass.mas_bottom).offset(10.0);
        make.left.right.equalTo(self.tfOldPass);
        make.height.equalTo(self.lbOldPass.mas_height);
    }];
    
    tfNewPass.secureTextEntry = TRUE;
    tfNewPass.layer.cornerRadius = tfOldPass.layer.cornerRadius;
    tfNewPass.layer.borderColor = tfOldPass.layer.borderColor;
    tfNewPass.layer.borderWidth = tfOldPass.layer.borderWidth;
    tfNewPass.font = tfOldPass.font;
    [tfNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbNewPass.mas_bottom);
        make.left.right.equalTo(self.lbNewPass);
        make.height.equalTo(self.tfOldPass.mas_height);
    }];
    tfNewPass.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, hTextfield)];
    tfNewPass.leftViewMode = UITextFieldViewModeAlways;
    
    //  Confirm password
    lbConfirm.font = lbOldPass.font;
    lbConfirm.textColor = TITLE_COLOR;
    [lbConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfNewPass.mas_bottom).offset(10.0);
        make.left.right.equalTo(self.tfNewPass);
        make.height.equalTo(self.lbOldPass.mas_height);
    }];
    
    tfConfirm.secureTextEntry = TRUE;
    tfConfirm.layer.cornerRadius = tfOldPass.layer.cornerRadius;
    tfConfirm.layer.borderColor = tfOldPass.layer.borderColor;
    tfConfirm.layer.borderWidth = tfOldPass.layer.borderWidth;
    tfConfirm.font = tfOldPass.font;
    [tfConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbConfirm.mas_bottom);
        make.left.right.equalTo(self.lbConfirm);
        make.height.equalTo(self.tfOldPass.mas_height);
    }];
    tfConfirm.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, hTextfield)];
    tfConfirm.leftViewMode = UITextFieldViewModeAlways;
    
    //  footer button
    float hBTN = 45.0;
    btnCancel.layer.cornerRadius = hBTN/2;
    btnCancel.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.layer.cornerRadius = hBTN/2;
    btnSave.backgroundColor = BLUE_COLOR;
    btnSave.titleLabel.font = btnCancel.titleLabel.font;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btnCancel);
        make.left.equalTo(self.btnCancel.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
}

- (IBAction)btnCancelPress:(UIButton *)sender {
}

- (IBAction)btnSavePress:(UIButton *)sender {
}
@end
