//
//  OrderTypeTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/22/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderTypeTbvCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

- (void)setCellIsSelected: (BOOL)select;

@end

NS_ASSUME_NONNULL_END
