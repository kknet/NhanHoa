//
//  AppDelegate.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppDelegate.h"
#import "AppTabbarViewController.h"
#import "NewSignInViewController.h"
#import "CartModel.h"
#import <AVFoundation/AVAudioPlayer.h>
#import "JSONKit.h"

//  PJSIP COMMENT
/*
#include "pjsip_sources/pjlib/include/pjlib.h"
#include "pjsip_sources/pjsip/include/pjsua.h"
#include "pjsip_sources/pjsua/pjsua_app.h"
#include "pjsip_sources/pjsua/pjsua_app_config.h"
*/

#import "MoMoPayment.h"

#define THIS_FILE    "AppDelegate.m"
#define KEEP_ALIVE_INTERVAL 600

#define MAX_MEDIA_CNT 1 /* Media count, set to 1 for audio
* only or 2 for audio and video */
#define AF pj_AF_INET() /* Change to pj_AF_INET6() for IPv6.
71  * PJ_HAS_IPV6 must be enabled and
72  * your system must support IPv6. */

#if 0
#define SIP_PORT 5080 /* Listening SIP port */
#define RTP_PORT 5000 /* RTP port */
#else
#define SIP_PORT 5060 /* Listening SIP port */
#define RTP_PORT 4000 /* RTP port */
#endif

@import Firebase;

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize sizeCartCount;
@synthesize errorStyle, warningStyle, successStyle;
@synthesize hStatusBar, hNav, userInfo, internetReachable, internetActive, listCity, listNumber;
@synthesize fontBold, fontMedium, fontRegular, fontItalic, fontThin, fontDesc, fontNormal, fontMediumDesc, hTextfield, radius, fontBTN, fontItalicDesc;
@synthesize needReloadListProfile, profileEdit, editCMND_a, editCMND_b, editBanKhai, domainsPrice;
@synthesize dataCrop, token, hashKey;
@synthesize cartWindow, shoppingCartVC, shoppingCartNavVC, cartViewController, cartNavViewController, listBank, cartView, errorMsgDict, listPricingQT, listPricingVN, notiAudio, getInfoTimer, countLogin;
@synthesize supportCall, ringbackPlayer, beepPlayer;
@synthesize del, voipRegistry, callToken, callTokenReady, accCallInfo, current_call_id, pjsipConfAudioId;
@synthesize callViewController, remoteName, needChangeDNS;
@synthesize localization, safeAreaBottomPadding, btnSearchBar;

AppDelegate      *app;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  hide title of back bar title
    
    [FIRApp configure];
    [FIRMessaging messaging].delegate = self;
    
    //  setup for Fabric
    [Fabric with:@[[Crashlytics class]]];
    
    //  setup language
    localization = [[HMLocalization alloc] init];
    [localization setLanguage: key_vi];
    
    if ([UNUserNotificationCenter class] != nil) {
        // iOS 10 or later
        // For iOS 10 display notification (sent via APNS)
        [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
        
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions completionHandler:^(BOOL granted, NSError * _Nullable error) {
             // ...
         }];
    } else {
        // iOS 10 notifications aren't available; fall back to iOS 8-9 notifications.
        UIUserNotificationType allNotificationTypes = (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    [application registerForRemoteNotifications];
    
    [self setupFontForApp];
    sizeCartCount = 22.0;
    
    safeAreaBottomPadding = 0;
    if (@available(iOS 11.0, *)) {
        safeAreaBottomPadding = self.window.safeAreaInsets.bottom;
    }
    
    //  Register remote notifications
    if(SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){
        UNUserNotificationCenter *notifiCenter = [UNUserNotificationCenter currentNotificationCenter];
        notifiCenter.delegate = self;
        [notifiCenter requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error){
            if( !error ){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
            }
        }];
    }
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)])
    {
        UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        UIRemoteNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:types];
    }
    
    //  setup logs folder
    supportCall = TRUE;
    
    [self setupForWriteLogFileForApp];
    [AppUtils createDirectoryAndSubDirectory:@"avatars"];
    [self createErrorMessagesInfo];
    
    //  custom tabbar & navigation bar
    hStatusBar = application.statusBarFrame.size.height;
    [self enableSizeForBarButtonItem: FALSE];
    
    UINavigationBar.appearance.barTintColor = NAV_COLOR;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.translucent = NO;
    UINavigationBar.appearance.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontRegular, NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    
    
    listNumber = [[NSArray alloc] initWithObjects: @"+", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    
    //  setup message style
    warningStyle = [[CSToastStyle alloc] initWithDefaultStyle];
    warningStyle.backgroundColor = ORANGE_COLOR;
    warningStyle.messageColor = UIColor.whiteColor;
    warningStyle.messageFont = [UIFont fontWithName:RobotoRegular size:18.0];
    warningStyle.cornerRadius = 20.0;
    warningStyle.messageAlignment = NSTextAlignmentCenter;
    warningStyle.messageNumberOfLines = 5;
    warningStyle.shadowColor = UIColor.blackColor;
    warningStyle.shadowOpacity = 1.0;
    warningStyle.shadowOffset = CGSizeMake(-5, -5);
    
    errorStyle = [[CSToastStyle alloc] initWithDefaultStyle];
    errorStyle.backgroundColor = [UIColor colorWithRed:(211/255.0) green:(55/255.0) blue:(55/255.0) alpha:1.0];
    errorStyle.messageColor = UIColor.whiteColor;
    errorStyle.messageFont = [UIFont fontWithName:RobotoRegular size:18.0];
    errorStyle.cornerRadius = 20.0;
    errorStyle.messageAlignment = NSTextAlignmentCenter;
    errorStyle.messageNumberOfLines = 5;
    errorStyle.shadowColor = UIColor.blackColor;
    errorStyle.shadowOpacity = 1.0;
    errorStyle.shadowOffset = CGSizeMake(-5, -5);
    
    successStyle = [[CSToastStyle alloc] initWithDefaultStyle];
    successStyle.backgroundColor = BLUE_COLOR;
    successStyle.messageColor = UIColor.whiteColor;
    successStyle.messageFont = [UIFont fontWithName:RobotoRegular size:18.0];
    successStyle.cornerRadius = 20.0;
    successStyle.messageAlignment = NSTextAlignmentCenter;
    successStyle.messageNumberOfLines = 5;
    successStyle.shadowColor = UIColor.blackColor;
    successStyle.shadowOpacity = 1.0;
    successStyle.shadowOffset = CGSizeMake(-5, -5);
    
    
    [self createListCity];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"fondoTabBar"]];
    [UITabBar appearance].layer.borderWidth = 0.0f;
    [UITabBar appearance].clipsToBounds = true;
    
    //  status network
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:login_state];
    if (loginState == nil || [loginState isEqualToString:@"NO"]) {
        [self showStartLoginView];
        
    }else{
        NewSignInViewController *signInVC = [[NewSignInViewController alloc] initWithNibName:@"NewSignInViewController" bundle:nil];
        UINavigationController *signInNav = [[UINavigationController alloc] initWithRootViewController:signInVC];
        
        [self.window setRootViewController:signInNav];
        [self.window makeKeyAndVisible];
    }
    // Override point for customization after application launch.
    
    if (self.cartWindow == nil) {
        //  self.cartWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.cartWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.cartWindow.backgroundColor = UIColor.whiteColor;;
        self.cartWindow.windowLevel = UIWindowLevelNormal;
        self.cartWindow.tag = 2;
    }
    
    /*
    if (self.cartViewController == nil) {
        self.cartViewController = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
        self.cartNavViewController = [[UINavigationController alloc] initWithRootViewController:self.cartViewController];
        self.cartNavViewController.navigationBarHidden = YES;
    }
    cartWindow.rootViewController = cartNavViewController;
    */
    
    if (shoppingCartVC == nil) {
        shoppingCartVC = [[ShoppingCartViewController alloc] initWithNibName:@"ShoppingCartViewController" bundle:nil];
        shoppingCartNavVC = [[UINavigationController alloc] initWithRootViewController: shoppingCartVC];
        shoppingCartNavVC.navigationBarHidden = TRUE;
    }
    cartWindow.rootViewController = shoppingCartNavVC;
    
    cartWindow.alpha = 0;
    
    //  for callkit
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_x_Max) {
        self.del = [[ProviderDelegate alloc] init];
        [self.del config];
    }
    
    //  PJSIP COMMENT
    /*
    [self registerForNotifications:[UIApplication sharedApplication]];
    app = self;
    [self startPjsuaForApp];
    current_call_id = -1;
    */
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: 0];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    NSCharacterSet *removestring = [NSCharacterSet characterSetWithCharactersInString:@"<> "];
//    callToken = [[[NSString stringWithFormat:@"%@", deviceToken] componentsSeparatedByCharactersInSet: removestring] componentsJoinedByString: @""];
//
//    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"GETTED TOKEN FOR APP: %@", callToken]];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@">>>>>ERROR<<<<< CAN NOT GET TOKEN FOR APP: %@", error.localizedDescription]];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}


