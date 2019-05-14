//
//  PaymentViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentStepView.h"
#import "SelectProfileView.h"
#import "OnepayPaymentView.h"
#import "PaymentResultView.h"

@interface PaymentViewController : UIViewController

@property (nonatomic, strong) PaymentStepView *viewMenu;
@property (nonatomic, strong) SelectProfileView *chooseProfileView;
@property (nonatomic, strong) OnepayPaymentView *onepayView;
@property (nonatomic, strong) PaymentResultView *paymentResultView;

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnPayment;
@property (nonatomic, assign) float hMenu;
@property (nonatomic, assign) float hTbConfirm;
@property (nonatomic, assign) float padding;

@property (weak, nonatomic) IBOutlet UITableView *tbConfirmProfile;

- (IBAction)btnPaymentPress:(UIButton *)sender;

@end
