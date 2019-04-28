//
//  HomeMenuCell.h
//  NhanHoa
//
//  Created by admin on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeMenuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbSepaBottom;
@property (weak, nonatomic) IBOutlet UILabel *lbSepaRight;

@end

NS_ASSUME_NONNULL_END
