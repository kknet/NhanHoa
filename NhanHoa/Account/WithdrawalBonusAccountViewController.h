//
//  WithdrawalBonusAccountViewController.h
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalBonusAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UIButton *btn500K;
@property (weak, nonatomic) IBOutlet UIButton *btn1000K;
@property (weak, nonatomic) IBOutlet UIButton *btn1500K;

@property (weak, nonatomic) IBOutlet UILabel *lbDesc;
@property (weak, nonatomic) IBOutlet UILabel *lbNoti;
@property (weak, nonatomic) IBOutlet UITextField *tfMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnWithdrawal;

@property (nonatomic, assign) long withdrawMoney;

- (IBAction)btn500KPress:(UIButton *)sender;
- (IBAction)btn1000KPress:(UIButton *)sender;
- (IBAction)btn1500KPress:(UIButton *)sender;
- (IBAction)btnWithdrawalPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
