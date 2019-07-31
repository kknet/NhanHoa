//
//  AppDelegate.h
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Toast.h"
#import "Reachability.h"
#import "CityObject.h"
#import "CartViewController.h"
#import "ShoppingCartView.h"
#import "LaunchViewController.h"
#import "AudioSessionUtils.h"
#import "WebServiceUtils.h"
#import "ProviderDelegate.h"
#import <PushKit/PushKit.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

#import "CallViewController.h"

typedef enum TypeHomeMenu{
    eRegisterDomain,
    ePricingDomain,
    eSearchDomain,
    eRecharge,
    eRewardsPoints,
    eManagerDomain,
    eWithdrawal,
    eProfile,
    eSupport,
    eOrdersList,
    eRegisterHosting,
    eRegisterSSL,
    eRegisterEmail,
    eRegisterVPS,
    eRegisterCloudServer,
}TypeHomeMenu;

typedef enum PaymentMethod{
    ePaymentWithATM,
    ePaymentWithVisaMaster,
}PaymentMethod;

@interface AppDelegate : UIResponder <UIApplicationDelegate, WebServiceUtilsDelegate, PKPushRegistryDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CSToastStyle *errorStyle;
@property (strong, nonatomic) CSToastStyle *warningStyle;
@property (strong, nonatomic) CSToastStyle *successStyle;

+(AppDelegate *) sharedInstance;
@property (nonatomic, assign) float hStatusBar;
@property (nonatomic, assign) float hNav;

@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, assign) BOOL internetActive;
@property (strong, nonatomic) Reachability *internetReachable;
@property (strong, nonatomic) NSMutableArray *listCity;
@property (nonatomic, strong) NSArray *listNumber;

- (void)enableSizeForBarButtonItem: (BOOL)enable;

@property (nonatomic, strong) UIFont *fontRegular;
@property (nonatomic, strong) UIFont *fontBold;
@property (nonatomic, strong) UIFont *fontMedium;
@property (nonatomic, strong) UIFont *fontThin;
@property (nonatomic, strong) UIFont *fontItalic;
@property (nonatomic, strong) UIFont *fontDesc;
@property (nonatomic, strong) UIFont *fontMediumDesc;
@property (nonatomic, strong) UIFont *fontNormal;
@property (nonatomic, strong) UIFont *fontBTN;
@property (nonatomic, assign) float hTextfield;
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) float registerAccSuccess;
@property (nonatomic, strong) NSString *registerAccount;

@property (nonatomic, assign) BOOL needReloadListProfile;

@property (nonatomic, strong) NSMutableDictionary *profileEdit;
@property (nonatomic, strong) UIImage *editCMND_a;
@property (nonatomic, strong) UIImage *editCMND_b;
@property (nonatomic, strong) UIImage *editBanKhai;
@property (nonatomic, strong) NSDictionary *domainsPrice;
@property (nonatomic, strong) UIImage *cropAvatar;
@property (nonatomic, strong) NSData *dataCrop;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *hashKey;

- (NSString *)findCityObjectWithCityCode: (NSString *)code;
@property(strong, nonatomic) UIWindow *cartWindow;

@property(strong, nonatomic) CartViewController *cartViewController;
@property(strong, nonatomic) UINavigationController *cartNavViewController;

@property(strong, nonatomic) NSMutableArray *listBank;
@property(strong, nonatomic) NSMutableArray *listAllDomains;
@property(strong, nonatomic) NSMutableArray *listExpireDomains;

- (void)updateShoppingCartCount;
- (void)showCartScreenContent;
- (void)hideCartView;

@property (nonatomic, strong) ShoppingCartView *cartView;

@property (nonatomic, strong) NSMutableDictionary *errorMsgDict;
@property (nonatomic, strong) NSMutableArray *listPricingVN;
@property (nonatomic, strong) NSMutableArray *listPricingQT;

@property(strong, nonatomic) LaunchViewController *launchVC;

@property(strong, nonatomic) AudioSessionUtils *notiAudio;

@property (nonatomic, strong) NSTimer *getInfoTimer;
@property (nonatomic, assign) int countLogin;
- (void)startTimerToReloadInfoAfterTopupSuccessful;

@property (nonatomic, assign) BOOL supportCall;
@property (nonatomic, assign) BOOL newHomeLayout;

- (void)removeAccount;
- (void)makeCallTo: (NSString *)strCall;
- (void)hangupAllCall;
- (void)answerCallWithCallID: (int)call_id;
- (int)getDurationForCurrentCall;
- (BOOL)checkMicrophoneWasMuted;
- (BOOL)checkCurrentCallWasHold;
- (BOOL)isCallWasConnected;
- (NSArray *)getContactNameOfRemoteForCall;
- (BOOL)muteMicrophone: (BOOL)mute;
- (void)holdCurrentCall: (BOOL)hold;
- (BOOL)sendDtmfWithValue: (NSString *)value;
- (void)playBeepSound;

@property (nonatomic, strong) ProviderDelegate *del;
@property (nonatomic, strong) PKPushRegistry* voipRegistry;
@property (nonatomic, strong) NSString *callToken;
@property (nonatomic, assign) BOOL callTokenReady;
@property (nonatomic, strong) NSDictionary *accCallInfo;
@property (nonatomic, assign) int current_call_id;
@property (nonatomic, assign) int pjsipConfAudioId;

- (void)registerSIPAccountWithInfo: (NSDictionary *)info;

//  for ringback tone
@property (nonatomic, strong) AVAudioPlayer *beepPlayer;
@property (nonatomic, strong) AVAudioPlayer *ringbackPlayer;
- (void)playRingbackTone;
- (void)stopRingbackTone;

@property (nonatomic, strong) CallViewController *callViewController;
@property (nonatomic, strong) NSString *remoteName;
- (void)showCallViewWithDirection: (CallDirection)direction remote: (NSString *)remote;
- (void)hideCallView;

- (void)tryToLogin151;

@end

