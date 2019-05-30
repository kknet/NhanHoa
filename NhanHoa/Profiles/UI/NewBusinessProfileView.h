//
//  NewBusinessProfileView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"
#import "WebServices.h"

typedef enum {
    eAddNewBusinessProfile,
    eEditBusinessProfile,
}BusinessProfileMode;

@protocol NewBusinessProfileViewDelegate
- (void)onSelectPersonalProfile;
- (void)onBusinessPassportFrontPress;
- (void)onBusinessPassportBehindPress;
- (void)businessProfileWasCreated;
@end

@interface NewBusinessProfileView : UIView<UIGestureRecognizerDelegate, UIScrollViewDelegate, UIActionSheetDelegate, ChooseCityPopupViewDelegate, UITextFieldDelegate, WebServicesDelegate>

@property (nonatomic, strong) id<NewBusinessProfileViewDelegate, NSObject> delegate;

@property (nonatomic, assign) BusinessProfileMode mode;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
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
@property (weak, nonatomic) IBOutlet UILabel *lbGender;
@property (weak, nonatomic) IBOutlet UIButton *icMale;
@property (weak, nonatomic) IBOutlet UILabel *lbMale;
@property (weak, nonatomic) IBOutlet UIButton *icFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbFemale;
@property (weak, nonatomic) IBOutlet UILabel *lbBOD;
@property (weak, nonatomic) IBOutlet UITextField *tfBOD;
@property (weak, nonatomic) IBOutlet UIButton *btnBOD;

@property (weak, nonatomic) IBOutlet UILabel *lbPosition;
@property (weak, nonatomic) IBOutlet UITextField *tfPosition;
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;

@property (weak, nonatomic) IBOutlet UIView *viewPassport;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassportFront;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassportBehind;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportBehind;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hLabel;
@property (nonatomic, assign) float mTop;

@property (nonatomic, strong) ChooseCityPopupView *popupChooseCity;

- (void)setupUIForViewForAddProfile: (BOOL)isAddNew update: (BOOL)isUpdate;
- (IBAction)btnSavePress:(UIButton *)sender;
- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)btnPerCityPress:(UIButton *)sender;
- (IBAction)btnBODPress:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;

@property (nonatomic, strong) NSString *businessCity;
@property (nonatomic, assign) int gender;


@property (nonatomic, strong) UIImage *imgFront;
@property (nonatomic, strong) NSString *linkFrontPassport;

@property (nonatomic, strong) UIImage *imgBehind;
@property (nonatomic, strong) NSString *linkBehindPassport;

@property (nonatomic, strong) WebServices *webService;

- (void)removePassportFrontPhoto;
- (void)removePassportBehindPhoto;

- (void)displayInfoForProfileWithInfo: (NSDictionary *)info;

@end
