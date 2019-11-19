//
//  CartPaymentViewController.h
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartPaymentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *icBackStep;
@property (weak, nonatomic) IBOutlet UILabel *lbStepTitle;
@property (weak, nonatomic) IBOutlet UIButton *icNextStep;
@property (weak, nonatomic) IBOutlet UILabel *lbBgState;
@property (weak, nonatomic) IBOutlet UILabel *lbBgActiveState;

@property (weak, nonatomic) IBOutlet UITableView *tbProfile;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icBackStepClick:(UIButton *)sender;
- (IBAction)icNextStepClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
