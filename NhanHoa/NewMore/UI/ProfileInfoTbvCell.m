//
//  ProfileInfoTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileInfoTbvCell.h"

@implementation ProfileInfoTbvCell
@synthesize lbSepa, lbTitle, lbValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:19.0];
    }
    
    lbTitle.font = lbValue.font  = textFont;
    
    lbTitle.textColor = GRAY_150;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        //  make.top.equalTo(self).offset(20.0);
        make.left.equalTo(self).offset(padding);
        make.width.mas_equalTo(0);
    }];
    
    lbValue.textColor = GRAY_50;
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        //  make.top.equalTo(self).offset(20.0);
        make.right.equalTo(self).offset(-padding);
        make.left.equalTo(lbTitle.mas_right).offset(10.0);
    }];
    
    lbSepa.backgroundColor = GRAY_230;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTitle);
        make.right.equalTo(lbValue);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateFrameWithContent {
    float textSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:lbTitle.text] withFont:lbTitle.font andMaxWidth:SCREEN_WIDTH].width + 5.0;
    
    [lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(textSize);
    }];
}

@end
