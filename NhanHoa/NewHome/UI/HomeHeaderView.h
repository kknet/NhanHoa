//
//  HomeHeaderView.h
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HomeHeaderViewDelegate <NSObject>
@optional
- (void)selectOnTopupHeaderMenu;
- (void)selectOnWithdrawHeaderMenu;
- (void)selectOnPromotionHeaderMenu;
- (void)selectOnTransactionHeaderMenu;
@end

@interface HomeHeaderView : UIView

@property (nonatomic, strong) id<HomeHeaderViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;
@property (weak, nonatomic) IBOutlet UILabel *lbHello;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainMoney;
@property (weak, nonatomic) IBOutlet UIButton *icMainMoney;
@property (weak, nonatomic) IBOutlet UIView *viewMainWallet;

@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusMoney;
@property (weak, nonatomic) IBOutlet UIButton *icBonusMoney;
@property (weak, nonatomic) IBOutlet UIView *viewBonusWallet;

@property (weak, nonatomic) IBOutlet UILabel *lbTopup;
@property (weak, nonatomic) IBOutlet UIButton *icTopup;
@property (weak, nonatomic) IBOutlet UIButton *icWithdraw;
@property (weak, nonatomic) IBOutlet UILabel *lbWithdraw;

@property (weak, nonatomic) IBOutlet UIButton *icPromotion;
@property (weak, nonatomic) IBOutlet UILabel *lbPromotion;
@property (weak, nonatomic) IBOutlet UIButton *icTrans;
@property (weak, nonatomic) IBOutlet UILabel *lbTrans;

@property (nonatomic, assign) float hContentView;

- (void)setupUIForView;
- (void)displayAccountInformation;
- (void)updateShoppingCartCount;

- (IBAction)icTopupClick:(UIButton *)sender;
- (IBAction)icWithdrawClick:(UIButton *)sender;
- (IBAction)icPromotionsClick:(UIButton *)sender;
- (IBAction)icTransactionClick:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
