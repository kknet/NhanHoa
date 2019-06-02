//
//  PriceDomainInfoCell.h
//  NhanHoa
//
//  Created by Khai Leo on 6/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PriceDomainInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbRenew;
@property (weak, nonatomic) IBOutlet UILabel *lbSetup;
@property (weak, nonatomic) IBOutlet UILabel *lbTransfer;
@property (weak, nonatomic) IBOutlet UIImageView *imgSepa;

- (void)showContentWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