- (void) userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler
{
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionAlert);
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        if (notiAudio == nil) {
            notiAudio = [[AudioSessionUtils alloc] init];
        }
        [notiAudio playNotificationTone];
    }
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler
{
    
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [[MoMoPayment shareInstant] handleOpenUrl:url];
    return TRUE;
}


+(AppDelegate *)sharedInstance{
    return ((AppDelegate*) [[UIApplication sharedApplication] delegate]);
}

- (void)showStartLoginView {
    NewLaunchViewController *launchVC = [[NewLaunchViewController alloc] initWithNibName:@"NewLaunchViewController" bundle:nil];
    UINavigationController *launchNav = [[UINavigationController alloc] initWithRootViewController:launchVC];
    
    [self.window setRootViewController:launchNav];
    [self.window makeKeyAndVisible];
}

- (void)checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"\n[%s] Network status is %d", __FUNCTION__, internetStatus]];
    
    switch (internetStatus){
        case NotReachable: {
            internetActive = NO;
            break;
        }
        case ReachableViaWiFi: {
            internetActive = YES;
            break;
        }
        case ReachableViaWWAN: {
            internetActive = YES;
            
            break;
        }
    }
}

- (void)createListCity {
    listCity = [[NSMutableArray alloc] init];
    
    CityObject *city1 = [[CityObject alloc] initWithCode:@"1" name:@"Hồ Chí Minh"];
    [listCity addObject: city1];
    
    CityObject *city2 = [[CityObject alloc] initWithCode:@"2" name:@"Hà Nội"];
    [listCity addObject: city2];
    
    CityObject *city3 = [[CityObject alloc] initWithCode:@"3" name:@"An Giang"];
    [listCity addObject: city3];
    
    CityObject *city4 = [[CityObject alloc] initWithCode:@"4" name:@"Bạc Liêu"];
    [listCity addObject: city4];
    
    CityObject *city5 = [[CityObject alloc] initWithCode:@"5" name:@"Bà Rịa - Vũng Tàu"];
    [listCity addObject: city5];
    
    CityObject *city6 = [[CityObject alloc] initWithCode:@"6" name:@"Bắc Kạn"];
    [listCity addObject: city6];
    
    CityObject *city7 = [[CityObject alloc] initWithCode:@"7" name:@"Bắc Giang"];
    [listCity addObject: city7];
    
    CityObject *city8 = [[CityObject alloc] initWithCode:@"8" name:@"Bắc Ninh"];
    [listCity addObject: city8];
    
    CityObject *city9 = [[CityObject alloc] initWithCode:@"9" name:@"Bến Tre"];
    [listCity addObject: city9];
    
    CityObject *city10 = [[CityObject alloc] initWithCode:@"10" name:@"Bình Dương"];
    [listCity addObject: city10];
    
    CityObject *city11 = [[CityObject alloc] initWithCode:@"11" name:@"Bình Định"];
    [listCity addObject: city11];
    
    CityObject *city12 = [[CityObject alloc] initWithCode:@"12" name:@"Bình Phước"];
    [listCity addObject: city12];
    
    CityObject *city13 = [[CityObject alloc] initWithCode:@"13" name:@"Bình Thuận"];
    [listCity addObject: city13];
    
    CityObject *city14 = [[CityObject alloc] initWithCode:@"14" name:@"Cao Bằng"];
    [listCity addObject: city14];
    
    CityObject *city15 = [[CityObject alloc] initWithCode:@"15" name:@"Cà Mau"];
    [listCity addObject: city15];
    
    CityObject *city16 = [[CityObject alloc] initWithCode:@"16" name:@"Cần Thơ"];
    [listCity addObject: city16];
    
    CityObject *city17 = [[CityObject alloc] initWithCode:@"17" name:@"Đà Nẵng"];
    [listCity addObject: city17];
    
    CityObject *city18 = [[CityObject alloc] initWithCode:@"18" name:@"Đắk Lắk"];
    [listCity addObject: city18];
    
    CityObject *city19 = [[CityObject alloc] initWithCode:@"19" name:@"Đồng Nai"];
    [listCity addObject: city19];
    
    CityObject *city20 = [[CityObject alloc] initWithCode:@"20" name:@"Đồng Tháp"];
    [listCity addObject: city20];
    
    CityObject *city21 = [[CityObject alloc] initWithCode:@"21" name:@"Hà Giang"];
    [listCity addObject: city21];
    
    CityObject *city23 = [[CityObject alloc] initWithCode:@"23" name:@"Hà Nam"];
    [listCity addObject: city23];
    
    CityObject *city24 = [[CityObject alloc] initWithCode:@"24" name:@"Hà Tây"];
    [listCity addObject: city24];
    
    CityObject *city25 = [[CityObject alloc] initWithCode:@"25" name:@"Hà Tĩnh"];
    [listCity addObject: city25];
    
    CityObject *city26 = [[CityObject alloc] initWithCode:@"26" name:@"Hải Dương"];
    [listCity addObject: city26];
    
    CityObject *city27 = [[CityObject alloc] initWithCode:@"27" name:@"Hải Phòng"];
    [listCity addObject: city27];
    
    CityObject *city28 = [[CityObject alloc] initWithCode:@"28" name:@"Hòa Bình"];
    [listCity addObject: city28];
    
    CityObject *city29 = [[CityObject alloc] initWithCode:@"29" name:@"Hưng Yên"];
    [listCity addObject: city29];
    
    CityObject *city30 = [[CityObject alloc] initWithCode:@"30" name:@"Khánh Hòa"];
    [listCity addObject: city30];
    
    CityObject *city31 = [[CityObject alloc] initWithCode:@"31" name:@"Kiên Giang"];
    [listCity addObject: city31];
    
    CityObject *city32 = [[CityObject alloc] initWithCode:@"32" name:@"Kon Tum"];
    [listCity addObject: city32];
    
    CityObject *city33 = [[CityObject alloc] initWithCode:@"33" name:@"Lai Châu"];
    [listCity addObject: city33];
    
    CityObject *city34 = [[CityObject alloc] initWithCode:@"34" name:@"Lạng Sơn"];
    [listCity addObject: city34];
    
    CityObject *city35 = [[CityObject alloc] initWithCode:@"35" name:@"Lào Cai"];
    [listCity addObject: city35];
    
    CityObject *city36 = [[CityObject alloc] initWithCode:@"36" name:@"Lâm Đồng"];
    [listCity addObject: city36];
    
    CityObject *city37 = [[CityObject alloc] initWithCode:@"37" name:@"Long An"];
    [listCity addObject: city37];
    
    CityObject *city38 = [[CityObject alloc] initWithCode:@"38" name:@"Nam Định"];
    [listCity addObject: city38];
    
    CityObject *city39 = [[CityObject alloc] initWithCode:@"39" name:@"Nghệ An"];
    [listCity addObject: city39];
    
    CityObject *city40 = [[CityObject alloc] initWithCode:@"40" name:@"Ninh Bình"];
    [listCity addObject: city40];
    
    CityObject *city41 = [[CityObject alloc] initWithCode:@"41" name:@"Ninh Thuận"];
    [listCity addObject: city41];
    
    CityObject *city42 = [[CityObject alloc] initWithCode:@"42" name:@"Phú Thọ"];
    [listCity addObject: city42];
    
    CityObject *city43 = [[CityObject alloc] initWithCode:@"43" name:@"Phú Yên"];
    [listCity addObject: city43];
    
    CityObject *city44 = [[CityObject alloc] initWithCode:@"44" name:@"Quảng Bình"];
    [listCity addObject: city44];
    
    CityObject *city45 = [[CityObject alloc] initWithCode:@"45" name:@"Quảng Nam"];
    [listCity addObject: city45];
    
    CityObject *city46 = [[CityObject alloc] initWithCode:@"46" name:@"Quảng Ngãi"];
    [listCity addObject: city46];
    
    CityObject *city47 = [[CityObject alloc] initWithCode:@"47" name:@"Quảng Ninh"];
    [listCity addObject: city47];
    
    CityObject *city48 = [[CityObject alloc] initWithCode:@"48" name:@"Quảng Trị"];
    [listCity addObject: city48];
    
    CityObject *city49 = [[CityObject alloc] initWithCode:@"49" name:@"Sóc Trăng"];
    [listCity addObject: city49];
    
    CityObject *city50 = [[CityObject alloc] initWithCode:@"50" name:@"Sơn La"];
    [listCity addObject: city50];
    
    CityObject *city51 = [[CityObject alloc] initWithCode:@"51" name:@"Tây Ninh"];
    [listCity addObject: city51];
    
    CityObject *city52 = [[CityObject alloc] initWithCode:@"52" name:@"Thái Bình"];
    [listCity addObject: city52];
    
    CityObject *city53 = [[CityObject alloc] initWithCode:@"53" name:@"Thái Nguyên"];
    [listCity addObject: city53];
    
    CityObject *city54 = [[CityObject alloc] initWithCode:@"54" name:@"Thanh Hóa"];
    [listCity addObject: city54];
    
    CityObject *city55 = [[CityObject alloc] initWithCode:@"55" name:@"Thừa Thiên Huế"];
    [listCity addObject: city55];
    
    CityObject *city56 = [[CityObject alloc] initWithCode:@"56" name:@"Tiền Giang"];
    [listCity addObject: city56];
    
    CityObject *city57 = [[CityObject alloc] initWithCode:@"57" name:@"Trà Vinh"];
    [listCity addObject: city57];
    
    CityObject *city58 = [[CityObject alloc] initWithCode:@"58" name:@"Tuyên Quang"];
    [listCity addObject: city58];
    
    CityObject *city59 = [[CityObject alloc] initWithCode:@"59" name:@"Vĩnh Long"];
    [listCity addObject: city59];
    
    CityObject *city60 = [[CityObject alloc] initWithCode:@"60" name:@"Vĩnh Phúc"];
    [listCity addObject: city60];
    
    CityObject *city61 = [[CityObject alloc] initWithCode:@"Yên Bái" name:@"Yên Bái"];
    [listCity addObject: city61];
    
    CityObject *city62 = [[CityObject alloc] initWithCode:@"62" name:@"Đắk Nông"];
    [listCity addObject: city62];
    
    CityObject *city63 = [[CityObject alloc] initWithCode:@"63" name:@"Gia Lai"];
    [listCity addObject: city63];
    
    CityObject *city64 = [[CityObject alloc] initWithCode:@"64" name:@"Điện Biên"];
    [listCity addObject: city64];
    
    CityObject *city65 = [[CityObject alloc] initWithCode:@"65" name:@"Hậu Giang"];
    [listCity addObject: city65];
    
    CityObject *city66 = [[CityObject alloc] initWithCode:@"66" name:@"Buôn Ma Thuột"];
    [listCity addObject: city66];
    
    CityObject *city67 = [[CityObject alloc] initWithCode:@"67" name:@"Crimmitschau"];
    [listCity addObject: city67];
}

