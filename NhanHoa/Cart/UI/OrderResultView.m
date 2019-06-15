//
//  OrderResultView.m
//  NhanHoa
//
//  Created by Khai Leo on 6/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderResultView.h"
#import "DomainResultView.h"

@implementation OrderResultView
@synthesize scvContent, btnClose;

- (void)setupUIForView {
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    btnClose.backgroundColor = BLUE_COLOR;
    [btnClose setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnClose.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnClose.layer.cornerRadius = [AppDelegate sharedInstance].radius;
}

- (void)setContentViewWithInfo: (NSDictionary *)paymentResult {
    float padding = 15.0;
    
    NSArray *allkeys = [paymentResult allKeys];
    for (int index=0; index<(int)allkeys.count; index++) {
        NSString *key = [allkeys objectAtIndex: index];
        NSString *state = [paymentResult objectForKey:key];
        [self addDomainResultViewForIndex:index state:state domain: key];
    }
    
    float maxHeight = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + 60.0);
    float viewHeight = allkeys.count*160.0 + (allkeys.count-1)*5;
    if (viewHeight + (padding + 45.0 + padding) < maxHeight) {
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent).offset(padding);
            make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
            make.top.equalTo(self.scvContent).offset(maxHeight - 45.0 - padding);
            make.height.mas_equalTo(45.0);
        }];
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, maxHeight);
        
    }else{
        [btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent).offset(padding);
            make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
            make.top.equalTo(self.scvContent).offset(viewHeight+padding);
            make.height.mas_equalTo(45.0);
        }];
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, viewHeight + 2*padding + 45.0);
    }
}

- (void)addDomainResultViewForIndex: (int)index state: (NSString *)state domain: (NSString *)domain {
    DomainResultView *domainView;
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"DomainResultView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[DomainResultView class]]) {
            domainView = (DomainResultView *) currentObject;
            break;
        }
    }
    [self.scvContent addSubview: domainView];
    
    float hView = 160.0;
    float originY = 0;
    if (index > 0) {
        originY = index * hView + index * 5;
    }
    
    [domainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scvContent).offset(originY);
        make.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [domainView setupUIForView];
    
    if (![AppUtils isNullOrEmpty: state] && [state isEqualToString:@"success"]) {
        domainView.imgStatus.image = [UIImage imageNamed:@"order_completed"];
        
        NSString *content = [NSString stringWithFormat:@"Mua tên miền thành công:\n%@", domain];
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content];
        [contentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:18.0] range:NSMakeRange(contentString.length-domain.length, domain.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:TITLE_COLOR range:NSMakeRange(0, contentString.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:NSMakeRange(contentString.length-domain.length, domain.length)];
        
        domainView.lbContent.attributedText = contentString;
    }else{
        domainView.imgStatus.image = [UIImage imageNamed:@"order_failed"];
        
        NSString *content = [NSString stringWithFormat:@"Mua tên miền thất bại:\n%@", domain];
        NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:content];
        [contentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:18.0] range:NSMakeRange(contentString.length-domain.length, domain.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:TITLE_COLOR range:NSMakeRange(0, contentString.length)];
        [contentString addAttribute:NSForegroundColorAttributeName value:NEW_PRICE_COLOR range:NSMakeRange(contentString.length-domain.length, domain.length)];
        
        domainView.lbContent.attributedText = contentString;
    }
}


@end
