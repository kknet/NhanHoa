//
//  PaymentResultView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentResultView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeTran;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UILabel *lbFee;
@property (weak, nonatomic) IBOutlet UILabel *lbFeeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbID;
@property (weak, nonatomic) IBOutlet UILabel *lbIDValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbTimeValue;
@property (weak, nonatomic) IBOutlet UIButton *btnTopupMore;
@property (weak, nonatomic) IBOutlet UIButton *btnSupport;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)btnTopupMorePress:(UIButton *)sender;
- (IBAction)btnSupportPress:(UIButton *)sender;

- (void)setupUIForView;
- (void)showContentWithInfo: (NSDictionary *)info;

@end
