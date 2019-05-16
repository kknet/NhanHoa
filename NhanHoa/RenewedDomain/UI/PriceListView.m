//
//  PriceListView.m
//  NhanHoa
//
//  Created by admin on 5/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PriceListView.h"

@implementation PriceListView
@synthesize viewHeader, icClose, lbTitle, viewMenu, btnAllDomains, btnExpireDomains, tbDomains, delegate;

- (void)setupUIForView {
    float hHeader = [AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav;
    float padding = 15.0;
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hHeader);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.bottom.equalTo(self.viewHeader);
        make.width.mas_equalTo(250);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.lbTitle.mas_centerY);
        make.left.equalTo(self.viewHeader).offset(padding - 8);
        make.width.height.mas_equalTo(40);
    }];
    
    //  view menu
    float hMenu = 40.0;
    viewMenu.layer.cornerRadius = hMenu/2;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hMenu);
    }];
    
    [btnAllDomains setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAllDomains.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnAllDomains.backgroundColor = BLUE_COLOR;
    btnAllDomains.layer.cornerRadius = hMenu/2;
    [btnAllDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.viewMenu);
        make.right.equalTo(self.viewMenu.mas_centerX);
    }];
    
    [btnExpireDomains setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnExpireDomains.titleLabel.font = btnAllDomains.titleLabel.font;
    btnExpireDomains.backgroundColor = UIColor.clearColor;
    btnExpireDomains.layer.cornerRadius = hMenu/2;
    [btnExpireDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewMenu.mas_centerX);
        make.right.top.bottom.equalTo(self.viewMenu);
    }];
    
    //  table content
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(padding);
        make.left.bottom.right.equalTo(self);
    }];
}

- (IBAction)icCloseClicked:(UIButton *)sender {
    [delegate onCloseViewDomainPrice];
}

- (IBAction)btnAllDomainsPress:(UIButton *)sender {
}

- (IBAction)btnExpireDomainsPress:(UIButton *)sender {
}
@end
