//
//  CartMoreInfoClvCell.h
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartMoreInfoClvCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterMore;

@end

NS_ASSUME_NONNULL_END
