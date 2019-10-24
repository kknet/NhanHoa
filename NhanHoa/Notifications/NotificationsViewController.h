//
//  NotificationsViewController.h
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icTrash;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmptyNotif;


@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)icTrashClick:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
