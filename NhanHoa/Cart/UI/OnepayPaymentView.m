//
//  OnepayPaymentView.m
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OnepayPaymentView.h"
#import "PaymentMethodCell.h"
#import "CartModel.h"

@implementation OnepayPaymentView
@synthesize tbMethod, wvPayment, typePaymentMethod, delegate;

- (void)setupUIForViewWithMenuHeight: (float)hMenu heightNav:(float)hNav padding: (float)padding
{
    self.clipsToBounds = TRUE;
    typePaymentMethod = ePaymentWithATM;
    
    [tbMethod registerNib:[UINib nibWithNibName:@"PaymentMethodCell" bundle:nil] forCellReuseIdentifier:@"PaymentMethodCell"];
    tbMethod.delegate = self;
    tbMethod.dataSource = self;
    tbMethod.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    float hFooter = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + hNav + hMenu + 2*60.0);
    
    UIView *footerView;
    if (hFooter < 75) {
        hFooter = 75.0;
    }
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    footerView.backgroundColor = UIColor.whiteColor;
    
    UIButton *btnConfirmPayment = [[UIButton alloc] initWithFrame:CGRectMake(padding, footerView.frame.size.height-padding-45.0, footerView.frame.size.width-2*padding, 45.0)];
    [btnConfirmPayment setTitle:@"Tiến hành thang toán" forState:UIControlStateNormal];
    btnConfirmPayment.backgroundColor = BLUE_COLOR;
    [btnConfirmPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnConfirmPayment.layer.cornerRadius = 45.0/2;
    btnConfirmPayment.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [footerView addSubview: btnConfirmPayment];
    [btnConfirmPayment addTarget:self
                          action:@selector(btnConfirmPaymentPress)
                forControlEvents:UIControlEventTouchUpInside];
    tbMethod.tableFooterView = footerView;
    
    wvPayment.hidden = TRUE;
    wvPayment.opaque = NO;
    wvPayment.scalesPageToFit = YES;
    wvPayment.delegate = self;
    wvPayment.backgroundColor = UIColor.whiteColor;
    [wvPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
}

- (void)btnConfirmPaymentPress {
    wvPayment.hidden = FALSE;
    
    if (typePaymentMethod == ePaymentWithATM)
    {
        NSString *returnURL = return_url;
        returnURL = @"";
        
        //  Thêm 2 số 0 vào amount hiện tại
        long totalMoney = [[CartModel getInstance] getTotalPriceForCart];
        NSString *amount = [NSString stringWithFormat:@"%ld00", totalMoney];
        
        NSString *transactionID = [AppUtils generateIDForTransaction];
        //  20190514_1557803641.218678
        NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=D67342C2&vpc_Amount=%@&vpc_Command=pay&vpc_Currency=VND&vpc_Locale=vn&vpc_MerchTxnRef=%@&vpc_Merchant=ONEPAY&vpc_OrderInfo=JSECURETEST01&vpc_ReturnURL=%@&vpc_Version=2", amount, transactionID, returnURL];
        
        NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, @"A3EFDFABA8653DF2342E8DAC29B51AF0"];
        
        NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:get_hash_url]];
        NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //  074D8D27C3ED8409130B6C6029F026FB35F749405D19C16A6A055530803503DA
        NSString *url = [NSString stringWithFormat:@"https://mtf.onepay.vn/onecomm-pay/vpc.op?%@&vpc_SecureHash=%@", params, secureHash];
        [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
        
    }else if (typePaymentMethod == ePaymentWithVisaMaster) {
        NSString *returnURL = @"https://api.websudo.xyz/dr.php";
        returnURL = @"";
        
        NSString *vpc_MerchTxnRef = [AppUtils generateIDForTransaction];
        NSString *lang = @"vn";
        
        //  Thêm 2 số 0 vào amount hiện tại
        long totalMoney = [[CartModel getInstance] getTotalPriceForCart];
        NSString *amount = [NSString stringWithFormat:@"%ld00", totalMoney];
        
        NSString *params = [NSString stringWithFormat:@"vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Locale=%@&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=JSECURETEST01&vpc_ReturnURL=https://api.websudo.xyz/dr.php&vpc_Version=2", ACCESSCODE_VISA, amount, lang, vpc_MerchTxnRef, MERCHANT_ID_VISA];
        
        NSString *get_hash_url = [NSString stringWithFormat:@"https://api.websudo.xyz/test.php?function=parseAndGet&%@&scret=%@", params, HASHCODE_VISA];
        
        NSURL *urlLink = [NSURL URLWithString:get_hash_url];
        NSData *data = [NSData dataWithContentsOfURL: urlLink];
        NSString *secureHash = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //
        returnURL = [returnURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        params = [NSString stringWithFormat:@"AgainLink=onepay.vn&Title=NhanHoaCompany&vpc_AccessCode=%@&vpc_Amount=%@&vpc_Command=pay&vpc_Locale=%@&vpc_MerchTxnRef=%@&vpc_Merchant=%@&vpc_OrderInfo=JSECURETEST01&vpc_ReturnURL=%@&vpc_Version=2&vpc_SecureHash=%@", ACCESSCODE_VISA, amount, lang, vpc_MerchTxnRef, MERCHANT_ID_VISA, returnURL, secureHash];
        
        NSString *url = [NSString stringWithFormat:@"https://mtf.onepay.vn/vpcpay/vpcpay.op?%@&vpc_SecureHash=%@", params, secureHash];
        [wvPayment loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString: url]]];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentMethodCell *cell = (PaymentMethodCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentMethodCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.imgType.image = [UIImage imageNamed:@"atm.png"];
        cell.lbTitle.text = @"Cổng thanh toán nội địa";
        cell.lbSepa.hidden = FALSE;
        
    }else{
        cell.imgType.image = [UIImage imageNamed:@"visa.png"];
        cell.lbTitle.text = @"Cổng thanh toán quốc tế";
        cell.lbSepa.hidden = TRUE;
    }
    
    if (typePaymentMethod == (PaymentMethod)indexPath.row) {
        cell.imgChoose.hidden = FALSE;
    }else{
        cell.imgChoose.hidden = TRUE;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    typePaymentMethod = (PaymentMethod)indexPath.row;
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
#pragma mark - Webview delegate
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"---start: %@", request.URL.absoluteString);
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *url = [webView.request.URL absoluteString];
    //url = @"https://mtf.onepay.vn/onecomm-pay/http?vpc_AdditionData=970425&vpc_Amount=1500000000&vpc_Command=pay&vpc_CurrencyCode=VND&vpc_Locale=vn&vpc_MerchTxnRef=201904191555668012.153090&vpc_Merchant=ONEPAY&vpc_OrderInfo=JSECURETEST01&vpc_TransactionNo=1701694&vpc_TxnResponseCode=0&vpc_Version=2&vpc_SecureHash=898C1DA1E61A34BF0B66494E224D763D04376A52426CBC909E528D328E9704EE";
    
    NSString *query = [webView.request.URL query];
    if (query != nil && ![query isEqualToString:@""])
    {
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
                    [delegate paymentResultWithInfo: info];
                    
                }else{
                    NSLog(@"Dữ liệu không toàn vẹn");
                }
            }
            
        }else{
            NSLog(@"Không có vpc_TxnResponseCode");
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

@end
