//
//  NotificationCell.h
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTime;
@property (weak, nonatomic) IBOutlet UIImageView *imgSepa;

@end
