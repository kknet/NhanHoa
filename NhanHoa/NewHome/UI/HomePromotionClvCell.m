//
//  HomePromotionClvCell.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomePromotionClvCell.h"

@implementation HomePromotionClvCell
@synthesize lbTitle, imgPromotion, viewContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = TRUE;
    
    UIFont *textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
    
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            textFont = [UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
        {
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
            
        }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
        {
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
            
        }else{
            textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
        }
    }else{
        textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium];
    }
    
    viewContent.layer.cornerRadius = 10.0;
    viewContent.clipsToBounds = TRUE;
    viewContent.backgroundColor = UIColor.whiteColor;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.left.bottom.right.equalTo(self);
        make.top.left.equalTo(self);
        make.bottom.right.equalTo(self).offset(-5.0);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = [UIColor colorWithRed:(48/255.0) green:(48/255.0) blue:(48/255.0) alpha:1.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent).offset(5.0);
        make.right.equalTo(viewContent).offset(-5.0);
        make.bottom.equalTo(viewContent);
        make.height.mas_equalTo(50.0);
    }];
    
    [imgPromotion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewContent);
        make.bottom.equalTo(lbTitle.mas_top);
    }];
    
    [self addBoxShadowForView:self color:[UIColor colorWithRed:(150/255.0) green:(150/255.0)
                                                          blue:(150/255.0) alpha:0.8]
                      opacity:1.0 offsetX:1 offsetY:1];
}

- (void)addBoxShadowForView: (UIView *)view color: (UIColor *)color opacity: (float)opacity offsetX: (float)x offsetY:(float)y
{
    view.layer.masksToBounds = FALSE;
    view.layer.shadowOffset = CGSizeMake(x, y);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = opacity;
}

@end
