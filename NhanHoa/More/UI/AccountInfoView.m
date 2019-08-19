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
    
    float hAvatar = 60.0;
    float paddingX = 5.0;
    
    float padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    lbMainAccount.font = lbRewardAccount.font = [UIFont fontWithName:RobotoRegular size:14.0];
    lbMainMoney.font = lbRewardMoney.font = [UIFont fontWithName:RobotoMedium size:14.0];
    
    if (!IS_IPHONE && !IS_IPOD) {
        hAvatar = 80.0;
        paddingX = 5.0;
        
        lbMainAccount.font = lbRewardAccount.font = [AppDelegate sharedInstance].fontDesc;
        lbMainMoney.font = lbRewardMoney.font = [AppDelegate sharedInstance].fontMediumDesc;
    }
    
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.cornerRadius = hAvatar/2;
    imgAvatar.layer.borderColor = BLUE_COLOR.CGColor;
    imgAvatar.layer.borderWidth = 1.0;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(10.0);
        make.width.height.mas_equalTo(hAvatar);
    }];
    
    lbName.font = [AppDelegate sharedInstance].fontMedium;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgAvatar.mas_right).offset(paddingX);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(imgAvatar.mas_centerY).offset(-2.5);
    }];
    
    lbEmail.font = [AppDelegate sharedInstance].fontRegular;
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.equalTo(imgAvatar.mas_centerY).offset(2.5);
    }];
    
    imgSepa.backgroundColor = GRAY_235;
    [imgSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAvatar);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(self.imgAvatar.mas_bottom).offset(10.0);
        make.height.mas_equalTo(1.0);
    }];
    
    //  main wallet
    viewWallet.backgroundColor = viewReward.backgroundColor = UIColor.clearColor;
    imgWallet.layer.cornerRadius = imgReward.layer.cornerRadius = 35.0/2;
    imgWallet.clipsToBounds = imgReward.clipsToBounds = TRUE;
    
    lbName.textColor = lbEmail.textColor = lbMainAccount.textColor = lbRewardAccount.textColor = TITLE_COLOR;
    lbMainMoney.textColor = lbRewardMoney.textColor = ORANGE_COLOR;
    
    lbMainAccount.text = text_main_account;
    lbRewardAccount.text = text_bonus_money;
    
    if (IS_IPHONE || IS_IPOD) {
        [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgSepa.mas_bottom).offset(10.0);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_centerX).offset(-padding/2);
            make.bottom.equalTo(self).offset(-10.0);
        }];
        
        [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.viewWallet).offset(padding);
            make.centerY.equalTo(self.viewWallet.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        [lbMainAccount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgWallet.mas_right).offset(2.0);
            make.bottom.equalTo(self.imgWallet.mas_centerY).offset(-1.0);
            make.right.equalTo(self.viewWallet);
        }];
        
        [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lbMainAccount);
            make.top.equalTo(self.imgWallet.mas_centerY).offset(1.0);
        }];
        
        //  reward wallet
        [viewReward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.viewWallet);
            make.right.equalTo(self);
            make.left.equalTo(self.mas_centerX).offset(padding/2);
        }];
        
        
        [imgReward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.viewReward);
            make.centerY.equalTo(self.viewReward.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        [lbRewardAccount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgReward.mas_right).offset(2.0);
            make.bottom.equalTo(self.imgReward.mas_centerY).offset(-1.0);
            make.right.equalTo(self.viewReward).offset(-padding);
        }];
        
        [lbRewardMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.lbRewardAccount);
            make.top.equalTo(self.imgReward.mas_centerY).offset(1.0);
        }];
        
    }else{
        [viewWallet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgSepa.mas_bottom).offset(10.0);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_centerX).offset(-padding/2);
            make.bottom.equalTo(self).offset(-10.0);
        }];
        
        [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewWallet).offset(padding);
            make.centerY.equalTo(viewWallet.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        lbMainAccount.text = @"Tài khoản chính:";
        float sizeText = [AppUtils getSizeWithText:lbMainAccount.text withFont:lbMainAccount.font].width + 5.0;
        [lbMainAccount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgWallet.mas_right).offset(paddingX);
            make.top.bottom.equalTo(viewWallet);
            make.width.mas_equalTo(sizeText);
        }];
        
        [lbMainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbMainAccount.mas_right);
            make.top.bottom.equalTo(lbMainAccount);
            make.right.equalTo(viewWallet).offset(-paddingX);
        }];
        
        //  reward wallet
        [viewReward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(viewWallet);
            make.right.equalTo(self);
            make.left.equalTo(self.mas_centerX).offset(padding/2);
        }];
        
        [imgReward mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewReward);
            make.centerY.equalTo(viewReward.mas_centerY);
            make.width.height.mas_equalTo(35.0);
        }];
        
        lbRewardAccount.text = @"Tiền thưởng:";
        sizeText = [AppUtils getSizeWithText:lbRewardAccount.text withFont:lbRewardAccount.font].width + 5.0;
        [lbRewardAccount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(imgReward.mas_right).offset(paddingX);
            make.top.bottom.equalTo(viewReward);
            make.width.mas_equalTo(sizeText);
        }];
        
        [lbRewardMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbRewardAccount.mas_right);
            make.top.bottom.equalTo(lbRewardAccount);
            make.right.equalTo(viewReward).offset(-paddingX);
        }];
    }
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
