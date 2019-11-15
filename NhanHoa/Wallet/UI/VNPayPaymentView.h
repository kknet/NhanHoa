//
//  VNPayPaymentView.h
//  NhanHoa
//
//  Created by OS on 11/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VNPayPaymentViewDelegate <NSObject>

@optional
- (void)closeVNPayPaymentView;
- (void)VNPayPaymentSuccessful;
@end

@interface VNPayPaymentView : UIView<UIWebViewDelegate, WebServiceUtilsDelegate>

@property (nonatomic, strong) id<VNPayPaymentViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIWebView *wvContent;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *icWaiting;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
- (IBAction)icBackClick:(UIButton *)sender;

- (void)setupUIForViewWithHeightNav: (float)hNav;
- (void)tryToLoadContentWithData: (NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
