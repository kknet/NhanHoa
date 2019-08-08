//
//  HostingDetailTbvCell.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingDetailTbvCell : UITableViewCell

@property (strong, nonatomic) IBOutlet PaddingLabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;
@end

NS_ASSUME_NONNULL_END
