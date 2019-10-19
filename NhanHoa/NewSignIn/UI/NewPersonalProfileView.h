//
//  NewPersonalProfileView.h
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol NewPersonalProfileViewDelegate <NSObject>

@optional
- (void)onPersonalViewBackClicked;
- (void)readyToRegisterPersonalAccount: (NSDictionary *)info;
@end


@interface NewPersonalProfileView : UIView<UITextViewDelegate, UITextFieldDelegate, ChooseCityPopupViewDelegate>

@property (nonatomic, strong) id<NewPersonalProfileViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFullname;
@property (weak, nonatomic) IBOutlet UITextField *tfFullname;
@property (weak, nonatomic) IBOutlet UILabel *lbBotFullname;

@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;

@property (weak, nonatomic) IBOutlet UILabel *lbBirthday;
@property (weak, nonatomic) IBOutlet UITextField *tfBirthday;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBirthday;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseDOB;

@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPassport;

@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *lbPermanentAddr;
@property (weak, nonatomic) IBOutlet UITextField *tfPermanentAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPermanentAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbBotCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UILabel *lbBotCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrCity;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseCity;
@property (weak, nonatomic) IBOutlet UITextView *tvPolicy;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString *cityCode;

- (void)setupUIForViewWithHeightNav: (float)hNav;
- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnChooseCityPress:(UIButton *)sender;
- (IBAction)btnChooseDOBPress:(UIButton *)sender;
- (IBAction)btnRegisterPress:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
