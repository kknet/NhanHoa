//
//  NewHomeMenuCell.h
//  NhanHoa
//
//  Created by OS on 7/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewHomeMenuCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbSepaBottom;
@property (weak, nonatomic) IBOutlet UILabel *lbSepaRight;

@end

NS_ASSUME_NONNULL_END
