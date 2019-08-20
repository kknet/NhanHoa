//
//  RegisterAccountStep2ViewController.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterAccountStep2ViewController.h"
#import "PersonalProfileView.h"
#import "BusinessProfileView.h"
#import "AccountModel.h"
#import "WebServices.h"
#import "OTPConfirmView.h"
#import <CommonCrypto/CommonDigest.h>

@interface RegisterAccountStep2ViewController ()<UIScrollViewDelegate, PersonalProfileViewDelegate, BusinessProfileViewDelegate, WebServicesDelegate, OTPConfirmViewDelegate>
{
    PersonalProfileView *personalProfile;
    BusinessProfileView *businessProfile;
    OTPConfirmView *otpView;
    WebServices *webService;
    float hMenu;
}
@end

@implementation NSString (MD5)
- (NSString *)MD5String {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (int)strlen(cstr), result);
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end

@implementation RegisterAccountStep2ViewController
@synthesize viewMenu, viewAccInfo, lbAccount, lbNumOne, lbSepa, viewProfileInfo, lbProfile, lbNumTwo, scvContent;
@synthesize email, password;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thông tin hồ sơ";
    [self setupUIForView];
    
    [self addPersonalProfileView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"RegisterAccountStep2ViewController"];
    [self addOTPViewIfNeed];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void) orientationChanged
{
    float screenWidth = [DeviceUtils getWidthOfScreen];
    float screenHeight = [DeviceUtils getHeightOfScreen];
    
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth);
    }];
    
    [personalProfile mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth);
    }];
}

- (void)addPersonalProfileView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PersonalProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PersonalProfileView class]]) {
            personalProfile = (PersonalProfileView *) currentObject;
            break;
        }
    }
    personalProfile.delegate = self;
    [scvContent addSubview: personalProfile];
    
    float mTop = 10.0;
    float hLabel = 30.0;
    float padding = 15.0;
    float hTitle = 40.0;
    float hBTN = 45.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        hLabel = 40.0;
        hTitle = 60.0;
        padding = 30.0;
        hBTN = 55.0;
    }
    
    float hView = hTitle + 30 + 5.0 + hLabel + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + hBTN + 2*padding;
    personalProfile.contentSize = hView;
    
    [personalProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [personalProfile setupUIForView];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hView);
}

- (void)addBusinessProfileView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"BusinessProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[BusinessProfileView class]]) {
            businessProfile = (BusinessProfileView *) currentObject;
            break;
        }
    }
    businessProfile.delegate = self;
    [self.scvContent addSubview: businessProfile];
    
    float mTop = 10.0;
    float hLabel = 30.0;
    float padding = 15.0;
    float hTitle = 40.0;
    float hBTN = 45.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hLabel = 40.0;
        hTitle = 60.0;
        hBTN = 55.0;
        padding = 30.0;
    }
    
    float hView = hTitle + 30 + 5.0 + hLabel + padding + hLabel + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + hLabel + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + hBTN + 2*padding;
    businessProfile.contentSize = hView;
    
    [businessProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [businessProfile setupUIForView];
    self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hView);
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float paddingX = 3.0;
    float sizeMenu = 20.0;
    hMenu = 60.0;
    self.view.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    
    lbAccount.font = lbNumOne.font = lbNumTwo.font = lbProfile.font = [AppDelegate sharedInstance].fontDesc;
    if (!IS_IPHONE && !IS_IPOD) {
        sizeMenu = 30.0;
        paddingX = 10.0;
        lbAccount.font = lbProfile.font = lbNumOne.font = lbNumTwo.font = [AppDelegate sharedInstance].fontRegular;
    }
    
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    lbSepa.textColor = [UIColor colorWithRed:(130/255.0) green:(146/255.0) blue:(169/255.0) alpha:1.0];
    if ([DeviceUtils isScreen320]) {
        lbSepa.text = @"--";
    }else{
        lbSepa.text = @"-----";
    }
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewMenu.mas_centerX);
        make.top.bottom.equalTo(viewMenu);
    }];
    
    [viewAccInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(viewMenu);
        make.right.equalTo(lbSepa.mas_left);
    }];
    
    [lbAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewAccInfo);
        make.right.equalTo(viewAccInfo).offset(-2.0);
    }];
    
    [lbNumOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbAccount.mas_left).offset(-paddingX);
        make.centerY.equalTo(lbAccount.mas_centerY);
        make.width.height.mas_equalTo(sizeMenu);
    }];
    
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(viewMenu);
        make.left.equalTo(lbSepa.mas_right);
    }];
    
    [lbNumTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewProfileInfo).offset(2.0);
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.width.height.mas_equalTo(sizeMenu);
    }];
    
    [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbNumTwo.mas_right).offset(paddingX);
        make.top.bottom.equalTo(self.viewProfileInfo);
    }];
    
    lbNumOne.clipsToBounds = lbNumTwo.clipsToBounds = TRUE;
    lbNumOne.layer.cornerRadius = lbNumTwo.layer.cornerRadius = sizeMenu/2;
    
    scvContent.delegate = self;
    scvContent.backgroundColor = UIColor.whiteColor;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom).offset(10.0);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

