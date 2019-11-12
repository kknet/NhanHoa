//
//  EmailsViewController.h
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UIScrollView *scvMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnHosting;
@property (weak, nonatomic) IBOutlet UIButton *btnGoogle;
@property (weak, nonatomic) IBOutlet UIButton *btnMicrosoft;
@property (weak, nonatomic) IBOutlet UIButton *btnServer;
@property (weak, nonatomic) IBOutlet UILabel *lbMenu;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnHostingPress:(UIButton *)sender;
- (IBAction)btnGooglePress:(UIButton *)sender;
- (IBAction)btnMicrosoftPress:(UIButton *)sender;
- (IBAction)btnServerPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
