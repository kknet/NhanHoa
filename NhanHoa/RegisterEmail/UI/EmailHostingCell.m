//
//  EmailHostingCell.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "EmailHostingCell.h"

@implementation EmailHostingCell
@synthesize viewWrapper, viewHeader, lbName, lbPrice, lbMemory, lbMemoryValue, lbSepa1, lbEmailPOP3, lbEmailPOP3Value, lbSepa2, lbEmailForwarders, lbEmailForwardersValue, lbSepa3, lbDomain, lbDomainValue, lbSepa4, btnAddCart;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // Initialization code
    float padding = 10.0;
    float mTop = 15.0;
    float paddingContent = 7.0;
    
    viewWrapper.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    viewWrapper.layer.borderWidth = 1.0;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(paddingContent);
        make.right.equalTo(self).offset(-paddingContent);
        make.bottom.equalTo(self).offset(-paddingContent - mTop);
    }];
    [AppUtils addBoxShadowForView:viewWrapper color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(60.0);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(5.0);
        make.left.equalTo(viewHeader).offset(padding);
        make.right.equalTo(viewHeader).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo(20.0);
    }];
    
    //  content
    float hItem = 45.0;
    [lbMemory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper.mas_centerX);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbMemoryValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbMemory);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.left.equalTo(lbMemory.mas_right);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMemory.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Email POP3/webmail
    [lbEmailPOP3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa1.mas_bottom);
        make.left.right.equalTo(lbMemory);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbEmailPOP3Value mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmailPOP3);
        make.left.right.equalTo(lbMemoryValue);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmailPOP3.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Email Forwarders
    [lbEmailForwarders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa2.mas_bottom);
        make.left.right.equalTo(lbEmailPOP3);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbEmailForwardersValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEmailForwarders);
        make.left.right.equalTo(lbEmailPOP3Value);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEmailForwarders.mas_bottom);
        make.left.right.equalTo(lbSepa2);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Domain
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa3.mas_bottom);
        make.left.right.equalTo(lbEmailForwarders);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomain);
        make.left.right.equalTo(lbEmailForwardersValue);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.right.equalTo(lbSepa3);
        make.height.mas_equalTo(1.0);
    }];
    
    //  button add to cart
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa4.mas_bottom).offset(mTop);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    lbName.textColor = BLUE_COLOR;
    lbName.font = [AppDelegate sharedInstance].fontBold;
    lbPrice.font = [AppDelegate sharedInstance].fontMedium;
    
    lbMemory.font = lbEmailPOP3.font = lbEmailForwarders.font = lbDomain.font = [AppDelegate sharedInstance].fontRegular;
    lbMemoryValue.font = lbEmailPOP3Value.font = lbEmailForwardersValue.font = lbDomainValue.font = [AppDelegate sharedInstance].fontMedium;
    
    lbMemory.textColor = lbEmailPOP3.textColor = lbEmailForwarders.textColor = lbDomain.textColor = TITLE_COLOR;
    
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnAddCart.backgroundColor = ORANGE_BUTTON;
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
