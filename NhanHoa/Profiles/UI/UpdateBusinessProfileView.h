//
//  UpdateBusinessProfileView.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    eAddNewBusinessProfile,
    eUpdateBusinessProfile,
}TypeBusinessProfileView;

@protocol UpdateBusinessProfileViewDelegate <NSObject>

@optional
- (void)clickOnBacksideBusinessProfile;
- (void)clickOnFrontBusinessProfile;

- (void)updateBusinessProfileSuccessfully;
- (void)failedToUpdateBusinessProfileWithError: (NSString *)error;

- (void)addBusinessProfileSuccessfully;
- (void)failedToAddBusinessProfileWithError: (NSString *)error;

@end

@interface UpdateBusinessProfileView : UIView<UITextFieldDelegate, ChooseCityPopupViewDelegate, UIGestureRecognizerDelegate, WebServiceUtilsDelegate>

@property (nonatomic, strong) id<NSObject, UpdateBusinessProfileViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnBusinessInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistrantInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbMenuActive;

@property (weak, nonatomic) IBOutlet UIScrollView *scvBusiness;

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

@property (weak, nonatomic) IBOutlet UIButton *btnSaveInfo;

//  registrant info
@property (weak, nonatomic) IBOutlet UIScrollView *scvRegistrant;
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

@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbBotAddress;

@property (weak, nonatomic) IBOutlet UILabel *lbFront;
@property (weak, nonatomic) IBOutlet UILabel *lbBackside;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackside;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveRegistrantInfo;

@property (nonatomic, assign) TypeBusinessProfileView typeOfView;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString *businessCity;
@property (nonatomic, strong) NSString *linkFrontPassport;
@property (nonatomic, strong) NSString *linkBacksidePassport;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

- (void)setupUIForView;
- (void)displayInfoForProfileWithInfo: (NSDictionary *)info;
- (void)saveAllValueBeforeChangeView;

- (IBAction)btnRegistrantInfoPress:(UIButton *)sender;
- (IBAction)btnBusinessInfoPress:(UIButton *)sender;
- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender;
- (IBAction)btnSaveInfoBusinessPress:(UIButton *)sender;
- (IBAction)btnSaveRegistrantInfoPress:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnChooseDOBPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