- (void)enableSizeForBarButtonItem: (BOOL)enable {
    float fontSize = 0.1;
    if (enable) {
        fontSize = 18.0;
    }
    NSDictionary *titleInfo = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:fontSize], NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateNormal];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateHighlighted];
}

- (void)setupFontForApp {
    radius = 5.0;
    
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            //  Screen width: 320.000000 - Screen height: 667.000000
            fontBold = [UIFont fontWithName:RobotoBold size:16.0];
            fontMedium = [UIFont fontWithName:RobotoMedium size:16.0];
            fontRegular = [UIFont fontWithName:RobotoRegular size:16.0];
            fontDesc = [UIFont fontWithName:RobotoRegular size:14.0];
            fontBTN = [UIFont fontWithName:RobotoRegular size:18.0];
            fontItalic = [UIFont fontWithName:RobotoItalic size:16.0];
            
            fontNormal = [UIFont fontWithName:RobotoRegular size:15.0];
            fontItalicDesc = [UIFont fontWithName:RobotoItalic size:15.0];
            fontMediumDesc = [UIFont fontWithName:RobotoMedium size:15.0];
            
            hTextfield = 35.0;
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            //  Screen width: 375.000000 - Screen height: 667.000000
            fontBold = [UIFont fontWithName:RobotoBold size:16.0];
            fontMedium = [UIFont fontWithName:RobotoMedium size:16.0];
            fontRegular = [UIFont fontWithName:RobotoRegular size:16.0];
            fontDesc = [UIFont fontWithName:RobotoRegular size:14.0];
            fontBTN = [UIFont fontWithName:RobotoRegular size:18.0];
            fontItalic = [UIFont fontWithName:RobotoItalic size:16.0];
            
            fontNormal = [UIFont fontWithName:RobotoRegular size:15.0];
            fontItalicDesc = [UIFont fontWithName:RobotoItalic size:15.0];
            fontMediumDesc = [UIFont fontWithName:RobotoMedium size:15.0];
            
            hTextfield = 38.0;
            
        }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
        {
            //  Screen width: 414.000000 - Screen height: 736.000000
            fontBold = [UIFont fontWithName:RobotoBold size:18.0];
            fontMedium = [UIFont fontWithName:RobotoMedium size:18.0];
            fontRegular = [UIFont fontWithName:RobotoRegular size:18.0];
            fontDesc = [UIFont fontWithName:RobotoRegular size:16.0];
            fontBTN = [UIFont fontWithName:RobotoRegular size:20.0];
            fontItalic = [UIFont fontWithName:RobotoItalic size:18.0];
            
            fontNormal = [UIFont fontWithName:RobotoRegular size:16.0];
            fontItalicDesc = [UIFont fontWithName:RobotoItalic size:16.0];
            fontMediumDesc = [UIFont fontWithName:RobotoMedium size:16.0];
            
            hTextfield = 40.0;
            
        }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator]){
            //  Screen width: 414.000000 - Screen height: 812.000000
            fontBold = [UIFont fontWithName:RobotoBold size:18.0];
            fontMedium = [UIFont fontWithName:RobotoMedium size:18.0];
            fontRegular = [UIFont fontWithName:RobotoRegular size:18.0];
            fontDesc = [UIFont fontWithName:RobotoRegular size:16.0];
            fontBTN = [UIFont fontWithName:RobotoRegular size:20.0];
            fontItalic = [UIFont fontWithName:RobotoItalic size:18.0];
            
            fontNormal = [UIFont fontWithName:RobotoRegular size:16.0];
            fontItalicDesc = [UIFont fontWithName:RobotoItalic size:16.0];
            fontMediumDesc = [UIFont fontWithName:RobotoMedium size:16.0];
            
            hTextfield = 40.0;
            
        }else{
            fontBold = [UIFont fontWithName:RobotoRegular size:16.0];
            fontMedium = [UIFont fontWithName:RobotoMedium size:16.0];
            fontRegular = [UIFont fontWithName:RobotoRegular size:16.0];
            fontDesc = [UIFont fontWithName:RobotoRegular size:14.0];
            fontBTN = [UIFont fontWithName:RobotoRegular size:18.0];
            fontItalic = [UIFont fontWithName:RobotoItalic size:16.0];
            
            fontNormal = [UIFont fontWithName:RobotoRegular size:15.0];
            fontItalicDesc = [UIFont fontWithName:RobotoItalic size:15.0];
            fontMediumDesc = [UIFont fontWithName:RobotoMedium size:15.0];
            
            hTextfield = 38.0;
        }
    }else{
        fontRegular = [UIFont fontWithName:RobotoRegular size:22.0];
        fontBTN = [UIFont fontWithName:RobotoRegular size:25.0];
        fontItalic = [UIFont fontWithName:RobotoItalic size:22.0];
        fontMedium = [UIFont fontWithName:RobotoMedium size:22.0];
        fontBold = [UIFont fontWithName:RobotoBold size:22.0];
        fontNormal = [UIFont fontWithName:RobotoRegular size:20.0];
        fontMediumDesc = [UIFont fontWithName:RobotoMedium size:20.0];
        fontDesc = [UIFont fontWithName:RobotoRegular size:19.0];
        
        fontItalicDesc = [UIFont fontWithName:RobotoItalic size:16.0];
        
        hTextfield = 50.0;
    }
}

