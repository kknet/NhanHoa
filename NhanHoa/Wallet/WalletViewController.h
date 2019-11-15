//
//  WalletViewController.h
//  NhanHoa
//
//  Created by OS on 10/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TypeWalletMenu{
    eMainWalletMenu,
    eBonusWalletMenu,
}TypeWalletMenu;

NS_ASSUME_NONNULL_BEGIN

@interface WalletViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UIImageView *bgWallet;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIButton *btnMainWallet;
@property (weak, nonatomic) IBOutlet UIButton *btnBonusWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbBalance;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbCurrency;

@property (weak, nonatomic) IBOutlet UITableView *tbHistory;

@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UIButton *btnTopUp;

@property (nonatomic, assign) TypeWalletMenu curMenu;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnMainWalletPress:(UIButton *)sender;
- (IBAction)btnBonusWalletPress:(UIButton *)sender;
- (IBAction)btnTopUpPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
