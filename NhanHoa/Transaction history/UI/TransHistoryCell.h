//
//  TransHistoryCell.h
//  NhanHoa
//
//  Created by Khai Leo on 6/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

- (void)displayDataWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
