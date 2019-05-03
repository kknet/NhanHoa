//
//  SelectProfileView.h
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelectProfileViewDelegate
- (void)onIconCloseClicked;
@end

@interface SelectProfileView : UIView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) id<NSObject, SelectProfileViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbProfile;
@property (weak, nonatomic) IBOutlet UIButton *icClose;

@property (nonatomic, assign) float hHeader;
@property (nonatomic, assign) int selectedRow;

- (void)setupUIForView;
- (IBAction)icAddClick:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;

//  Add profile
@property (weak, nonatomic) IBOutlet UIScrollView *scvAddProfile;

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
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UITextField *tfPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfCountry;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbCity;
@property (weak, nonatomic) IBOutlet UITextField *tfCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrCity;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbTitlePassport;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassportFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgPassportBehind;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportFront;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportBehind;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

- (IBAction)icPersonalClick:(UIButton *)sender;
- (IBAction)icBusinessClick:(UIButton *)sender;
- (IBAction)icMaleClick:(UIButton *)sender;
- (IBAction)icFemaleClick:(UIButton *)sender;
- (IBAction)btnCountryPress:(UIButton *)sender;
- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)btnSavePress:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
