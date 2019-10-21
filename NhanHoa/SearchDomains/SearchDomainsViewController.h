//
//  SearchDomainsViewController.h
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchDomainsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIImageView *bgHeader;
@property (weak, nonatomic) IBOutlet UIButton *icClose;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *bgTop;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *icSearch;
@property (weak, nonatomic) IBOutlet UIView *viewCheckMultiDomains;
@property (weak, nonatomic) IBOutlet UIImageView *imgCheckMultiDomains;
@property (weak, nonatomic) IBOutlet UILabel *lbCheckMultiDomains;

@property (weak, nonatomic) IBOutlet UIView *viewRenewDomain;
@property (weak, nonatomic) IBOutlet UIImageView *imgRenewDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbRenewDomain;

@property (weak, nonatomic) IBOutlet UIView *viewTransferDomains;
@property (weak, nonatomic) IBOutlet UIImageView *imgTransferDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbTransferDomain;

@property (weak, nonatomic) IBOutlet UICollectionView *clvSlider;
@property (weak, nonatomic) IBOutlet UICollectionView *clvPosts;
@property (weak, nonatomic) IBOutlet UITableView *tbDomainsType;

- (IBAction)icCloseClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)icSearchClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