- (NSString *)findCityObjectWithCityCode: (NSString *)code {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code = %@", code];
    NSArray *filter = [listCity filteredArrayUsingPredicate: predicate];
    if (filter.count > 0) {
        CityObject *result = [filter firstObject];
        return result.name;
    }
    return @"";
}

- (void)updateShoppingCartCount {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        self.cartView.lbCount.hidden = TRUE;
    }else{
        self.cartView.lbCount.hidden = FALSE;
        self.cartView.lbCount.text = [NSString stringWithFormat:@"%d", [[CartModel getInstance] countItemInCart]];
    }
}

- (void)showCartScreenContent
{
    /*
    if (self.cartWindow == nil) {
        //  self.cartWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.cartWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.cartWindow.backgroundColor = UIColor.redColor;
        self.cartWindow.windowLevel = UIWindowLevelNormal;
        self.cartWindow.tag = 2;
    }
    if (self.cartViewController == nil) {
        self.cartViewController = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
        self.cartNavViewController = [[UINavigationController alloc] initWithRootViewController:self.cartViewController];
        self.cartNavViewController.navigationBarHidden = YES;
    }
    [ProgressHUD updateCurrentWindowWithNewWindow: self.cartWindow];
    cartWindow.rootViewController = cartNavViewController;
    cartWindow.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.cartWindow.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.cartWindow.alpha = 1;
        [self.cartWindow makeKeyAndVisible];
    }completion:^(BOOL finished) {
        
    }]; */
    if (cartWindow == nil) {
        //  self.cartWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        cartWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
        cartWindow.backgroundColor = UIColor.redColor;
        cartWindow.windowLevel = UIWindowLevelNormal;
        cartWindow.tag = 2;
    }
    if (shoppingCartVC == nil) {
        shoppingCartVC = [[ShoppingCartViewController alloc] initWithNibName:@"ShoppingCartViewController" bundle:nil];
        shoppingCartNavVC = [[UINavigationController alloc] initWithRootViewController: shoppingCartVC];
        shoppingCartNavVC.navigationBarHidden = TRUE;
    }
    [ProgressHUD updateCurrentWindowWithNewWindow: cartWindow];
    cartWindow.rootViewController = shoppingCartNavVC;
    cartWindow.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        cartWindow.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        cartWindow.alpha = 1;
        [cartWindow makeKeyAndVisible];
    }];
}

- (void)hideCartView {
    [ProgressHUD updateCurrentWindowWithNewWindow: self.window];
    if( [cartWindow isKeyWindow] ) {
        
        [UIView animateWithDuration:0.2 animations:^{
            cartWindow.alpha = 0;
        } completion:^(BOOL finished) {
            /*
            if (self.cartViewController != nil) {
                [self.cartViewController.view removeFromSuperview];
                self.cartViewController = nil;
            }
            
            if (self.cartNavViewController != nil) {
                [self.cartNavViewController.view removeFromSuperview];
                self.cartNavViewController = nil;
            }
            */
            if (shoppingCartVC != nil) {
                [shoppingCartVC.view removeFromSuperview];
                shoppingCartVC = nil;
            }
            
            if (shoppingCartNavVC != nil) {
                [shoppingCartNavVC.view removeFromSuperview];
                shoppingCartNavVC = nil;
            }
            [cartWindow removeFromSuperview];
            [self.window makeKeyAndVisible];
        }];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadChoosedDomainList" object:nil];
    }
}

- (void)setupForWriteLogFileForApp
{
    //  create folder each day
    NSString *directory = [NSString stringWithFormat:@"%@/%@", logsFolderName, [AppUtils getCurrentDateForLogFolder]];
    [AppUtils createDirectoryAndSubDirectory:directory];
    
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    //  set logs file path
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    
    NSString *logFilePath = [documentsDir stringByAppendingPathComponent:directory];
    
    DDLogFileManagerDefault *documentsFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logFilePath];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:documentsFileManager];
    
    [fileLogger setMaximumFileSize:(1024 * 2 * 1024)];  //  2MB for each log file
    [fileLogger setRollingFrequency:(3600.0 * 24.0)];  // roll everyday
    [[fileLogger logFileManager] setMaximumNumberOfLogFiles:5];
    [fileLogger setLogFormatter:[[DDLogFileFormatterDefault alloc]init]];
    
    [DDLog addLogger:fileLogger];
}

- (void)createErrorMessagesInfo {
    errorMsgDict = [[NSMutableDictionary alloc] init];
    
    [errorMsgDict setObject:@"Truy vấn không hợp lệ" forKey:@"001"];
    [errorMsgDict setObject:@"Thiếu tên truy cập hoặc mật khẩu" forKey:@"002"];
    [errorMsgDict setObject:@"Tên truy cập không tồn tại trên hệ thống" forKey:@"003"];
    [errorMsgDict setObject:@"Mật khẩu không chính xác" forKey:@"004"];
    [errorMsgDict setObject:@"Tài khoản chưa được kích hoạt" forKey:@"005"];
    [errorMsgDict setObject:@"Tài khoản đang bị khóa" forKey:@"006"];
    [errorMsgDict setObject:@"Tài khoản thiếu thông tin cá nhân hay chủ thể" forKey:@"007"];
    [errorMsgDict setObject:@"Hồ sơ cần thêm nhập thiếu tên hoặc CMND hoặc số điện thoại" forKey:@"008"];
    [errorMsgDict setObject:@"Tên chủ thể phải là tiếng Việt có dấu" forKey:@"009"];
    [errorMsgDict setObject:@"Số điện thoại không hợp lệ" forKey:@"010"];
    [errorMsgDict setObject:@"Hồ sơ tổ chức bị thiếu một trong các thông tin sau: Tên tổ chức, Mã số thuế, địa chỉ, số điện thoại" forKey:@"011"];
    [errorMsgDict setObject:@"Mã hồ sơ không tồn tại trên hệ thống" forKey:@"012"];
    [errorMsgDict setObject:@"Số năng đăng ký hoặc duy trì không hợp lệ" forKey:@"013"];
    [errorMsgDict setObject:@"Mã hồ sơ không phải là hồ sơ của tài khoản đăng nhập" forKey:@"014"];
    [errorMsgDict setObject:@"Tên miền không ở trạng thái tự do để đăng ký" forKey:@"015"];
    [errorMsgDict setObject:@"Số tiền trong tài khoản không đủ để đăng ký / duy trì tên miền" forKey:@"016"];
    [errorMsgDict setObject:@"Tên miền không hợp lệ hoặc không tồn tại trên hệ thống" forKey:@"017"];
    [errorMsgDict setObject:@"Tên miền đang ở chế độ được bảo vệ, vui lòng liên nhà cung cấp tên miền để được hỗ trợ." forKey:@"018"];
    [errorMsgDict setObject:@"Thiếu thông tin NS1" forKey:@"019"];
    [errorMsgDict setObject:@"Không thể phân giải NS1" forKey:@"020"];
    [errorMsgDict setObject:@"Thiếu thông tin NS2" forKey:@"021"];
    [errorMsgDict setObject:@"Không thể phân giải NS2" forKey:@"022"];
    [errorMsgDict setObject:@"Không thể phân giải NS3" forKey:@"023"];
    [errorMsgDict setObject:@"Không thể phân giải NS4" forKey:@"024"];
    [errorMsgDict setObject:@"DNS đang được cập nhật. Vui lòng cập nhật DNS sau." forKey:@"025"];
    [errorMsgDict setObject:@"Tên miền không tồn tại trên hệ thống" forKey:@"026"];
    [errorMsgDict setObject:@"Mật khẩu phải nhiều hơn 6 ký tự" forKey:@"027"];
    [errorMsgDict setObject:@"Mật khẩu mới không giống nhau" forKey:@"028"];
    [errorMsgDict setObject:@"Thiếu mã OTP" forKey:@"029"];
    [errorMsgDict setObject:@"Mã OTP nhập vào không chính xác" forKey:@"030"];
    [errorMsgDict setObject:@"Số điện thoại không hợp lệ" forKey:@"031"];
    [errorMsgDict setObject:@"Mã hồ sơ không phải là hồ sơ của tài khoản đăng nhập" forKey:@"032"];
    [errorMsgDict setObject:@"Thông tin tài khoản ngân hàng nhập vào chưa đầy đủ" forKey:@"033"];
    [errorMsgDict setObject:@"Mã đơn hàng không tồn tại trên hệ thống" forKey:@"034"];
    [errorMsgDict setObject:@"Thiếu hình đại đại diện (profile photo)" forKey:@"035"];
    [errorMsgDict setObject:@"Có lỗi xảy ra trong quá trình cập nhật hình đại diện" forKey:@"036"];
    [errorMsgDict setObject:@"URL hình đại diện không hợp lệ" forKey:@"037"];
    [errorMsgDict setObject:@"Thông tin câu hỏi nhập vào chưa đầy đủ" forKey:@"038"];
    [errorMsgDict setObject:@"Tên truy cập đã tồn tại trên hệ thống" forKey:@"039"];
    [errorMsgDict setObject:@"Tên truy cập phải là địa chỉ email" forKey:@"040"];
    [errorMsgDict setObject:@"Quá trình đăng ký đang bị giới hạn, tối đa 3 lần đăng ký trong 60 phút" forKey:@"041"];
    [errorMsgDict setObject:@"Thiếu CMND mặt trước" forKey:@"042"];
    [errorMsgDict setObject:@"Tên miền cần tra cứu không hợp lệ" forKey:@"043"];
    [errorMsgDict setObject:@"Số tiền cần rút lớn hơn số tiền thưởng tài khoản đang có" forKey:@"044"];
    [errorMsgDict setObject:@"Số tiền cần rút nhỏ hơn số tiền tối thiểu có thể rút" forKey:@"045"];
}

