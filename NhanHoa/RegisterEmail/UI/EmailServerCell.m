//
//  EmailServerCell.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "EmailServerCell.h"

@implementation EmailServerCell
@synthesize viewWrapper, lbHeaderBG, lbName, lbPrice, tfTime, imgArr, btnChooseTime, imgEmailInbox, lbEmailInbox, lbEmailInboxValue, lbSepa1, imgStore, lbStore, lbStoreValue, lbSepa2, imgEmail, lbEmail, lbEmailValue, lbSepa3, imgEmailForwarders, lbEmailForwarders, lbEmailForwardersValue, lbSepa4, imgEmailList, lbEmailList, lbEmailListValue, lbSepa5, imgDomain, lbDomain, lbDomainValue, lbSepa6, imgIPAddr, lbIPAddr, lbIPAddrValue, lbSepa7, imgSecure, lbSecure, lbSecureValue, lbSepa8, btnAddCart;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    float paddingContent = 7.0;
    float mTop = 15.0;
    float padding = 10.0;
    float hItem = 40.0;
    float sizeIcon = 16.0;
    
    viewWrapper.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    viewWrapper.layer.borderWidth = 1.0;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(paddingContent);
        make.right.equalTo(self).offset(-paddingContent);
        make.bottom.equalTo(self).offset(-paddingContent - mTop);
    }];
    [AppUtils addBoxShadowForView:viewWrapper color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    lbName.font = [AppDelegate sharedInstance].fontBold;
    lbName.textColor = BLUE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWrapper).offset(5.0);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    lbPrice.font = [AppDelegate sharedInstance].fontMedium;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo(20.0);
    }];
    
    tfTime.font = [AppDelegate sharedInstance].fontMedium;
    tfTime.backgroundColor = UIColor.whiteColor;
    [AppUtils setBorderForTextfield:tfTime borderColor:BORDER_COLOR];
    [tfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPrice.mas_bottom).offset(5.0);
        make.left.right.equalTo(lbPrice);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tfTime.mas_centerY);
        make.right.equalTo(tfTime).offset(-5.0);
        make.width.mas_equalTo(16.0);
        make.height.mas_equalTo(12.0);
    }];
    
    [btnChooseTime setTitle:@"" forState:UIControlStateNormal];
    [btnChooseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfTime);
    }];
    
    [lbHeaderBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrapper);
        make.bottom.equalTo(tfTime.mas_bottom).offset(5.0);
    }];
    
    //  Tỷ lệ mail vào inbox
    [lbEmailInbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbHeaderBG.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding + 17.0 + 5.0);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgEmailInbox mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbEmailInbox.mas_centerY);
        make.left.equalTo(viewWrapper).offset(padding);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbEmailInboxValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmailInbox);
        make.left.equalTo(lbEmailInbox.mas_right).offset(paddingContent);
        make.right.equalTo(viewWrapper).offset(-padding);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmailInbox.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Dung lượng lưu trữ
    [lbStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa1.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgStore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbStore.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbStoreValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbStore);
        make.left.equalTo(lbStore.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbStoreValue.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Địa chỉ email
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa2.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbEmail.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbEmailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmail);
        make.left.equalTo(lbEmail.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmail.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Email forwarder
    [lbEmailForwarders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa3.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgEmailForwarders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbEmailForwarders.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbEmailForwardersValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmailForwarders);
        make.left.equalTo(lbEmailForwarders.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmailForwarders.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Danh sách email
    [lbEmailList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa4.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgEmailList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbEmailList.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbEmailListValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmailList);
        make.left.equalTo(lbEmailList.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmailList.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Tên miền tạo email
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa5.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbDomain.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomain);
        make.left.equalTo(lbDomain.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Địa chỉ IP riêng
    [lbIPAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa6.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgIPAddr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbIPAddr.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbIPAddrValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbIPAddr);
        make.left.equalTo(lbIPAddr.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbIPAddr.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Giao thức bảo mật
    [lbSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa7.mas_bottom);
        make.left.equalTo(lbEmailInbox);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgSecure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbSecure.mas_centerY);
        make.left.right.equalTo(imgEmailInbox);
        make.height.mas_equalTo(sizeIcon);
    }];
    
    [lbSecureValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbSecure);
        make.left.equalTo(lbSecure.mas_right).offset(paddingContent);
        make.right.equalTo(lbEmailInboxValue);
    }];
    
    [lbSepa8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSecure.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa8.mas_bottom).offset(mTop);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    lbEmailInbox.textColor = lbStore.textColor = lbEmail.textColor = lbEmailForwarders.textColor = lbEmailList.textColor = lbDomain.textColor = lbIPAddr.textColor = lbSecure.textColor = TITLE_COLOR;
    
    lbEmailInbox.font = lbStore.font = lbEmail.font = lbEmailForwarders.font = lbEmailList.font = lbDomain.font = lbIPAddr.font = lbSecure.font = [AppDelegate sharedInstance].fontRegular;
    
    lbEmailInboxValue.font = lbStoreValue.font = lbEmailValue.font = lbEmailForwardersValue.font = lbEmailListValue.font = lbDomainValue.font = lbIPAddrValue.font = lbSecureValue.font = [AppDelegate sharedInstance].fontMedium;
    
    lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = lbSepa7.backgroundColor = lbSepa8.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnAddCart.backgroundColor = ORANGE_BUTTON;
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
