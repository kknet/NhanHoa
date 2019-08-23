//
//  WhoIsNoResult.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsNoResult.h"
#import "CartModel.h"

@implementation WhoIsNoResult

@synthesize lbDomain, imgEmoji, lbContent, viewDomain, lbName, lbPrice, btnChoose;
@synthesize domainInfo, hEmoji, padding, hDomainView;

- (void)setupUIForView {
    padding = 15.0;
    hEmoji = 35.0;
    hDomainView = 65.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hEmoji = 50.0;
        hDomainView = 80.0;
    }
    
    lbDomain.textColor = BLUE_COLOR;
    lbDomain.font = [AppDelegate sharedInstance].fontMedium;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(60.0);
    }];
    
    [imgEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(hEmoji);
    }];
    
    lbContent.font = [AppDelegate sharedInstance].fontRegular;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgEmoji.mas_bottom).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
    }];
    
    viewDomain.layer.cornerRadius = 7.0;
    viewDomain.layer.borderWidth = 2.0;
    viewDomain.layer.borderColor = [UIColor colorWithRed:(250/255.0) green:(157/255.0) blue:(26/255.0) alpha:1.0].CGColor;
    [viewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbContent.mas_bottom).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hDomainView);
    }];
    
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    btnChoose.backgroundColor = BLUE_COLOR;
    btnChoose.layer.cornerRadius = 36.0/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewDomain).offset(-padding);
        make.centerY.equalTo(viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(80.0);
    }];
    
    lbName.font = [AppDelegate sharedInstance].fontMedium;
    lbName.textColor = BLUE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewDomain).offset(padding);
        make.bottom.equalTo(viewDomain.mas_centerY).offset(-2.0);
        make.right.equalTo(btnChoose.mas_left).offset(-padding);
    }];
    
    lbPrice.font = [AppDelegate sharedInstance].fontRegular;
    lbPrice.textColor = NEW_PRICE_COLOR;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.equalTo(viewDomain.mas_centerY).offset(2.0);
    }];
}

- (float)showContentOfDomainWithInfo: (NSDictionary *)info {
    if (info != nil) {
        domainInfo = [[NSDictionary alloc] initWithDictionary: info];
    }
    
    NSString *domain = [info objectForKey:@"domain"];
    lbDomain.text = lbName.text = domain;
    BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: domain];
    if (exists) {
        [btnChoose setTitle:text_unselect forState:UIControlStateNormal];
        btnChoose.backgroundColor = ORANGE_COLOR;
    }else{
        [btnChoose setTitle:text_select forState:UIControlStateNormal];
        btnChoose.backgroundColor = BLUE_COLOR;        
    }
    [self updateFrameWithContentOfButton];
    
    NSString *content = SFM(@"Hiện tại tên miền %@ chưa được đăng ký!\nBạn có muốn đăng ký tên miền này không?", domain);
    NSRange range = [content rangeOfString: domain];
    if (range.location != NSNotFound) {
        UIFont *regular = [AppDelegate sharedInstance].fontRegular;
        UIFont *medium = [AppDelegate sharedInstance].fontMedium;
        if ([DeviceUtils isScreen320]) {
            regular = [AppDelegate sharedInstance].fontNormal;
            medium = [AppDelegate sharedInstance].fontMediumDesc;
        }
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:regular, NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:medium, NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
        
        lbContent.attributedText = attr;
    }else{
        lbContent.text = content;
    }
    
    id price_first_year = [info objectForKey:@"price_first_year"];
    if ([price_first_year isKindOfClass:[NSString class]]) {
        NSString *amount = [AppUtils convertStringToCurrencyFormat: price_first_year];
        lbPrice.text = SFM(@"%@ VNĐ/%@", amount, text_year);
        
    }else if ([price_first_year isKindOfClass:[NSNumber class]]) {
        NSString *amount = SFM(@"%ld", [price_first_year longValue]);
        NSString *strAmount = [AppUtils convertStringToCurrencyFormat: amount];
        lbPrice.text = SFM(@"%@ VNĐ/%@", strAmount, text_year);
    }else{
        lbPrice.text = @"Liên hệ";
    }
    
    float hContent = [AppUtils getSizeWithText:lbContent.text withFont:lbContent.font andMaxWidth:(SCREEN_WIDTH - 2*padding)].height + 10.0;
    
    return 60.0 + hEmoji + 10.0 + hContent + 10.0 + hDomainView + 10.0;
}

- (IBAction)btnChoosePress:(UIButton *)sender {
    if (domainInfo != nil) {
        BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: domainInfo];
        if (exists) {
            [[CartModel getInstance] removeDomainFromCart: domainInfo];
            [btnChoose setTitle:text_select forState:UIControlStateNormal];
            btnChoose.backgroundColor = BLUE_COLOR;
            
        }else{
            [[CartModel getInstance] addDomainToCart: domainInfo];
            [btnChoose setTitle:text_unselect forState:UIControlStateNormal];
            btnChoose.backgroundColor = ORANGE_COLOR;
        }
        [self updateFrameWithContentOfButton];
        
        [[AppDelegate sharedInstance] updateShoppingCartCount];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"selectedOrRemoveDomainFromCart" object:nil];
    }
}

- (void)updateFrameWithContentOfButton {
    float widthBTN = [AppUtils getSizeWithText:btnChoose.currentTitle withFont:btnChoose.titleLabel.font].width + 20.0;
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewDomain).offset(-padding);
        make.centerY.equalTo(viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(widthBTN);
    }];
}

@end
