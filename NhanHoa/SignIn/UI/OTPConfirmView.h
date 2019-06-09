//
//  OTPConfirmView.h
//  NhanHoa
//
//  Created by Khai Leo on 6/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OTPConfirmViewDelegate <NSObject>
@optional
- (void)confirmOTPWithCode: (NSString *)code;
- (void)onResendOTPPress;
@end

@interface OTPConfirmView : UIView

@property (weak, nonatomic) id<OTPConfirmViewDelegate, NSObject> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfChar1;
@property (weak, nonatomic) IBOutlet UITextField *tfChar2;
@property (weak, nonatomic) IBOutlet UITextField *tfChar3;
@property (weak, nonatomic) IBOutlet UITextField *tfChar4;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lbNotReceived;
@property (weak, nonatomic) IBOutlet UIButton *btnResend;

- (IBAction)btnResendPress:(UIButton *)sender;
- (IBAction)btnConfirmPress:(UIButton *)sender;
- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
