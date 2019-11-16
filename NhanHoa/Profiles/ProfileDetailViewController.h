//
//  ProfileDetailViewController.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UITableView *tbInfo;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistrant;
@property (weak, nonatomic) IBOutlet UIButton *btnBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbMenuActive;

@property (nonatomic, strong) NSDictionary *profileInfo;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)btnRegistrantPress:(UIButton *)sender;
- (IBAction)btnBusinessPress:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
