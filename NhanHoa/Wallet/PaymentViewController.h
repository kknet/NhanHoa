//
//  PaymentViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnepayPaymentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

@property (nonatomic, assign) long money;
@property (nonatomic, assign) PaymentMethod typePaymentMethod;
@property (nonatomic, strong) OnepayPaymentView *paymentView;
- (IBAction)btnContinuePress:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
