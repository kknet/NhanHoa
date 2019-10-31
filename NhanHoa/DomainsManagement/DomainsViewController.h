//
//  DomainsViewController.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgTop;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UIScrollView *scvMenu;
@property (weak, nonatomic) IBOutlet UITableView *tbDomains;
@property (weak, nonatomic) IBOutlet UILabel *lbNoData;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
