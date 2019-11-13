//
//  AddCartResultPopupView.m
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddCartResultPopupView.h"

@implementation AddCartResultPopupView
@synthesize imgResult, lbTitle, btnPay, btnContinue, hBTN;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 12.0;
        
        float padding = 15.0;
        float hIMG = 80.0;
        hBTN = 50.0;
        
        UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            hBTN = 45.0;
            hIMG = 60.0;
            textFont = [UIFont fontWithName:RobotoBold size:18.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
            hBTN = 48.0;
            hIMG = 70.0;
            textFont = [UIFont fontWithName:RobotoBold size:20.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
            hBTN = 50.0;
            hIMG = 80.0;
            textFont = [UIFont fontWithName:RobotoBold size:22.0];
        }
        
        UIImage *imgOK = [UIImage imageNamed:@"search_domain_ok"];
        float widthImg = hIMG * imgOK.size.width/imgOK.size.height;
        imgResult = [[UIImageView alloc] init];
        imgResult.image = imgOK;
        [self addSubview: imgResult];
        [imgResult mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self).offset(2*padding);
            make.width.mas_equalTo(widthImg);
            make.height.mas_equalTo(hIMG);
        }];
        
        lbTitle = [[UILabel alloc] init];
        lbTitle.text = @"Thêm vào giỏ hàng thành công";
        lbTitle.textColor = GRAY_50;
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.font = textFont;
        [self addSubview: lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgResult.mas_bottom).offset(padding);
            make.left.equalTo(self).offset(5.0);
            make.right.equalTo(self).offset(-5.0);
            make.height.mas_equalTo(40.0);
        }];
        
        btnContinue = [[UIButton alloc] init];
        btnContinue.backgroundColor = [UIColor colorWithRed:(47/255.0) green:(125/255.0) blue:(215/255.0) alpha:1.0];
        [btnContinue setTitle:@"Tiếp tục mua" forState:UIControlStateNormal];
        [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btnContinue.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
        btnContinue.layer.cornerRadius = 8.0;
        [btnContinue addTarget:self
                        action:@selector(fadeOut)
              forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btnContinue];
        [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbTitle.mas_bottom).offset(padding);
            make.left.equalTo(self).offset(padding);
            make.right.equalTo(self).offset(-padding);
            make.height.mas_equalTo(hBTN);
        }];
        
        btnPay = [[UIButton alloc] init];
        btnPay.backgroundColor = [UIColor colorWithRed:(218/255.0) green:(81/255.0) blue:(90/255.0) alpha:1.0];
        [btnPay setTitle:@"Thanh toán" forState:UIControlStateNormal];
        [btnPay setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        btnPay.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
        btnPay.layer.cornerRadius = 8.0;
        [btnPay addTarget:self
                   action:@selector(onButtonPayPress)
         forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: btnPay];
        [btnPay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnContinue.mas_bottom).offset(padding);
            make.left.right.equalTo(btnContinue);
            make.height.mas_equalTo(hBTN);
        }];
        
    }
    return self;
}

- (void)onButtonPayPress {
    [self fadeOut];
    if ([delegate respondsToSelector:@selector(selectedOnButtonPayment)]) {
        [delegate selectedOnButtonPayment];
    }
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    //Add transparent
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBackground.backgroundColor = UIColor.blackColor;
    viewBackground.alpha = 0.5;
    viewBackground.tag = 20;
    [aView addSubview:viewBackground];
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
}

- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    for (UIView *subView in self.superview.subviews){
        if (subView.tag == 20){
            [subView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }
    }];
}

@end
