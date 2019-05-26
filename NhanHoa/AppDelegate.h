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

typedef enum TypeHomeMenu{
    eRegisterDomain,
    eRenewDomain,
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
@property (nonatomic, strong) NSString *logFilePath;
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

@end

