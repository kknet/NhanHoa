//
//  OnepayPaymentView.m
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OnepayPaymentView.h"
#import "CartModel.h"

@implementation OnepayPaymentView
@synthesize viewHeader, icBack, lbHeader, wvPayment, typePaymentMethod, delegate, typePayment, topupMoney, icWaiting;

- (IBAction)icBackClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onBackIconClick)]) {
        [delegate onBackIconClick];
    }
}

- (void)setupUIForView
{
    self.clipsToBounds = TRUE;
    typePaymentMethod = ePaymentWithATM;
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.equalTo(self.viewHeader);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].hNav);
    }];
    
    lbHeader.font = [AppDelegate sharedInstance].fontBTN;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.top.bottom.equalTo(self.icBack);
        make.width.mas_equalTo(200);
    }];
    
    
    wvPayment.hidden = TRUE;
    wvPayment.opaque = NO;
    wvPayment.scalesPageToFit = YES;
    wvPayment.delegate = self;
    wvPayment.backgroundColor = UIColor.whiteColor;
    [wvPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.bottom.right.equalTo(self);
    }];
    
    icWaiting.hidden = TRUE;
    icWaiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    icWaiting.backgroundColor = UIColor.whiteColor;
    icWaiting.alpha = 0.5;
    [icWaiting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.wvPayment);
    }];
}

- (void)showPaymentContentViewWithMoney: (long)money
{
    wvPayment.hidden = FALSE;
    topupMoney = money;
    
    if (typePaymentMethod == ePaymentWithATM && topupMoney > 0) {
        icWaiting.hidden = FALSE;
        [icWaiting startAnimating];
        
        NSString *returnURL = return_url;
        
        //  Thêm 2 số 0 vào amount hiện tại
        NSString *amount = [NSString stringWithFormat:@"%ld00", topupMoney];
        if (![AppUtils isNullOrEmpty: amount]) {
            NSString *transactionID = [AppUtils generateIDForTransaction];
            NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Currency=VND&vpc_Locale=vn&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=NAP_TIEN_VAO_VI&vpc_ReturnURL=%@&vpc_Version=2", ACCESSCODE, amount, transactionID, MERCHANT_ID, returnURL];
            
            NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, HASHCODE];
            
            NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:get_hash_url]];
            NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //  074D8D27C3ED8409130B6C6029F026FB35F749405D19C16A6A055530803503DA
            NSString *url = [NSString stringWithFormat:@"%@?%@&vpc_SecureHash=%@", URL_Payment, params, secureHash];
            [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
            
        }else{
            [self makeToast:@"Số tiền thanh toán không hợp lệ. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
        
    }else if (typePaymentMethod == ePaymentWithVisaMaster) {
        
    }
    
    
    
}


