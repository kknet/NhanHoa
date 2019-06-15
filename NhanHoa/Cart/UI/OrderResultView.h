//
//  OrderResultView.h
//  NhanHoa
//
//  Created by Khai Leo on 6/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderResultView : UIView
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;
@property (weak, nonatomic) IBOutlet UIButton *btnClose;

- (void)setupUIForView;
- (void)setContentViewWithInfo: (NSDictionary *)paymentResult;
@end

NS_ASSUME_NONNULL_END
