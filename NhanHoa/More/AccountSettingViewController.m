//
//  AccountSettingViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "ChangePasswordViewController.h"
#import "AccountModel.h"

@interface AccountSettingViewController ()

@end

@implementation AccountSettingViewController

@synthesize btnAvatar, btnChoosePhoto, viewInfo, lbInfo, lbName, lbNameValue, lbID, lbIDValue, lbEmail, lbEmailValue, viewPassword, lbPasswordInfo, lbPassword, btnChangePassword, lbPasswordValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"AccountSettingViewController"];
    
    self.title = @"Cài đặt tài khoản";
    [self displayInformationForAccount];
}

- (void)displayInformationForAccount {
    lbNameValue.text = [AccountModel getCusRealName];
    lbIDValue.text = [AccountModel getCusIdOfUser];
    lbEmailValue.text = [AccountModel getCusEmail];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hItem = 40.0;
    
    [btnAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(20.0);
        make.width.height.mas_equalTo(100.0);
    }];
    
    [btnChoosePhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.btnAvatar.mas_bottom).offset(-5.0);
        make.width.height.mas_equalTo(22.0);
    }];
    
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnAvatar.mas_bottom).offset(20.0);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(50.0);
    }];
    
    lbInfo.textColor = TITLE_COLOR;
    lbInfo.font = [UIFont fontWithName:RobotoMedium size:17.0];
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewInfo);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    float maxText = [AppUtils getSizeWithText:@"Nhân Hoà ID:" withFont:[UIFont fontWithName:RobotoRegular size:17.0]].width;
    //  name
    lbName.textColor = TITLE_COLOR;
    lbName.font = [UIFont fontWithName:RobotoRegular size:17.0];
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom).offset(10.0);
        make.left.equalTo(self.view).offset(padding);
        make.width.mas_equalTo(maxText);
        make.height.mas_equalTo(hItem);
    }];
    
    lbNameValue.textColor = TITLE_COLOR;
    lbNameValue.font = lbInfo.font;
    [lbNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbName);
        make.left.equalTo(self.lbName.mas_right).offset(5.0);
        make.right.equalTo(self.view).offset(-padding);

    }];
    
    //  Nhan Hoa ID
    lbID.textColor = TITLE_COLOR;
    lbID.font = lbName.font;
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbName);
        make.top.equalTo(self.lbName.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    lbIDValue.textColor = TITLE_COLOR;
    lbIDValue.font = lbNameValue.font;
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbID);
        make.left.right.equalTo(self.lbNameValue);
        
    }];
    
    //  Email
    lbEmail.textColor = TITLE_COLOR;
    lbEmail.font = lbName.font;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbID);
        make.top.equalTo(self.lbID.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    lbEmailValue.textColor = TITLE_COLOR;
    lbEmailValue.font = lbNameValue.font;
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbEmail);
        make.left.right.equalTo(self.lbIDValue);
    }];
    
    //  view password
    [viewPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmailValue.mas_bottom).offset(5.0);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.viewInfo.mas_height);
    }];
    
    lbPasswordInfo.textColor = TITLE_COLOR;
    lbPasswordInfo.font = lbInfo.font;
    [lbPasswordInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewPassword);
        make.left.equalTo(self.viewPassword).offset(padding);
        make.right.equalTo(self.viewPassword).offset(-padding);
    }];
    
    //  password
    lbPassword.textColor = TITLE_COLOR;
    lbPassword.font = lbName.font;
    [lbPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbEmail);
        make.top.equalTo(self.viewPassword.mas_bottom).offset(5.0);
        make.height.mas_equalTo(hItem);
    }];
    
    lbPasswordValue.textColor = TITLE_COLOR;
    lbPasswordValue.font = lbNameValue.font;
    [lbPasswordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPassword);
        make.left.right.equalTo(self.lbEmailValue);
    }];
    
    btnChangePassword.layer.cornerRadius = 45.0/2;
    btnChangePassword.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnChangePassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
}

- (IBAction)btnChangePasswordPress:(UIButton *)sender {
    ChangePasswordViewController *changePassVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
    [self.navigationController pushViewController:changePassVC animated:TRUE];
}

- (IBAction)btnAvatarPress:(UIButton *)sender {
}

- (IBAction)btnChoosePhotoPress:(UIButton *)sender {
}
@end
