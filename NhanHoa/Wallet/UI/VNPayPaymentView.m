//
//  VNPayPaymentView.m
//  NhanHoa
//
//  Created by OS on 11/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "VNPayPaymentView.h"

@implementation VNPayPaymentView
@synthesize viewHeader, lbHeader, icWaiting, wvContent, icBack;
@synthesize delegate;

- (IBAction)icBackClick:(UIButton *)sender {
    [self dismissView];
}

- (void)setupUIForViewWithHeightNav: (float)hNav
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.clipsToBounds = TRUE;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        icBack.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        icBack.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250);
    }];
    
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    
    wvContent.hidden = TRUE;
    wvContent.opaque = NO;
    wvContent.scalesPageToFit = YES;
    wvContent.delegate = self;
    wvContent.backgroundColor = UIColor.whiteColor;
    [wvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.bottom.right.equalTo(self);
    }];
    
    icWaiting.hidden = TRUE;
    icWaiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    icWaiting.backgroundColor = UIColor.whiteColor;
    icWaiting.alpha = 0.5;
    [icWaiting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(wvContent);
    }];
}

- (void)tryToLoadContentWithData: (NSDictionary *)data {
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        wvContent.hidden = FALSE;
        icWaiting.hidden = FALSE;
        [icWaiting startAnimating];
        
        NSString *url = [data objectForKey:@"url"];
        if (![AppUtils isNullOrEmpty: url]) {
            [wvContent loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
        }else{
            //  [self dismissView];
        }
    }else{
        //  [self dismissView];
    }
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
        NSLog(@"check query: %@", query);
        
        if ([[webView stringByEvaluatingJavaScriptFromString:@"document.readyState"] isEqualToString:@"complete"])
        {
            
            icWaiting.hidden = TRUE;
            [icWaiting stopAnimating];
        }
        
        NSDictionary *info = [self getResultInfoFromString: query];
        [self processWithInfo: info];
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

- (void)regetMyAccountInformation {
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

- (void)processWithInfo: (NSDictionary *)info
{
    NSString *vnp_ResponseCode = [info objectForKey:@"vnp_ResponseCode"];
    if (![AppUtils isNullOrEmpty: vnp_ResponseCode]) {
        if ([vnp_ResponseCode isEqualToString:@"0"]) {
            [[AppDelegate sharedInstance] startTimerToReloadInfoAfterTopupSuccessful];
            
            [self regetMyAccountInformation];
            
            [self makeToast:@"Giao dịch thành công" duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
            [self performSelector:@selector(paymentSuccessful) withObject:nil afterDelay:1.5];
            
        }else if ([vnp_ResponseCode isEqualToString:@"01"] || [vnp_ResponseCode isEqualToString:@"1"]) {
            [self makeToast:@"Giao dịch đã tồn tại" duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:1.5];
            
        }else if ([vnp_ResponseCode isEqualToString:@"02"] || [vnp_ResponseCode isEqualToString:@"2"]) {
            [self makeToast:@"Merchant không hợp lệ" duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:1.5];
            
        }else if ([vnp_ResponseCode isEqualToString:@"03"] || [vnp_ResponseCode isEqualToString:@"3"]) {
            [self makeToast:@"Dữ liệu gửi sang không đúng định dạng" duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:1.5];
            
        }else if ([vnp_ResponseCode isEqualToString:@"04"] || [vnp_ResponseCode isEqualToString:@"4"]) {
            [self makeToast:@"Khởi tạo GD không thành công do Website đang bị tạm khóa" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"05"] || [vnp_ResponseCode isEqualToString:@"5"]) {
            [self makeToast:@"Quý khách nhập sai mật khẩu quá số lần quy định. Xin quý khách vui lòng thực hiện lại giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"08"] || [vnp_ResponseCode isEqualToString:@"8"]) {
            [self makeToast:@"Hệ thống Ngân hàng đang bảo trì. Xin quý khách tạm thời không thực hiện giao dịch bằng thẻ/tài khoản của Ngân hàng này." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"13"]) {
            [self makeToast:@"Quý khách nhập sai mật khẩu xác thực giao dịch (OTP). Xin quý khách vui lòng thực hiện lại giao dịch." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"07"] || [vnp_ResponseCode isEqualToString:@"7"]) {
            [self makeToast:@"Giao dịch bị nghi ngờ là giao dịch gian lận" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"09"] || [vnp_ResponseCode isEqualToString:@"9"]) {
            [self makeToast:@"Thẻ/Tài khoản của khách hàng chưa đăng ký dịch vụ InternetBanking tại ngân hàng." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"10"]) {
            [self makeToast:@"Khách hàng xác thực thông tin thẻ/tài khoản không đúng quá 3 lần" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"11"]) {
            [self makeToast:@"Đã hết hạn chờ thanh toán. Xin quý khách vui lòng thực hiện lại giao dịch." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"12"]) {
            [self makeToast:@"Thẻ/Tài khoản của khách hàng bị khóa." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"24"]) {
            [self makeToast:@"Bạn đã hủy giao dịch." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"51"]) {
            [self makeToast:@"Tài khoản của quý khách không đủ số dư để thực hiện giao dịch." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"65"]) {
            [self makeToast:@"Tài khoản của Quý khách đã vượt quá hạn mức giao dịch trong ngày." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"91"]) {
            [self makeToast:@"Không tìm thấy giao dịch yêu cầu hoàn trả." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"93"]) {
            [self makeToast:@"Số tiền hoàn trả không hợp lệ. Số tiền hoàn trả phải nhỏ hơn hoặc bằng số tiền thanh toán." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"94"]) {
            [self makeToast:@"Giao dịch đã được gửi yêu cầu hoàn tiền trước đó. Yêu cầu này VNPAY đang xử lý." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"95"]) {
            [self makeToast:@"Giao dịch này không thành công bên VNPAY. VNPAY từ chối xử lý yêu cầu." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"97"]) {
            [self makeToast:@"Chữ ký không hợp lệ." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
            
        }else if ([vnp_ResponseCode isEqualToString:@"00"]) {
            [self makeToast:@"Giao dịch bị hủy bỏ do không khớp dữ liệu." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
        }else {
            [self makeToast:@"Lỗi không xác định." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
        }
    }
}

- (void)dismissView {
    if ([delegate respondsToSelector:@selector(closeVNPayPaymentView)]) {
        [delegate closeVNPayPaymentView];
    }
}

- (void)paymentSuccessful {
    if ([delegate respondsToSelector:@selector(VNPayPaymentSuccessful)]) {
        [delegate VNPayPaymentSuccessful];
    }
}

@end
