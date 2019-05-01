//
//  RegisterAccountViewController.h
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterAccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIView *viewAccInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbNumOne;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIView *viewProfileInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbNumTwo;

@property (weak, nonatomic) IBOutlet UIScrollView *scvAccInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbStepOne;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *icShowPass;

@property (weak, nonatomic) IBOutlet UILabel *lbConfirmPass;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *icShowConfirmPass;

@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UILabel *lbHaveAccount;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;

- (IBAction)btnContinuePress:(UIButton *)sender;
- (IBAction)btnSignInPress:(UIButton *)sender;
- (IBAction)icShowPassPress:(UIButton *)sender;
- (IBAction)icShowConfirmPassPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
