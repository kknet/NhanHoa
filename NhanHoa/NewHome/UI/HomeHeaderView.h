//
//  HomeHeaderView.h
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbHello;
@property (weak, nonatomic) IBOutlet UIButton *icCall;

@property (weak, nonatomic) IBOutlet UIView *viewWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainMoney;
@property (weak, nonatomic) IBOutlet UIButton *icMainMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusMoney;
@property (weak, nonatomic) IBOutlet UIButton *icBonusMoney;

@property (weak, nonatomic) IBOutlet UILabel *lbTopup;
@property (weak, nonatomic) IBOutlet UIButton *icTopup;
@property (weak, nonatomic) IBOutlet UIButton *icPromotion;
@property (weak, nonatomic) IBOutlet UILabel *lbPromotion;
@property (weak, nonatomic) IBOutlet UIButton *icTrans;
@property (weak, nonatomic) IBOutlet UILabel *lbTrans;

- (void)setupUIForView;

@property (nonatomic, assign) float hContentView;

@end

NS_ASSUME_NONNULL_END
