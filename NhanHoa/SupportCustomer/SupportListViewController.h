//
//  SupportListViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 7/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SupportListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *tfNumber;
@property (weak, nonatomic) IBOutlet UIButton *btnClear;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbNoData;

- (IBAction)btnClearPress:(UIButton *)sender;
- (IBAction)btnCallPress:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
