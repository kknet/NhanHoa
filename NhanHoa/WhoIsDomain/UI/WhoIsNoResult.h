//
//  WhoIsNoResult.h
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WhoIsNoResult : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UIImageView *imgEmoji;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
@property (weak, nonatomic) IBOutlet UIView *viewDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbOldPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIButton *btnChoose;

- (void)setupUIForView;
- (void)showContentOfDomainWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
