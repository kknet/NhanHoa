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

NS_ASSUME_NONNULL_BEGIN

@protocol SelectProfileViewDelegate
@optional
- (void)onIconCloseClicked;
- (void)onSelectedProfileForDomain;
- (void)onPassportFrontPress;
- (void)onPassportBehindPress;
- (void)onCreatNewProfileClicked;
@end

@interface SelectProfileView : UIView<UITableViewDelegate, UITableViewDataSource, WebServicesDelegate>

@property (nonatomic,strong) id<NSObject, SelectProfileViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icAdd;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITableView *tbProfile;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbNoData;

@property (nonatomic, assign) float hHeader;
@property (nonatomic, assign) int selectedRow;
@property (nonatomic, strong) NSString *cusIdSelected;

- (void)setupUIForView;
- (IBAction)icAddClick:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;

@property (nonatomic, strong) WebServices *webService;
@property (nonatomic, strong) NSMutableArray *listProfiles;
@property (nonatomic, assign) int cartIndexItemSelect;

- (void)getListProfilesForAccount;

@end

NS_ASSUME_NONNULL_END
