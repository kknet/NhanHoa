//
//  SignUpBusinessProfileView.h
//  NhanHoa
//
//  Created by OS on 10/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SignUpBusinessProfileViewDelegate <NSObject>

@optional
- (void)onBusinessViewBackClicked;
@end

@interface SignUpBusinessProfileView : UIView<ChooseCityPopupViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) id<SignUpBusinessProfileViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessName;

@property (weak, nonatomic) IBOutlet UILabel *lbTaxCode;
@property (weak, nonatomic) IBOutlet UITextField *tfTaxCode;
@property (weak, nonatomic) IBOutlet UILabel *lbBotTaxCode;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessAddr;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessAddr;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessCountry;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessCity;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessCity;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessBotCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgBusinessCity;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseBusinessCity;

@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

@property (weak, nonatomic) IBOutlet UIScrollView *scvPersonal;
@property (weak, nonatomic) IBOutlet UIView *viewPersonalTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonalTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFullname;
@property (weak, nonatomic) IBOutlet UITextField *tfFullname;
@property (weak, nonatomic) IBOutlet UILabel *lbBotFullname;
@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbDOB;
@property (weak, nonatomic) IBOutlet UITextField *tfDOB;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseDOB;
@property (weak, nonatomic) IBOutlet UILabel *lbBotDOB;
@property (weak, nonatomic) IBOutlet UILabel *lbPostition;
@property (weak, nonatomic) IBOutlet UITextField *tfPostition;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPPostition;
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbBotEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbBotCountry;

@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UILabel *lbBotCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgCityArr;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseCity;
@property (weak, nonatomic) IBOutlet UITextView *tvPolicy;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender;
- (IBAction)btnContinuePress:(UIButton *)sender;
- (IBAction)btnRegisterPress:(UIButton *)sender;
- (IBAction)btnChooseCityPress:(UIButton *)sender;
- (IBAction)btnChooseDOBPress:(UIButton *)sender;

- (void)setupUIForViewWithHeightNav: (float)hNav;

@property (nonatomic, strong) NSString *businessCityCode;

@end

NS_ASSUME_NONNULL_END
