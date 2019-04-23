//
//  AppDelegate.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppDelegate.h"
#import "RegisterDomainViewController.h"
#import "RegisteredDomainViewController.h"
#import "MoreViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    RegisterDomainViewController *registerDomainVC = [[RegisterDomainViewController alloc] initWithNibName:@"RegisterDomainViewController" bundle:nil];
    UINavigationController *registerNav = [[UINavigationController alloc] initWithRootViewController:registerDomainVC];
    
    UIImage *image = [UIImage imageNamed:@"domain"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *registerItem = [[UITabBarItem alloc] initWithTitle:@"Đăng ký tên miền" image:image selectedImage:nil];
    
    registerNav.tabBarItem = registerItem;
    
    RegisteredDomainViewController *registeredDomainVC = [[RegisteredDomainViewController alloc] initWithNibName:@"RegisteredDomainViewController" bundle:nil];
    UINavigationController *registeredNav = [[UINavigationController alloc] initWithRootViewController:registeredDomainVC];
    
    UITabBarItem *registeredItem = [[UITabBarItem alloc] initWithTitle:@"Danh sách đăng ký" image:[UIImage imageNamed:@"domain"] selectedImage:nil];
    registeredNav.tabBarItem = registeredItem;
    
    
    MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController:moreVC];
    
    UITabBarItem *moreItem = [[UITabBarItem alloc] initWithTitle:@"Thêm" image:[UIImage imageNamed:@"domain"] tag:2];
    moreNav.tabBarItem = moreItem;
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[registerNav , registeredNav, moreNav];
    
    [self.window setRootViewController:tabBarController];
    [self.window makeKeyAndVisible];
    
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


@end
