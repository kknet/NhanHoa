//
//  BankAccountViewController.h
//  NhanHoa
//
//  Created by OS on 11/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgBank;
@property (weak, nonatomic) IBOutlet UILabel *lbBankName;
@property (weak, nonatomic) IBOutlet UILabel *lbAccountName;
@property (weak, nonatomic) IBOutlet UILabel *lbAccountNo;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnUpdatePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