- (void)btnConfirmPaymentPress {
    wvPayment.hidden = FALSE;
    
    if (typePaymentMethod == ePaymentWithATM)
    {
        NSString *returnURL = return_url;
        returnURL = @"";
        
        //  Thêm 2 số 0 vào amount hiện tại
        NSString *amount = @"";
        if ([typePayment isEqualToString: register_domain]) {
            long totalMoney = [[CartModel getInstance] getTotalPriceForCart];
            amount = [NSString stringWithFormat:@"%ld00", totalMoney];
            
        }else if ([typePayment isEqualToString: renew_domain]) {
            long totalMoney = [[CartModel getInstance] demoGetPriceForRenewDomain];
            amount = [NSString stringWithFormat:@"%ld00", totalMoney];
            
        }else if ([typePayment isEqualToString: topup_money]) {
            amount = [NSString stringWithFormat:@"%ld00", topupMoney];
        }
        
        if (![AppUtils isNullOrEmpty: amount]) {
            
            NSString *transactionID = [AppUtils generateIDForTransaction];
            //  20190514_1557803641.218678
            NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=D67342C2&vpc_Amount=%@&vpc_Command=pay&vpc_Currency=VND&vpc_Locale=vn&vpc_MerchTxnRef=%@&vpc_Merchant=ONEPAY&vpc_OrderInfo=JSECURETEST01&vpc_ReturnURL=%@&vpc_Version=2", amount, transactionID, returnURL];
            
            NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, @"A3EFDFABA8653DF2342E8DAC29B51AF0"];
            
            NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:get_hash_url]];
            NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //  074D8D27C3ED8409130B6C6029F026FB35F749405D19C16A6A055530803503DA
            NSString *url = [NSString stringWithFormat:@"https://mtf.onepay.vn/onecomm-pay/vpc.op?%@&vpc_SecureHash=%@", params, secureHash];
            [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
            
        }else{
            [self makeToast:@"Số tiền thanh toán không hợp lệ. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
        
    }else if (typePaymentMethod == ePaymentWithVisaMaster) {
        NSString *returnURL = @"https://api.websudo.xyz/dr.php";
        
        NSString *vpc_MerchTxnRef = [AppUtils generateIDForTransaction];
        NSString *lang = @"vn";
        
        //  Thêm 2 số 0 vào amount hiện tại
        NSString *amount = @"";
        if ([typePayment isEqualToString: register_domain]) {
            long totalMoney = [[CartModel getInstance] getTotalPriceForCart];
            amount = [NSString stringWithFormat:@"%ld00", totalMoney];
            
        }else if ([typePayment isEqualToString: renew_domain]) {
            long totalMoney = [[CartModel getInstance] demoGetPriceForRenewDomain];
            amount = [NSString stringWithFormat:@"%ld00", totalMoney];
            
        }else if ([typePayment isEqualToString: topup_money]) {
            amount = [NSString stringWithFormat:@"%ld00", topupMoney];
        }
        
        if (![AppUtils isNullOrEmpty: amount]) {
            
            NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Locale=%@&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=NAP_TIEN_VAO_VI&vpc_ReturnURL=https://api.websudo.xyz/dr.php&vpc_Version=2", ACCESSCODE_VISA, amount, lang, vpc_MerchTxnRef, MERCHANT_ID_VISA];
            
            NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, HASHCODE_VISA];
            
            NSURL *urlLink = [NSURL URLWithString:get_hash_url];
            NSData *data = [NSData dataWithContentsOfURL: urlLink];
            NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //
            returnURL = [returnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            params = [NSString stringWithFormat:@"AgainLink=onepay.vn&Title=NhanHoaCompany&vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Locale=%@&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=%@&vpc_ReturnURL=%@&vpc_Version=2&vpc_SecureHash=%@", ACCESSCODE_VISA, amount, lang, vpc_MerchTxnRef, MERCHANT_ID_VISA, @"NAP_TIEN_VAO_VI", returnURL, secureHash];
            
            NSString *url = [NSString stringWithFormat:@"https://mtf.onepay.vn/vpcpay/vpcpay.op?%@&vpc_SecureHash=%@", params, secureHash];
            [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
            
        }else{
            [self makeToast:@"Số tiền thanh toán không hợp lệ. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

#pragma mark - Webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    
    //url = @"https://mtf.onepay.vn/onecomm-pay/http?vpc_AdditionData=970425&vpc_Amount=1500000000&vpc_Command=pay&vpc_CurrencyCode=VND&vpc_Locale=vn&vpc_MerchTxnRef=201904191555668012.153090&vpc_Merchant=ONEPAY&vpc_OrderInfo=JSECURETEST01&vpc_TransactionNo=1701694&vpc_TxnResponseCode=0&vpc_Version=2&vpc_SecureHash=898C1DA1E61A34BF0B66494E224D763D04376A52426CBC909E528D328E9704EE";
    
    if (webView.loading) {
        icWaiting.hidden = FALSE;
        [icWaiting startAnimating];
        return;
    }
    
    NSString *query = [webView.request.URL query];
    if (query != nil && ![query isEqualToString:@""])
    {
        if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"])
        {
            
            icWaiting.hidden = TRUE;
            [icWaiting stopAnimating];
        }
        
        NSDictionary *info = [self getResultInfoFromString: query];
        NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
        if (vpc_TxnResponseCode != nil)
        {
            NSString *vpc_SecureHash = [info objectForKey:@"vpc_SecureHash"];
            if (vpc_SecureHash != nil && ![vpc_SecureHash isEqualToString:@""])
            {
                NSString *get_hash_url = @"";
                if (typePaymentMethod == ePaymentWithATM) {
                    get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=getHashCode&%@&scret=%@", query, HASHCODE];
                }else{
                    get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=getHashCode&%@&scret=%@", query, HASHCODE_VISA];
                }
                
                NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:get_hash_url]];
                NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if (secureHash != nil && ![secureHash isEqualToString:@""] && [secureHash isEqualToString: vpc_SecureHash]) {
                    //  vpc_SecureHash ==   secureHash: DỮ LIỆU ĐÃ ĐƯỢC TOÀN VẸN
                    [self processWithInfo: info];
                    
                }else{
                    NSLog(@"Dữ liệu không toàn vẹn");
                }
            }
        }else{
            NSString *path = webView.request.URL.path;
            if (![AppUtils isNullOrEmpty: path]) {
                NSArray *contentArr = [path componentsSeparatedByString:@"/"];
                if (contentArr != nil && [contentArr containsObject:@"cancel.op"]) {
                    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"Received url with path %@", path] toFilePath:[AppDelegate sharedInstance].logFilePath];
                    [self userCancelPayment];
                }
            }
//            NSLog(@"---------------------------------------------");
//            NSLog(@"Load: %@", webView.request.URL.absoluteString);
//            NSLog(@"host: %@", webView.request.URL.host);
//            NSLog(@"port: %@", webView.request.URL.port);
//            NSLog(@"user: %@", webView.request.URL.user);
//            NSLog(@"password: %@", webView.request.URL.password);
//            NSLog(@"Path: %@", );
//            NSLog(@"fragment: %@", webView.request.URL.fragment);
//            NSLog(@"parameter: %@", webView.request.URL.parameterString);
//            NSLog(@"query: %@", webView.request.URL.query);
//            NSLog(@"relativePath: %@", webView.request.URL.relativePath);
            /*
            AgainLink = "onepay.vn";
            Title = NhanHoaCompany;
            "vpc_Amount" = 61600000;
            "vpc_Command" = pay;
            "vpc_Locale" = vn;
            "vpc_MerchTxnRef" = "20190514_1557820445.363928";
            "vpc_Merchant" = TESTONEPAY;
            "vpc_Message" = Cancel;
            "vpc_OrderInfo" = JSECURETEST01;
            "vpc_SecureHash" = 88FF3B0BF251A35771990A378C9E5587E97DB6788DB2DC9C4736FA7AB5353631;
            "vpc_TxnResponseCode" = 99;
            "vpc_Version" = 2;  */
        }
    }
}

