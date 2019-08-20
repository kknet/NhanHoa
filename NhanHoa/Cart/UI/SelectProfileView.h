//
//  SelectProfileView.h
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebServices.h"
#import "ChooseCityPopupView.h"
#import "ProfileDetailCell.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SelectProfileViewDelegate
@optional
- (void)onIconCloseClicked;
- (void)onSelectedProfileForDomain;
- (void)onPassportFrontPress;
- (void)onPassportBehindPress;
- (void)onCreatNewProfileClicked;
@end

@interface SelectProfileView : UIView<UITableViewDelegate, UITableViewDataSource, WebServicesDelegate, UITextFieldDelegate, ProfileDetailCellDelegate>

@property (nonatomic,strong) id<NSObject, SelectProfileViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbProfile;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbNoData;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icClear;

@property (nonatomic, assign) float hHeader;
@property (nonatomic, assign) float hCell;
@property (nonatomic, assign) float hSmallCell;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) int selectedRow;
@property (nonatomic, strong) NSString *cusIdSelected;

- (void)setupUIForView;
- (IBAction)icAddClick:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icClearClick:(UIButton *)sender;

@property (nonatomic, strong) WebServices *webService;
@property (nonatomic, strong) NSMutableArray *listProfiles;
@property (nonatomic, assign) int cartIndexItemSelect;

@property (nonatomic, assign) BOOL searching;
@property (nonatomic, strong) NSTimer *searchTimer;
@property (nonatomic, strong) NSMutableArray *listSearch;

- (void)getListProfilesForAccount;

@end

NS_ASSUME_NONNULL_END
