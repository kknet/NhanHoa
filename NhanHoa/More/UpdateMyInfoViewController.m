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

@interface UpdateMyInfoViewController ()<UpdatePersonalProfileDelegate, UpdateBusinessProfileDelegate, WebServicesDelegate, UIScrollViewDelegate> {
    WebServices *webService;
    int tryLoginCount;
}
@end

@implementation UpdateMyInfoViewController
@synthesize editPersonalView, editBusinessView, scvContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_update_my_info;
    
    scvContent.delegate = self;
    scvContent.showsVerticalScrollIndicator = FALSE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
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
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
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
    [editPersonalView setupUIForView];
    
    [editPersonalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(editPersonalView.hContent);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, editPersonalView.hContent);
}

-(void)savePersonalMyAccountInformation:(NSDictionary *)info {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_updating Interaction:NO];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] initWithDictionary: info];
    [jsonDict setObject:edit_profile_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:edit_profile_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]]];
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
    editBusinessView.delegate = self;
    [editBusinessView setupUIForView];
    
    [editBusinessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(editBusinessView.hContent);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, editBusinessView.hContent);
}

- (void)saveBusinessMyAccountInformation:(NSDictionary *)info {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_updating Interaction:NO];
    
    if (webService == nil) {
        webService = [[WebServices alloc] init];
        webService.delegate = self;
    }
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] initWithDictionary: info];
    [jsonDict setObject:edit_profile_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:edit_profile_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jsonDict = %@", __FUNCTION__, @[jsonDict]]];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    
    float widthScreen = [DeviceUtils getWidthOfScreen];
    if (editPersonalView != nil) {
        [editPersonalView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(widthScreen);
        }];
        scvContent.contentSize = CGSizeMake(widthScreen, editPersonalView.hContent);
    }
    
    if (editBusinessView != nil) {
        [editBusinessView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(widthScreen);
        }];
        scvContent.contentSize = CGSizeMake(widthScreen, editBusinessView.hContent);
    }
}


- (void)tryLoginToUpdateInformation {
    
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
    [jsonDict setObject:login_mod forKey:@"mod"];
    [jsonDict setObject:USERNAME forKey:@"username"];
    [jsonDict setObject:PASSWORD forKey:@"password"];
    
    [webService callWebServiceWithLink:login_func withParams:jsonDict];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] tryLoginCount = %d , jSonDict = %@", __FUNCTION__, tryLoginCount, @[jsonDict]]];
}

- (void)dismissView {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s]", __FUNCTION__]];
    
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - Webservice delegate

- (void)failedToCallWebService:(NSString *)link andError:(NSString *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Error: %@", __FUNCTION__, link, error]];
    
    [ProgressHUD dismiss];
    if ([link isEqualToString:edit_profile_func]) {
        NSString *content = [AppUtils getErrorContentFromData: error];
        [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([link isEqualToString: login_func]) {
        if (tryLoginCount > 3) {
            NSString *content = [AppUtils getErrorContentFromData: error];
            [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            
            tryLoginCount = 0;
        }else{
            tryLoginCount++;
            [self tryLoginToUpdateInformation];
        }
    }
}

- (void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n Response data: %@", __FUNCTION__, link, @[data]]];
    
    if ([link isEqualToString:edit_profile_func]) {
        //  If your info has been updated success, login again to refresh data was saved before
        tryLoginCount = 1;
        [self tryLoginToUpdateInformation];
        
    }else if ([link isEqualToString: login_func]) {
        [ProgressHUD dismiss];
        
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [AppDelegate sharedInstance].userInfo = [[NSDictionary alloc] initWithDictionary: data];
        }
        [self.view makeToast:your_info_has_been_updated duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
    }
}

- (void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> function = %@ & responeCode = %d", __FUNCTION__, link, responeCode]];
}

@end
