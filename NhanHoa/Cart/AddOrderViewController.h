//
//  AddOrderViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentStepView.h"
#import "SelectProfileView.h"
#import "PaymentResultView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddOrderViewController : UIViewController

@property (nonatomic, strong) PaymentStepView *viewMenu;
@property (nonatomic, strong) SelectProfileView *chooseProfileView;
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

NS_ASSUME_NONNULL_END
