//
//  IntroduceHostingViewController.h
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroduceHostingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *bgHosting;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewWindows;
@property (weak, nonatomic) IBOutlet UIImageView *imgWindows;
@property (weak, nonatomic) IBOutlet UILabel *lbWindows;

@property (weak, nonatomic) IBOutlet UIView *viewLinux;
@property (weak, nonatomic) IBOutlet UIImageView *imgLinux;
@property (weak, nonatomic) IBOutlet UILabel *lbLinux;

@property (weak, nonatomic) IBOutlet UIView *viewWordpress;
@property (weak, nonatomic) IBOutlet UIImageView *imgWordpress;
@property (weak, nonatomic) IBOutlet UILabel *lbWordpress;
@property (weak, nonatomic) IBOutlet UITableView *tbQuestions;

@property (weak, nonatomic) IBOutlet UICollectionView *clvPromotions;
@property (weak, nonatomic) IBOutlet UICollectionView *clvSliders;


- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
