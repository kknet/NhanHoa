//
//  CheckDomainForRegisterHostingView.h
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CheckDomainForRegisterHostingViewDelegate <NSObject>

@optional
- (void)closeCheckDomainView;
- (void)confirmAfterCheckDomainView;
@end

@interface CheckDomainForRegisterHostingView : UIView

@property (nonatomic, strong) id<CheckDomainForRegisterHostingViewDelegate, NSObject> delegate;

@property (weak, nonatomic) IBOutlet UILabel *lbBackground;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfDomain;
@property (weak, nonatomic) IBOutlet UIButton *icCheck;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIView *viewResult;
@property (weak, nonatomic) IBOutlet UILabel *lbResult;
@property (weak, nonatomic) IBOutlet UIImageView *imgResult;

- (IBAction)btnRegisterPress:(UIButton *)sender;
- (IBAction)icCheckClick:(UIButton *)sender;
- (IBAction)icBackClick:(UIButton *)sender;

@property (nonatomic, assign) float hContentView;
@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hImgResult;
- (void)showContentInfoView;
- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
