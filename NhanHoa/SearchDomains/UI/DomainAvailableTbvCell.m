//
//  DomainAvailableTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainAvailableTbvCell.h"
#import "DomainModel.h"
#import "CartModel.h"

@implementation DomainAvailableTbvCell
@synthesize viewWrap, imgBackground, lbDomainTop, lbDesc, viewBottom, lbDomainBottom, lbPrice, btnBuy;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    UIImage *bg = [UIImage imageNamed:@"domain-search-availabel"];
    float hBG = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    viewWrap.clipsToBounds = TRUE;
    viewWrap.layer.cornerRadius = 12.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15.0);
    }];
    
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hBG);
    }];
    
    lbDomainTop.font = textFont;
    [lbDomainTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBackground).offset(padding);
        make.right.equalTo(imgBackground).offset(-padding);
        make.bottom.equalTo(imgBackground.mas_centerY).offset(-10.0);
    }];
    
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2.0];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomainTop.mas_bottom).offset(2.0);
        make.left.right.equalTo(lbDomainTop);
    }];
    
    viewBottom.backgroundColor = UIColor.whiteColor;
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBackground.mas_bottom);
        make.left.right.bottom.equalTo(viewWrap);
    }];
    
    btnBuy.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnBuy setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnBuy.backgroundColor = BLUE_COLOR;
    btnBuy.layer.cornerRadius = 5.0;
    [btnBuy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewBottom).offset(-padding);
        make.centerY.equalTo(viewBottom.mas_centerY);
        make.height.mas_equalTo(40.0);
        make.width.mas_equalTo(0);
    }];
    
    lbDomainBottom.textColor = GRAY_100;
    lbDomainBottom.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    [lbDomainBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewBottom).offset(padding);
        make.bottom.equalTo(viewBottom.mas_centerY).offset(-2.0);
        make.right.equalTo(btnBuy.mas_left).offset(-5.0);
    }];
    
    lbPrice.textColor = ORANGE_COLOR;
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-3];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainBottom);
        make.top.equalTo(viewBottom.mas_centerY).offset(2.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayContentWithInfo: (NSDictionary *)info {
    NSString *domain = [info objectForKey: @"domain"];
    lbDomainTop.text = lbDomainBottom.text = domain;
    
    NSString *price = [DomainModel getPriceFromDomainInfo: info];
    if (![AppUtils isNullOrEmpty: price]) {
        price = [AppUtils convertStringToCurrencyFormat: price];
        lbPrice.text = SFM(@"%@VNĐ", price);
    }else{
        lbPrice.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Contact price"];
    }
    //  [cell showPriceForDomainCell: TRUE];
    //  cell.btnChoose.enabled = TRUE;
    
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        lbDesc.text = SFM(@"%@\n%@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"This domain have not registered yet."], [[AppDelegate sharedInstance].localization localizedStringForKey:@"You can using it!"]);
        
        if ([[CartModel getInstance] checkCurrentDomainExistsInCart: info]) {
            btnBuy.backgroundColor = ORANGE_COLOR;
            [btnBuy setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Unselect"]
                    forState:UIControlStateNormal];
            
        }else{
            btnBuy.backgroundColor = BLUE_COLOR;
            [btnBuy setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Select"]
                    forState:UIControlStateNormal];
        }
        
        float widthBTN = [AppUtils getSizeWithText:btnBuy.currentTitle withFont:btnBuy.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
        [btnBuy mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(widthBTN);
        }];
    }
}

@end
