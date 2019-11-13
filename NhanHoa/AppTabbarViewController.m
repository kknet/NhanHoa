//
//  AppTabbarViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AppTabbarViewController.h"
#import "NewHomeViewController.h"
#import "OrdersListViewController.h"
#import "NotificationsViewController.h"
#import "SearchDomainsViewController.h"
#import "NewMoreViewController.h"
#import "HomeViewController.h"
#import "BOViewController.h"
#import "FLAnimatedImage.h"

@interface AppTabbarViewController (){
    AppDelegate *appDelegate;
    UIColor *actColor;
    
    UIButton *btnCall;
    float sizeCall;
    CALayer *topBorder;
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
    OrdersListViewController *ordersVC = [[OrdersListViewController alloc] initWithNibName:@"OrdersListViewController" bundle:nil];
    UINavigationController *ordersNav = [[UINavigationController alloc] initWithRootViewController: ordersVC];
    
    UIImage *imgOrders = [UIImage imageNamed:@"tabbar_invoices_def"];
    imgOrders = [imgOrders imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgOrdersAct = [UIImage imageNamed:@"tabbar_invoices_act"];
    imgOrdersAct = [imgOrdersAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *ordersItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Orders"] image:imgOrders selectedImage:imgOrdersAct];
    [ordersItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    ordersNav.tabBarItem = ordersItem;
    
    //  search domains
    SearchDomainsViewController *searchDomainsVC = [[SearchDomainsViewController alloc] initWithNibName:@"SearchDomainsViewController" bundle:nil];
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
    
    UITabBarItem *notifItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Notifications"] image:imgNotif selectedImage:imgNotifAct];
    [notifItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    notifNav.tabBarItem = notifItem;
    
    //  Tabbar account
    NewMoreViewController *moreVC = [[NewMoreViewController alloc] initWithNibName:@"NewMoreViewController" bundle:nil];
    UINavigationController *moreNav = [[UINavigationController alloc] initWithRootViewController: moreVC];
    
    UIImage *imgAcc = [UIImage imageNamed:@"tabbar_acc_def"];
    imgAcc = [imgAcc imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *imgAccAct = [UIImage imageNamed:@"tabbar_acc_act"];
    imgAccAct = [imgAccAct imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *accItem = [[UITabBarItem alloc] initWithTitle:[appDelegate.localization localizedStringForKey:@"Account"] image:imgAcc selectedImage:imgAccAct];
    [accItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: itemFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    moreNav.tabBarItem = accItem;
    
    //  tabBarController.viewControllers = @[homeNav, boNav , transHisNav, moreNav];
    tabBarController.viewControllers = @[homeNav, ordersNav, searchDomainsNav, notifNav, moreNav];
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
    
    [ordersItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: TITLE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateNormal];
    [ordersItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: BLUE_COLOR, NSForegroundColorAttributeName, textFont, NSFontAttributeName, nil] forState:UIControlStateSelected];
    
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
    
//    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"search" ofType: @"gif"];
//    NSData *data = [NSData dataWithContentsOfFile: filePath];
//
//    //  FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://api.websudo.xyz/fruits-apple.gif"]]];
//    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
//    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
//    imageView.animatedImage = image;
//    imageView.frame = CGRectMake(0.0, -appDelegate.safeAreaBottomPadding, sizeIcon, sizeIcon);
//    imageView.backgroundColor = BLUE_COLOR;
//    imageView.clipsToBounds = TRUE;
//    imageView.layer.cornerRadius = sizeIcon/2;
//    //  imageView.frame = CGRectMake(0.0, 0.0, 100.0, 100.0);
//    [appDelegate.window addSubview:imageView];
//    if (appDelegate.safeAreaBottomPadding > 0) {
//        imageView.center = CGPointMake(self.tabBarController.tabBar.center.x, self.tabBarController.tabBar.center.y-appDelegate.safeAreaBottomPadding + 5.0);
//    }else{
//        imageView.center = CGPointMake(self.tabBarController.tabBar.center.x, self.tabBarController.tabBar.center.y);
//    }
    
    topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 1.0f);
    topBorder.backgroundColor = BORDER_COLOR.CGColor;
    [self.tabBarController.tabBar.layer addSublayer:topBorder];
    
    [self setupMiddleButton];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

- (void)setupMiddleButton
{
    /*
    float sizeIcon = self.tabBarController.tabBar.frame.size.height;
    
    appDelegate.btnSearchBar = [UIButton buttonWithType:UIButtonTypeCustom];
    appDelegate.btnSearchBar.frame = CGRectMake(0.0, -appDelegate.safeAreaBottomPadding, sizeIcon, sizeIcon);
    [appDelegate.btnSearchBar setImage:[UIImage imageNamed:@"search_www"] forState:UIControlStateNormal];
    appDelegate.btnSearchBar.alpha = 0;
    appDelegate.btnSearchBar.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    appDelegate.btnSearchBar.backgroundColor = [UIColor colorWithRed:(21/255.0) green:(101/255.0) blue:(212/255.0) alpha:1.0];
    appDelegate.btnSearchBar.layer.borderColor = [UIColor colorWithRed:(6/255.0) green:(89/255.0) blue:(203/255.0) alpha:1.0].CGColor;
    appDelegate.btnSearchBar.layer.borderWidth = 3.0;
    appDelegate.btnSearchBar.layer.cornerRadius = sizeIcon/2;
    [self.view addSubview: appDelegate.btnSearchBar];
    
    if (appDelegate.safeAreaBottomPadding > 0) {
        appDelegate.btnSearchBar.center = CGPointMake(self.tabBarController.tabBar.center.x, self.tabBarController.tabBar.center.y-appDelegate.safeAreaBottomPadding + 5.0);
    }else{
        appDelegate.btnSearchBar.center = CGPointMake(self.tabBarController.tabBar.center.x, self.tabBarController.tabBar.center.y);
    }
    [self.view addSubview: appDelegate.btnSearchBar];
    [appDelegate.btnSearchBar addTarget:self
                                 action:@selector(onButtonSearchTabbarPress)
                       forControlEvents:UIControlEventTouchUpInside];
    */
    
    appDelegate.btnSearchBar = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];

    CGRect menuButtonFrame = appDelegate.btnSearchBar.frame;
    menuButtonFrame.origin.y = self.view.bounds.size.height - menuButtonFrame.size.height - appDelegate.safeAreaBottomPadding;
    menuButtonFrame.origin.x = self.view.bounds.size.width/2 - menuButtonFrame.size.width/2;
    appDelegate.btnSearchBar.frame = menuButtonFrame;
    
    appDelegate.btnSearchBar.backgroundColor = [UIColor colorWithRed:(21/255.0) green:(101/255.0) blue:(212/255.0) alpha:1.0];
    appDelegate.btnSearchBar.layer.borderColor = [UIColor colorWithRed:(6/255.0) green:(89/255.0) blue:(203/255.0) alpha:1.0].CGColor;
    appDelegate.btnSearchBar.layer.borderWidth = 3.0;
    appDelegate.btnSearchBar.layer.cornerRadius = menuButtonFrame.size.height/2;
    [self.view addSubview: appDelegate.btnSearchBar];

    appDelegate.btnSearchBar.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    [appDelegate.btnSearchBar setImage:[UIImage imageNamed:@"search_www"] forState:UIControlStateNormal];
    [appDelegate.btnSearchBar addTarget:self
                                 action:@selector(onButtonSearchTabbarPress)
                       forControlEvents:UIControlEventTouchUpInside];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    
    [topBorder removeFromSuperlayer];
    
    topBorder = [CALayer layer];
    topBorder.backgroundColor = BORDER_COLOR.CGColor;
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait || [UIDevice currentDevice].orientation == UIDeviceOrientationPortraitUpsideDown) {
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            topBorder.frame = CGRectMake(0.0f, 0.0f, SCREEN_HEIGHT, 1.0f);
        }else{
            topBorder.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 1.0f);
        }
    }else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        if (SCREEN_WIDTH > SCREEN_HEIGHT) {
            topBorder.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 1.0f);
        }else{
            topBorder.frame = CGRectMake(0.0f, 0.0f, SCREEN_HEIGHT, 1.0f);
        }
    }
    [self.tabBarController.tabBar.layer addSublayer:topBorder];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    tabBarController.navigationController.navigationBarHidden = TRUE;
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
//    float hTabbar = tabBarController.tabBar.frame.size.height;
//    sizeCall = 70.0;
//
//    btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnCall setImage:[UIImage imageNamed:@"ic_call"] forState:UIControlStateNormal];
//    [appDelegate.window addSubview: btnCall];
//    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(appDelegate.window).offset(-15.0);
//        make.bottom.equalTo(appDelegate.window).offset(-15.0-hTabbar);
//        make.width.height.mas_equalTo(sizeCall);
//    }];
//
//
//    UIPanGestureRecognizer* pgr = [[UIPanGestureRecognizer alloc]
//                                   initWithTarget:self
//                                   action:@selector(handlePan:)];
//    [btnCall addGestureRecognizer:pgr];
}

