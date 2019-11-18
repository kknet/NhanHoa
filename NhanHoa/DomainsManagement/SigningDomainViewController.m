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
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, wvContent, icWaiting, domain_signing_url, domain_signed_url;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    wvContent.hidden = TRUE;
    icWaiting.hidden = FALSE;
    [icWaiting startAnimating];
    
    if (![AppUtils isNullOrEmpty: domain_signed_url]) {
        lbHeader.text = text_signed_contract;
        [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: domain_signed_url]]];
        
    }else if (![AppUtils isNullOrEmpty: domain_signing_url]) {
        lbHeader.text = text_signing_contract;
        [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: domain_signing_url]]];
        
    }else{
        [self.view makeToast:@"Dữ liệu không hợp lệ. Vui lòng kiểm tra lại." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
    
    [self updateCartCountForView];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [[AppDelegate sharedInstance] showCartScreenContent];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = [AppDelegate sharedInstance].sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].sizeCartCount);
    }];
    
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:1.0 offsetX:1.0 offsetY:1.0];
    
    wvContent.keyboardDisplayRequiresUserAction = FALSE;
    //  wvContent.usesGUIFixes = YES;
    wvContent.opaque = NO;
    wvContent.scalesPageToFit = TRUE;
    wvContent.delegate = self;
    wvContent.backgroundColor = UIColor.whiteColor;
    [wvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(viewHeader.mas_bottom).offset(5.0);
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

@end
