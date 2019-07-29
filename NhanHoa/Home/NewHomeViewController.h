//
//  NewHomeViewController.h
//  NhanHoa
//
//  Created by OS on 7/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewSearch;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icSearch;

@property (weak, nonatomic) IBOutlet UIImageView *imgBanner;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;

@property (weak, nonatomic) IBOutlet UIView *viewWallet;
@property (weak, nonatomic) IBOutlet UIView *viewMainWallet;
@property (weak, nonatomic) IBOutlet UIImageView *imgMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMoneyMain;

@property (weak, nonatomic) IBOutlet UIView *viewBonusWallet;
@property (weak, nonatomic) IBOutlet UIImageView *imgBonusWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbBonusWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMoneyBonus;

@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@property (weak, nonatomic) IBOutlet UICollectionView *clvMenu;

@end

NS_ASSUME_NONNULL_END