//implementation
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //  [self.view endEditing: TRUE];
}

#pragma mark - PersonalViewDelegate
- (void)readyToRegisterPersonalAccount:(NSDictionary *)info
{
    if ([AppUtils isNullOrEmpty: email] || [AppUtils isNullOrEmpty: password]) {
        [self.view makeToast:@"Thông tin không hợp lệ. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_processing Interaction:FALSE];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] initWithDictionary: info];
    [jsonDict setObject:register_account_mod forKey:@"mod"];
    [jsonDict setObject:email forKey:@"email"];
    [jsonDict setObject:[[password MD5String] lowercaseString] forKey:@"password"];
    [jsonDict setObject:[NSNumber numberWithInt:type_personal] forKey:@"own_type"];
    
    [webService callWebServiceWithLink:register_account_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict])];
}

- (void)readyToRegisterBusinessAccount:(NSDictionary *)info {
    if ([AppUtils isNullOrEmpty: email] || [AppUtils isNullOrEmpty: password]) {
        [self.view makeToast:@"Thông tin không hợp lệ. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_processing Interaction:FALSE];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] initWithDictionary: info];
    [jsonDict setObject:register_account_mod forKey:@"mod"];
    [jsonDict setObject:email forKey:@"email"];
    [jsonDict setObject:[[password MD5String] lowercaseString] forKey:@"password"];
    [jsonDict setObject:[NSNumber numberWithInt:type_business] forKey:@"own_type"];
    
    [webService callWebServiceWithLink:register_account_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict])];
}

- (void)afterRegisterAccountSuccess {
    [AppDelegate sharedInstance].registerAccSuccess = TRUE;
    [AppDelegate sharedInstance].registerAccount = email;
    [self.navigationController popToRootViewControllerAnimated: TRUE];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@, error = %@", __FUNCTION__, link, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@, data = %@", __FUNCTION__, link, @[data])];
    [ProgressHUD dismiss];
    
    if ([link isEqualToString:register_account_func]) {
        [self showConfirmOTPView];
        
    }else if ([link isEqualToString: check_otp_func]) {
        [self.view makeToast:@"Tài khoản của bạn đã được đăng ký thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        [self performSelector:@selector(afterRegisterAccountSuccess) withObject:nil afterDelay:2.0];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@, responeCode = %d", __FUNCTION__, link, responeCode)];
    [ProgressHUD dismiss];
}

#pragma mark - ProfileView Delegate
- (void)selectBusinessProfile {
    if (businessProfile == nil) {
        [self addBusinessProfileView];
    }else{
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, businessProfile.contentSize);
    }
    personalProfile.hidden = TRUE;
    businessProfile.hidden = FALSE;
}

- (void)selectPersonalProfile {
    if (personalProfile == nil) {
        [self addPersonalProfileView];
    }else{
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, personalProfile.contentSize);
    }
    personalProfile.hidden = FALSE;
    businessProfile.hidden = TRUE;
}

- (void)addOTPViewIfNeed {
    if (otpView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OTPConfirmView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OTPConfirmView class]]) {
                otpView = (OTPConfirmView *) currentObject;
                break;
            }
        }
        [self.view addSubview: otpView];
        otpView.backgroundColor = BORDER_COLOR;
    }
    [otpView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [otpView setupUIForView];
    otpView.delegate = self;
    otpView.hidden = TRUE;
}

- (void)showConfirmOTPView {
    otpView.hidden = FALSE;
    [self.navigationItem setHidesBackButton: TRUE];
}

-(void)onResendOTPPress {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (![AppUtils isNullOrEmpty: email] && ![AppUtils isNullOrEmpty: password]) {
        [[WebServiceUtils getInstance] resendOTPForUsername:email password:[AppUtils getMD5StringOfString: password]];
    }
}

-(void)confirmOTPWithCode:(NSString *)code
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] code = %@", __FUNCTION__, code)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:your_acc_is_being_actived Interaction:NO];
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:check_otp_mod forKey:@"mod"];
    [jsonDict setObject:email forKey:@"username"];
    [jsonDict setObject:[AppUtils getMD5StringOfString:password] forKey:@"password"];
    [jsonDict setObject:code forKey:@"code"];
    
    [webService callWebServiceWithLink:check_otp_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:SFM(@"jSonDict = %@", @[jsonDict])];
}

@end
