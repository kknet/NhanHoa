//
//  ShoppingCartViewController.h
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewEmpty;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmpty;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIButton *icViewTopBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTopTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIView *viewPrices;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbVAT;
@property (weak, nonatomic) IBOutlet UILabel *lbVATMoney;

@property (weak, nonatomic) IBOutlet UIView *viewFooter;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPayment;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPaymentMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnProceedToRegister;

- (IBAction)icViewTopBackClick:(UIButton *)sender;
- (IBAction)btnProceedToRegisterPress:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
