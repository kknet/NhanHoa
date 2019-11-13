//
//  SSLViewController.h
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UIScrollView *scvMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnComodoSSL;
@property (weak, nonatomic) IBOutlet UIButton *btnGeotrustSSL;
@property (weak, nonatomic) IBOutlet UIButton *btnSymantecSSL;
@property (weak, nonatomic) IBOutlet UILabel *lbMenu;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnComodoSSLPress:(UIButton *)sender;
- (IBAction)btnGeotrustSSLPress:(UIButton *)sender;
- (IBAction)btnSymantectPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
