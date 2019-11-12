//
//  IntroduceEmailsViewController.h
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface IntroduceEmailsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *bgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIView *viewEmailHosting;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmailHosting;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailHosting;

@property (weak, nonatomic) IBOutlet UIView *viewEmailGoogle;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmailGoogle;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailGoogle;

@property (weak, nonatomic) IBOutlet UIView *viewEmailMicrosoft;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmailMicrosoft;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailMicrosoft;

@property (weak, nonatomic) IBOutlet UIView *viewEmailServerRieng;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmailServerRieng;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailServerRieng;

@property (weak, nonatomic) IBOutlet UICollectionView *clvSliders;

@property (weak, nonatomic) IBOutlet UITableView *tbQuestions;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