- (void)userCancelPayment {
    if ([delegate respondsToSelector:@selector(userClickCancelPayment)]) {
        [delegate userClickCancelPayment];
        [self makeToast:@"Bạn đã hủy giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
    }
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

- (void)processWithInfo: (NSDictionary *)info {
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self makeToast:@"Giao dịch không thành công. Bạn đã hủy giao dịch!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            //  [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:2.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_number_Code]) {
            [self makeToast:@"Giao dịch không thành công. Số thẻ không đúng. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self showPaymentContentViewWithMoney: topupMoney];
            
            return;
        }else if ([vpc_TxnResponseCode isEqualToString: Expired_card_Code]) {
            [self makeToast:@"Giao dịch không thành công. Thẻ hết hạn/Thẻ bị khóa. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self showPaymentContentViewWithMoney: topupMoney];
            return;
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_name_Code]) {
            [self makeToast:@"Giao dịch không thành công. Tên chủ thẻ không đúng. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Insufficient_fund_Code]) {
            [self makeToast:@"Giao dịch không thành công. Số tiền không đủ để thanh toán. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self showPaymentContentViewWithMoney: topupMoney];
            return;
        }
    }
}

https://authentication.tpb.vn/PGAuthentication/?ID=10f0e1db420f100bcd2c0d22e535eacf3abb80f599406aab4f23af67270c45c445444907854#


@end
