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
    UIFont *textFont;
}

@end

@implementation UpdateDNSViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, lbDNS1, tfDNS1, lbDNS2, tfDNS2, lbDNS3, tfDNS3, lbDNS4, tfDNS4, btnCancel, btnSave;
@synthesize domain;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    [self updateCartCountForView];
    
    dictDNS = [[NSDictionary alloc] init];
    
    lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Change Name Server"];
    tfDNS1.text = tfDNS2.text = tfDNS3.text = tfDNS4.text = @"";
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Checking..."] Interaction:FALSE];
    
    [self getDNSValueForDomain: domain];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
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

- (IBAction)btnCancelPress:(UIButton *)sender {
    [self.view endEditing: TRUE];
    
    [self showDNSContent];
}

- (IBAction)btnSavePress:(UIButton *)sender
{
    [self.view endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfDNS1.text] && [AppUtils isNullOrEmpty: tfDNS2.text] && [AppUtils isNullOrEmpty: tfDNS3.text] && [AppUtils isNullOrEmpty: tfDNS4.text]){
        [self.view makeToast:@"Vui lòng nhập giá trị để cập nhật!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating..."] Interaction:NO];
    
    [[WebServiceUtils getInstance] changeDNSForDomain:domain dns1:tfDNS1.text dns2:tfDNS2.text dns3:tfDNS3.text dns4:tfDNS4.text];
}

- (void)getDNSValueForDomain: (NSString *)domainName
{
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getDNSValueForDomain: domainName];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hBTN = 53.0;
    float mTop = 15.0;
    
    float smallSize = (SCREEN_WIDTH - 3*padding)/4;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hBTN = 53.0;
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
    lbCount.layer.cornerRadius = [AppDelegate sharedInstance].sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].sizeCartCount);
    }];
    
    //  DNS1
    [lbDNS1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(2*padding);
        make.left.equalTo(self.view).offset(padding);
        make.width.mas_equalTo(smallSize);
        make.height.mas_equalTo(hBTN);
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
        make.height.mas_equalTo(hBTN);
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
        make.height.mas_equalTo(hBTN);
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
        make.height.mas_equalTo(hBTN);
    }];
    
    [AppUtils setBorderForTextfield:tfDNS4 borderColor:BORDER_COLOR];
    [tfDNS4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDNS4);
        make.left.right.equalTo(tfDNS3);
    }];
    
    btnCancel.backgroundColor = OLD_PRICE_COLOR;
    [btnCancel setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.equalTo(self.view).offset(-padding-[AppDelegate sharedInstance].safeAreaBottomPadding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnCancel.mas_right).offset(padding);
        make.top.bottom.equalTo(btnCancel);
        make.right.equalTo(self.view).offset(-padding);
    }];
    
    btnSave.layer.cornerRadius = btnCancel.layer.cornerRadius = 8.0;
    btnSave.titleLabel.font = btnCancel.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2.0];
    
    lbDNS1.font = lbDNS2.font = lbDNS3.font = lbDNS4.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2.0];
    tfDNS1.font = tfDNS2.font = tfDNS3.font = tfDNS4.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2.0];
    
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
    [ProgressHUD dismiss];
    [self.view makeToast:@"Không lấy được giá trị DNS của tên miền!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getDNSForDomainSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self prepareDataToDisplay: data];
}

-(void)failedToChangeDNSForDomainWithError:(NSString *)error {
    [ProgressHUD dismiss];
    
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString *content = [AppUtils getErrorContentFromData: error];
        [self.view makeToast:content duration:1.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([error isKindOfClass:[NSString class]]) {
        [self.view makeToast:error duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)changeDNSForDomainSuccessful {
    [ProgressHUD dismiss];
    
    [self.view makeToast:@"Cập nhật DNS thành công" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

@end
