//
//  ChangePassViewController.h
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePassViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIImageView *imgCurPass;
@property (weak, nonatomic) IBOutlet UITextField *tfCurPass;
@property (weak, nonatomic) IBOutlet UIButton *icShowPass;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPass;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;


@property (weak, nonatomic) IBOutlet UIView *viewNewPass;
@property (weak, nonatomic) IBOutlet UITextField *tfNewPass;
@property (weak, nonatomic) IBOutlet UIImageView *imgNewPass;
@property (weak, nonatomic) IBOutlet UIButton *icShowNewPass;
@property (weak, nonatomic) IBOutlet UILabel *lbBotNewPass;

@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPass;
@property (weak, nonatomic) IBOutlet UIImageView *imgConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *icShowConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lbBotConfirmPass;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveNewPass;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icShowPassClick:(UIButton *)sender;
- (IBAction)btnForgotPassPress:(UIButton *)sender;
- (IBAction)btnContinuePress:(UIButton *)sender;
- (IBAction)icShowNewPassClick:(UIButton *)sender;
- (IBAction)icShowConfirmPassClick:(UIButton *)sender;
- (IBAction)btnSaveNewPassPress:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
