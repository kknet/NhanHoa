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
}TypeHomeMenu;

typedef enum PaymentMethod{
    ePaymentWithATM,
    ePaymentWithVisaMaster,
}PaymentMethod;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

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
@property (nonatomic, strong) UIFont *fontBTN;
@property (nonatomic, assign) float hTextfield;
@property (nonatomic, assign) float radius;
@property (nonatomic, assign) float registerAccSuccess;
@property (nonatomic, strong) NSString *registerAccount;

@property (nonatomic, assign) BOOL needReloadListProfile;
@property (nonatomic, assign) BOOL needReloadListDomains;

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

- (void)updateShoppingCartCount;
- (void)showCartScreenContent;
- (void)hideCartView;
- (void)showLoginView;

@property (nonatomic, strong) ShoppingCartView *cartView;

@property (nonatomic, strong) NSMutableDictionary *errorMsgDict;
@property (nonatomic, strong) NSMutableArray *listPricingVN;
@property (nonatomic, strong) NSMutableArray *listPricingQT;

@property (nonatomic, assign) BOOL dontNeedLogin;

@property(strong, nonatomic) UIWindow *loginWindow;
@property(strong, nonatomic) LaunchViewController *launchVC;

@end

