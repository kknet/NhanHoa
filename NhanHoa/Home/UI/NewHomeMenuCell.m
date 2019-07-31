//
//  NewHomeMenuCell.m
//  NhanHoa
//
//  Created by OS on 7/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewHomeMenuCell.h"

@implementation NewHomeMenuCell
@synthesize imgType, lbName, lbSepaRight, lbSepaBottom;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // Initialization code
    float sizeIcon = [self getSizeIconForDevice];
    float mTop = 5.0;
    
    if ([DeviceUtils isScreen320]) {
        mTop = 0.0;
    }
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_centerY).offset(0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    lbName.numberOfLines = 10;
    lbName.font = [self getFontForDevice];
    lbName.textColor = TITLE_COLOR;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.centerX.equalTo(self.mas_centerX);
        //        make.top.equalTo(self.imgType.mas_bottom).offset(5.0);
        //        make.width.mas_equalTo(105.0);
        make.top.equalTo(self.imgType.mas_bottom).offset(mTop);
        make.left.equalTo(self).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
    }];
    
    
    lbSepaRight.backgroundColor = LIGHT_GRAY_COLOR;
    [lbSepaRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-1.0);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    lbSepaBottom.backgroundColor = lbSepaRight.backgroundColor;
    [lbSepaBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (UIFont *)getFontForDevice {
    NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        return [UIFont fontWithName:RobotoRegular size:13.5];
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        return [UIFont fontWithName:RobotoRegular size:14];
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
    {
        return [UIFont fontWithName:RobotoRegular size:16];
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator]){
        return [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else{
        return [UIFont fontWithName:RobotoRegular size:14.0];
    }
}

- (float)getSizeIconForDevice {
    float size = 45.0;
    
    NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        size = 32.0;
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        size = 38.0;
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
    {
        size = 41.0;
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator]){
        size = 43.0;
    }else{
        
    }
    return size;
}

@end