#pragma mark - Firebase
- (void)messaging:(FIRMessaging *)messaging didReceiveRegistrationToken:(NSString *)fcmToken {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] fcmToken = %@", __FUNCTION__, fcmToken)];
    token = fcmToken;
}

- (void)startTimerToReloadInfoAfterTopupSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [self performSelector:@selector(regetLoginInformation) withObject:nil afterDelay:10];
}

- (void)regetLoginInformation {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
    if (getInfoTimer != nil) {
        [getInfoTimer invalidate];
        getInfoTimer = nil;
    }
    countLogin = 1;
    
    NSLog(@"regetLoginInformation after 15s");
    getInfoTimer = [NSTimer scheduledTimerWithTimeInterval:15.0 target:self selector:@selector(tryToRegetLoginInformation) userInfo:nil repeats:TRUE];
}

- (void)tryToRegetLoginInformation {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (countLogin >= 6) {
        if (getInfoTimer != nil) {
            [getInfoTimer invalidate];
            getInfoTimer = nil;
        }
        countLogin = 0;
        NSLog(@"countLogin = 6, cancel timer");
        return;
    }
    countLogin++;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadBalanceInfo" object:nil];
}

- (void)hideTabbarCustomSubviews: (BOOL)hide withDuration: (BOOL)duration {
    if (duration) {
        if (hide) {
            [UIView animateWithDuration:0.05 animations:^{
                btnSearchBar.alpha = 0;
            }];
        }else{
            [UIView animateWithDuration:0.05 animations:^{
                btnSearchBar.alpha = 1;
            }];
        }
    }else{
        btnSearchBar.alpha = (hide) ? 0 : 1;
    }
}

#pragma mark PJSIP

- (void)getAccVoipFreeForUser {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    [info setObject:USERNAME forKey:@"id"];
    
    NSString *password = [AccountModel getPasswordWasStoredForAccount];
    [info setObject:password forKey:@"hash"];
    
    [info setObject:GetAccVoipAction forKey:@"action"];
    NSString *total = [NSString stringWithFormat:@"/cskhvoip%@", password];
    NSString *key = [AppUtils getMD5StringOfString: total];
    [info setObject:key forKey:@"key"];

    NSURL *URL = [NSURL URLWithString: link_api_call];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: URL];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    [request setTimeoutInterval: 60];

    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];

    for (int i=0; i<[info allKeys].count; i++) {
        NSString *key = [[info allKeys] objectAtIndex: i];
        NSString *value = [info objectForKey: key];
        [request setValue:value forHTTPHeaderField:key];
    }
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         // whatever you do on the connectionDidFinishLoading
         // delegate can be moved here
         if (error != nil) {
             
         }else{
             NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
             int responseCode = (int)[httpResponse statusCode];
             if (responseCode == 200) {
                 NSString *value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 id object = [value objectFromJSONString];
                 if ([object isKindOfClass:[NSDictionary class]]) {
                     id success = [object objectForKey:@"success"];
                     if ([success boolValue] == TRUE) {
                         NSDictionary *data = [object objectForKey:@"data"];
                         [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"acc_call_info"];
                         [[NSUserDefaults standardUserDefaults] synchronize];
                         
                         accCallInfo = [[NSDictionary alloc] initWithDictionary: data];
                         
                         [self registerSIPAccountWithInfo: data];
                     }
                 }
             }
         }
     }];
}

#pragma mark - PushKit Functions
- (void)pushRegistry:(PKPushRegistry *)registry didInvalidatePushTokenForType:(NSString *)type {
    NSLog(@"PushKit Token invalidated");
    dispatch_async(dispatch_get_main_queue(), ^{
        //  [LinphoneManager.instance setPushNotificationToken:nil];
    });
}

