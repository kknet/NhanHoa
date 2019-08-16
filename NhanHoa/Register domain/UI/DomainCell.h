//
//  DomainCell.h
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *parentView;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnChoose;
@property (weak, nonatomic) IBOutlet UIButton *btnWarning;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float marginX;

- (void)addBoxShadowForView: (UIView *)view withColor: (UIColor *)color;

- (void)updateSizeButtonWithContent: (NSString *)content;
- (void)showPriceForDomainCell: (BOOL)show;

@end

NS_ASSUME_NONNULL_END
