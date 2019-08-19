//
//  MoreViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    eSettingAccount,
    eManagerDomainList,
    eCustomnerSupport,
    eBankInfo,
    eApplicationInfo,
    eSignOut,
}eSettingMenu;

@interface MoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@end
