//
//  OrdersListViewController.h
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eMenuAll,
    eMenuPending,
    eMenuCreating,
    eMenuUsing,
    eMenuAboutToExpire,
    eMenuExpired,
}eMenuType;

NS_ASSUME_NONNULL_BEGIN

@interface OrdersListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIView *viewTop;
@property (weak, nonatomic) IBOutlet UITextField *tfSearch;
@property (weak, nonatomic) IBOutlet UIImageView *imgSearch;
@property (weak, nonatomic) IBOutlet UIScrollView *scvMenu;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
