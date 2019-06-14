//
//  AppDelegate.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppDelegate.h"
#import "AppTabbarViewController.h"
#import "LaunchViewController.h"
#import "SignInViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import "CartModel.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize errorStyle, warningStyle, successStyle;
@synthesize hStatusBar, hNav, logFilePath, userInfo, internetReachable, internetActive, listCity, listNumber;
@synthesize fontBold, fontMedium, fontRegular, fontItalic, fontThin, fontDesc, hTextfield, radius, fontBTN;
@synthesize needReloadListProfile, needReloadListDomains, profileEdit, editCMND_a, editCMND_b, editBanKhai, domainsPrice, registerAccSuccess, registerAccount;
@synthesize cropAvatar, dataCrop, token, hashKey;
@synthesize cartWindow, cartViewController, cartNavViewController, listBank, cartView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  hide title of back bar title
    
    [self setupFontForApp];
    
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
    [AppUtils createDirectoryAndSubDirectory:logsFolderName];
    [AppUtils createDirectoryAndSubDirectory:@"avatars"];
    
    NSString *subDirectory = [NSString stringWithFormat:@"%@/%@.txt", logsFolderName, [AppUtils getCurrentDate]];
    logFilePath = [WriteLogsUtils makeFilePathWithFileName: subDirectory];
    
    //  custom tabbar & navigation bar
    hStatusBar = application.statusBarFrame.size.height;
    
    [self enableSizeForBarButtonItem: FALSE];
    
    UINavigationBar.appearance.barTintColor = NAV_COLOR;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.translucent = NO;
    
    UINavigationBar.appearance.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:18.0], NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    
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
        SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
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
    
    if (self.cartViewController == nil) {
        self.cartViewController = [[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
        self.cartNavViewController = [[UINavigationController alloc] initWithRootViewController:self.cartViewController];
        self.cartNavViewController.navigationBarHidden = YES;
    }
    cartWindow.rootViewController = cartNavViewController;
    cartWindow.alpha = 0;
    
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSCharacterSet *removestring = [NSCharacterSet characterSetWithCharactersInString:@"<> "];
    token = [[[NSString stringWithFormat:@"%@", deviceToken] componentsSeparatedByCharactersInSet: removestring] componentsJoinedByString: @""];
    
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"GETTED TOKEN FOR APP: %@", token] toFilePath:logFilePath];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@">>>>>ERROR<<<<< CAN NOT GET TOKEN FOR APP: %@", error.localizedDescription] toFilePath:logFilePath];
}

+(AppDelegate *)sharedInstance{
    return ((AppDelegate*) [[UIApplication sharedApplication] delegate]);
}

- (void)showStartLoginView {
    LaunchViewController *launchVC = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
    UINavigationController *launchNav = [[UINavigationController alloc] initWithRootViewController:launchVC];
    
    [self.window setRootViewController:launchNav];
    [self.window makeKeyAndVisible];
}

- (void)checkNetworkStatus:(NSNotification *)notice
{
    // called after network status changes
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"\n[%s] Network status is %d", __FUNCTION__, internetStatus] toFilePath: logFilePath];
    
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
    
    NSString *deviceMode = [AppUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        //  Screen width: 320.000000 - Screen height: 667.000000
        fontBold = [UIFont fontWithName:RobotoBold size:16.0];
        fontMedium = [UIFont fontWithName:RobotoMedium size:16.0];
        fontRegular = [UIFont fontWithName:RobotoRegular size:16.0];
        fontDesc = [UIFont fontWithName:RobotoRegular size:14.0];
        fontBTN = [UIFont fontWithName:RobotoRegular size:18.0];
        fontItalic = [UIFont fontWithName:RobotoItalic size:16.0];
        
        hTextfield = 38.0;
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2] || [deviceMode isEqualToString: simulator])
    {
        //  Screen width: 375.000000 - Screen height: 667.000000
        fontBold = [UIFont fontWithName:RobotoBold size:16.0];
        fontMedium = [UIFont fontWithName:RobotoMedium size:16.0];
        fontRegular = [UIFont fontWithName:RobotoRegular size:16.0];
        fontDesc = [UIFont fontWithName:RobotoRegular size:14.0];
        fontBTN = [UIFont fontWithName:RobotoRegular size:18.0];
        fontItalic = [UIFont fontWithName:RobotoItalic size:16.0];
        
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
        
        hTextfield = 40.0;
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2]){
        //  Screen width: 375.000000 - Screen height: 812.000000
        fontBold = [UIFont fontWithName:RobotoBold size:18.0];
        fontMedium = [UIFont fontWithName:RobotoMedium size:18.0];
        fontRegular = [UIFont fontWithName:RobotoRegular size:18.0];
        fontDesc = [UIFont fontWithName:RobotoRegular size:16.0];
        fontBTN = [UIFont fontWithName:RobotoRegular size:20.0];
        fontItalic = [UIFont fontWithName:RobotoItalic size:18.0];
        
        hTextfield = 40.0;
        
    }else{
        fontBold = [UIFont fontWithName:RobotoRegular size:16.0];
        fontMedium = [UIFont fontWithName:RobotoMedium size:16.0];
        fontRegular = [UIFont fontWithName:RobotoRegular size:16.0];
        fontDesc = [UIFont fontWithName:RobotoRegular size:14.0];
        fontBTN = [UIFont fontWithName:RobotoRegular size:18.0];
        fontItalic = [UIFont fontWithName:RobotoItalic size:16.0];
        
        hTextfield = 38.0;
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
    
    cartWindow.rootViewController = cartNavViewController;
    cartWindow.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.cartWindow.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.cartWindow.alpha = 1;
        [self.cartWindow makeKeyAndVisible];
    }completion:^(BOOL finished) {
        
    }];
    
    //  SF(@"iOS_%@_%@",bundleIdentifier,version)
}

- (void)hideCartView {
    
    if( [self.cartWindow isKeyWindow] ) {
        [UIView animateWithDuration:0.2 animations:^{
            self.cartWindow.alpha = 0;
        } completion:^(BOOL finished) {
            if (self.cartViewController != nil) {
                [self.cartViewController.view removeFromSuperview];
                self.cartViewController = nil;
            }
            
            if (self.cartNavViewController != nil) {
                [self.cartNavViewController.view removeFromSuperview];
                self.cartNavViewController = nil;
            }
            [self.cartWindow removeFromSuperview];
        }];
    }
}

@end
