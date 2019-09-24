//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentMethodCell.h"
#import "MoMoPayment.h"
#import "MoMoConfig.h"
#import "MoMoDialogs.h"
#import "RSA.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource, OnepayPaymentViewDelegate>
{
    AppDelegate *appDelegate;
    float hCell;
    UIButton *btnMoMoPayment;
    
    //SDK v2.2
    MoMoDialogs *dialog;
}
@end

@implementation PaymentViewController
@synthesize tbContent, btnContinue, money, typePaymentMethod, paymentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Nạp tiền vào ví";
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"PaymentViewController"];
    
    typePaymentMethod = ePaymentWithATM;
    btnMoMoPayment.hidden = TRUE;
    
    [self registerObServers];
}

- (void)registerObServers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NoficationCenterTokenReceived:)
                                                 name:@"NoficationCenterTokenReceived" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NoficationCenterTokenStartRequest:)
                                                 name:@"NoficationCenterTokenStartRequest" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.paymentView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)setupUIForView {
    hCell = 60.0;
    float hBTN = 45.0;
    float padding = 15.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        hCell = 80.0;
        hBTN = 55.0;
        padding = 30.0;
    }
    //  Add MoMo payment button to self.view
    btnMoMoPayment = [UIButton buttonWithType: UIButtonTypeCustom];
    [[MoMoPayment shareInstant] addMoMoPayCustomButton:btnMoMoPayment forControlEvents:UIControlEventTouchUpInside toView:self.view];
    
    btnContinue.titleLabel.font = btnMoMoPayment.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnContinue.layer.cornerRadius = btnMoMoPayment.layer.cornerRadius = hBTN/2;
    btnContinue.backgroundColor = BLUE_COLOR;
    
    [btnContinue setTitle:text_continue forState:UIControlStateNormal];
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnMoMoPayment.backgroundColor = BLUE_COLOR;
    [btnMoMoPayment setTitle:text_continue forState:UIControlStateNormal];
    [btnMoMoPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnMoMoPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(btnContinue);
    }];
    
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(btnContinue.mas_top).offset(-padding);
    }];
    [tbContent registerNib:[UINib nibWithNibName:@"PaymentMethodCell" bundle:nil] forCellReuseIdentifier:@"PaymentMethodCell"];
}


#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentMethodCell *cell = (PaymentMethodCell *)[tableView dequeueReusableCellWithIdentifier:@"PaymentMethodCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == ePaymentWithATM) {
        cell.imgType.image = [UIImage imageNamed:@"atm.png"];
        cell.lbTitle.text = @"Thẻ ATM nội địa và Internet Banking";
        cell.lbSepa.hidden = FALSE;
        
    }else if(indexPath.row == ePaymentWithVisaMaster){
        cell.imgType.image = [UIImage imageNamed:@"master-card.png"];
        cell.lbTitle.text = @"Thẻ Visa / Master";
        cell.lbSepa.hidden = FALSE;
        
    }else{
        cell.imgType.image = [UIImage imageNamed:@"momo_icon"];
        cell.lbTitle.text = @"Ví MoMo";
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
    if (typePaymentMethod == ePaymentWithMoMo) {
        [self prepareInfoForMoMoPayment];
        
        btnContinue.hidden = TRUE;
        btnMoMoPayment.hidden = FALSE;
    }else{
        btnContinue.hidden = FALSE;
        btnMoMoPayment.hidden = TRUE;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return hCell;
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startContinuePayment) withObject:nil afterDelay:0.05];
}

- (void)startContinuePayment {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (typePaymentMethod == ePaymentWithATM || typePaymentMethod == ePaymentWithVisaMaster) {
        [self addOnepayPaymentViewIfNeed];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }completion:^(BOOL finished) {
            self.paymentView.typePaymentMethod = self.typePaymentMethod;
            [self.paymentView showPaymentContentViewWithMoney: self.money];
        }];
    }else{
        
    }
}

