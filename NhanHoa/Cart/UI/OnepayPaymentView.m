//
//  OnepayPaymentView.m
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OnepayPaymentView.h"
#import "CartModel.h"
#import "AccountModel.h"

@implementation OnepayPaymentView
@synthesize viewHeader, icBack, lbHeader, wvPayment, typePaymentMethod, delegate, typePayment, topupMoney, icWaiting, resultView;

- (IBAction)icBackClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(onBackIconClick)]) {
        [delegate onBackIconClick];
    }
}

- (void)setupUIForView
{
    self.clipsToBounds = TRUE;
    
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
    topupMoney = money;
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang xử lý..." Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getAddfunWithAmout:[NSString stringWithFormat:@"%ld", topupMoney] type:typePaymentMethod];
}

#pragma mark - Webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView.loading) {
//        icWaiting.hidden = FALSE;
//        [icWaiting startAnimating];
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
                    [WriteLogsUtils writeLogContent:SFM(@"[%s] >>>>>>>>>>>>>>>>>>>> Dữ liệu không toàn vẹn", __FUNCTION__)];
                }
            }
        }else{
            NSString *path = webView.request.URL.path;
            if (![AppUtils isNullOrEmpty: path]) {
                NSArray *contentArr = [path componentsSeparatedByString:@"/"];
                if (contentArr != nil && [contentArr containsObject:@"cancel.op"]) {
                    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"Received url with path %@", path]];
                    [self userCancelPayment];
                }
            }
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s] >>>>>>>>>>>>>>> info = %@", __FUNCTION__, @[info])];
    
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: Bank_Declined_Code]) {
            [self makeToast:@"Giao dịch không thành công. Ngân hàng phát hành thẻ từ chối cấp phép cho giao dịch. Vui lòng liên hệ ngân hàng theo số điện thoại sau mặt thẻ để biết chính xác nguyên nhân Ngân hàng từ chối." duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            return;
           
        }else if ([vpc_TxnResponseCode isEqualToString: Merchant_not_exist_Code]) {
            [self makeToast:@"Giao dịch không thành công, có lỗi trong quá trình cài đặt cổng thanh toán. Vui lòng liên hệ với OnePAY để được hỗ trợ (Hotline 1900 633 927)" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_access_Code]) {
            [self makeToast:@"Giao dịch không thành công, có lỗi trong quá trình cài đặt cổng thanh toán. Vui lòng liên hệ với OnePAY để được hỗ trợ (Hotline 1900 633 927)" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_amount_Code]) {
            [self makeToast:@"Giao dịch không thành công, số tiền không hợp lệ. Vui lòng liên hệ với OnePAY để được hỗ trợ (Hotline 1900 633 927)" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_currency_Code]) {
            [self makeToast:@"Giao dịch không thành công, loại tiền tệ không hợp lệ. Vui lòng liên hệ với OnePAY để được hỗ trợ (Hotline 1900 633 927)" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Unspecified_failure_Code]) {
            [self makeToast:@"Giao dịch không thành công. Ngân hàng phát hành thẻ từ chối cấp phép cho giao dịch. Vui lòng liên hệ ngân hàng theo số điện thoại sau mặt thẻ để biết chính xác nguyên nhân Ngân hàng từ chối." duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_number_Code]) {
            [self makeToast:@"Giao dịch không thành công. Số thẻ không đúng. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            
            return;
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_name_Code]) {
            [self makeToast:@"Giao dịch không thành công. Tên chủ thẻ không đúng. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Expired_card_Code]) {
            [self makeToast:@"Giao dịch không thành công. Thẻ hết hạn/Thẻ bị khóa. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Card_not_registed_Code]) {
            [self makeToast:@"Giao dịch không thành công. Thẻ chưa đăng ký sử dụng dịch vụ thanh toán trên Internet. Vui lòng liên hê ngân hàng theo số điện thoại sau mặt thẻ để được hỗ trợ." duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_date_Code]) {
            [self makeToast:@"Giao dịch không thành công. Ngày phát hành/Hết hạn không đúng. Vui lòng kiểm tra và thực hiện thanh toán lại" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Exist_Amount_Code]) {
            [self makeToast:@"Giao dịch không thành công. thẻ/ tài khoản đã vượt quá hạn mức thanh toán. Vui lòng kiểm tra và thực hiện thanh toán lại" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Insufficient_fund_Code]) {
            [self makeToast:@"Giao dịch không thành công. Số tiền không đủ để thanh toán. Vui lòng kiểm tra và thực hiện thanh toán lại!" duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:4.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self makeToast:@"Giao dịch không thành công. Bạn đã hủy giao dịch!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Failured_Content]) {
            [self makeToast:@"Giao dịch không thành công!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            //  [self showPaymentContentViewWithMoney: topupMoney];
            return;
        }else if ([vpc_TxnResponseCode isEqualToString: Approved_Code]){
            [[AppDelegate sharedInstance] startTimerToReloadInfoAfterTopupSuccessful];
            
            [self regetMyAccountInformation];
            
            [self makeToast:@"Giao dịch thành công!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
        }else{
            [self makeToast:@"Giao dịch không thành công!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            return;
        }
    }
}

- (void)backIconViewResultClick {
    if ([delegate respondsToSelector:@selector(onBackIconClick)]) {
        [delegate onBackIconClick];
    }
}

- (void)regetMyAccountInformation {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    
}

-(void)failedToGetAmoutWithError:(NSString *)error {
    [ProgressHUD dismiss];
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)getAmoutSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [self showPaymentContentViewWithData: data];
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(onBackIconClick)]) {
        [delegate onBackIconClick];
    }
}

- (void)showPaymentContentViewWithData: (NSDictionary *)data {
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        wvPayment.hidden = FALSE;
        icWaiting.hidden = FALSE;
        [icWaiting startAnimating];
        
        NSString *url = [data objectForKey:@"url"];
        if (![AppUtils isNullOrEmpty: url]) {
            [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
        }else{
            [self dismissView];
        }
    }else{
        [self dismissView];
    }
    
    return;
    NSString *returnURL = return_url;
    
    NSString *vpc_OrderInfo = [NSString stringWithFormat:@"App_Addfun_%@", [AccountModel getCusIdOfUser]];
    
    if (typePaymentMethod == ePaymentWithATM && topupMoney > 0) {
        
        //  Thêm 2 số 0 vào amount hiện tại
        NSString *amount = [NSString stringWithFormat:@"%ld00", topupMoney];
        if (![AppUtils isNullOrEmpty: amount]) {
            NSString *vpc_MerchTxnRef = [AppDelegate sharedInstance].hashKey;
            
            NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Currency=VND&vpc_Locale=vn&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=%@&vpc_ReturnURL=%@&vpc_Version=2", ACCESSCODE, amount, vpc_MerchTxnRef, MERCHANT_ID, vpc_OrderInfo, returnURL];
            
            NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, HASHCODE];
            
            NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:get_hash_url]];
            NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //  074D8D27C3ED8409130B6C6029F026FB35F749405D19C16A6A055530803503DA
            NSString *url = [NSString stringWithFormat:@"%@?%@&vpc_SecureHash=%@", URL_Payment, params, secureHash];
            [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
            
        }else{
            [self makeToast:@"Số tiền thanh toán không hợp lệ. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
        
    }else if (typePaymentMethod == ePaymentWithVisaMaster && topupMoney > 0) {
        
        NSString *vpc_MerchTxnRef = [AppDelegate sharedInstance].hashKey;
        NSString *lang = @"vn";
        
        //  Thêm 2 số 0 vào amount hiện tại
        NSString *amount = [NSString stringWithFormat:@"%ld00", topupMoney];
        
        if (![AppUtils isNullOrEmpty: amount]) {
            
            NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Locale=%@&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=%@&vpc_ReturnURL=%@&vpc_Version=2", ACCESSCODE_VISA, amount, lang, vpc_MerchTxnRef, MERCHANT_ID_VISA, vpc_OrderInfo, returnURL];
            
            NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, HASHCODE_VISA];
            
            NSURL *urlLink = [NSURL URLWithString:get_hash_url];
            NSData *data = [NSData dataWithContentsOfURL: urlLink];
            NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //
            returnURL = [returnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
            params = [NSString stringWithFormat:@"AgainLink=onepay.vn&Title=NhanHoaCompany&vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Locale=%@&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=%@&vpc_ReturnURL=%@&vpc_Version=2&vpc_SecureHash=%@", ACCESSCODE_VISA, amount, lang, vpc_MerchTxnRef, MERCHANT_ID_VISA, vpc_OrderInfo, returnURL, secureHash];
            
            NSString *url = [NSString stringWithFormat:@"%@?%@&vpc_SecureHash=%@", URL_Payment_VISA, params, secureHash];
            [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
            
        }else{
            [self makeToast:@"Số tiền thanh toán không hợp lệ. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

@end
