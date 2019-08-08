//
//  RegisterEmailViewController.h
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterEmailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailHosting;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailServer;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)btnEmailHostingPress:(UIButton *)sender;
- (IBAction)btnEmailServerPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
