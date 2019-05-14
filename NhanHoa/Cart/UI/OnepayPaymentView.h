//
//  OnepayPaymentView.h
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OnepayPaymentView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tbMethod;
@property (weak, nonatomic) IBOutlet UIWebView *wvPayment;

- (void)setupUIForViewWithMenuHeight: (float)hMenu heightNav:(float)hNav padding: (float)padding;
@property (nonatomic, assign) int typePaymentMethod;

@end

NS_ASSUME_NONNULL_END
