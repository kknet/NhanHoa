//
//  SignInDescClvCell.m
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SignInDescClvCell.h"

@implementation SignInDescClvCell
@synthesize imgPhoto, lbTitle, lbContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    UIFont *titleFont = [UIFont fontWithName:RobotoBold size:24.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        titleFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        titleFont = [UIFont fontWithName:RobotoBold size:22.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        titleFont = [UIFont fontWithName:RobotoBold size:24.0];
    }
    
    
    float padding = 15.0;
    float hLabel = 60.0;
    float hContent = 60.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        hLabel = 40.0;
        hContent = 40.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6) {
        hLabel = 40.0;
        hContent = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        hLabel = 60.0;
        hContent = 60.0;
    }
    
    lbContent.font = textFont;
    lbContent.textColor = [UIColor colorWithRed:(120/255.0) green:(120/255.0)
                                           blue:(120/255.0) alpha:1.0];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.bottom.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hContent);
    }];
    
    lbTitle.font = titleFont;
    lbTitle.textColor = BLUE_COLOR;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbContent);
        make.bottom.equalTo(lbContent.mas_top);
        make.height.mas_equalTo(hLabel);
    }];
    
    [imgPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(lbTitle.mas_top).offset(-padding);
    }];
}

@end
