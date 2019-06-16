//
//  WhoisDomainPopupView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoisDomainPopupView.h"
#import "AccountModel.h"

@implementation WhoisDomainPopupView
@synthesize whoisView, icClose, icWaiting, domain, webService, hItem;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 12.0;
        
        //  add whois view
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsDomainView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[WhoIsDomainView class]]) {
                whoisView = (WhoIsDomainView *) currentObject;
                break;
            }
        }
        hItem = 28.0;
        whoisView.hLabel = hItem;
        [self addSubview: whoisView];
        [whoisView setupUIForView];
        [whoisView resetAllValueForView];
        [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(self);
        }];
        
        //  close popup
        icClose = [[UIButton alloc] init];
        icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [icClose setImage:[UIImage imageNamed:@"close_blue"] forState:UIControlStateNormal];
        [icClose addTarget:self
                    action:@selector(fadeOut)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: icClose];
        [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self);
            make.width.height.mas_equalTo(40.0);
        }];
        
        icWaiting = [[UIActivityIndicatorView alloc] init];
        icWaiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        icWaiting.backgroundColor = UIColor.whiteColor;
        icWaiting.alpha = 0.5;
        icWaiting.hidden = TRUE;
        [self addSubview: icWaiting];
        
        [icWaiting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
    }
    return self;
}


- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    //Add transparent
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBackground.backgroundColor = UIColor.blackColor;
    viewBackground.alpha = 0.5;
    viewBackground.tag = 20;
    [aView addSubview:viewBackground];
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
    
    [icWaiting startAnimating];
    icWaiting.hidden = FALSE;
    
    [self getWhoisInfoOfDomain: domain];
}

- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    for (UIView *subView in self.superview.subviews){
        if (subView.tag == 20){
            [subView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            self.webService = nil;
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }
    }];
}

- (void)getWhoisInfoOfDomain: (NSString *)strDomain {
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:whois_mod forKey:@"mod"];
    [jsonDict setObject:domain forKey:@"domain"];
    [jsonDict setObject:[AccountModel getCusIdOfUser] forKey:@"cus_id"];
    [jsonDict setObject:[NSNumber numberWithInt: 1] forKey:@"type"];
    [webService callWebServiceWithLink:whois_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict]]];
}

#pragma mark - Webservice
-(void)failedToCallWebService:(NSString *)link andError:(id)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n error: %@", __FUNCTION__, link, error]];
    
    [icWaiting stopAnimating];
    icWaiting.hidden = TRUE;
}

-(void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Data: %@", __FUNCTION__, link, data]];
    
    if ([link isEqualToString: whois_func]) {
        [icWaiting stopAnimating];
        icWaiting.hidden = TRUE;
        
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            NSString *dns = [data objectForKey:@"dns"];
            if (![AppUtils isNullOrEmpty: dns]) {
                dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
                dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
            }
            float maxSize = (SCREEN_WIDTH - 4*15.0)/2 + 35.0;
            float hPopup = [AppUtils getHeightOfWhoIsDomainViewWithContent:dns font:whoisView.lbDNSValue.font heightItem:hItem maxSize:maxSize];
            
            [whoisView showContentOfDomainWithInfo: data];
            
            [UIView animateWithDuration:0.1 animations:^{
                self.frame = CGRectMake(5.0, (SCREEN_HEIGHT-hPopup)/2, SCREEN_WIDTH-10.0, hPopup);
            }];
        }
    }
}

-(void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> function = %@ & responeCode = %d", __FUNCTION__, link, responeCode]];
    
    [icWaiting stopAnimating];
    icWaiting.hidden = TRUE;
}

@end