- (void)addOnepayPaymentViewIfNeed {
    if (paymentView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OnepayPaymentView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OnepayPaymentView class]]) {
                paymentView = (OnepayPaymentView *) currentObject;
                break;
            }
        }
        UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
        [curWindow addSubview: paymentView];
    }
    paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [paymentView setupUIForView];
    paymentView.delegate = self;
    paymentView.backgroundColor = UIColor.whiteColor;
}

#pragma mark - PaymentView Delegate
-(void)onBackIconClick {
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)onBackIconResultViewClick {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)userClickCancelPayment {
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)paymentResultWithInfo:(NSDictionary *)info {
    //  reset hashkey
    [AppDelegate sharedInstance].hashKey = @"";
    
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self.view makeToast:@"Bạn đã hủy bỏ giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            //  [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:2.0];
            return;
            
        }else if ([vpc_TxnResponseCode isEqualToString: Invalid_card_number_Code]) {
            [self.view makeToast:@"Số thẻ không chính xác. Vui lòng kiểm tra lại" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
    }
}

- (void)dismissView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - For MoMo
- (void)prepareInfoForMoMoPayment {
    //  Khai Le: setup for business account
    NSString *appBundleID = [[NSBundle mainBundle] bundleIdentifier];
    [[MoMoPayment shareInstant] initializingAppBundleId:appBundleID
                                             merchantId:MoMo_Merchant_ID
                                           merchantName:@"Nhân Hoà"
                                      merchantNameTitle:@"Nhà cung cấp" billTitle:@"Người dùng"];
    
    NSString *content = @"Nạp tiền vào ví cho ứng dụng Nhân Hoà";
    NSMutableDictionary *paymentinfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        [NSNumber numberWithLong: money], @"amount",
                                        [NSNumber numberWithInt:0], @"fee",
                                        content, @"description",
                                        @"{\"key1\":\"value1\",\"key2\":\"value2\"}",@"extra",
                                        @"vi",@"language",
                                        [AccountModel getCusEmail], @"username",
                                        nil];
    
    [paymentinfo setValue:MoMo_IOS_SCHEME_ID forKey:@"appScheme"];
    [[MoMoPayment shareInstant] initPaymentInformation:paymentinfo momoAppScheme:@"com.momo.appv2.ios" environment:MOMO_SDK_DEVELOPMENT];
}

-(void)NoficationCenterTokenStartRequest:(NSNotification*)notif
{
    if (notif.object != nil && [notif.object isEqualToString:@"MoMoWebDialogs"]) {
        dialog = [[MoMoDialogs alloc] init];
        [self presentViewController:dialog animated:YES completion:nil];
    }
}

-(void)NoficationCenterTokenReceived:(NSNotification*)notif
{
    if (dialog) {
        [dialog dismissViewControllerAnimated:YES completion:^{
            [self processMoMoNoficationCenterTokenReceived:notif];
        }];
    }
    else{
        [self processMoMoNoficationCenterTokenReceived:notif];
    }
}

