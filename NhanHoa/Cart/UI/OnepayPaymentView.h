//
//  OnepayPaymentView.h
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OnepayPaymentViewDelegate
- (void)paymentResultWithInfo: (NSDictionary *)info;
@end

@interface OnepayPaymentView : UIView<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
@property (nonatomic, strong) <NSObject, OnepayPaymentViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tbMethod;
@property (weak, nonatomic) IBOutlet UIWebView *wvPayment;

- (void)setupUIForViewWithMenuHeight: (float)hMenu heightNav:(float)hNav padding: (float)padding;
@property (nonatomic, assign) PaymentMethod typePaymentMethod;

@end

NS_ASSUME_NONNULL_END
