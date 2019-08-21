//
//  DNSDetailCell.m
//  NhanHoa
//
//  Created by OS on 7/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSDetailCell.h"

@implementation DNSDetailCell
@synthesize icDelete, icEdit, lbSepa5, lbTTL, lbSepa4, lbMX, lbSepa3, lbValue, lbSepa2, lbType, lbSepa1, lbHost, lbSepa6, lbBotSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (!IS_IPHONE && !IS_IPOD) {
        lbBotSepa.backgroundColor = lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
        icEdit.imageEdgeInsets = icDelete.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        
        float widthMX = 50.0;
        float widthTTL = 70.0;
        float widthBTN = 60.0;
        float widthType = [AppUtils getSizeWithText:@"URL Redirect" withFont:[AppDelegate sharedInstance].fontDesc].width + 10.0;
        float widthValue = (SCREEN_WIDTH - (widthBTN + widthBTN + widthTTL + widthMX + widthType + 6.0))/2;
        
        [lbHost mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(widthValue);
        }];
        
        [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(lbHost.mas_right);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa1.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthType);
        }];
        
        [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbType.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa2.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthValue);
        }];
        
        [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbValue.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa3.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthMX);
        }];
        
        [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbMX.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa4.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthTTL);
        }];
        
        [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbTTL.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [icEdit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(lbSepa5.mas_right).offset((widthBTN-40.0)/2);
            make.width.height.mas_equalTo(40.0);
        }];
        
        [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa5.mas_right).offset(widthBTN);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [icDelete mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icEdit);
            make.left.equalTo(lbSepa6.mas_right).offset((widthBTN-40.0)/2);
            make.width.equalTo(icEdit.mas_width);
        }];
        
        [lbBotSepa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(1.0);
        }];
        
        lbHost.textAlignment = lbType.textAlignment = lbValue.textAlignment = lbMX.textAlignment = lbTTL.textAlignment = NSTextAlignmentCenter;
        
        lbHost.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = [UIFont fontWithName:RobotoRegular size:18.0];
        
        return;
    }
    
    float padding = 5.0;
    icEdit.imageEdgeInsets = icDelete.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    
    float wHost = 100.0;
    float widthMX = 60.0;
    float widthTTL = 60.0;
    float widthValue = 120.0;
    float widthType = 40.0;
    float widthBTN = 40.0;
    
    NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        wHost = 80.0;
        widthTTL = 40.0;
        widthMX = 25.0;
        widthType = 75.0;
        widthBTN = 25.0;
        
        lbTTL.font = lbType.font = lbMX.font = lbValue.font = lbHost.font = [UIFont systemFontOfSize:12];
        icEdit.imageEdgeInsets = icDelete.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        wHost = 90.0;
        widthTTL = 45.0;
        widthMX = 30.0;
        widthType = 90.0;
        widthBTN = 35.0;
        
        lbTTL.font = lbType.font = lbMX.font = lbValue.font = lbHost.font = [UIFont systemFontOfSize:14];
        icEdit.imageEdgeInsets = icDelete.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2] || [deviceMode isEqualToString: simulator])
    {
        //  for 6s plus
        widthTTL = 50.0;
        widthMX = 40.0;
        widthType = 95.0;
        widthBTN = 40.0;
        
        lbTTL.font = lbType.font = lbMX.font = lbValue.font = lbHost.font = [UIFont systemFontOfSize:15.5];
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2])
    {
        widthMX = widthTTL = 50.0;
        widthType = 120.0;
        widthBTN = 60.0;
        
        lbTTL.font = lbType.font = lbMX.font = lbValue.font = lbHost.font = [UIFont systemFontOfSize:17];
    }
    
    float maxWidth = UIScreen.mainScreen.bounds.size.height - 44.0 - [UIApplication sharedApplication].statusBarFrame.size.height;
    widthValue = maxWidth - (padding + wHost + padding + 1.0 + (padding + widthType + padding) + 1.0 + (padding + padding) + 1.0 + (padding + widthMX + padding) + 1.0 + (padding + widthTTL + padding) + 1.0 + (padding + widthBTN + padding) + 1.0 + (padding + widthBTN + padding));
    
    [lbHost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(wHost);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(lbHost.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa1.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthType);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbType.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa2.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthValue);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbValue.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa3.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthMX);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMX.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa4.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthTTL);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTTL.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [icEdit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(lbSepa5.mas_right).offset(padding + (widthBTN-40.0)/2);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa5.mas_right).offset(padding + widthBTN + padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [icDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icEdit);
        make.left.equalTo(lbSepa6.mas_right).offset(padding + (widthBTN-40.0)/2);
        make.width.equalTo(icEdit.mas_width);
    }];
    
    [lbBotSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    lbTTL.textAlignment = lbMX.textAlignment = NSTextAlignmentCenter;
    
    lbBotSepa.backgroundColor = lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = [UIColor colorWithRed:(230/255.0) green:(230/255.0) blue:(230/255.0) alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showDNSRecordContentWithInfo: (NSDictionary *)info {
    if (info != nil && [info isKindOfClass:[NSDictionary class]]) {
        NSString *record_name = [info objectForKey:@"record_name"];
        lbHost.text = (![AppUtils isNullOrEmpty: record_name]) ? record_name : @"";
        
        NSString *record_type = [info objectForKey:@"record_type"];
        lbType.text = (![AppUtils isNullOrEmpty: record_type]) ? record_type : @"";
        
        NSString *record_value = [info objectForKey:@"record_value"];
        lbValue.text = (![AppUtils isNullOrEmpty: record_value]) ? record_value : @"";
        
        NSString *record_mx = [info objectForKey:@"record_mx"];
        lbMX.text = (![AppUtils isNullOrEmpty: record_mx]) ? record_mx : @"";
        
        NSString *record_ttl = [info objectForKey:@"record_ttl"];
        lbTTL.text = (![AppUtils isNullOrEmpty: record_ttl]) ? record_ttl : @"";
        
        /*
        "record_id" = 709276;
        "record_mx" = "<null>";
        "record_name" = "@";
        "record_ttl" = 3600;
        "record_type" = A;
        "record_value" = "172.104.55.77";
        */
    }else{
        lbTTL.text = lbValue.text = lbType.text = lbMX.text = lbHost.text = @"";
    }
}

- (void)refreshLayoutForView {
    if (!IS_IPHONE && !IS_IPOD) {
        float widthMX = 50.0;
        float widthTTL = 70.0;
        float widthBTN = 60.0;
        float widthType = [AppUtils getSizeWithText:@"URL Redirect" withFont:[AppDelegate sharedInstance].fontDesc].width + 10.0;
        float widthValue = (SCREEN_WIDTH - (widthBTN + widthBTN + widthTTL + widthMX + widthType + 6.0))/2;
        
        [lbHost mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.mas_equalTo(widthValue);
        }];
        
        [lbSepa1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(lbHost.mas_right);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa1.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthType);
        }];
        
        [lbSepa2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbType.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa2.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthValue);
        }];
        
        [lbSepa3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbValue.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbMX mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa3.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthMX);
        }];
        
        [lbSepa4 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbMX.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [lbTTL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa4.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(widthTTL);
        }];
        
        [lbSepa5 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbTTL.mas_right);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [icEdit mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.equalTo(lbSepa5.mas_right).offset((widthBTN-40.0)/2);
            make.width.height.mas_equalTo(40.0);
        }];
        
        [lbSepa6 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lbSepa5.mas_right).offset(widthBTN);
            make.top.bottom.equalTo(self);
            make.width.mas_equalTo(1.0);
        }];
        
        [icDelete mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(icEdit);
            make.left.equalTo(lbSepa6.mas_right).offset((widthBTN-40.0)/2);
            make.width.equalTo(icEdit.mas_width);
        }];
        
        return;
    }
    
    float padding = 5.0;
    float wHost = 100.0;
    float widthMX = 60.0;
    float widthTTL = 60.0;
    float widthValue = 120.0;
    float widthType = 40.0;
    float widthBTN = 40.0;
    
    NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        wHost = 80.0;
        widthTTL = 40.0;
        widthMX = 25.0;
        widthType = 75.0;
        widthBTN = 25.0;
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        wHost = 90.0;
        widthTTL = 45.0;
        widthMX = 30.0;
        widthType = 90.0;
        widthBTN = 35.0;
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2] || [deviceMode isEqualToString: simulator])
    {
        //  for 6s plus
        widthTTL = 50.0;
        widthMX = 40.0;
        widthType = 95.0;
        widthBTN = 40.0;
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2])
    {
        widthMX = widthTTL = 50.0;
        widthType = 120.0;
        widthBTN = 60.0;
    }
    
    float maxWidth = UIScreen.mainScreen.bounds.size.height - 44.0 - [UIApplication sharedApplication].statusBarFrame.size.height;
    widthValue = maxWidth - (padding + wHost + padding + 1.0 + (padding + widthType + padding) + 1.0 + (padding + padding) + 1.0 + (padding + widthMX + padding) + 1.0 + (padding + widthTTL + padding) + 1.0 + (padding + widthBTN + padding) + 1.0 + (padding + widthBTN + padding));
    
    [lbHost mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(wHost);
    }];
    
    [lbSepa1 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(lbHost.mas_right).offset(padding);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbType mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa1.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthType);
    }];
    
    [lbSepa2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbType.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbValue mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa2.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthValue);
    }];
    
    [lbSepa3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbValue.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbMX mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa3.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthMX);
    }];
    
    [lbSepa4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMX.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [lbTTL mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa4.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(widthTTL);
    }];
    
    [lbSepa5 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTTL.mas_right).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [icEdit mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(lbSepa5.mas_right).offset(padding + (widthBTN-40.0)/2);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [lbSepa6 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbSepa5.mas_right).offset(padding + widthBTN + padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(1.0);
    }];
    
    [icDelete mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(icEdit);
        make.left.equalTo(lbSepa6.mas_right).offset(padding + (widthBTN-40.0)/2);
        make.width.equalTo(icEdit.mas_width);
    }];
    
    [lbBotSepa mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

@end
