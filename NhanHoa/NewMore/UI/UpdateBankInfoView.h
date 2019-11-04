//
//  UpdateBankInfoView.h
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UpdateBankInfoViewDelegate <NSObject>

@optional
- (void)closeUpdateBankInfoView;
- (void)bankInfoHasBeenUpdatedSuccessful;
@end

@interface UpdateBankInfoView : UIView<UITextFieldDelegate, UIGestureRecognizerDelegate, UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>

@property (nonatomic, strong) id<UpdateBankInfoViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UILabel *lbBankName;
@property (weak, nonatomic) IBOutlet UITextField *tfBankName;
@property (weak, nonatomic) IBOutlet UILabel *lbOwnerName;
@property (weak, nonatomic) IBOutlet UITextField *tfOwnerName;
@property (weak, nonatomic) IBOutlet UILabel *lbBankAccountNumber;
@property (weak, nonatomic) IBOutlet UITextField *tfBankAccountNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (nonatomic, strong) UITableView *tbBank;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hCell;
@property (nonatomic, strong) NSTimer *searchTimer;
@property (nonatomic, strong) NSMutableArray *searchList;



- (IBAction)btnSavePress:(UIButton *)sender;
- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;

- (void)setupUIForViewWithHeightNav: (float)hNav;


@end

NS_ASSUME_NONNULL_END
