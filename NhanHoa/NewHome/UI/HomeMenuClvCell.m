//
//  HomeMenuClvCell.m
//  NhanHoa
//
//  Created by OS on 10/15/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeMenuClvCell.h"

@implementation HomeMenuClvCell
@synthesize imgType, lbMenu;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIFont *textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    if (IS_IPHONE || IS_IPOD) {
        NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
        if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
        {
            textFont = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            
        }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
        {
            textFont = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            
        }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
        {
            textFont = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            
        }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator])
        {
            textFont = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
            
        }else{
            textFont = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
        }
    }else{
        textFont = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
    }
    
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(45.0);
    }];
    
    lbMenu.textColor = [UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1.0];
    lbMenu.font = textFont;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgType.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(25.0);
    }];
}

@end
