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
@synthesize domainInfo;

- (void)setupUIForView {
    float padding = 15.0;
    
    lbDomain.textColor = BLUE_COLOR;
    lbDomain.font = [UIFont fontWithName:RobotoBold size:16.0];
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(60.0);
    }];
    
    [imgEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomain.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgEmoji.mas_bottom).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
    }];
    
    viewDomain.layer.cornerRadius = 7.0;
    viewDomain.layer.borderWidth = 2.0;
    viewDomain.layer.borderColor = [UIColor colorWithRed:(250/255.0) green:(157/255.0) blue:(26/255.0) alpha:1.0].CGColor;
    [viewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbContent.mas_bottom).offset(10.0);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(65.0);
    }];
    
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:15.0];
    btnChoose.backgroundColor = BLUE_COLOR;
    btnChoose.layer.cornerRadius = 36.0/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewDomain).offset(-padding);
        make.centerY.equalTo(self.viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(60.0);
    }];
    
    lbName.font = [UIFont fontWithName:RobotoBold size:16.0];
    lbName.textColor = BLUE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewDomain).offset(padding);
        make.bottom.equalTo(self.viewDomain.mas_centerY).offset(-2.0);
        make.right.equalTo(self.btnChoose.mas_left).offset(-padding);
    }];
    
    lbPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbPrice.textColor = NEW_PRICE_COLOR;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbName);
        make.top.equalTo(self.viewDomain.mas_centerY).offset(2.0);
    }];
}

- (void)showContentOfDomainWithInfo: (NSDictionary *)info {
    if (info != nil) {
        domainInfo = [[NSDictionary alloc] initWithDictionary: info];
    }
    
    NSString *domain = [info objectForKey:@"domain"];
    if ([AppUtils isNullOrEmpty: domain]) {
        domain = unknown;
    }
    lbDomain.text = lbName.text = domain;
    
    NSString *content = [NSString stringWithFormat:@"Hiện tại tên miền %@ chưa được đăng ký!\nBạn có muốn đăng ký tên miền này không?", domain];
    NSRange range = [content rangeOfString: domain];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:16.0], NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoMedium size:16.0], NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
        
        lbContent.attributedText = attr;
    }else{
        lbContent.text = content;
    }
    
    id price_first_year = [info objectForKey:@"price_first_year"];
    if ([price_first_year isKindOfClass:[NSString class]]) {
        NSString *amount = [AppUtils convertStringToCurrencyFormat: price_first_year];
        lbPrice.text = [NSString stringWithFormat:@"%@ vnđ/năm", amount];
        
    }else if ([price_first_year isKindOfClass:[NSNumber class]]) {
        NSString *amount = [NSString stringWithFormat:@"%ld", [price_first_year longValue]];
        NSString *strAmount = [AppUtils convertStringToCurrencyFormat: amount];
        lbPrice.text = [NSString stringWithFormat:@"%@ vnđ/năm", strAmount];
    }else{
        lbPrice.text = @"Liên hệ";
    }
}

- (IBAction)btnChoosePress:(UIButton *)sender {
    if (domainInfo != nil) {
        BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: domainInfo];
        if (exists) {
            [[CartModel getInstance] removeDomainFromCart: domainInfo];
            
        }else{
            [[CartModel getInstance] addDomainToCart: domainInfo];
        }
        [[AppDelegate sharedInstance] updateShoppingCartCount];
    }
}

@end
