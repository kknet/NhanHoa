//
//  AppTabbarViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppTabbarViewController.h"
#import "HomeViewController.h"
#import "BOViewController.h"
#import "TransHistoryViewController.h"
#import "MoreViewController.h"

@interface AppTabbarViewController (){
    UIColor *actColor;
}

@end

@implementation AppTabbarViewController
@synthesize tabBarController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    actColor = [UIColor colorWithRed:(58/255.0) green:(75/255.0) blue:(101/255.0) alpha:1.0];
    
    tabBarController = [[UITabBarController alloc] init];
    
    // Do any additional setup after loading the view.
    [self setupUIForView];
    
    
    //  Tabbar home
    //  HelveticaNeue-Medium
    UIFont *itemFont = [UIFont fontWithName:@"HelveticaNeue" size:12.5];
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController: homeVC];
    
    UIImage *imgHome = [UIImage imageNamed:@"tabbar_home_def"];
    imgHome = [imgHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgHomeAct = [UIImage imageNamed:@"tabbar_home_act"];
    imgHomeAct = [imgHomeAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:@"Trang chủ" image:imgHome selectedImage:imgHomeAct];
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    homeNav.tabBarItem = homeItem;
    
    //  Tabbar BO
    BOViewController *boVC = [[BOViewController alloc] initWithNibName:@"BOViewController" bundle:nil];
    UINavigationController *boNav = [[UINavigationController alloc] initWithRootViewController: boVC];
    
    UIImage *imgBO = [UIImage imageNamed:@"tabbar_BO_def"];
    imgBO = [imgBO imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgBOAct = [UIImage imageNamed:@"tabbar_BO_act"];
    imgBOAct = [imgBOAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *boItem = [[UITabBarItem alloc] initWithTitle:@"Đấu giá" image:imgBO selectedImage:imgBOAct];
    [boItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    boNav.tabBarItem = boItem;
    
    //  Tabbar transaction history
    TransHistoryViewController *transHisVC = [[TransHistoryViewController alloc] initWithNibName:@"TransHistoryViewController" bundle:nil];
    UINavigationController *transHisNav = [[UINavigationController alloc] initWithRootViewController: transHisVC];
    
    UIImage *imgTransHis = [UIImage imageNamed:@"tabbar_history_def"];
    imgTransHis = [imgTransHis imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgTransHisAct = [UIImage imageNamed:@"tabbar_history_act"];
    imgTransHisAct = [imgTransHisAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *transHisItem = [[UITabBarItem alloc] initWithTitle:@"Lịch sử giao dịch" image:imgTransHis selectedImage:imgTransHisAct];
    [transHisItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    transHisNav.tabBarItem = transHisItem;
    
    //  Tabbar account
    MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController: moreVC];
    
    UIImage *imgAcc = [UIImage imageNamed:@"tabbar_acc_def"];
    imgAcc = [imgAcc imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgAccAct = [UIImage imageNamed:@"tabbar_acc_act"];
    imgAccAct = [imgAccAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *accItem = [[UITabBarItem alloc] initWithTitle:@"Tài khoản" image:imgAcc selectedImage:imgAccAct];
    [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    moreNav.tabBarItem = accItem;
    
    tabBarController.viewControllers = @[homeNav, boNav , transHisNav, moreNav];
    [self.view addSubview: tabBarController.view];
}

- (void)setupUIForView {
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:(58/255.0) green:(75/255.0) blue:(101/255.0) alpha:1.0];
    tabBarController.tabBar.barTintColor = UIColor.whiteColor;
    tabBarController.tabBar.backgroundColor = UIColor.whiteColor;
}

@end
