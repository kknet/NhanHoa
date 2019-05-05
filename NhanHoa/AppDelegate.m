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

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize errorStyle, warningStyle, successStyle;
@synthesize hStatusBar, logFilePath, userInfo, webService, internetReachable, internetActive;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  hide title of back bar title
    
    NSString *subDirectory = [NSString stringWithFormat:@"%@/%@.txt", logsFolderName, [AppUtils getCurrentDate]];
    logFilePath = [WriteLogsUtils makeFilePathWithFileName: subDirectory];
    
    //  custom tabbar & navigation bar
    hStatusBar = application.statusBarFrame.size.height;
    
    NSDictionary *titleInfo = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoItalic size:0.1], NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateNormal];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateHighlighted];
    
    UINavigationBar.appearance.barTintColor = NAV_COLOR;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.translucent = NO;
    
    UINavigationBar.appearance.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:16.0], NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    
    //  setup message style
    warningStyle = [[CSToastStyle alloc] initWithDefaultStyle];
    warningStyle.backgroundColor = [UIColor colorWithRed:(254/255.0) green:(196/255.0) blue:(46/255.0) alpha:1.0];
    warningStyle.messageColor = UIColor.whiteColor;
    warningStyle.messageFont = [UIFont fontWithName:RobotoRegular size:15.0];
    warningStyle.cornerRadius = 20.0;
    warningStyle.messageAlignment = NSTextAlignmentCenter;
    warningStyle.messageNumberOfLines = 5;
    warningStyle.shadowColor = UIColor.blackColor;
    warningStyle.shadowOpacity = 1.0;
    warningStyle.shadowOffset = CGSizeMake(-5, -5);
    
    errorStyle = [[CSToastStyle alloc] initWithDefaultStyle];
    errorStyle.backgroundColor = [UIColor colorWithRed:(211/255.0) green:(55/255.0) blue:(55/255.0) alpha:1.0];
    errorStyle.messageColor = UIColor.whiteColor;
    errorStyle.messageFont = [UIFont fontWithName:RobotoRegular size:15.0];
    errorStyle.cornerRadius = 20.0;
    errorStyle.messageAlignment = NSTextAlignmentCenter;
    errorStyle.messageNumberOfLines = 5;
    errorStyle.shadowColor = UIColor.blackColor;
    errorStyle.shadowOpacity = 1.0;
    errorStyle.shadowOffset = CGSizeMake(-5, -5);
    
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
        webService = [[WebServices alloc] init];
        webService.delegate = self;
        
        if (![AppUtils isNullOrEmpty: USERNAME] && ![AppUtils isNullOrEmpty:PASSWORD]) {
            NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
            [jsonDict setObject:login_mod forKey:@"mod"];
            [jsonDict setObject:USERNAME forKey:@"username"];
            [jsonDict setObject:PASSWORD forKey:@"password"];
            [webService callWebServiceWithLink:login_func withParams:jsonDict];
            
            AppTabbarViewController *tabbarVC = [[AppTabbarViewController alloc] init];
            [self.window setRootViewController:tabbarVC];
            [self.window makeKeyAndVisible];
        }else{
            [self showStartLoginView];
        }
    }
    // Override point for customization after application launch.
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

#pragma mark - Webserviec
-(void)failedToCallWebService:(NSString *)link andError:(id)error {
    
}

-(void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    if ([link isEqualToString:login_func]) {
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            userInfo = [[NSDictionary alloc] initWithDictionary: data];
        }
    }
}

-(void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if ([link isEqualToString: login_func]) {
        if (responeCode != 200) {
            [self showStartLoginView];
            [self.window makeToast:@"Thông tin đăng nhập không chính xác!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }
}

@end
