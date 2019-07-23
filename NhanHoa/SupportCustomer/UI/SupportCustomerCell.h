//
//  SupportCustomerCell.h
//  NhanHoa
//
//  Created by Khai Leo on 7/20/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SupportCustomerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbExtension;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;

- (void)displayContentWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
