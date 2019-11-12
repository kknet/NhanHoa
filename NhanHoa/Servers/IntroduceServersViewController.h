//
//  IntroduceServersViewController.h
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroduceServersViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *bgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewWindowsServer;
@property (weak, nonatomic) IBOutlet UIImageView *imgWindowsServer;
@property (weak, nonatomic) IBOutlet UILabel *lbWindowsServer;

@property (weak, nonatomic) IBOutlet UIView *viewLinuxServer;
@property (weak, nonatomic) IBOutlet UIImageView *imgLinuxServer;
@property (weak, nonatomic) IBOutlet UILabel *lbLinuxServer;

@property (weak, nonatomic) IBOutlet UITableView *tbQuestions;

@property (weak, nonatomic) IBOutlet UICollectionView *clvPromotions;
@property (weak, nonatomic) IBOutlet UICollectionView *clvSliders;


- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
