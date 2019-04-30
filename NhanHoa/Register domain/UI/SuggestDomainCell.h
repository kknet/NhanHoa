//
//  SuggestDomainCell.h
//  NhanHoa
//
//  Created by admin on 4/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuggestDomainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewParent;
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbPriceLine;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hItem;

- (void)addBoxShadowForView: (UIView *)view withColor: (UIColor *)color;

@end

NS_ASSUME_NONNULL_END
