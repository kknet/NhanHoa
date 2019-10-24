//
//  NotificationTbvCell.h
//  NhanHoa
//
//  Created by Khai Leo on 10/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NotificationTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UIImageView *imgNotif;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgNotifUnread;

- (void)displayContentForCellWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
