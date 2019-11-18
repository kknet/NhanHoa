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
#import "VNPayPaymentView.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource, OnepayPaymentViewDelegate, WebServiceUtilsDelegate, VNPayPaymentViewDelegate>
{
    AppDelegate *appDelegate;
    float hCell;
    UIButton *btnMoMoPayment;
    
    //SDK v2.2
    MoMoDialogs *dialog;
    VNPayPaymentView *vnPayView;
    
    NSString *appData;
    NSString *momoPhoneNumber;
}
@end

@implementation PaymentViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, tbContent, btnContinue, money, typePaymentMethod, paymentView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self updateCartCountForView];
    
    lbHeader.text = @"Nạp tiền vào ví";
    
    [self prepareInfoForMoMoPayment];
    
    typePaymentMethod = ePaymentWithVNPayATM;
    btnMoMoPayment.hidden = TRUE;
    btnContinue.hidden = FALSE;
    
    [self registerObServers];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
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

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hBTN = 53.0;
    float padding = 15.0;
    
    hCell = 80.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hCell = 60.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hCell = 70.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 53.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hCell = 80.0;
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
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
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo( appDelegate.sizeCartCount);
    }];
    
    
    //  Add MoMo payment button to self.view
    btnMoMoPayment = [UIButton buttonWithType: UIButtonTypeCustom];
    [[MoMoPayment shareInstant] addMoMoPayCustomButton:btnMoMoPayment forControlEvents:UIControlEventTouchUpInside toView:self.view];
    
    btnContinue.titleLabel.font = btnMoMoPayment.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    btnContinue.layer.cornerRadius = btnMoMoPayment.layer.cornerRadius = 8.0;
    btnContinue.backgroundColor = BLUE_COLOR;
    
    [btnContinue setTitle:text_continue forState:UIControlStateNormal];
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    if (appDelegate.safeAreaBottomPadding > 0) {
        [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(padding);
            make.right.equalTo(self.view).offset(-padding);
            make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
            make.height.mas_equalTo(hBTN);
        }];
    }else{
        [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(padding);
            make.bottom.right.equalTo(self.view).offset(-padding);
            make.height.mas_equalTo(hBTN);
        }];
    }
    
    
    btnMoMoPayment.backgroundColor = BLUE_COLOR;
    [btnMoMoPayment setTitle:text_continue forState:UIControlStateNormal];
    [btnMoMoPayment setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnMoMoPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(btnContinue);
    }];
    
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent registerNib:[UINib nibWithNibName:@"PaymentMethodCell" bundle:nil] forCellReuseIdentifier:@"PaymentMethodCell"];
    tbContent.scrollEnabled = FALSE;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(btnContinue.mas_top).offset(-padding);
    }];
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
    
    if (indexPath.row == ePaymentWithVNPayATM) {
        cell.imgType.image = [UIImage imageNamed:@"vnpay_logo"];
        cell.lbTitle.text = @"iBanking / Thẻ ATM nội địa";
        cell.lbSepa.hidden = FALSE;
        
    }else if (indexPath.row == ePaymentWithVNPayMaster) {
        cell.imgType.image = [UIImage imageNamed:@"vnpay_logo"];
        cell.lbTitle.text = @"Thẻ thanh toán quốc tế Visa/ MasterCard";
        cell.lbSepa.hidden = FALSE;
        
        
    }else if (indexPath.row == ePaymentWithMoMo) {
        cell.imgType.image = [UIImage imageNamed:@"momo_icon"];
        cell.lbTitle.text = @"Ví MOMO";
        cell.lbSepa.hidden = FALSE;
        
    }else if (indexPath.row == ePaymentWithATM) {
        cell.imgType.image = [UIImage imageNamed:@"atm.png"];
        cell.lbTitle.text = @"Thẻ ATM nội địa và Internet Banking";
        cell.lbSepa.hidden = FALSE;
        
    }else if(indexPath.row == ePaymentWithVisaMaster){
        cell.imgType.image = [UIImage imageNamed:@"master-card.png"];
        cell.lbTitle.text = @"Thẻ Visa / Master";
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
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"No network connection. Please check again!"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startContinuePayment) withObject:nil afterDelay:0.05];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

