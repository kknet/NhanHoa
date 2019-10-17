//
//  AppTabbarViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppTabbarViewController.h"
#import "NewHomeViewController.h"
#import "InvoicesViewController.h"
#import "NotificationsViewController.h"
#import "WhoIsViewController.h"

#import "HomeViewController.h"
#import "BOViewController.h"
#import "TransHistoryViewController.h"
#import "MoreViewController.h"

@interface AppTabbarViewController (){
    AppDelegate *appDelegate;
    UIColor *actColor;
}

@end

@implementation AppTabbarViewController
@synthesize tabBarController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    actColor = [UIColor colorWithRed:(58/255.0) green:(75/255.0) blue:(101/255.0) alpha:1.0];
    
    tabBarController = [[UITabBarController alloc] init];
    
    // Do any additional setup after loading the view.
    [self setupUIForView];
    
    
    UIFont *itemFont = [UIFont fontWithName:@"HelveticaNeue" size:12.5];
    //  Tabbar home
    NewHomeViewController *homeVC = [[NewHomeViewController alloc] initWithNibName:@"NewHomeViewController" bundle:nil];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController: homeVC];
    
    UIImage *imgHome = [UIImage imageNamed:@"tabbar_home_def"];
    imgHome = [imgHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgHomeAct = [UIImage imageNamed:@"tabbar_home_act"];
    imgHomeAct = [imgHomeAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Home"] image:imgHome selectedImage:imgHomeAct];
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    homeNav.tabBarItem = homeItem;
    
    //  Tabbar Invoices
    InvoicesViewController *invoicesVC = [[InvoicesViewController alloc] initWithNibName:@"InvoicesViewController" bundle:nil];
    UINavigationController *invoicesNav = [[UINavigationController alloc] initWithRootViewController: invoicesVC];
    
    UIImage *imgInvoices = [UIImage imageNamed:@"tabbar_invoices_def"];
    imgInvoices = [imgInvoices imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgInvoicesAct = [UIImage imageNamed:@"tabbar_invoices_act"];
    imgInvoicesAct = [imgInvoicesAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *invoicesItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Invoices"] image:imgInvoices selectedImage:imgInvoicesAct];
    [invoicesItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    invoicesNav.tabBarItem = invoicesItem;
    
    //  search domains
    WhoIsViewController *whoIsVC = [[WhoIsViewController alloc] initWithNibName:@"WhoIsViewController" bundle:nil];
    UINavigationController *whoIsNav = [[UINavigationController alloc] initWithRootViewController: whoIsVC];
    
    UITabBarItem *whoisItem = [[UITabBarItem alloc] initWithTitle:@"" image:nil selectedImage:nil];
    whoIsNav.tabBarItem = whoisItem;
    
    //  notifications tabbar
    NotificationsViewController *notifVC = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    UINavigationController *notifNav = [[UINavigationController alloc] initWithRootViewController: notifVC];
    
    
    UIImage *imgNotif = [UIImage imageNamed:@"tabbar_notif_def"];
    imgNotif = [imgNotif imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgNotifAct = [UIImage imageNamed:@"tabbar_notif_act"];
    imgNotifAct = [imgNotifAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *notifItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Notifications"] image:imgNotif selectedImage:imgNotifAct];
    [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    notifNav.tabBarItem = notifItem;
    
    //  Tabbar transaction history
    /*
    TransHistoryViewController *transHisVC = [[TransHistoryViewController alloc] initWithNibName:@"TransHistoryViewController" bundle:nil];
    UINavigationController *transHisNav = [[UINavigationController alloc] initWithRootViewController: transHisVC];
    
    
    UIImage *imgTransHis = [UIImage imageNamed:@"tabbar_history_def"];
    imgTransHis = [imgTransHis imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgTransHisAct = [UIImage imageNamed:@"tabbar_history_act"];
    imgTransHisAct = [imgTransHisAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *transHisItem = [[UITabBarItem alloc] initWithTitle:text_trans_history image:imgTransHis selectedImage:imgTransHisAct];
    [transHisItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    transHisNav.tabBarItem = transHisItem;
    */
    
    //  Tabbar account
    MoreViewController *moreVC = [[MoreViewController alloc] initWithNibName:@"MoreViewController" bundle:nil];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController: moreVC];
    
    UIImage *imgAcc = [UIImage imageNamed:@"tabbar_acc_def"];
    imgAcc = [imgAcc imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgAccAct = [UIImage imageNamed:@"tabbar_acc_act"];
    imgAccAct = [imgAccAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *accItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Account"] image:imgAcc selectedImage:imgAccAct];
    [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    moreNav.tabBarItem = accItem;
    
    //  tabBarController.viewControllers = @[homeNav, boNav , transHisNav, moreNav];
    tabBarController.viewControllers = @[homeNav, invoicesNav, whoIsNav, notifNav, moreNav];
    [self.view addSubview: tabBarController.view];
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:16.0];
    if (IS_IPHONE || IS_IPOD) {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            textFont = [UIFont fontWithName:RobotoRegular size:13.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
            textFont = [UIFont fontWithName:RobotoRegular size:14.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
            textFont = [UIFont fontWithName:RobotoRegular size:15.0];
        }
    }
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [invoicesItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    [invoicesItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
    
    //  size button
    float sizeIcon;
    if (appDelegate.safeAreaBottomPadding > 0) {
        sizeIcon = self.tabBarController.tabBar.frame.size.height;
    }else{
        sizeIcon = self.tabBarController.tabBar.frame.size.height - 3.0;
    }
    
    appDelegate.btnSearchBar = [UIButton buttonWithType:UIButtonTypeCustom];
    appDelegate.btnSearchBar.frame = CGRectMake(0.0, -appDelegate.safeAreaBottomPadding, sizeIcon, sizeIcon);
    [appDelegate.btnSearchBar setImage:[UIImage imageNamed:@"search_domains_100"] forState:UIControlStateNormal];
    appDelegate.btnSearchBar.alpha = 0;
    
    if (appDelegate.safeAreaBottomPadding > 0) {
        appDelegate.btnSearchBar.center = CGPointMake(self.tabBarController.tabBar.center.x, self.tabBarController.tabBar.center.y-appDelegate.safeAreaBottomPadding + 5.0);
    }else{
        appDelegate.btnSearchBar.center = CGPointMake(self.tabBarController.tabBar.center.x, self.tabBarController.tabBar.center.y);
    }
    [appDelegate.window addSubview: appDelegate.btnSearchBar];
    [appDelegate.btnSearchBar addTarget:self
                                 action:@selector(onButtonSearchTabbarPress)
                       forControlEvents:UIControlEventTouchUpInside];
    
    appDelegate.lbTopTabbar = [[UILabel alloc] init];
    appDelegate.lbTopTabbar.backgroundColor = BORDER_COLOR;
    [appDelegate.window addSubview: appDelegate.lbTopTabbar];
    appDelegate.lbTopTabbar.alpha = 0;
    [appDelegate.lbTopTabbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(appDelegate.window); make.bottom.equalTo(appDelegate.window).offset(-tabBarController.tabBar.frame.size.height-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setupUIForView {
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:(58/255.0) green:(75/255.0) blue:(101/255.0) alpha:1.0];
    tabBarController.tabBar.barTintColor = UIColor.whiteColor;
    tabBarController.tabBar.backgroundColor = UIColor.whiteColor;
}

- (void)onButtonSearchTabbarPress {
    [tabBarController setSelectedIndex: 2];
    NSLog(@"onButtonSearchTabbarPress");
}

@end
