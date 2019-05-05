//
//  AppDelegate.h
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Toast.h"
#import "WebServices.h"
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

@interface AppDelegate : UIResponder <UIApplicationDelegate, WebServicesDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CSToastStyle *errorStyle;
@property (strong, nonatomic) CSToastStyle *warningStyle;
@property (strong, nonatomic) CSToastStyle *successStyle;

+(AppDelegate *) sharedInstance;
@property (nonatomic, strong) NSString *logFilePath;
@property (nonatomic, assign) float hStatusBar;

@property (nonatomic, strong) NSDictionary *userInfo;
@property (nonatomic, strong) WebServices *webService;

@property (nonatomic, assign) BOOL internetActive;
@property (strong, nonatomic) Reachability *internetReachable;

@end