-(void)processMoMoNoficationCenterTokenReceived:(NSNotification*)notif{
    
    //Token Replied
    NSLog(@"::MoMoPay Log::Received Token Replied::%@",notif.object);
    
    NSString *sourceText = [NSString stringWithFormat:@"%@", notif.object];
    
    NSURL *url = [NSURL URLWithString:sourceText];
    if (url) {
        sourceText = url.query;
    }
    
    NSArray *parameters = [sourceText componentsSeparatedByString:@"&"];
    
    NSDictionary *response = [self getDictionaryFromComponents:parameters];
    NSString *status = [NSString stringWithFormat:@"%@",[response objectForKey:@"status"]];
    NSString *message = [NSString stringWithFormat:@"%@",[response objectForKey:@"message"]];
    if ([status isEqualToString:@"0"]) {
        NSLog(@"::MoMoPay Log: SUCESS TOKEN.");
        NSString *data = [NSString stringWithFormat:@"%@",[response objectForKey:@"data"]];//session data
        NSString *phoneNumber =  [NSString stringWithFormat:@"%@",[response objectForKey:@"phonenumber"]];//wallet Id
        NSString *env = @"app";
        if (response[@"env"]) {
            env =  [NSString stringWithFormat:@"%@",[response objectForKey:@"env"]];
        }
        
        if (response[@"extra"]) {
            //Decode base 64 for using
        }
        
        /*  SEND THESE PARRAM TO SERVER:  phoneNumber, data, env
         CALL API MOMO PAYMENT
         */
        //  hash: RSA (jsonString + public key);
        NSString *partnerRefId = SFM(@"Merchant_%@", [AppUtils randomStringWithLength: 10]);
        NSString *jsonString = [NSString stringWithFormat:@"{\"partnerCode\":\"%@\",\"partnerRefId\":\"%@\",\"amount\":%ld}", MoMo_Partner_Code, partnerRefId, money];
        NSString *hash = [RSA encryptString:jsonString publicKey:MoMo_PublicKey];
        
        NSString *requestBody = [NSString stringWithFormat:@"{\"partnerCode\":\"%@\",\"partnerRefId\":\"%@\",\"customerNumber\":\"%@\",\"appData\":\"%@\",\"hash\":\"%@\",\"version\":%f,\"payType\":%d}", MoMo_Partner_Code, partnerRefId, [response objectForKey:@"phonenumber"], data, hash, 2.0, 3];
        
        NSData *postData = [requestBody dataUsingEncoding:NSUTF8StringEncoding];;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:@"https://test-payment.momo.vn/pay/app"]];
        //  [request setURL:[NSURL URLWithString:MOMO_PAYMENT_URL]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
        [request setHTTPBody:postData];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

        NSURLResponse *response;
        NSError *err;
        NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        if (!err) {
            NSError *errJson;
            id responseObject = [NSJSONSerialization JSONObjectWithData:GETReply options:0 error:&errJson];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoficationCenterCreateOrderReceived" object:responseObject];

            id status = [responseObject objectForKey:@"status"];
            if (([status isKindOfClass:[NSNumber class]] && [status intValue] == 0) || ([status isKindOfClass:[NSString class]] && status != nil && [status isEqualToString:@"0"]))
            {
                //  TREO TIỀN THÀNH CÔNG, THỰC HIỆN GỬI IPN
                NSString *momoTransId = [responseObject objectForKey:@"transid"];
                NSString *message = [responseObject objectForKey:@"message"];
                if (momoTransId != nil) {
                    NSString *requestId = SFM(@"IDReq_%@", [AppUtils randomStringWithLength: 6]);
                    NSString *beforeHMAC = SFM(@"partnerCode=%@&partnerRefId=%@&requestType=%@&requestId=%@&momoTransId=%@", MoMo_Partner_Code, partnerRefId, MoMo_Request_Type_Confirm, requestId, momoTransId);
                    NSString *signature = [AppUtils getHashHmacSHA256OfString:beforeHMAC key:MoMo_SecretKey];
                    
                    NSString *requestBody = [NSString stringWithFormat:@"{\"partnerCode\":\"%@\",\"partnerRefId\":\"%@\",\"requestType\":\"%@\",\"requestId\":\"%@\",\"momoTransId\":\"%@\",\"signature\":\"%@\"}", MoMo_Partner_Code, partnerRefId, MoMo_Request_Type_Confirm, requestId, momoTransId, signature];
                    
                    NSData *postData = [requestBody dataUsingEncoding:NSUTF8StringEncoding];;
                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
                    [request setURL:[NSURL URLWithString:@"https://test-payment.momo.vn/pay/confirm"]];
                    //  [request setURL:[NSURL URLWithString:MOMO_PAYMENT_URL]];
                    [request setHTTPMethod:@"POST"];
                    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
                    [request setHTTPBody:postData];
                    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
                    
                    NSURLResponse *response;
                    NSError *err;
                    NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
                    if (!err) {
                        NSError *errJson;
                        id responseObject = [NSJSONSerialization JSONObjectWithData:GETReply options:0 error:&errJson];
                        id status = [responseObject objectForKey:@"status"];
                        if (([status isKindOfClass:[NSNumber class]] && [status intValue] == 0) || ([status isKindOfClass:[NSString class]] && status != nil && [status isEqualToString:@"0"]))
                        {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:SFM(@"%@", responseObject) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                            [alertView show];
                            /*
                            {
                                data =     {
                                    amount = 10000;
                                    momoTransId = 2307207562;
                                    partnerCode = MOMOIQA420180417;
                                    partnerRefId = "Merchant_BUeywencAN";
                                };
                                message = "Th\U00e0nh c\U00f4ng";
                                signature = 46b0601836e199d94b6ddc0e95a4359520e4ca63976726870856f486c2a46b8c;
                                status = 0;
                            }   */
                        }
                        
                    }else {
                        NSLog(@"Error: %@", err.localizedDescription);
                    }
                }
                
            }else{
                NSString *message = [responseObject objectForKey:@"message"];
                NSLog(@"status: %@ - message: %@", status, message);
                NSLog(@"----DONE");
            }
            
            /*
            {
                amount = 10000;
                message = "Giao d\U1ecbch \U0111\U00e3 \U0111\U01b0\U1ee3c x\U1eed l\U00fd. Qu\U00fd kh\U00e1ch vui l\U00f2ng ki\U1ec3m tra l\U1ea1i. Xin c\U1ea3m \U01a1n!";
                signature = eeb44ae8a6cc3a6b71c30499b31ab5851a8eda999da9ca160aba63fa46f67ecd;
                status = 2132;
                transid = 15693099908823;
            }
            */
            
        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoficationCenterCreateOrderReceived" object:err.description];
        }
                
        
