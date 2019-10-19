//
//  NewSignUpViewController.h
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewSignUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTop;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbBotEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *icShowPass;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPass;
@property (weak, nonatomic) IBOutlet UIImageView *imgConfirmPass;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *icShowConfirmPass;
@property (weak, nonatomic) IBOutlet UILabel *lbBotConfirmPass;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;
@property (weak, nonatomic) IBOutlet UIButton *btnHaveAccount;

@property (weak, nonatomic) IBOutlet UIView *viewType;
@property (weak, nonatomic) IBOutlet UILabel *lbWelcome;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbChooseType;
@property (weak, nonatomic) IBOutlet UIView *viewPersonal;
@property (weak, nonatomic) IBOutlet UIImageView *imgPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonal;
@property (weak, nonatomic) IBOutlet UIView *viewBusiness;
@property (weak, nonatomic) IBOutlet UIImageView *imgBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusiness;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseTypeContinue;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackground;
@property (weak, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)icShowPassClick:(UIButton *)sender;
- (IBAction)icShowConfirmPassClick:(UIButton *)sender;
- (IBAction)btnContinuePress:(UIButton *)sender;
- (IBAction)btnHaveAccountPress:(UIButton *)sender;
- (IBAction)btnChooseTypeContinuePress:(UIButton *)sender;
- (IBAction)icCloseViewTypeClick:(UIButton *)sender;
- (IBAction)btnBackPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
