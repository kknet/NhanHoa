//
//  BusinessProfileView.h
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BusinessProfileViewDelegate
- (void)selectPersonalProfile;
- (void)readyToRegisterBusinessAccount: (NSDictionary *)info;
@end

@interface BusinessProfileView : UIView<UIGestureRecognizerDelegate, UITextFieldDelegate, ChooseCityPopupViewDelegate>

@property (nonatomic, strong) id <BusinessProfileViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbVision;
@property (weak, nonatomic) IBOutlet UIButton *icPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonal;
@property (weak, nonatomic) IBOutlet UIButton *icBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusiness;

@property (weak, nonatomic) IBOutlet UILabel *lbInfoBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *lbTaxCode;
@property (weak, nonatomic) IBOutlet UITextField *tfTaxCode;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;

@property (weak, nonatomic) IBOutlet UILabel *lbInfoRegister;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterName;
@property (weak, nonatomic) IBOutlet UITextField *tfRegisterName;
@property (weak, nonatomic) IBOutlet UILabel *lbSex;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbBOD;
@property (weak, nonatomic) IBOutlet UITextField *tfBOD;
@property (weak, nonatomic) IBOutlet UILabel *lbPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbPerAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfPerAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbPerCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfPerCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbPerCity;
@property (weak, nonatomic) IBOutlet UITextField *tfPerCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgPerCityArrow;
@property (weak, nonatomic) IBOutlet UIButton *btnPerCity;
@property (weak, nonatomic) IBOutlet UIButton *btnBOD;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

- (void)setupUIForView;
- (IBAction)chooseBusinessCityPress:(UIButton *)sender;
- (IBAction)choosePersonalCityPress:(UIButton *)sender;
- (IBAction)btnRegisterPress:(UIButton *)sender;
- (IBAction)icPersonalClick:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnBODPress:(UIButton *)sender;

@property (nonatomic, strong) NSString *businessCityCode;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, assign) int gender;
@property (nonatomic, assign) int typeCity;
@property (nonatomic, assign) float contentHeight;

@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;


@end

NS_ASSUME_NONNULL_END
