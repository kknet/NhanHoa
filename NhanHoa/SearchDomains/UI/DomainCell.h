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
@property (weak, nonatomic) IBOutlet UIButton *btnViewInfo;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float marginX;
@property (nonatomic, assign) float hBTN;

- (void)updateSizeButtonWithContent: (NSString *)content;
- (void)showPriceForDomainCell: (BOOL)show;
- (void)setStateForNotSupportDomain;

@end

NS_ASSUME_NONNULL_END
