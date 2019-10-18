//
//  NewSignInViewController.h
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewSignInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbBotEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmailState;

@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassword;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPassword;
@property (weak, nonatomic) IBOutlet UIButton *icShowPass;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)icShowPassClick:(UIButton *)sender;
- (IBAction)btnForgotPasswordPress:(UIButton *)sender;
- (IBAction)btnSignInPress:(UIButton *)sender;
- (IBAction)btnSignUpPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
