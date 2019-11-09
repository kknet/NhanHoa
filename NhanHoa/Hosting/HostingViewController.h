//
//  HostingViewController.h
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UIScrollView *scvMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnWindowsHosting;
@property (weak, nonatomic) IBOutlet UIButton *btnLinuxHosting;
@property (weak, nonatomic) IBOutlet UIButton *btnWordpressHosting;
@property (weak, nonatomic) IBOutlet UILabel *lbMenu;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnWindowsHostingPress:(UIButton *)sender;
- (IBAction)btnLinuxHostingPress:(UIButton *)sender;
- (IBAction)btnWordpressHostingPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
