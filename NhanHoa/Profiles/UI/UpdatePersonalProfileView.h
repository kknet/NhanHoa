//
//  UpdatePersonalProfileView.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

typedef enum {
    eAddNewPersonalProfile,
    eUpdatePersonalProfile,
}TypePersonalProfileView;

NS_ASSUME_NONNULL_BEGIN

@protocol UpdatePersonalProfileViewDelegate <NSObject>

@optional
- (void)clickOnBacksidePersonalProfile;
- (void)clickOnFrontPersonalProfile;

- (void)updatePersonalProfileSuccessfully;
- (void)failedToUpdatePersonalProfileWithError: (NSString *)error;

- (void)addPersonalProfileSuccessfully;
- (void)failedToAddPersonalProfileWithError: (NSString *)error;
@end

@interface UpdatePersonalProfileView : UIView<UITextFieldDelegate, WebServiceUtilsDelegate, ChooseCityPopupViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<UpdatePersonalProfileViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;

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
@property (weak, nonatomic) IBOutlet UILabel *lbBotDOB;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseDOB;

@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPassport;

@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbBotEmail;

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

@property (weak, nonatomic) IBOutlet UILabel *lbFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;

@property (weak, nonatomic) IBOutlet UILabel *lbBackside;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackside;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveInfo;

- (void)setupUIForView;
- (void)displayInfoForPersonalProfileWithInfo: (NSDictionary *)info;

@property (nonatomic, assign) TypePersonalProfileView typeOfView;
@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *linkFrontPassport;
@property (nonatomic, strong) NSString *linkBehindPassport;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnChooseDOBPress:(UIButton *)sender;
- (IBAction)btnChooseCityPress:(UIButton *)sender;
- (IBAction)btnSaveInfoPress:(UIButton *)sender;

- (void)removePassportFrontPhoto;
- (void)removePassportBacksidePhoto;
- (void)saveAllValueBeforeChangeView;

@end

NS_ASSUME_NONNULL_END
