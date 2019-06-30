//
//  SigningDomainViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SigningDomainViewController.h"
#import <WebKit/WebKit.h>

@interface SigningDomainViewController ()<UIWebViewDelegate>

@end

@implementation SigningDomainViewController
@synthesize wvContent, icWaiting, domain_signing_url, domain_signed_url;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"SigningDomainViewController"];
    
    wvContent.hidden = TRUE;
    icWaiting.hidden = FALSE;
    [icWaiting startAnimating];
    
    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        self.title = text_signed_contract;
        [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: domain_signed_url]]];
        
    }else if (![AppUtils isNullOrEmpty: domain_signing_url]) {
        self.title = text_signing_contract;
        [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: domain_signing_url]]];
        
    }else{
        [self.view makeToast:@"Dữ liệu không hợp lệ. Vui lòng kiểm tra lại." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
    
}

- (void)setupUIForView {
    wvContent.keyboardDisplayRequiresUserAction = FALSE;
    //  wvContent.usesGUIFixes = YES;
    wvContent.opaque = NO;
    wvContent.scalesPageToFit = TRUE;
    wvContent.delegate = self;
    wvContent.backgroundColor = UIColor.whiteColor;
    [wvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(5.0);
        make.bottom.equalTo(self.view).offset(-5.0);
    }];
    
    icWaiting.hidden = TRUE;
    icWaiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    icWaiting.backgroundColor = UIColor.whiteColor;
    icWaiting.alpha = 0.5;
    [icWaiting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.wvContent);
    }];
}

- (NSDictionary *)getResultInfoFromString: (NSString *)infoStr {
    NSMutableDictionary *queryStringDictionary = [[NSMutableDictionary alloc] init];
    NSArray *urlComponents = [infoStr componentsSeparatedByString:@"&"];
    for (NSString *keyValuePair in urlComponents)
    {
        NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];
        NSString *key = [[pairComponents firstObject] stringByRemovingPercentEncoding];
        NSString *value = [[pairComponents lastObject] stringByRemovingPercentEncoding];
        
        [queryStringDictionary setObject:value forKey:key];
    }
    return queryStringDictionary;
}

#pragma mark - Webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if(navigationType == UIWebViewNavigationTypeFormSubmitted)
    {
        icWaiting.hidden = FALSE;
        [icWaiting startAnimating];
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView.loading) {
        return;
    }
    
    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"])
        {
            icWaiting.hidden = TRUE;
            [icWaiting stopAnimating];
            wvContent.hidden = FALSE;
        }
    }else if (![AppUtils isNullOrEmpty: domain_signing_url]) {
        if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"])
        {
            icWaiting.hidden = TRUE;
            [icWaiting stopAnimating];
            wvContent.hidden = FALSE;
        }
        
        NSString *query = [webView.request.URL query];
        if (query != nil && ![query isEqualToString:@""])
        {
            [WriteLogsUtils writeLogContent:SFM(@"[%s] query = %@", __FUNCTION__, query)];
            
            NSDictionary *info = [self getResultInfoFromString: query];
            if (info != nil) {
                NSString *status = [info objectForKey:@"status"];
                if (![AppUtils isNullOrEmpty: status]) {
                    icWaiting.hidden = TRUE;
                    [icWaiting stopAnimating];
                    
                    if ([status isEqualToString:@"0"]) {
                        [self.view makeToast:@"Bạn đã ký tên lên hợp đồng thành công" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
                        [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:3.0];
                    }else{
                        [self.view makeToast:@"Đã có lỗi xảy ra. Vui lòng thử lại" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                        [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:3.0];
                    }
                }
            }
        }
    }
}

- (void)backToPreviousView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

/*
"cus_id" = 127115;
"domain_id" = 105257;
hash = 97046ec8a290c4ff214acddfcf1fa363;

status = 0;
*/

@end
