//
//  BonusHistoryCell.h
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BonusHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbActionName;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@property (weak, nonatomic) IBOutlet UIImageView *imgSepa;

@end

NS_ASSUME_NONNULL_END
