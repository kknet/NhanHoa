//
//  IntroduceVPSViewController.h
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroduceVPSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *bgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewWindowsVPS;
@property (weak, nonatomic) IBOutlet UIImageView *imgWindowsVPS;
@property (weak, nonatomic) IBOutlet UILabel *lbWindowsVPS;

@property (weak, nonatomic) IBOutlet UIView *viewLinuxVPS;
@property (weak, nonatomic) IBOutlet UIImageView *imgLinuxVPS;
@property (weak, nonatomic) IBOutlet UILabel *lbLinuxVPS;

@property (weak, nonatomic) IBOutlet UITableView *tbQuestions;

@property (weak, nonatomic) IBOutlet UICollectionView *clvPromotions;
@property (weak, nonatomic) IBOutlet UICollectionView *clvSliders;


- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