- (void)startContinuePayment {
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (typePaymentMethod == ePaymentWithATM || typePaymentMethod == ePaymentWithVisaMaster) {
        [self addOnepayPaymentViewIfNeed];
        
        [UIView animateWithDuration:0.3 animations:^{
            paymentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }completion:^(BOOL finished) {
            paymentView.typePaymentMethod = typePaymentMethod;
            [paymentView showPaymentContentViewWithMoney: money];
        }];
    }else if (typePaymentMethod == ePaymentWithVNPayATM || typePaymentMethod == ePaymentWithVNPayMaster){
        //  Payment with VNPay
        if (money <= 0) {
            [self.view makeToast:@"Số tiền nạp không hợp lệ. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
            return;
        }
        
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:@"Đang xử lý..." Interaction:FALSE];
        
        if (typePaymentMethod == ePaymentWithVNPayATM) {
            [WebServiceUtils getInstance].delegate = self;
            [[WebServiceUtils getInstance] VNPayGetFunWithAmount:[NSNumber numberWithLong: money] type:[NSNumber numberWithInt: 1]];
            
        }else{
            [WebServiceUtils getInstance].delegate = self;
            [[WebServiceUtils getInstance] VNPayGetFunWithAmount:[NSNumber numberWithLong: money] type:[NSNumber numberWithInt: 2]];
            
        }
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

- (void)paymentResultWithInfo:(NSDictionary *)info
{
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
- (void)prepareInfoForMoMoPayment
{
    NSString *appBundleID = [[NSBundle mainBundle] bundleIdentifier];
    [[MoMoPayment shareInstant] initializingAppBundleId:appBundleID
                                             merchantId:MoMo_Merchant_ID
                                           merchantName:@"Nhân Hòa"
                                      merchantNameTitle:@"Nhà cung cấp" billTitle:@"Người dùng"];
    
    NSString *content = @"Nạp tiền vào ví cho ứng dụng Nhân Hòa";
    NSMutableDictionary *paymentinfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                        [NSNumber numberWithLong: money], @"amount",
                                        [NSNumber numberWithInt:0], @"fee",
                                        content, @"description",
                                        @"{\"key1\":\"value1\",\"key2\":\"value2\"}",@"extra",
                                        @"vi",@"language",
                                        [AccountModel getCusEmail], @"username",
                                        nil];
    
    [paymentinfo setValue:MoMo_IOS_SCHEME_ID forKey:@"appScheme"];
    [[MoMoPayment shareInstant] initPaymentInformation:paymentinfo momoAppScheme:@"com.momo.appv2.ios" environment:MOMO_SDK_PRODUCTION];
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
    NSString *sourceText = [NSString stringWithFormat:@"%@", notif.object];
    
    NSURL *url = [NSURL URLWithString:sourceText];
    if (url) {
        sourceText = url.query;
    }
    
    NSArray *parameters = [sourceText componentsSeparatedByString:@"&"];
    
    NSDictionary *response = [self getDictionaryFromComponents:parameters];
    NSString *status = [NSString stringWithFormat:@"%@",[response objectForKey:@"status"]];
    NSString *message = [NSString stringWithFormat:@"%@",[response objectForKey:@"message"]];
    
    if ([status isEqualToString:@"0"])
    {
        if (money <= 0) {
            [self.view makeToast:@"Số tiền không hợp lệ. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
            return;
        }
        momoPhoneNumber = [response objectForKey:@"phonenumber"];
        appData = SFM(@"%@", [response objectForKey:@"data"]);
        
        if (![AppUtils isNullOrEmpty: appData])
        {
            [ProgressHUD backgroundColor: ProgressHUD_BG];
            [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Processing..."] Interaction:FALSE];
            
            [WebServiceUtils getInstance].delegate = self;
            [[WebServiceUtils getInstance] MoMoPaymentWithAmount:[NSNumber numberWithLong:money] appData:appData customerNumber:momoPhoneNumber];
        }else{
            [self.view makeToast:@"Không thể lấy appData từ MoMo. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        }
        
        /*  SEND THESE PARRAM TO SERVER:  phoneNumber, data, env
         CALL API MOMO PAYMENT
         */
        //  hash: RSA (jsonString + public key);
//        NSString *partnerRefId = SFM(@"Merchant_%@", [AppUtils randomStringWithLength: 10]);
//        NSString *jsonString = [NSString stringWithFormat:@"{\"partnerCode\":\"%@\",\"partnerRefId\":\"%@\",\"amount\":%ld}", MoMo_Partner_Code, partnerRefId, money];
//        NSString *hash = [RSA encryptString:jsonString publicKey:MoMo_PublicKey];
//
//        NSString *requestBody = [NSString stringWithFormat:@"{\"partnerCode\":\"%@\",\"partnerRefId\":\"%@\",\"customerNumber\":\"%@\",\"appData\":\"%@\",\"hash\":\"%@\",\"version\":%f,\"payType\":%d}", MoMo_Partner_Code, partnerRefId, [response objectForKey:@"phonenumber"], appData, hash, 2.0, 3];
//
//        NSData *postData = [requestBody dataUsingEncoding:NSUTF8StringEncoding];;
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:@"https://test-payment.momo.vn/pay/app"]];
//        //  [request setURL:[NSURL URLWithString:MOMO_PAYMENT_URL]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//        [request setHTTPBody:postData];
//        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//
//        NSURLResponse *response;
//        NSError *err;
//        NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//        if (!err) {
//            NSError *errJson;
//            id responseObject = [NSJSONSerialization JSONObjectWithData:GETReply options:0 error:&errJson];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"NoficationCenterCreateOrderReceived" object:responseObject];
//
//            id status = [responseObject objectForKey:@"status"];
//            if (([status isKindOfClass:[NSNumber class]] && [status intValue] == 0) || ([status isKindOfClass:[NSString class]] && status != nil && [status isEqualToString:@"0"]))
//            {
//                //  TREO TIỀN THÀNH CÔNG, THỰC HIỆN GỬI IPN
//                NSString *momoTransId = [responseObject objectForKey:@"transid"];
//                NSString *message = [responseObject objectForKey:@"message"];
//                if (momoTransId != nil) {
//                    NSString *requestId = SFM(@"IDReq_%@", [AppUtils randomStringWithLength: 6]);
//                    NSString *beforeHMAC = SFM(@"partnerCode=%@&partnerRefId=%@&requestType=%@&requestId=%@&momoTransId=%@", MoMo_Partner_Code, partnerRefId, MoMo_Request_Type_Confirm, requestId, momoTransId);
//                    NSString *signature = [AppUtils getHashHmacSHA256OfString:beforeHMAC key:MoMo_SecretKey];
//
//                    NSString *requestBody = [NSString stringWithFormat:@"{\"partnerCode\":\"%@\",\"partnerRefId\":\"%@\",\"requestType\":\"%@\",\"requestId\":\"%@\",\"momoTransId\":\"%@\",\"signature\":\"%@\"}", MoMo_Partner_Code, partnerRefId, MoMo_Request_Type_Confirm, requestId, momoTransId, signature];
//
//                    NSData *postData = [requestBody dataUsingEncoding:NSUTF8StringEncoding];;
//                    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//                    [request setURL:[NSURL URLWithString:@"https://test-payment.momo.vn/pay/confirm"]];
//                    //  [request setURL:[NSURL URLWithString:MOMO_PAYMENT_URL]];
//                    [request setHTTPMethod:@"POST"];
//                    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//                    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//                    [request setHTTPBody:postData];
//                    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//
//                    NSURLResponse *response;
//                    NSError *err;
//                    NSData *GETReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//                    if (!err) {
//                        NSError *errJson;
//                        id responseObject = [NSJSONSerialization JSONObjectWithData:GETReply options:0 error:&errJson];
//                        id status = [responseObject objectForKey:@"status"];
//                        if (([status isKindOfClass:[NSNumber class]] && [status intValue] == 0) || ([status isKindOfClass:[NSString class]] && status != nil && [status isEqualToString:@"0"]))
//                        {
//                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:SFM(@"%@", responseObject) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//                            [alertView show];
//                            /*
//                            {
//                                data =     {
//                                    amount = 10000;
//                                    momoTransId = 2307207562;
//                                    partnerCode = MOMOIQA420180417;
//                                    partnerRefId = "Merchant_BUeywencAN";
//                                };
//                                message = "Th\U00e0nh c\U00f4ng";
//                                signature = 46b0601836e199d94b6ddc0e95a4359520e4ca63976726870856f486c2a46b8c;
//                                status = 0;
//                            }   */
//                        }
//
//                    }else {
//                        NSLog(@"Error: %@", err.localizedDescription);
//                    }
//                }
//
//            }else{
//                NSString *message = [responseObject objectForKey:@"message"];
//                [self.view makeToast:message duration:3.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
//            }
//        }else {
//            [self.view makeToast:err.localizedDescription duration:3.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
//        }
    }else
    {
        if ([status isEqualToString:@"1"]) {
            [self.view makeToast:@"::MoMoPay Log: REGISTER_PHONE_NUMBER_REQUIRE." duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
            
        }else if ([status isEqualToString:@"2"]) {
            [self.view makeToast:@"::MoMoPay Log: LOGIN_REQUIRE." duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
            
        }else if ([status isEqualToString:@"3"]) {
            [self.view makeToast:@"::MoMoPay Log: NO_WALLET. You need to cashin to MoMo Wallet." duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
            
        }else if ([status isEqualToString:@"5"]) {
            [self.view makeToast:@"Hết thời gian thực hiện giao dịch!" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
            
        }else if ([status isEqualToString:@"6"]) {
            [self.view makeToast:@"Bạn đã huỷ giao dịch!" duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        }else {
            [self.view makeToast:message duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        }
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
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

#pragma mark - WebserviceDelegate
-(void)failedToGetFunWithVNPay:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)getFunVNPaySuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if (vnPayView == nil) {
        [self addVNPayPaymentToMainView];
    }
    vnPayView.delegate = self;
    
    [self performSelector:@selector(showVNPayPaymentViewWithData:) withObject:data afterDelay:0.3];
}

- (void)addVNPayPaymentToMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"VNPayPaymentView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[VNPayPaymentView class]]) {
            vnPayView = (VNPayPaymentView *) currentObject;
            break;
        }
    }
    UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
    [curWindow addSubview: vnPayView];
    [vnPayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curWindow).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(curWindow);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    [vnPayView setupUIForViewWithHeightNav: self.navigationController.navigationBar.frame.size.height];
}

- (void)showVNPayPaymentViewWithData: (NSDictionary *)object
{
    UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
    [vnPayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curWindow);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [vnPayView tryToLoadContentWithData: object];
    }];
}

#pragma mark - VNPayPaymentViewDelegate
-(void)closeVNPayPaymentView {
    UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
    [vnPayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curWindow).offset(SCREEN_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self dismissView];
    }];
}

-(void)VNPayPaymentSuccessful {
    UIWindow *curWindow = [[UIApplication sharedApplication] keyWindow];
    [vnPayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curWindow).offset(SCREEN_HEIGHT);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [self dismissView];
    }];
}

#pragma mark - For MoMo

-(void)failedToTopupMoneyWithMoMo:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)topupMoneyWithMoMoSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self.view makeToast:@"Giao dịch thành công" duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

@end
