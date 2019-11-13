//
//  AddCartResultPopupView.h
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol AddCartResultPopupViewDelegate <NSObject>
@optional
- (void)selectedOnButtonPayment;
@end

@interface AddCartResultPopupView : UIView

@property (nonatomic, strong) id<AddCartResultPopupViewDelegate, NSObject> delegate;

@property (nonatomic, strong) UIImageView *imgResult;
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIButton *btnContinue;
@property (nonatomic, strong) UIButton *btnPay;
@property (nonatomic, assign) float hBTN;

- (void)showInView:(UIView *)aView animated:(BOOL)animated;
- (void)fadeOut;

@end

NS_ASSUME_NONNULL_END
