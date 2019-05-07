//
//  WhoisDomainPopupView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhoIsDomainView.h"
#import "WebServices.h"

@interface WhoisDomainPopupView : UIView<WebServicesDelegate>

@property (nonatomic, strong) WhoIsDomainView *whoisView;
@property (nonatomic, strong) UIButton *icClose;
@property (nonatomic, strong) UIActivityIndicatorView *icWaiting;

@property (nonatomic, strong) WebServices *webService;
@property (nonatomic, strong) NSString *domain;
@property (nonatomic, assign) float hItem;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;


@end