- (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type {
    
    NSLog(@"PushKit : incoming voip notfication: %@", payload.dictionaryPayload);
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_x_Max) { // Call category
        UNNotificationAction *act_ans =
        [UNNotificationAction actionWithIdentifier:@"Answer"
                                             title:NSLocalizedString(@"Answer", nil)
                                           options:UNNotificationActionOptionForeground];
        UNNotificationAction *act_dec = [UNNotificationAction actionWithIdentifier:@"Decline"
                                                                             title:NSLocalizedString(@"Decline", nil)
                                                                           options:UNNotificationActionOptionNone];
        UNNotificationCategory *cat_call =
        [UNNotificationCategory categoryWithIdentifier:@"call_cat"
                                               actions:[NSArray arrayWithObjects:act_ans, act_dec, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
        // Msg category
        UNTextInputNotificationAction *act_reply =
        [UNTextInputNotificationAction actionWithIdentifier:@"Reply"
                                                      title:NSLocalizedString(@"Reply", nil)
                                                    options:UNNotificationActionOptionNone];
        UNNotificationAction *act_seen =
        [UNNotificationAction actionWithIdentifier:@"Seen"
                                             title:NSLocalizedString(@"Mark as seen", nil)
                                           options:UNNotificationActionOptionNone];
        UNNotificationCategory *cat_msg =
        [UNNotificationCategory categoryWithIdentifier:@"msg_cat"
                                               actions:[NSArray arrayWithObjects:act_reply, act_seen, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
        
        // Video Request Category
        UNNotificationAction *act_accept =
        [UNNotificationAction actionWithIdentifier:@"Accept"
                                             title:NSLocalizedString(@"Accept", nil)
                                           options:UNNotificationActionOptionForeground];
        
        UNNotificationAction *act_refuse = [UNNotificationAction actionWithIdentifier:@"Cancel"
                                                                                title:NSLocalizedString(@"Cancel", nil)
                                                                              options:UNNotificationActionOptionNone];
        UNNotificationCategory *video_call =
        [UNNotificationCategory categoryWithIdentifier:@"video_request"
                                               actions:[NSArray arrayWithObjects:act_accept, act_refuse, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
        
        // ZRTP verification category
        UNNotificationAction *act_confirm = [UNNotificationAction actionWithIdentifier:@"Confirm"
                                                                                 title:NSLocalizedString(@"Accept", nil)
                                                                               options:UNNotificationActionOptionNone];
        
        UNNotificationAction *act_deny = [UNNotificationAction actionWithIdentifier:@"Deny"
                                                                              title:NSLocalizedString(@"Deny", nil)
                                                                            options:UNNotificationActionOptionNone];
        UNNotificationCategory *cat_zrtp =
        [UNNotificationCategory categoryWithIdentifier:@"zrtp_request"
                                               actions:[NSArray arrayWithObjects:act_confirm, act_deny, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
        
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound |
                                          UNAuthorizationOptionBadge)
         completionHandler:^(BOOL granted, NSError *_Nullable error) {
             // Enable or disable features based on authorization.
             if (error) {
                 NSLog(@"%@", error.description);
             }
         }];
        NSSet *categories = [NSSet setWithObjects:cat_call, cat_msg, video_call, cat_zrtp, nil];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self processRemoteNotification:payload.dictionaryPayload];
    });
}

- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(PKPushType)type
{
    NSLog(@"voip token: %@", (credentials.token));
    dispatch_async(dispatch_get_main_queue(), ^{
        callToken = credentials.token.description;
        callToken = [callToken stringByReplacingOccurrencesOfString:@" " withString:@""];
        callToken = [callToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
        callToken = [callToken stringByReplacingOccurrencesOfString:@">" withString:@""];
        
        [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"GETTED TOKEN FOR APP: %@", callToken]];
    });
}

- (void)processRemoteNotification:(NSDictionary *)userInfo {
    NSDictionary *aps = [userInfo objectForKey:@"aps"];
    if (aps != nil)
    {
        [self getAccVoipFreeForUser];
        
        NSDictionary *alert = [aps objectForKey:@"alert"];
        NSString *loc_key = [aps objectForKey:@"loc-key"];
        NSString *callId = [aps objectForKey:@"callerid"];
        self.remoteName = callId;
        
        NSString *content = [NSString stringWithFormat:@"Bạn có cuộc gọi từ %@", self.remoteName];
        UILocalNotification *messageNotif = [[UILocalNotification alloc] init];
        messageNotif.fireDate = [NSDate dateWithTimeIntervalSinceNow: 0.1];
        messageNotif.timeZone = [NSTimeZone defaultTimeZone];
        messageNotif.timeZone = [NSTimeZone defaultTimeZone];
        messageNotif.alertBody = content;
        messageNotif.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification: messageNotif];
        
        if (alert != nil) {
            loc_key = [alert objectForKey:@"loc-key"];
            //  if we receive a remote notification, it is probably because our TCP background socket was no more working. As a result, break it and refresh registers in order to make sure to receive incoming INVITE or MESSAGE
            
            //linphone_core_set_network_reachable(LC, FALSE);
            if (![AppUtils checkNetworkAvailable]) {
                [self.window makeToast:@"Không có kết nối internet. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:errorStyle];
                return;
            }
            if (loc_key != nil) {
                //  callId = [userInfo objectForKey:@"call-id"];
                if (callId != nil) {
                    if ([callId isEqualToString:@""]){
                        //Present apn pusher notifications for info
                        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_x_Max) {
                            UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
                            content.title = @"APN Pusher";
                            content.body = @"Push notification received !";
                            
                            UNNotificationRequest *req = [UNNotificationRequest requestWithIdentifier:@"call_request" content:content trigger:NULL];
                            [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:req withCompletionHandler:^(NSError * _Nullable error) {
                                // Enable or disable features based on authorization.
                                if (error) {
                                    NSLog(@"Error while adding notification request :%@", error.description);
                                }
                            }];
                        } else {
                            UILocalNotification *notification = [[UILocalNotification alloc] init];
                            notification.repeatInterval = 0;
                            notification.alertBody = @"Push notification received !";
                            notification.alertTitle = @"APN Pusher";
                            [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
                        }
                    } else {
                        NSLog(@"addPushCallId");
                        //  [LinphoneManager.instance addPushCallId:callId];
                    }
                } else  if ([callId  isEqual: @""]) {
                    NSLog(@"PushNotification: does not have call-id yet, fix it !");
                }
            }else{
                [self.window makeToast:@"Not loc_key" duration:1.0 position:CSToastPositionCenter style:self.errorStyle];
            }
        }
    }
}

#pragma mark - Sound for call
- (void)playRingbackTone {
    if (ringbackPlayer == nil) {
        /* Use this code to play an audio file */
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"ringbacktone"  ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        ringbackPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        ringbackPlayer.numberOfLoops = -1; //Infinite
        [ringbackPlayer prepareToPlay];
    }
    
    if (ringbackPlayer.isPlaying) {
        return;
    }
    [ringbackPlayer play];
}

- (void)playBeepSound {
    if (beepPlayer == nil) {
        /* Use this code to play an audio file */
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"beep"  ofType:@"mp3"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        beepPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        [beepPlayer prepareToPlay];
    }
    
    if (beepPlayer.isPlaying) {
        [beepPlayer stop];
        [beepPlayer prepareToPlay];
    }
    [beepPlayer play];
}

- (void)stopRingbackTone {
    if (ringbackPlayer != nil) {
        [ringbackPlayer stop];
    }
    ringbackPlayer = nil;
}

- (void)showCallViewWithDirection: (CallDirection)direction remote: (NSString *)remote {
    if (callViewController == nil) {
        callViewController = [[CallViewController alloc] initWithNibName:@"CallViewController" bundle:nil];
    }
    callViewController.callDirection = direction;
    callViewController.remoteName = remote;
    
    callViewController.view.clipsToBounds = TRUE;
    callViewController.view.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    [self.window addSubview: callViewController.view];
    
    [self performSelector:@selector(startToShowCallView) withObject:nil afterDelay:0.05];
}

- (void)startToShowCallView {
    [callViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.window);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.window layoutIfNeeded];
    }];
}

- (void)hideCallView {
    [callViewController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.window);
        make.height.mas_equalTo(0.0);
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.window layoutIfNeeded];
    }completion:^(BOOL finished) {
        [callViewController.view removeFromSuperview];
        callViewController = nil;
        
        [AppDelegate sharedInstance].cartView.hidden = FALSE;
    }];
}

