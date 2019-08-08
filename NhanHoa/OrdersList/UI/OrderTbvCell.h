//
//  OrderTbvCell.h
//  NhanHoa
//
//  Created by OS on 8/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbService;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@end

NS_ASSUME_NONNULL_END
