//
//  WhoIsViewController.h
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhoIsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tbContent;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

- (IBAction)btnSearchPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
