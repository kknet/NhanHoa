//
//  UpdateDNSViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateDNSViewController.h"
#import "AccountModel.h"

@interface UpdateDNSViewController ()<WebServiceUtilsDelegate>{
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
    
    
    dictDNS = [[NSDictionary alloc] init];
    
    tfDNS1.text = tfDNS2.text = tfDNS3.text = tfDNS4.text = @"";
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_checking Interaction:FALSE];
    
    [self getDNSValueForDomain: domain];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    [self.view endEditing: TRUE];
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:OLD_PRICE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(onCancelButtonPress) withObject:nil afterDelay:0.05];
}

- (void)onCancelButtonPress {
    btnCancel.backgroundColor = OLD_PRICE_COLOR;
    [btnCancel setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [self showDNSContent];
}

- (IBAction)btnSavePress:(UIButton *)sender
{
    [self.view endEditing: TRUE];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(onSaveButtonPress) withObject:nil afterDelay:0.05];
}

- (void)onSaveButtonPress {
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfDNS1.text] && [AppUtils isNullOrEmpty: tfDNS2.text] && [AppUtils isNullOrEmpty: tfDNS3.text] && [AppUtils isNullOrEmpty: tfDNS4.text]){
        [self.view makeToast:@"Vui lòng nhập giá trị để cập nhật!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_updating Interaction:NO];
    
    [self changeDNSValueForDomain];
}

- (void)getDNSValueForDomain: (NSString *)domainName
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] domainName = %@", __FUNCTION__, domainName)];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getDNSValueForDomain: domainName];
}

- (void)changeDNSValueForDomain {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] changeDNSForDomain:domain dns1:tfDNS1.text dns2:tfDNS2.text dns3:tfDNS3.text dns4:tfDNS4.text];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hBTN = 45.0;
    float mTop = 15.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hBTN = 55.0;
    }
    
    float smallSize = (SCREEN_WIDTH - 3*padding)/4;
    
    //  DNS1
    [lbDNS1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(padding);
        make.width.mas_equalTo(smallSize);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS1 borderColor:BORDER_COLOR];
    [tfDNS1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDNS1);
        make.left.equalTo(lbDNS1.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    //  DNS2
    [lbDNS2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDNS1);
        make.top.equalTo(lbDNS1.mas_bottom).offset(mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS2 borderColor:BORDER_COLOR];
    [tfDNS2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDNS2);
        make.left.right.equalTo(tfDNS1);
    }];
    
    //  DNS3
    [lbDNS3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDNS2);
        make.top.equalTo(lbDNS2.mas_bottom).offset(mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS3 borderColor:BORDER_COLOR];
    [tfDNS3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDNS3);
        make.left.right.equalTo(tfDNS2);
    }];
    
    //  DNS4
    [lbDNS4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDNS3);
        make.top.equalTo(lbDNS3.mas_bottom).offset(mTop);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS4 borderColor:BORDER_COLOR];
    [tfDNS4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDNS4);
        make.left.right.equalTo(tfDNS3);
    }];
    
    btnCancel.backgroundColor = OLD_PRICE_COLOR;
    btnCancel.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    [btnCancel setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.backgroundColor = BLUE_COLOR;
    btnSave.layer.borderColor = BLUE_COLOR.CGColor;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnCancel.mas_right).offset(padding);
        make.top.bottom.equalTo(btnCancel);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius = hBTN/2;
    btnSave.titleLabel.font = btnCancel.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnCancel.layer.borderWidth = btnSave.layer.borderWidth = 1.0;
    
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
    if ([AppDelegate sharedInstance].needChangeDNS) {
        [AppDelegate sharedInstance].needChangeDNS = FALSE;
        NSArray *viewControllers = [self.navigationController viewControllers];
        if (viewControllers.count >= 3) {
            [self.navigationController popToViewController:viewControllers[viewControllers.count - 3] animated:YES];
        }else{
            [self.navigationController popViewControllerAnimated: TRUE];
        }
    }else{
        [self.navigationController popViewControllerAnimated: TRUE];
    }
}

#pragma mark - Webservice delegate

-(void)failedToGetDNSForDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"Không lấy được giá trị DNS của tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getDNSForDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    [self prepareDataToDisplay: data];
}

-(void)failedToChangeDNSForDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString *content = [AppUtils getErrorContentFromData: error];
        [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([error isKindOfClass:[NSString class]]) {
        [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)changeDNSForDomainSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    
    [self.view makeToast:@"Cập nhật DNS thành công" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

@end
