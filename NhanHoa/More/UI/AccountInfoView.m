//
//  AccountInfoView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccountInfoView.h"
#import "AccountModel.h"

@implementation AccountInfoView
@synthesize imgAvatar, lbName, lbEmail, imgSepa, viewWallet, imgWallet, lbMainAccount, lbMainMoney, viewReward, lbRewardMoney, lbRewardAccount, imgReward;

- (void)setupUIForView {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 7.0;
    
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.cornerRadius = 60.0/2;
    imgAvatar.layer.borderColor = BLUE_COLOR.CGColor;
    imgAvatar.layer.borderWidth = 1.0;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(10.0);
        make.width.height.mas_equalTo(60.0);
    }];
    
    lbName.font = [UIFont fontWithName:RobotoMedium size:18.0];
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAvatar.mas_right).offset(5.0);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self.imgAvatar.mas_centerY).offset(-2.5);
    }];
    
    lbEmail.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbEmail.textColor = TITLE_COLOR;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbName);
        make.top.equalTo(self.imgAvatar.mas_centerY).offset(2.5);
    }];
    
    imgSepa.backgroundColor = BORDER_COLOR;
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAvatar);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.imgAvatar.mas_bottom).offset(10.0);
        make.height.mas_equalTo(1.0);
    }];
    
    //  main wallet
    viewWallet.backgroundColor = UIColor.clearColor;
    [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgSepa.mas_bottom).offset(10.0);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    imgWallet.layer.cornerRadius = 35.0/2;
    imgWallet.clipsToBounds = TRUE;
    [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewWallet).offset(padding);
        make.centerY.equalTo(self.viewWallet.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbMainAccount.textColor = TITLE_COLOR;
    lbMainAccount.font = [UIFont fontWithName:RobotoRegular size:14.0];
    [lbMainAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgWallet.mas_right).offset(2.0);
        make.bottom.equalTo(self.imgWallet.mas_centerY).offset(-1.0);
        make.right.equalTo(self.viewWallet);
    }];
    
    lbMainMoney.font = [UIFont fontWithName:RobotoMedium size:14.0];
    lbMainMoney.textColor = ORANGE_COLOR;
    [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbMainAccount);
        make.top.equalTo(self.imgWallet.mas_centerY).offset(1.0);
    }];
    
    //  reward wallet
    viewReward.backgroundColor = UIColor.clearColor;
    [viewReward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewWallet);
        make.right.equalTo(self);
        make.left.equalTo(self.mas_centerX).offset(padding/2);
    }];
    
    imgReward.layer.cornerRadius = 35.0/2;
    imgReward.clipsToBounds = TRUE;
    [imgReward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewReward);
        make.centerY.equalTo(self.viewReward.mas_centerY);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbRewardAccount.textColor = TITLE_COLOR;
    lbRewardAccount.font = lbMainAccount.font;
    [lbRewardAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgReward.mas_right).offset(2.0);
        make.bottom.equalTo(self.imgReward.mas_centerY).offset(-1.0);
        make.right.equalTo(self.viewReward).offset(-padding);
    }];
    
    lbRewardMoney.font = lbMainMoney.font;
    lbRewardMoney.textColor = ORANGE_COLOR;
    [lbRewardMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRewardAccount);
        make.top.equalTo(self.imgReward.mas_centerY).offset(1.0);
    }];
    
}

- (void)displayInformation
{
    NSString *realName = [AccountModel getCusRealName];
    if (![AppUtils isNullOrEmpty: realName]) {
        lbName.text = realName;
    }else{
        lbName.text = @"Chưa cập nhật";
    }
    
    NSString *email = [AccountModel getCusEmail];
    if (![AppUtils isNullOrEmpty: email]) {
        lbEmail.text = email;
    }else{
        lbEmail.text = @"";
    }
    
    NSString *balance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: balance]) {
        balance = [AppUtils convertStringToCurrencyFormat: balance];
        lbMainMoney.text = [NSString stringWithFormat:@"%@VNĐ", balance];
    }else{
        lbMainMoney.text = @"0VNĐ";
    }
    
    NSString *points = [AccountModel getCusPoint];
    if (![AppUtils isNullOrEmpty: points]) {
        points = [AppUtils convertStringToCurrencyFormat: points];
        lbRewardMoney.text = [NSString stringWithFormat:@"%@VNĐ", points];
    }else{
        lbRewardMoney.text = @"0VNĐ";
    }
    
    NSString *avatarURL = [AccountModel getCusPhoto];
    if (![AppUtils isNullOrEmpty: avatarURL]) {
        [imgAvatar sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:DEFAULT_AVATAR];
    }else{
        imgAvatar.image = DEFAULT_AVATAR;
    }
}

@end
