//
//  PricingDomainsTbvCell.h
//  NhanHoa
//
//  Created by OS on 11/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PricingDomainsTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UILabel *lbSetup;
@property (weak, nonatomic) IBOutlet UILabel *lbRenew;
@property (weak, nonatomic) IBOutlet UILabel *lbTransfer;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

- (void)showPricingContentWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
