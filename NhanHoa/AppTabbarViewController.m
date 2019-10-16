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
#import "SearchDomainViewController.h"

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
    
    
    UIFont *itemFont = [UIFont fontWithName:@"HelveticaNeue" size:12.5];
    //  Tabbar home
    NewHomeViewController *homeVC = [[NewHomeViewController alloc] initWithNibName:@"NewHomeViewController" bundle:nil];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController: homeVC];
    
    UIImage *imgHome = [UIImage imageNamed:@"tabbar_home_def"];
    imgHome = [imgHome imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgHomeAct = [UIImage imageNamed:@"tabbar_home_act"];
    imgHomeAct = [imgHomeAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *homeItem = [[UITabBarItem alloc] initWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Home"] image:imgHome selectedImage:imgHomeAct];
    [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    homeNav.tabBarItem = homeItem;
    
    //  Tabbar Invoices
    InvoicesViewController *invoicesVC = [[InvoicesViewController alloc] initWithNibName:@"InvoicesViewController" bundle:nil];
    UINavigationController *invoicesNav = [[UINavigationController alloc] initWithRootViewController: invoicesVC];
    
    UIImage *imgInvoices = [UIImage imageNamed:@"tabbar_invoices_def"];
    imgInvoices = [imgInvoices imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgInvoicesAct = [UIImage imageNamed:@"tabbar_invoices_act"];
    imgInvoicesAct = [imgInvoicesAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *invoicesItem = [[UITabBarItem alloc] initWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Invoices"] image:imgInvoices selectedImage:imgInvoicesAct];
    [invoicesItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    invoicesNav.tabBarItem = invoicesItem;
    
    //  search domains
    SearchDomainViewController *searchDomainsVC = [[SearchDomainViewController alloc] initWithNibName:@"SearchDomainViewController" bundle:nil];
    UINavigationController *searchDomainsNav = [[UINavigationController alloc] initWithRootViewController: searchDomainsVC];
    
    UITabBarItem *searchItem = [[UITabBarItem alloc] initWithTitle:@"" image:nil selectedImage:nil];
    searchDomainsNav.tabBarItem = searchItem;
    
    //  notifications tabbar
    NotificationsViewController *notifVC = [[NotificationsViewController alloc] initWithNibName:@"NotificationsViewController" bundle:nil];
    UINavigationController *notifNav = [[UINavigationController alloc] initWithRootViewController: notifVC];
    
    
    UIImage *imgNotif = [UIImage imageNamed:@"tabbar_notif_def"];
    imgNotif = [imgNotif imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgNotifAct = [UIImage imageNamed:@"tabbar_notif_act"];
    imgNotifAct = [imgNotifAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *notifItem = [[UITabBarItem alloc] initWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Notifications"] image:imgNotif selectedImage:imgNotifAct];
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
    
    UITabBarItem *accItem = [[UITabBarItem alloc] initWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Account"] image:imgAcc selectedImage:imgAccAct];
    [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    moreNav.tabBarItem = accItem;
    
    //  tabBarController.viewControllers = @[homeNav, boNav , transHisNav, moreNav];
    tabBarController.viewControllers = @[homeNav, invoicesNav, searchDomainsNav, notifNav, moreNav];
    [self.view addSubview: tabBarController.view];
    
    UIView *lbTop = [[UILabel alloc] init];
    lbTop.backgroundColor = BORDER_COLOR;
    [tabBarController.view addSubview: lbTop];
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tabBarController.view);
        make.bottom.equalTo(tabBarController.view).offset(-tabBarController.tabBar.frame.size.height);
        make.height.mas_equalTo(1.0);
    }];
    
    if (!IS_IPHONE && !IS_IPOD) {
        UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        if(SYSTEM_VERSION_LESS_THAN(@"10.0")){
            [[UITabBar appearance] setItemWidth: 250];
            textFont = [UIFont fontWithName:RobotoRegular size:17.0];
        }
        
        [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
        [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
        
        [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
        [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
        
        [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
        [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
        
        //  [transHisItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], UITextAttributeTextColor, [NSValue valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName, [AppDelegate sharedInstance].fontRegular, UITextAttributeFont, nil] forState:UIControlStateNormal];
    }else{
        [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [homeItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        [invoicesItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [invoicesItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        
        [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    }
    
    //  size button
    float sizeIcon = self.tabBarController.tabBar.frame.size.height - 3.0;
    
    UIButton* btnSearch = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame = CGRectMake(0.0, 0.0, sizeIcon, sizeIcon);
    [btnSearch setImage:[UIImage imageNamed:@"search_domains"] forState:UIControlStateNormal];
    
    CGFloat heightDifference = sizeIcon - self.tabBarController.tabBar.frame.size.height;
    if (heightDifference < 0)
        btnSearch.center = self.tabBarController.tabBar.center;
    else
    {
        CGPoint center = self.tabBarController.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        btnSearch.center = center;
    }
    [self.tabBarController.view addSubview: btnSearch];
}

- (void)setupUIForView {
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:(58/255.0) green:(75/255.0) blue:(101/255.0) alpha:1.0];
    tabBarController.tabBar.barTintColor = UIColor.whiteColor;
    tabBarController.tabBar.backgroundColor = UIColor.whiteColor;
}


@end
