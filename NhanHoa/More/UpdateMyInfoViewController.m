//
//  UpdateMyInfoViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateMyInfoViewController.h"
#import "AccountModel.h"
#import "WebServices.h"

@interface UpdateMyInfoViewController ()<UpdatePersonalProfileDelegate, WebServicesDelegate, UIScrollViewDelegate> {
    WebServices *webService;
    int tryLoginCount;
}
@end

@implementation UpdateMyInfoViewController
@synthesize editPersonalView, editBusinessView, scvContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Cập nhật thông tin";
    
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
        //  make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"UpdateMyInfoViewController"];
    
    int type = [AccountModel getCusOwnType];
    if (type == type_personal) {
        [self addUpdatePersonalProfileView];
        [editPersonalView displayPersonalInformation];
    }else{
        [self addUpdateBusinessProfileView];
        [editBusinessView displayBusinessInformation];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if ([AccountModel getCusOwnType] == type_personal) {
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-[AppDelegate sharedInstance].hNav-[AppDelegate sharedInstance].hStatusBar);
    }else{
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, editBusinessView.hContent);
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)addUpdatePersonalProfileView {
    if (editPersonalView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdatePersonalProfile" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdatePersonalProfile class]]) {
                editPersonalView = (UpdatePersonalProfile *) currentObject;
                break;
            }
        }
        [scvContent addSubview: editPersonalView];
    }
    editPersonalView.delegate = self;
    [editPersonalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_HEIGHT-[AppDelegate sharedInstance].hNav-[AppDelegate sharedInstance].hStatusBar);
    }];
    [editPersonalView setupUIForView];
}

-(void)savePersonalMyAccountInformation:(NSDictionary *)info {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang cập nhật.." Interaction:NO];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] initWithDictionary: info];
    [jsonDict setObject:edit_profile_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:edit_profile_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)addUpdateBusinessProfileView {
    if (editBusinessView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdateBusinessProfile" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdateBusinessProfile class]]) {
                editBusinessView = (UpdateBusinessProfile *) currentObject;
                break;
            }
        }
        [scvContent addSubview: editBusinessView];
    }
    //  editBusinessView.delegate = self;
    float padding = 15.0;
    float mTop = 10.0;
    float hLabel = 30.0;
    
    float hContent = (padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (2*padding + hLabel) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + (mTop + hLabel + [AppDelegate sharedInstance].hTextfield) + 2*padding + 45.0 + 2*padding;
    
    [editBusinessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hContent);
    }];
    [editBusinessView setupUIForView];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)tryLoginToUpdateInformation {
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:login_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] tryLoginCount = %d , jSonDict = %@", __FUNCTION__, tryLoginCount, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (void)dismissView {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD dismiss];
    if ([link isEqualToString:edit_profile_func]) {
        [self.view makeToast:@"Đã có lỗi xảy ra trong quá trình cập nhật thông tin. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([link isEqualToString: login_func]) {
        if (tryLoginCount > 3) {
            [self.view makeToast:@"Không thể lấy lại được thông tin bạn vừa cập nhật." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
            tryLoginCount = 0;
        }else{
            tryLoginCount++;
            [self tryLoginToUpdateInformation];
        }
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString:edit_profile_func]) {
        //  If your info has been updated success, login again to refresh data was saved before
        tryLoginCount = 1;
        [self tryLoginToUpdateInformation];
        
    }else if ([link isEqualToString: login_func]) {
        [ProgressHUD dismiss];
        
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
        }
        [self.view makeToast:@"Thông tin đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

@end
