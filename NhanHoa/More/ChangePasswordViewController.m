//
//  ChangePasswordViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "WebServices.h"

@interface ChangePasswordViewController ()<WebServicesDelegate> {
    WebServices *webService;
}
@end

@implementation ChangePasswordViewController
@synthesize lbOldPass, tfOldPass, lbNewPass, tfNewPass, lbConfirm, tfConfirm, btnSave, btnCancel, lbWarning;

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
    
    //  Old password
    lbOldPass.font = lbNewPass.font = lbConfirm.font = [AppDelegate sharedInstance].fontMedium;
    tfOldPass.font = tfNewPass.font = tfConfirm.font = [AppDelegate sharedInstance].fontRegular;
    
    lbOldPass.textColor = lbNewPass.textColor = lbConfirm.textColor = TITLE_COLOR;
    
    [lbOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.view).offset(10.0);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    tfOldPass.secureTextEntry = TRUE;
    [AppUtils setBorderForTextfield:tfOldPass borderColor:BORDER_COLOR];
    [tfOldPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbOldPass.mas_bottom);
        make.left.right.equalTo(self.lbOldPass);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    //  New password
    float widthText = [AppUtils getSizeWithText:lbNewPass.text withFont:lbNewPass.font].width + 10.0;
    [lbNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfOldPass.mas_bottom).offset(10.0);
        make.left.equalTo(self.tfOldPass);
        make.width.mas_equalTo(widthText);
        make.height.equalTo(self.lbOldPass.mas_height);
    }];
    
    lbWarning.font = [AppDelegate sharedInstance].fontItalic;
    lbWarning.textColor = NEW_PRICE_COLOR;
    [lbWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbNewPass);
        make.left.equalTo(self.lbNewPass.mas_right);
        make.right.equalTo(self.tfOldPass);
    }];
    
    tfNewPass.secureTextEntry = TRUE;
    [AppUtils setBorderForTextfield:tfNewPass borderColor:BORDER_COLOR];
    [tfNewPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbNewPass.mas_bottom);
        make.left.right.equalTo(self.lbNewPass);
        make.height.equalTo(self.tfOldPass.mas_height);
    }];
    
    //  Confirm password
    [lbConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfNewPass.mas_bottom).offset(10.0);
        make.left.right.equalTo(self.tfNewPass);
        make.height.equalTo(self.lbOldPass.mas_height);
    }];
    
    tfConfirm.secureTextEntry = TRUE;
    [AppUtils setBorderForTextfield:tfConfirm borderColor:BORDER_COLOR];
    [tfConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbConfirm.mas_bottom);
        make.left.right.equalTo(self.lbConfirm);
        make.height.equalTo(self.tfOldPass.mas_height);
    }];
    
    //  footer button
    float hBTN = 45.0;
    btnCancel.titleLabel.font = btnSave.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnCancel.layer.cornerRadius = btnSave.layer.cornerRadius = hBTN/2;
    
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btnCancel);
        make.left.equalTo(self.btnCancel.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    tfOldPass.text = tfNewPass.text = tfConfirm.text = @"";
}

- (IBAction)btnSavePress:(UIButton *)sender {
    if ([AppUtils isNullOrEmpty: tfOldPass.text]) {
        [self.view makeToast:@"Bạn chưa nhập mật khẩu hiện tại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfNewPass.text]) {
        [self.view makeToast:@"Bạn chưa nhập mật khẩu mới!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfConfirm.text]) {
        [self.view makeToast:@"Bạn chưa nhập mật khẩu xác nhận!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (![tfNewPass.text isEqualToString: tfConfirm.text]) {
        [self.view makeToast:@"Xác nhận mật khẩu không chính xác. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    NSString *oldMd5Pass = [AppUtils getMD5StringOfString: tfOldPass.text];
    if (![oldMd5Pass isEqualToString: PASSWORD]) {
        [self.view makeToast:@"Mật khẩu hiện tại bạn nhập không chính xác. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    NSString *newPass = [AppUtils getMD5StringOfString: tfNewPass.text];
    
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:change_password_mod forKey:@"mod"];
    [info setObject:USERNAME forKey:@"username"];
    [info setObject:PASSWORD forKey:@"old_password"];
    [info setObject:newPass forKey:@"new_password"];
    [info setObject:newPass forKey:@"re_new_password"];
    
    
}

@end