-(void)handlePan:(UIPanGestureRecognizer*)pgr;
{
    if (pgr.state == UIGestureRecognizerStateChanged) {
        CGPoint center = pgr.view.center;
        CGPoint translation = [pgr translationInView:pgr.view];
        center = CGPointMake(center.x + translation.x,
                             center.y + translation.y);
        if (center.x < sizeCall/2) {
            center.x = sizeCall/2;
        }else if (center.x > SCREEN_WIDTH - sizeCall/2) {
            center.x = SCREEN_WIDTH - sizeCall/2;
        }
        
        if (center.y < [UIApplication sharedApplication].statusBarFrame.size.height + sizeCall/2) {
            center.y = sizeCall/2;
            
        }else if (center.y > SCREEN_HEIGHT - sizeCall/2) {
            center.y = SCREEN_HEIGHT - tabBarController.tabBar.frame.size.height - sizeCall/2;
        }
        
        pgr.view.center = center;
        [pgr setTranslation:CGPointZero inView:pgr.view];
    }
}

- (void)setupUIForView {
    tabBarController.tabBar.tintColor = [UIColor colorWithRed:(58/255.0) green:(75/255.0) blue:(101/255.0) alpha:1.0];
    tabBarController.tabBar.barTintColor = UIColor.whiteColor;
    tabBarController.tabBar.backgroundColor = UIColor.whiteColor;
}

- (void)onButtonSearchTabbarPress {
    UIViewController *selectedVC = tabBarController.selectedViewController;
    
    SearchDomainsViewController *searchVC = [[SearchDomainsViewController alloc] initWithNibName:@"SearchDomainsViewController" bundle:nil];
    if ([selectedVC isKindOfClass:[UINavigationController class]]) {
        searchVC.hidesBottomBarWhenPushed = TRUE;
        [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
        [(UINavigationController *)selectedVC pushViewController:searchVC animated:FALSE];
    }
    
    //  [tabBarController setSelectedIndex: 2];
}

@end
