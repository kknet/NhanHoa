//
//  HostingDetailsTbvCell.h
//  NhanHoa
//
//  Created by Khai Leo on 11/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HostingDetailsTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgChecked;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbValue;

@end

NS_ASSUME_NONNULL_END
