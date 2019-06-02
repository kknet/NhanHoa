//
//  UpdateDNSViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateDNSViewController.h"
#import "AccountModel.h"
#import "WebServices.h"

@interface UpdateDNSViewController ()<WebServicesDelegate>{
    WebServices *webService;
    NSDictionary *dictDNS;
}

@end

@implementation UpdateDNSViewController
@synthesize lbDNS1, tfDNS1, lbDNS2, tfDNS2, lbDNS3, tfDNS3, lbDNS4, tfDNS4, btnCancel, btnSave;
@synthesize domain;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đổi DNS";
    
    [self setupUIForView];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"UpdateDNSViewController"];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    dictDNS = [[NSDictionary alloc] init];
    
    tfDNS1.text = tfDNS2.text = tfDNS3.text = tfDNS4.text = @"";
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang kiểm tra..." Interaction:NO];
    
    [self getDNSValueForDomain: domain];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    webService = nil;
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    [self.view endEditing: TRUE];
    
    [self showDNSContent];
}

- (IBAction)btnSavePress:(UIButton *)sender
{
    [self.view endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfDNS1.text] && [AppUtils isNullOrEmpty: tfDNS2.text] && [AppUtils isNullOrEmpty: tfDNS3.text] && [AppUtils isNullOrEmpty: tfDNS4.text])
    {
        [self.view makeToast:@"Vui lòng nhập giá trị để cập nhật!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang cập nhật..." Interaction:NO];
    
    [self changeDNSValueForDomain];
}

- (void)getDNSValueForDomain: (NSString *)domainValue
{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:get_dns_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domainValue forKey:@"domain"];
    
    [webService callWebServiceWithLink:get_dns_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)changeDNSValueForDomain {
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:change_dns_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    [jsonDict setObject:domain forKey:@"domain"];
    
    if (![AppUtils isNullOrEmpty: tfDNS1.text]) {
        [jsonDict setObject:tfDNS1.text forKey:@"ns1"];
    }
    
    if (![AppUtils isNullOrEmpty: tfDNS2.text]) {
        [jsonDict setObject:tfDNS2.text forKey:@"ns2"];
    }
    
    if (![AppUtils isNullOrEmpty: tfDNS3.text]) {
        [jsonDict setObject:tfDNS3.text forKey:@"ns3"];
    }
    
    if (![AppUtils isNullOrEmpty: tfDNS4.text]) {
        [jsonDict setObject:tfDNS4.text forKey:@"ns4"];
    }
    [webService callWebServiceWithLink:change_dns_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float smallSize = (SCREEN_WIDTH - 3*padding)/4;
    
    //  DNS1
    [lbDNS1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(padding);
        make.width.mas_equalTo(smallSize);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS1 borderColor:BORDER_COLOR];
    [tfDNS1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDNS1);
        make.left.equalTo(self.lbDNS1.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    //  DNS2
    [lbDNS2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDNS1);
        make.top.equalTo(self.lbDNS1.mas_bottom).offset(padding);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS2 borderColor:BORDER_COLOR];
    [tfDNS2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDNS2);
        make.left.right.equalTo(self.tfDNS1);
    }];
    
    //  DNS3
    [lbDNS3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDNS2);
        make.top.equalTo(self.lbDNS2.mas_bottom).offset(padding);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS3 borderColor:BORDER_COLOR];
    [tfDNS3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDNS3);
        make.left.right.equalTo(self.tfDNS2);
    }];
    
    //  DNS4
    [lbDNS4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDNS3);
        make.top.equalTo(self.lbDNS3.mas_bottom).offset(padding);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS4 borderColor:BORDER_COLOR];
    [tfDNS4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbDNS4);
        make.left.right.equalTo(self.tfDNS3);
    }];
    
    btnCancel.backgroundColor = OLD_PRICE_COLOR;
    [btnCancel setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(45.0);
    }];
    
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnCancel.mas_right).offset(padding);
        make.top.bottom.equalTo(self.btnCancel);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius = 45.0/2;
    btnSave.titleLabel.font = btnCancel.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbDNS1.font = lbDNS2.font = lbDNS3.font = lbDNS4.font = [AppDelegate sharedInstance].fontMedium;
    tfDNS1.font = tfDNS2.font = tfDNS3.font = tfDNS4.font = [AppDelegate sharedInstance].fontRegular;
    
    lbDNS1.textColor = lbDNS2.textColor = lbDNS3.textColor = lbDNS4.textColor = tfDNS1.textColor = tfDNS2.textColor = tfDNS3.textColor = tfDNS4.textColor = TITLE_COLOR;
}

- (void)prepareDataToDisplay: (NSDictionary *)data {
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        dictDNS = [[NSMutableDictionary alloc] initWithDictionary: data];
        [self showDNSContent];
    }else{
        [self.view makeToast:@"Không lấy được giá trị DNS của tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (void)showDNSContent {
    NSString *ns1 = [dictDNS objectForKey:@"ns1"];
    tfDNS1.text = (![AppUtils isNullOrEmpty: ns1])? ns1 : @"";
    
    NSString *ns2 = [dictDNS objectForKey:@"ns2"];
    tfDNS2.text = (![AppUtils isNullOrEmpty: ns2])? ns2 : @"";
    
    NSString *ns3 = [dictDNS objectForKey:@"ns3"];
    tfDNS3.text = (![AppUtils isNullOrEmpty: ns3])? ns3 : @"";
    
    NSString *ns4 = [dictDNS objectForKey:@"ns4"];
    tfDNS4.text = (![AppUtils isNullOrEmpty: ns4])? ns4 : @"";
}

- (void)dismissView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    if ([link isEqualToString: get_dns_func]) {
        [self.view makeToast:@"Không lấy được giá trị DNS của tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([link isEqualToString: change_dns_func]) {
        if ([error isKindOfClass:[NSDictionary class]]) {
            NSString *errorCode = [(NSDictionary *)error objectForKey:@"errorCode"];
            if (errorCode != nil && [errorCode isEqualToString:@"008"]) {
                [self.view makeToast:@"Tên miền không được tìm thấy. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                return;
            }
        }
        [self.view makeToast:@"Cập nhật thất bại. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    if ([link isEqualToString: get_dns_func]) {
        [self prepareDataToDisplay: data];
        
    }else if ([link isEqualToString: change_dns_func]) {
        [self.view makeToast:@"Cập nhật DNS thành công" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

@end
