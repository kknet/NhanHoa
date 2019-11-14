//
//  ContactTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContactTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@end

NS_ASSUME_NONNULL_END
