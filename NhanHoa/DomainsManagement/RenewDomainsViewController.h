//
//  RenewDomainsViewController.h
//  NhanHoa
//
//  Created by OS on 11/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RenewDomainsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UITableView *tfInfo;

@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalValue;
@property (weak, nonatomic) IBOutlet UILabel *lbVAT;
@property (weak, nonatomic) IBOutlet UILabel *lbVATValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPayment;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPaymentValue;
@property (weak, nonatomic) IBOutlet UIButton *btnRenew;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnRenewPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
