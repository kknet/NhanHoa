//
//  ProfileDetailsViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailsViewController.h"

@interface ProfileDetailsViewController ()

@end

@implementation ProfileDetailsViewController

@synthesize scvContent, lbType, lbTypeValue, lbFullname, lbFullnameValue, lbBOD, lbBODValue, lbPassport, lbPassportValue, lbAddress, lbAddressValue, lbPhone, lbPhoneValue, lbEmail, lbEmailValue, imgPassport, lbPassportTitle, imgPassportFront, lbPassportFront, imgPassportBehind, lbPassportBehid, btnUpdate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnUpdatePress:(UIButton *)sender {
}

- (void)setupUIForView {
    float hItem = 30.0;
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:16.0];
    UIFont *mediumFont = [UIFont fontWithName:RobotoMedium size:16.0];
    
    float smallSize = [AppUtils getSizeWithText:@"Họ tên đầy đủ" withFont:textFont].width + 10.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  domain type
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent).offset(padding);
        make.left.equalTo(self.scvContent).offset(padding);
        make.width.mas_equalTo(smallSize);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbTypeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbType);
        make.left.equalTo(self.lbType.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding-smallSize);
    }];
    
    //  fullname
    [lbFullname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbType.mas_bottom);
        make.left.right.equalTo(self.lbType);
        make.height.equalTo(self.lbType.mas_height);
    }];
    
    [lbFullnameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbFullname);
        make.left.right.equalTo(self.lbTypeValue);
    }];
    
    //  birth of date
    [lbBOD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbFullname.mas_bottom);
        make.left.right.equalTo(self.lbFullname);
        make.height.equalTo(self.lbFullname.mas_height);
    }];
    
    [lbBODValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbBOD);
        make.left.right.equalTo(self.lbFullnameValue);
    }];
    
    //  passport
    [lbPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbBOD.mas_bottom);
        make.left.right.equalTo(self.lbBOD);
        make.height.equalTo(self.lbBOD.mas_height);
    }];
    
    [lbPassportValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPassport);
        make.left.right.equalTo(self.lbBODValue);
    }];
    
    //  Adress
    [lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassport.mas_bottom);
        make.left.right.equalTo(self.lbPassport);
        make.height.equalTo(self.lbPassport.mas_height);
    }];
    
    [lbAddressValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddress);
        make.left.right.equalTo(self.lbPassportValue);
        make.height.mas_equalTo(2*hItem);
    }];
    
    //  Phone
    [lbPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbAddressValue.mas_bottom);
        make.left.right.equalTo(self.lbAddress);
        make.height.equalTo(self.lbAddress.mas_height);
    }];
    
    [lbPhoneValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPhone);
        make.left.right.equalTo(self.lbAddressValue);
    }];
    
    //  Email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPhone.mas_bottom);
        make.left.right.equalTo(self.lbPhone);
        make.height.equalTo(self.lbPhone.mas_height);
    }];
    
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbEmail);
        make.left.right.equalTo(self.lbPhoneValue);
    }];
    
    //  Passport info
    [imgPassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbEmail.mas_bottom).offset((hItem-20)/2);
        make.left.equalTo(self.lbEmail);
        make.width.height.mas_equalTo(20);
    }];
    
    [lbPassportTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgPassport.mas_centerY);
        make.left.equalTo(self.imgPassport.mas_right).offset(5.0);
        make.right.equalTo(self.lbEmailValue.mas_right);
        make.height.mas_equalTo(hItem);
    }];
    
    float wPassport = (SCREEN_WIDTH-3*padding)/2;
    float hPassport = wPassport * 2/3;
    imgPassportFront.clipsToBounds = TRUE;
    [imgPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPassportTitle.mas_bottom);
        make.left.equalTo(self.lbEmail);
        make.width.mas_equalTo(wPassport);
        make.height.mas_equalTo(hPassport);
    }];
    
    [lbPassportFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgPassportFront.mas_bottom);
        make.left.right.equalTo(self.imgPassportFront);
        make.height.mas_equalTo(hItem);
    }];
    
    imgPassportBehind.clipsToBounds = TRUE;
    [imgPassportBehind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbPassportTitle.mas_bottom);
        make.left.equalTo(self.imgPassportFront.mas_right).offset(padding);
        make.width.mas_equalTo(wPassport);
    }];
    
    [lbPassportBehid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgPassportBehind.mas_bottom);
        make.left.right.equalTo(self.imgPassportBehind);
        make.height.mas_equalTo(hItem);
    }];
    
    lbType.font = lbFullname.font = lbBOD.font = lbPassport.font = lbAddress.font = lbPhone.font = lbEmail.font = lbPassportFront.font = lbPassportBehid.font = textFont;
    
    lbTypeValue.font = lbFullnameValue.font = lbBODValue.font = lbPassportValue.font = lbAddressValue.font = lbPhoneValue.font = lbEmailValue.font = lbPassportFrontValue.font = lbPassportBehidValue.font = mediumFont;
    
    lbType.textColor = lbTypeValue.textColor = lbFullname.textColor = lbFullnameValue.textColor = lbBOD.textColor = lbBODValue.textColor = lbPassport.textColor = lbPassportValue.textColor = lbAddress.textColor = lbAddressValue.textColor = lbPhone.textColor = lbPhoneValue.textColor = lbEmail.textColor = lbEmailValue.textColor = lbPassportTitle.textColor = lbPassportFront.textColor = lbPassportBehid.textColor = TITLE_COLOR;
}

@end
