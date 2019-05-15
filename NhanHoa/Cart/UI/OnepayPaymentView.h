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
- (void)onPaymentCancelButtonClick;
@end

@interface OnepayPaymentView : UIView<UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>
@property (nonatomic, strong) id<NSObject, OnepayPaymentViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tbMethod;
@property (weak, nonatomic) IBOutlet UIWebView *wvPayment;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *icWaiting;

- (void)setupUIForViewWithMenuHeight: (float)hMenu heightNav:(float)hNav padding: (float)padding;
@property (nonatomic, assign) PaymentMethod typePaymentMethod;

@property (nonatomic, assign) NSString *typePayment;
@property (nonatomic, assign) long topupMoney;

@end

NS_ASSUME_NONNULL_END
