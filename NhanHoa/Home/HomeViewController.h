//
//  HomeViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icNotify;
@property (weak, nonatomic) IBOutlet UIButton *icClear;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIScrollView *scvBanner;

@property (weak, nonatomic) IBOutlet UIView *viewWallet;
@property (weak, nonatomic) IBOutlet UIView *viewMainWallet;
@property (weak, nonatomic) IBOutlet UIImageView *imgMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;

@property (weak, nonatomic) IBOutlet UIView *viewRewards;
@property (weak, nonatomic) IBOutlet UIImageView *imgRewards;
@property (weak, nonatomic) IBOutlet UILabel *lbRewards;
@property (weak, nonatomic) IBOutlet UILabel *lbRewardsPoints;

@property (weak, nonatomic) IBOutlet UICollectionView *clvMenu;

- (IBAction)icNotifyClick:(UIButton *)sender;
- (IBAction)icClearClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@property (nonatomic, assign) float hMenu;

@end
