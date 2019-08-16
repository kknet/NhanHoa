//
//  TopupViewController.h
//  NhanHoa
//
//  Created by admin on 5/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopupViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnWallet;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;
@property (weak, nonatomic) IBOutlet UIButton *btn500K;
@property (weak, nonatomic) IBOutlet UIButton *btn1000K;
@property (weak, nonatomic) IBOutlet UIButton *btn1500K;
@property (weak, nonatomic) IBOutlet UITextField *tfMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnTopup;


- (IBAction)btn500KPress:(UIButton *)sender;
- (IBAction)btn1000KPress:(UIButton *)sender;
- (IBAction)btn1500kPress:(UIButton *)sender;
- (IBAction)btnTopupPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
