//
//  UpdatePersonalProfile.h
//  NhanHoa
//
//  Created by lam quang quan on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

@protocol UpdatePersonalProfileDelegate
- (void)savePersonalMyAccountInformation: (NSDictionary *)info;
@end

NS_ASSUME_NONNULL_BEGIN

@interface UpdatePersonalProfile : UIView<UITextFieldDelegate, ChooseCityPopupViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<UpdatePersonalProfileDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbBOD;
@property (weak, nonatomic) IBOutlet UITextField *tfBOD;
@property (weak, nonatomic) IBOutlet UIButton *btnBOD;
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrCity;

@property (weak, nonatomic) IBOutlet UIButton *btnReset;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (nonatomic, assign) int gender;

- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnBODPress:(UIButton *)sender;
- (IBAction)btnResetPress:(UIButton *)sender;
- (IBAction)btnSavePress:(UIButton *)sender;
- (IBAction)btnCityPress:(UIButton *)sender;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIView *viewPicker;
@property (nonatomic, strong) NSString *cityCode;

- (void)setupUIForView;
- (void)displayPersonalInformation;

@end

NS_ASSUME_NONNULL_END
