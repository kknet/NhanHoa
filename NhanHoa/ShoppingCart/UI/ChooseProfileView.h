//
//  ChooseProfileView.h
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ChooseProfileViewDelegate <NSObject>

@optional
- (void)closeChooseProfileView;
- (void)choosedProfileForDomain;
@end

@interface ChooseProfileView : UIView<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>

@property (nonatomic, strong) id<NSObject, ChooseProfileViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icClear;


@property (weak, nonatomic) IBOutlet UILabel *lbNoData;
@property (weak, nonatomic) IBOutlet UITableView *tbProfiles;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

- (IBAction)btnAddPress:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)icClearClick:(UIButton *)sender;

- (void)setupUIForViewWithHeightNav:(float)hNav;

@property (nonatomic, strong) NSMutableArray *listSearch;
@property (nonatomic, strong) NSMutableArray *listProfiles;
@property (nonatomic, assign) BOOL searching;
@property (nonatomic, assign) float hCell;
@property (nonatomic, strong) NSString *cusIdSelected;
@property (nonatomic, assign) int selectedRow;

@property (nonatomic, strong) NSTimer *searchTimer;

@end

NS_ASSUME_NONNULL_END
