//
//  SignInViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 4/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;
@property (weak, nonatomic) IBOutlet UILabel *lbToBeTheBest;
@property (weak, nonatomic) IBOutlet UITextField *tfAccount;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *icShowPass;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPass;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UILabel *lbNotAccount;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;


- (IBAction)icShowPassClicked:(UIButton *)sender;
- (IBAction)btnForgotPassPress:(UIButton *)sender;
- (IBAction)btnSignInPress:(UIButton *)sender;
- (IBAction)btnRegisterPress:(UIButton *)sender;

@property (nonatomic, assign) float hHeader;
@property (nonatomic, assign) float padding;

@end
