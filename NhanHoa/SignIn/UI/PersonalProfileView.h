//
//  PersonalProfileView.h
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PersonalProfileViewDelegate <NSObject>
- (void)selectBusinessProfile;
- (void)readyToRegisterAccount: (NSDictionary *)info;
@end

@interface PersonalProfileView : UIView<UITextFieldDelegate, UIGestureRecognizerDelegate, ChooseCityPopupViewDelegate>

@property (nonatomic, strong) id<PersonalProfileViewDelegate, NSObject> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbVision;
@property (weak, nonatomic) IBOutlet UIButton *icPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonal;
@property (weak, nonatomic) IBOutlet UIButton *icBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
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
@property (weak, nonatomic) IBOutlet UIImageView *imgArrowCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;


- (IBAction)icPersonalClick:(UIButton *)sender;
- (IBAction)icBusinessClick:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnRegisterPress:(UIButton *)sender;
- (IBAction)btnBODPress:(UIButton *)sender;
- (IBAction)btnCityPress:(UIButton *)sender;

- (void)setupUIForView;

@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, assign) int ownType;
@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, assign) float contentSize;

@end

NS_ASSUME_NONNULL_END
