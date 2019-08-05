//
//  RegisterHostingViewController.h
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterHostingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnWindows;
@property (weak, nonatomic) IBOutlet UIButton *btnWorldPress;
@property (weak, nonatomic) IBOutlet UIButton *btnLinux;
@property (weak, nonatomic) IBOutlet UIImageView *imgArr;

@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)btnLinuxPress:(UIButton *)sender;
- (IBAction)btnWindowsPress:(UIButton *)sender;
- (IBAction)btnWorldpressPPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
