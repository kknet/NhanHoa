//
//  UpdateNewPersonalProfileView.h
//  NhanHoa
//
//  Created by OS on 10/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooseCityPopupView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UpdateNewPersonalProfileViewDelegate <NSObject>

@optional
- (void)updateProfileInfoSuccessfully;
- (void)updateProfileInfoFailed;
@end

@interface UpdateNewPersonalProfileView : UIView<UITextFieldDelegate, ChooseCityPopupViewDelegate, WebServiceUtilsDelegate>

@property (nonatomic, strong) id<UpdateNewPersonalProfileViewDelegate, NSObject> delegate;

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
@property (weak, nonatomic) IBOutlet UIButton *btnChooseDOB;
@property (weak, nonatomic) IBOutlet UILabel *lbBotDOB;

@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPassport;

@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbPermanentAddr;
@property (weak, nonatomic) IBOutlet UITextField *tfPermanentAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbBotPermanentAddr;

@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbBotCountry;

@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UILabel *lbBotCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrowCity;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseCity;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveUpdate;

- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnChooseDOBPress:(UIButton *)sender;
- (IBAction)btnChooseCityPress:(UIButton *)sender;
- (IBAction)btnSaveUpdatePress:(UIButton *)sender;

@property (nonatomic, strong) UIView *transparentView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIView *toolBar;

@property (nonatomic, assign) int gender;
@property (nonatomic, strong) NSString *cityCode;

- (void)setupUIForView;
- (void)displayPersonalProfileInfo;

@end

NS_ASSUME_NONNULL_END
