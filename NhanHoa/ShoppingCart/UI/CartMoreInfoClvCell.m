//
//  CartMoreInfoClvCell.m
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartMoreInfoClvCell.h"

@implementation CartMoreInfoClvCell
@synthesize viewWrapper, lbTitle, lbContent, lbPrice, btnRegisterMore;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundColor = UIColor.clearColor;
    
    self.clipsToBounds = TRUE;
    
    float padding = 15.0;
    float hBTN = 45.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:20.0];
    if (IS_IPHONE || IS_IPOD) {
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            textFont = [UIFont fontWithName:RobotoBold size:16.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
            textFont = [UIFont fontWithName:RobotoBold size:18.0];
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
            textFont = [UIFont fontWithName:RobotoBold size:20.0];
        }
    }
    
    viewWrapper.layer.cornerRadius = 10.0;
    viewWrapper.clipsToBounds = TRUE;
    viewWrapper.backgroundColor = UIColor.whiteColor;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.bottom.right.equalTo(self).offset(-3.0);
    }];
    
    lbTitle.textColor = lbPrice.textColor = GRAY_80;
    lbContent.textColor = GRAY_100;
    
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWrapper).offset(5.0);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-1];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(50.0);
    }];
    
    lbPrice.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-1];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbContent.mas_bottom).offset(5.0);
        make.left.equalTo(lbContent);
        make.height.mas_equalTo(hBTN);
    }];
    
    float sizeText = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Register more"]
                                      withFont:[UIFont fontWithName:RobotoThin size:textFont.pointSize]
                                   andMaxWidth:SCREEN_WIDTH].width + 10.0;
    [btnRegisterMore setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Register more"]
                     forState:UIControlStateNormal];
    btnRegisterMore.layer.borderWidth = 1.0;
    btnRegisterMore.layer.cornerRadius = 5.0;
    btnRegisterMore.layer.borderColor = BLUE_COLOR.CGColor;
    btnRegisterMore.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnRegisterMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbContent);
        make.top.equalTo(lbPrice);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hBTN);
    }];
    
    [AppUtils addBoxShadowForView:self color:GRAY_200 opacity:0.8 offsetX:1 offsetY:1];
}

@end
