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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  hide title of back bar title
    
    //  custom tabbar & navigation bar
    NSDictionary *titleInfo = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoItalic size:0.1], NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateNormal];
    [UIBarButtonItem.appearance setTitleTextAttributes:titleInfo forState:UIControlStateHighlighted];
    
    UINavigationBar.appearance.barTintColor = NAV_COLOR;
    UINavigationBar.appearance.tintColor = UIColor.whiteColor;
    UINavigationBar.appearance.translucent = NO;
    
    UINavigationBar.appearance.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:16.0], NSFontAttributeName, UIColor.whiteColor, NSForegroundColorAttributeName, nil];
    
    //  setup message style
    warningStyle = [[CSToastStyle alloc] initWithDefaultStyle];
    warningStyle.backgroundColor = ORANGE_COLOR;
    warningStyle.messageColor = UIColor.whiteColor;
    warningStyle.messageFont = [UIFont fontWithName:RobotoRegular size:15.0];
    warningStyle.cornerRadius = 20.0;
    warningStyle.messageAlignment = NSTextAlignmentCenter;
    warningStyle.messageNumberOfLines = 5;
    warningStyle.shadowColor = UIColor.blackColor;
    warningStyle.shadowOpacity = 1.0;
    warningStyle.shadowOffset = CGSizeMake(-5, -5);
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageNamed:@"fondoTabBar"]];
    [UITabBar appearance].layer.borderWidth = 0.0f;
    [UITabBar appearance].clipsToBounds = true;
    
    NSString *loginState = [[NSUserDefaults standardUserDefaults] objectForKey:@"login_state"];
    if (loginState == nil || [loginState isEqualToString:@"NO"]) {
        LaunchViewController *launchVC = [[LaunchViewController alloc] initWithNibName:@"LaunchViewController" bundle:nil];
        UINavigationController *launchNav = [[UINavigationController alloc] initWithRootViewController:launchVC];
        
        [self.window setRootViewController:launchNav];
        [self.window makeKeyAndVisible];
        
    }else{
        AppTabbarViewController *tabbarVC = [[AppTabbarViewController alloc] init];
        [self.window setRootViewController:tabbarVC];
        [self.window makeKeyAndVisible];
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

@end
