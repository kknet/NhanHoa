//
//  TopUpMoneyView.h
//  NhanHoa
//
//  Created by Khai Leo on 10/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ePopupTopup,
    ePopupWithdraw,
}TypePopupMoney;

@protocol TopUpMoneyViewDelegate <NSObject>

@optional
- (void)closeTopupMoneyView;
- (void)startTopupToAccountWithMoneyValue: (long)money;
- (void)showAlertConfirmToWithDraw: (long)money;
@end

NS_ASSUME_NONNULL_BEGIN

@interface TopUpMoneyView : UIView<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<TopUpMoneyViewDelegate, NSObject> delegate;
@property (weak, nonatomic) IBOutlet UILabel *viewBg;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UITableView *tbMoney;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UITextField *tfMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbCurrency;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

- (IBAction)btnConfirmPress:(UIButton *)sender;
- (IBAction)icCloseClick:(UIButton *)sender;

@property (nonatomic, assign) float hTitle;
@property (nonatomic, assign) float hCell;
@property (nonatomic, assign) float hBTN;
@property (nonatomic, assign) float hContent;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) TypePopupMoney popupType;
@property (nonatomic, assign) int selectedRow;
@property (nonatomic, assign) long selectedMoney;

@property (nonatomic, strong) UIFont *textFont;

- (void)setupUIForView;
- (void)showMoneyListToTopUp;

@end

NS_ASSUME_NONNULL_END
