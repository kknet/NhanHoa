//
//  IntroduceSSLViewController.h
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroduceSSLViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *bgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewComodo;
@property (weak, nonatomic) IBOutlet UIImageView *imgComodo;
@property (weak, nonatomic) IBOutlet UILabel *lbComodo;

@property (weak, nonatomic) IBOutlet UIView *viewGeotrust;
@property (weak, nonatomic) IBOutlet UIImageView *imgGeotrust;
@property (weak, nonatomic) IBOutlet UILabel *lbGeotrust;

@property (weak, nonatomic) IBOutlet UIView *viewSymantec;
@property (weak, nonatomic) IBOutlet UIImageView *imgSymantec;
@property (weak, nonatomic) IBOutlet UILabel *lbSymantec;
@property (weak, nonatomic) IBOutlet UITableView *tbQuestions;

@property (weak, nonatomic) IBOutlet UICollectionView *clvPromotions;
@property (weak, nonatomic) IBOutlet UICollectionView *clvSliders;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
