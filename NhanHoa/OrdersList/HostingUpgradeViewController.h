//
//  HostingUpgradeViewController.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingUpgradeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UITableView *tbChoosePackage;
@property (weak, nonatomic) IBOutlet UITableView *tbPreview;

@end

NS_ASSUME_NONNULL_END
