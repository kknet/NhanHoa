//
//  PaymentViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentStepView.h"

@interface PaymentViewController : UIViewController

@property (nonatomic, strong) PaymentStepView *viewMenu;
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnPayment;

@property (nonatomic, assign) float hMenu;

@end
