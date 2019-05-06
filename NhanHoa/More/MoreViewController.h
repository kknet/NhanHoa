//
//  MoreViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountInfoView.h"

typedef enum{
    eSettingAccount,
    eContactInfo,
    eManagerDomainList,
    eCustomnerSupport,
    eApplicationInfo,
    eSignOut,
}eSettingMenu;

@interface MoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icSearch;
@property (weak, nonatomic) IBOutlet UIButton *icNotify;
@property (weak, nonatomic) IBOutlet UIButton *icClose;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

@property (nonatomic, strong) AccountInfoView *accInfoView;
@property (nonatomic, assign) float hAccount;
@property (nonatomic, assign) float padding;

- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)icNotifyClick:(UIButton *)sender;
- (IBAction)icSearchClick:(UIButton *)sender;

@end
