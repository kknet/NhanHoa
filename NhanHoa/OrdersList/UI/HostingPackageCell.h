//
//  HostingPackageCell.h
//  NhanHoa
//
//  Created by OS on 8/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingPackageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIImageView *imgTick;

@end

NS_ASSUME_NONNULL_END