//         dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
//             NSURLResponse *response;
//             NSError *err;
//             NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//             dispatch_async(dispatch_get_main_queue(), ^(void){
//                 if (!err) {
//                     NSError *errJson;
//                     id responseObject = [NSJSONSerialization JSONObjectWithData:GETReply options:0 error:&errJson];
//                     [[NSNotificationCenter defaultCenter] postNotificationName:@"NoficationCenterCreateOrderReceived" object:responseObject];
//
//                 }else {
//                     [[NSNotificationCenter defaultCenter] postNotificationName:@"NoficationCenterCreateOrderReceived" object:err.description];
//                 }
//             });
//         });
    }else
    {
        if ([status isEqualToString:@"1"]) {
            NSLog(@"::MoMoPay Log: REGISTER_PHONE_NUMBER_REQUIRE.");
        }
        else if ([status isEqualToString:@"2"]) {
            NSLog(@"::MoMoPay Log: LOGIN_REQUIRE.");
        }
        else if ([status isEqualToString:@"3"]) {
            NSLog(@"::MoMoPay Log: NO_WALLET. You need to cashin to MoMo Wallet ");
        }
        else if ([status isEqualToString:@"5"]) {
            [self.view makeToast:@"Hết thời gian thực hiện giao dịch!" duration:2.5 position:CSToastPositionCenter style:appDelegate.errorStyle];
            
        }else if ([status isEqualToString:@"6"]) {
            [self.view makeToast:@"Bạn đã huỷ giao dịch!" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        }else {
            [self.view makeToast:message duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        }
    }
}

-(NSMutableDictionary*) getDictionaryFromComponents:(NSArray *)components{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    // parse parameters to dictionary
    for (NSString *param in components) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        // get key, value
        NSString* key   = [elts objectAtIndex:0];
        key = [key stringByReplacingOccurrencesOfString:@"?" withString:@""];
        NSString* value = [elts objectAtIndex:1];
        
        ///Start Fix HTML Property issue
        if ([elts count]>2) {
            @try {
                value = [param substringFromIndex:([param rangeOfString:@"="].location+1)];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
        }
        ///End HTML Property issue
        if(value){
            value = [self stringForCStr:[value UTF8String]];
        }
        
        //
        if(key.length && value.length){
            [params setObject:value forKey:key];
        }
    }
    return params;
}

- (NSString*) stringForCStr:(const char *) cstr{
    if(cstr){
        return [NSString stringWithCString: cstr encoding: NSUTF8StringEncoding];
    }
    return @"";
}

@end
