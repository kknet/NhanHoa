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
    UIFont *textFont = [UIFont systemFontOfSize:20.0 weight:UIFontWeightThin];
    float sizeIcon = 54.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:13.0];
        sizeIcon = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:14.5];
        sizeIcon = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        sizeIcon = 54.0;
        textFont = [UIFont fontWithName:RobotoRegular size:15.5];
    }
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    lbMenu.textColor = [UIColor colorWithRed:(30/255.0) green:(30/255.0) blue:(30/255.0) alpha:1.0];
    lbMenu.font = textFont;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgType.mas_bottom);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(25.0);
    }];
}

@end
