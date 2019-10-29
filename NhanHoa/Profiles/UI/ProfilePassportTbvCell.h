//
//  ProfilePassportTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfilePassportTbvCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbFront;
@property (weak, nonatomic) IBOutlet UIImageView *imgFront;
@property (weak, nonatomic) IBOutlet UILabel *lbBackside;
@property (weak, nonatomic) IBOutlet UIImageView *imgBackside;
@end

NS_ASSUME_NONNULL_END