#pragma mark - functions for PJSIP
//  PJSIP COMMENT
/*
- (void)startPjsuaForApp {
    pjsua_create();

    pjsua_config ua_cfg;
    pjsua_logging_config log_cfg;
    pjsua_media_config media_cfg;

    pjsua_config_default(&ua_cfg);
    pjsua_logging_config_default(&log_cfg);
    pjsua_media_config_default(&media_cfg);

    ua_cfg.cb.on_incoming_call = &on_incoming_call;
    ua_cfg.cb.on_call_media_state = &on_call_media_state;
    ua_cfg.cb.on_call_state = &on_call_state;
    ua_cfg.cb.on_reg_state = &on_reg_state;

    pjsua_init(&ua_cfg, &log_cfg, &media_cfg);

    pjsua_transport_config transportConfig;

    pjsua_transport_config_default(&transportConfig);

    transportConfig.port = 51000;

    pjsua_transport_create(PJSIP_TRANSPORT_UDP, &transportConfig, NULL);
    pjsua_transport_create(PJSIP_TRANSPORT_TCP, &transportConfig, NULL);

    pjsua_start();
}

- (void)registerSIPAccountWithInfo: (NSDictionary *)info {
    NSString *account = [info objectForKey:@"account"];
    NSString *domain = [info objectForKey:@"domain"];
    NSString *port = [info objectForKey:@"port"];
    NSString *password = [info objectForKey:@"password"];

    if (![AppUtils isNullOrEmpty: account] && ![AppUtils isNullOrEmpty: domain] && ![AppUtils isNullOrEmpty: port] && ![AppUtils isNullOrEmpty: password]) {
        NSString *email = USERNAME;

        pj_status_t status;

        // Register the account on local sip server
        pjsua_acc_id acc_id;
        pjsua_acc_config cfg;
        pjsua_acc_config_default(&cfg);

        NSString *strCall = [NSString stringWithFormat:@"sip:%@@%@:%@", account, domain, port];
        NSString *regUri = [NSString stringWithFormat:@"sip:%@:%@", domain, port];

        cfg.id = pj_str((char *)[strCall UTF8String]);
        cfg.reg_uri = pj_str((char *)[regUri UTF8String]);
        cfg.cred_count = 1;
        cfg.cred_info[0].realm = pj_str("*");
        cfg.cred_info[0].scheme = pj_str("digest");
        cfg.cred_info[0].username = pj_str((char *)[account UTF8String]);
        cfg.cred_info[0].data_type = PJSIP_CRED_DATA_PLAIN_PASSWD;
        cfg.cred_info[0].data = pj_str((char *)[password UTF8String]);
        cfg.ice_cfg_use=PJSUA_ICE_CONFIG_USE_DEFAULT;
        //  disable IPV6
        cfg.ipv6_media_use = PJSUA_IPV6_DISABLED;

        pjsip_generic_string_hdr CustomHeader;
        pj_str_t name = pj_str("Call-ID");
        pj_str_t value = pj_str((char *)[email UTF8String]);
        pjsip_generic_string_hdr_init2(&CustomHeader, &name, &value);
        pj_list_push_back(&cfg.reg_hdr_list, &CustomHeader);

        pjsip_endpoint* endpoint = pjsua_get_pjsip_endpt();
        pj_dns_resolver* resolver;

        struct pj_str_t servers[] = {pj_str((char *)[domain UTF8String]) };
        pjsip_endpt_create_resolver(endpoint, &resolver);
        pj_dns_resolver_set_ns(resolver, 1, servers, NULL);

        // Init transport config structure
        pjsua_transport_config trans_cfg;
        pjsua_transport_config_default(&trans_cfg);
        trans_cfg.port = [port intValue];

        // Add UDP transport.
        status = pjsua_transport_create(PJSIP_TRANSPORT_UDP, &trans_cfg, NULL);
        if (status != PJ_SUCCESS){
            NSLog(@"Error creating transport");
        }

        status = pjsua_acc_add(&cfg, PJ_TRUE, &acc_id);
        if (status != PJ_SUCCESS){
            NSLog(@"Error adding account");
        }
    }else{
        [self.window makeToast:@"Thông tin tài khoản gọi không hợp lệ. Vui lòng kiểm tra lại!" duration:3.0 position:CSToastPositionCenter style:self.errorStyle];
    }
}

- (void)makeCallTo: (NSString *)strCall {
    //  NSString *stringForCall = [NSString stringWithFormat:@"sip:%@@nhanhoa1.vfone.vn:51000", strCall];
    char *destUri = (char *)[strCall UTF8String];

    pjsua_acc_id acc_id = 0;
    pj_status_t status;
    pj_str_t pj_uri = pj_str(destUri);

    //current register id _acc_id
    pj_caching_pool cp;
    pj_pool_t *pool;

    pjsua_msg_data msg_data;
    pjsua_msg_data_init(&msg_data);

    pj_caching_pool_init(&cp, &pj_pool_factory_default_policy, 0);
    pool= pj_pool_create(&cp.factory, "header", 1000, 1000, NULL);

    pj_str_t hname = pj_str((char *)[@"User-Agent" UTF8String]);
    pj_str_t hvalue = pj_str((char *)[USERNAME UTF8String]);
    pjsip_generic_string_hdr* add_hdr = pjsip_generic_string_hdr_create(pool, &hname, &hvalue);
    pj_list_push_back(&msg_data.hdr_list, add_hdr);

    status = pjsua_call_make_call(acc_id, &pj_uri, 0, NULL, &msg_data, NULL);
    if (status != PJ_SUCCESS){
        NSLog(@"Error making call");
    }
    pj_pool_release(pool);
}

- (int)getDurationForCurrentCall {
    if (current_call_id != -1) {
        pjsua_call_info ci;
        pjsua_call_get_info(current_call_id, &ci);
        //  NSLog(@"%ld - %ld", ci.total_duration.sec, ci.connect_duration.sec);
        return (int)ci.connect_duration.sec;
    }
    return 0;
}

- (BOOL)checkMicrophoneWasMuted {
    if (pjsipConfAudioId >= 0) {
        unsigned int tx_level;
        unsigned int rx_level;
        pjsua_conf_get_signal_level(pjsipConfAudioId, &tx_level, &rx_level);
        if (tx_level == 0) {
            return TRUE;
        }else{
            return FALSE;
        }
    }
    return FALSE;
}

- (BOOL)checkCurrentCallWasHold {
    if (current_call_id != -1) {
        pjsua_call_info ci;
        pjsua_call_get_info(current_call_id, &ci);
        if (ci.media_status == PJSUA_CALL_MEDIA_LOCAL_HOLD) {
            return TRUE;
        }
    }
    return FALSE;
}

- (BOOL)isCallWasConnected {
    if (current_call_id != -1) {
        pjsua_call_info ci;
        pjsua_call_get_info(current_call_id, &ci);

        if (ci.state == PJSIP_INV_STATE_CONFIRMED) {
            return TRUE;
        }
    }
    return FALSE;
}

- (NSArray *)getContactNameOfRemoteForCall {
    if (current_call_id != -1) {
        pjsua_call_info ci;
        pjsua_call_get_info(current_call_id, &ci);
        NSString *contactName = [NSString stringWithUTF8String: ci.remote_info.ptr];
        if (![AppUtils isNullOrEmpty: contactName]) {
            NSString *name;
            NSString *subname;

            //  get name
            NSRange range = [contactName rangeOfString:@" <"];
            if (range.location != NSNotFound) {
                name = [contactName substringToIndex: range.location];
            }else {
                range = [contactName rangeOfString:@"<"];
                if (range.location != NSNotFound) {
                    name = [contactName substringToIndex: range.location];
                }
            }
            if ([name hasPrefix:@"\""]) {
                name = [name substringFromIndex:1];
            }
            if ([name hasSuffix:@"\""]) {
                name = [name substringToIndex:name.length - 1];
            }

            //  get subname
            range = [contactName rangeOfString:@"<sip:"];
            if (range.location != NSNotFound) {
                NSRange subrange = [contactName rangeOfString:@"@"];
                if (subrange.location != NSNotFound && range.location < subrange.location) {
                    subname = [contactName substringWithRange:NSMakeRange(range.location+range.length, subrange.location - (range.location+range.length))];
                }
            }
            return @[name, subname];
        }
    }
    return nil;
}

- (NSArray *)getContactNameForCallWithCallInfo: (pjsua_call_info)ci {
    NSString *contactName = [NSString stringWithUTF8String: ci.remote_info.ptr];
    if (![AppUtils isNullOrEmpty: contactName]) {
        NSString *name;
        NSString *subname;

        //  get name
        NSRange range = [contactName rangeOfString:@" <"];
        if (range.location != NSNotFound) {
            name = [contactName substringToIndex: range.location];
        }else {
            range = [contactName rangeOfString:@"<"];
            if (range.location != NSNotFound) {
                name = [contactName substringToIndex: range.location];
            }
        }
        if ([name hasPrefix:@"\""]) {
            name = [name substringFromIndex:1];
        }
        if ([name hasSuffix:@"\""]) {
            name = [name substringToIndex:name.length - 1];
        }

        //  get subname
        range = [contactName rangeOfString:@"<sip:"];
        if (range.location != NSNotFound) {
            NSRange subrange = [contactName rangeOfString:@"@"];
            if (subrange.location != NSNotFound && range.location < subrange.location) {
                subname = [contactName substringWithRange:NSMakeRange(range.location+range.length, subrange.location - (range.location+range.length))];
            }
        }
        return @[name, subname];
    }
    return nil;
}

- (BOOL)sendDtmfWithValue: (NSString *)value {
    pjsua_call_send_dtmf_param param;
    param.method = PJSUA_DTMF_METHOD_RFC2833;
    param.duration = PJSUA_CALL_SEND_DTMF_DURATION_DEFAULT;
    param.digits = pj_str((char *)[value UTF8String]);

    pj_status_t status = pjsua_call_send_dtmf(current_call_id, &param);
    if (status != PJ_SUCCESS){
        return FALSE;
    }
    return TRUE;
}

- (BOOL)muteMicrophone: (BOOL)mute {
    if (mute) {
        @try {
            if( pjsipConfAudioId != 0 ) {
                NSLog(@"WC_SIPServer microphone disconnected from call");
                pjsua_conf_disconnect(0, pjsipConfAudioId);
                return TRUE;
            }
            return FALSE;
        }
        @catch (NSException *exception) {
            return FALSE;
        }
    }else{
        @try {
            if( pjsipConfAudioId != 0 ) {
                NSLog(@"WC_SIPServer microphone reconnected to call");
                pjsua_conf_connect(0,pjsipConfAudioId);
                return TRUE;
            }
            return FALSE;
        }
        @catch (NSException *exception) {
            return FALSE;
        }
    }
}

- (void)holdCurrentCall: (BOOL)hold {
    if (hold) {
        pjsua_call_set_hold(current_call_id, nil);
    }else{
        pjsua_call_update(current_call_id, PJSUA_CALL_UNHOLD, nil);
    }
}

- (void)hangupAllCall {
    pjsua_call_hangup_all();
}

- (void)hangupCallWithCallId: (pjsua_call_id)call_id code: (int)code reason: (NSString *)reason {
    pj_str_t pj_reason = pj_str((char *)[reason UTF8String]);
    pjsua_call_hangup(call_id, code, &pj_reason, nil);
}

- (void)removeAccount {
    pjsua_acc_id accId = pjsua_acc_get_default();
    if (pjsua_acc_is_valid(accId)) {
        pjsua_acc_del(accId);
    }
}

//  Callback called by the library upon receiving incoming call
static void on_incoming_call(pjsua_acc_id acc_id, pjsua_call_id call_id, pjsip_rx_data *rdata)
{
    pjsua_call_info ci;
    PJ_UNUSED_ARG(acc_id);
    PJ_UNUSED_ARG(rdata);

    pjsua_call_get_info(call_id, &ci);

    NSUUID *uuid = [NSUUID UUID];
    NSString *callId = [NSString stringWithFormat:@"%d", call_id];

    [app.del.calls setObject:callId forKey:uuid];
    [app.del.uuids setObject:uuid forKey:callId];

    NSString *caller = unknown;
    NSArray *info = [app getContactNameForCallWithCallInfo: ci];
    if (info != nil && info.count == 2) {
        caller = [NSString stringWithFormat:@"%@ - %@", [info firstObject], [info lastObject]];
    }
    [app.del reportIncomingCallwithUUID:uuid handle:caller video:FALSE];

    PJ_LOG(3,(THIS_FILE, "Incoming call from %.*s!!", (int)ci.remote_info.slen,ci.remote_info.ptr));
    //  Automatically answer incoming calls with 200/OK
    //  pjsua_call_answer(call_id, 200, NULL, NULL);
}

//  Callback called by the library when call's media state has changed
static void on_call_media_state(pjsua_call_id call_id)
{
    pjsua_call_info ci;

    pjsua_call_get_info(call_id, &ci);

    if (ci.media_status == PJSUA_CALL_MEDIA_ACTIVE) {
        // When media is active, connect call to sound device.
        pjsua_conf_connect(ci.conf_slot, 0);
        pjsua_conf_connect(0, ci.conf_slot);
    }
}

// Callback called by the library when call's state has changed
static void on_call_state(pjsua_call_id call_id, pjsip_event *e)
{
    //  store call_id to get duration
    app.current_call_id = call_id;

    pjsua_call_info ci;

    PJ_UNUSED_ARG(e);

    pjsua_call_get_info(call_id, &ci);
    PJ_LOG(3,(THIS_FILE, "Call %d state=%.*s", call_id, (int)ci.state_text.slen, ci.state_text.ptr));

    NSString *state = [app getContentOfCallStateWithStateValue: ci.state];
    NSString *last_status = [NSString stringWithFormat:@"%d", ci.last_status];
    app.pjsipConfAudioId = ci.conf_slot;

    [[NSNotificationCenter defaultCenter] postNotificationName:notifCallStateChanged object:[NSDictionary dictionaryWithObjectsAndKeys:state, @"state", last_status, @"last_status", nil]];

    if (ci.state == PJSIP_INV_STATE_DISCONNECTED) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *callId = [NSString stringWithFormat:@"%d", call_id];
            NSUUID *uuid = (NSUUID *)[app.del.uuids objectForKey: callId];
            if (uuid) {
                [app.del.uuids removeObjectForKey: callId];
                [app.del.calls removeObjectForKey: uuid];

                CXEndCallAction *act = [[CXEndCallAction alloc] initWithCallUUID:uuid];
                CXTransaction *tr = [[CXTransaction alloc] initWithAction:act];
                [app.del.controller requestTransaction:tr completion:^(NSError * _Nullable error) {
                    NSLog(@"error = %@", error);
                }];
            }
            [app removeAccount];
        });
    }
}

static void on_reg_state(pjsua_acc_id acc_id)
{
    //  pjsip_status_code   PJSIP_SC_OK
    pjsua_acc_info info;
    pjsua_acc_get_info(acc_id, &info);
    if (info.status == PJSIP_SC_OK) {
        [[NSNotificationCenter defaultCenter] postNotificationName:notifRegStateChanged object:[NSNumber numberWithInt: 1]];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:notifRegStateChanged object:[NSNumber numberWithInt: 0]];
    }
    PJ_UNUSED_ARG(acc_id);

    // Log already written.
}

- (NSString *)getContentOfCallStateWithStateValue: (pjsip_inv_state)state {
    switch (state) {
        case PJSIP_INV_STATE_NULL:{
            return CALL_INV_STATE_NULL;
        }
        case PJSIP_INV_STATE_CALLING:{
            return CALL_INV_STATE_CALLING;
        }
        case PJSIP_INV_STATE_INCOMING:{
            return CALL_INV_STATE_INCOMING;
        }
        case PJSIP_INV_STATE_EARLY:{
            return CALL_INV_STATE_EARLY;
        }
        case PJSIP_INV_STATE_CONNECTING:{
            return CALL_INV_STATE_CONNECTING;
        }
        case PJSIP_INV_STATE_CONFIRMED:{
            return CALL_INV_STATE_CONFIRMED;
        }
        case PJSIP_INV_STATE_DISCONNECTED:{
            return CALL_INV_STATE_DISCONNECTED;
        }
    }
    return @"";
}


- (void)answerCallWithCallID: (int)call_id {
    pjsua_call_answer(call_id, 200, NULL, NULL);

    //  show call screen
    [[AppDelegate sharedInstance] showCallViewWithDirection: IncomingCall remote: self.remoteName];
}


- (void)registerForNotifications:(UIApplication *)app {
    self.voipRegistry = [[PKPushRegistry alloc] initWithQueue:dispatch_get_main_queue()];
    self.voipRegistry.delegate = self;

    // Initiate registration.
    self.voipRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];

    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_9_x_Max) {
        // Call category
        UNNotificationAction *act_ans =
        [UNNotificationAction actionWithIdentifier:@"Answer"
                                             title:NSLocalizedString(@"Answer", nil)
                                           options:UNNotificationActionOptionForeground];
        UNNotificationAction *act_dec = [UNNotificationAction actionWithIdentifier:@"Decline"
                                                                             title:NSLocalizedString(@"Decline", nil)
                                                                           options:UNNotificationActionOptionNone];
        UNNotificationCategory *cat_call =
        [UNNotificationCategory categoryWithIdentifier:@"call_cat"
                                               actions:[NSArray arrayWithObjects:act_ans, act_dec, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];

        // Msg category
        UNTextInputNotificationAction *act_reply =
        [UNTextInputNotificationAction actionWithIdentifier:@"Reply"
                                                      title:NSLocalizedString(@"Reply", nil)
                                                    options:UNNotificationActionOptionNone];
        UNNotificationAction *act_seen =
        [UNNotificationAction actionWithIdentifier:@"Seen"
                                             title:NSLocalizedString(@"Mark as seen", nil)
                                           options:UNNotificationActionOptionNone];
        UNNotificationCategory *cat_msg =
        [UNNotificationCategory categoryWithIdentifier:@"msg_cat"
                                               actions:[NSArray arrayWithObjects:act_reply, act_seen, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];

        // Video Request Category
        UNNotificationAction *act_accept =
        [UNNotificationAction actionWithIdentifier:@"Accept"
                                             title:NSLocalizedString(@"Accept", nil)
                                           options:UNNotificationActionOptionForeground];

        UNNotificationAction *act_refuse = [UNNotificationAction actionWithIdentifier:@"Cancel"
                                                                                title:NSLocalizedString(@"Cancel", nil)
                                                                              options:UNNotificationActionOptionNone];
        UNNotificationCategory *video_call =
        [UNNotificationCategory categoryWithIdentifier:@"video_request"
                                               actions:[NSArray arrayWithObjects:act_accept, act_refuse, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];

        // ZRTP verification category
        UNNotificationAction *act_confirm = [UNNotificationAction actionWithIdentifier:@"Confirm"
                                                                                 title:NSLocalizedString(@"Accept", nil)
                                                                               options:UNNotificationActionOptionNone];

        UNNotificationAction *act_deny = [UNNotificationAction actionWithIdentifier:@"Deny"
                                                                              title:NSLocalizedString(@"Deny", nil)
                                                                            options:UNNotificationActionOptionNone];
        UNNotificationCategory *cat_zrtp =
        [UNNotificationCategory categoryWithIdentifier:@"zrtp_request"
                                               actions:[NSArray arrayWithObjects:act_confirm, act_deny, nil]
                                     intentIdentifiers:[[NSMutableArray alloc] init]
                                               options:UNNotificationCategoryOptionCustomDismissAction];
        [UNUserNotificationCenter currentNotificationCenter].delegate = self;
        [[UNUserNotificationCenter currentNotificationCenter]
         requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound |
                                          UNAuthorizationOptionBadge)
         completionHandler:^(BOOL granted, NSError *_Nullable error) {
             // Enable or disable features based on authorization.
             if (error) {
                 NSLog(@"%@", error.description);
             }
         }];
        NSSet *categories = [NSSet setWithObjects:cat_call, cat_msg, video_call, cat_zrtp, nil];
        [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:categories];
    }
}
*/


@end
