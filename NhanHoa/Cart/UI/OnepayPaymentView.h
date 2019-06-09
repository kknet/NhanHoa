//
//  OnepayPaymentView.h
//  NhanHoa
//
//  Created by admin on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentResultView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OnepayPaymentViewDelegate
- (void)paymentResultWithInfo: (NSDictionary *)info;
- (void)userClickCancelPayment;
- (void)onBackIconClick;
@end

@interface OnepayPaymentView : UIView<UIWebViewDelegate, WebServiceUtilsDelegate>
@property (nonatomic, strong) id<NSObject, OnepayPaymentViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIWebView *wvPayment;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *icWaiting;

- (IBAction)icBackClick:(UIButton *)sender;
- (void)setupUIForView;
- (void)showPaymentContentViewWithMoney: (long)money;

@property (nonatomic, assign) PaymentMethod typePaymentMethod;
@property (nonatomic, assign) NSString *typePayment;
@property (nonatomic, assign) long topupMoney;

@property (nonatomic, strong) PaymentResultView *resultView;

@end

NS_ASSUME_NONNULL_END
