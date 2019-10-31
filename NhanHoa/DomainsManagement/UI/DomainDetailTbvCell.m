//
//  DomainDetailTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainDetailTbvCell.h"

@implementation DomainDetailTbvCell
@synthesize lbTitle, lbValue, lbDesc, imgStatus, lbSepa;
@synthesize textFont, padding;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    float hLabel = 25.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        textFont = [UIFont fontWithName:RobotoMedium size:19.0];
    }
    
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(15.0);
        make.width.mas_equalTo(0);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.bottom.equalTo(lbTitle);
        make.left.equalTo(lbTitle.mas_right);
    }];
    
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbValue);
        make.top.equalTo(lbValue.mas_bottom);
        make.height.mas_equalTo(hLabel);
        make.width.mas_equalTo(0);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
    lbTitle.textColor = lbValue.textColor = GRAY_100;
    lbDesc.textColor = UIColor.whiteColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateFrameWithContentValue {
    float leftSize = [AppUtils getSizeWithText:lbTitle.text withFont:lbTitle.font andMaxWidth:SCREEN_WIDTH].width + 20.0;
    [lbTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(leftSize);
    }];
    
    if (![lbDesc.text isEqualToString:@""]) {
        float sizeDesc = [AppUtils getSizeWithText:lbDesc.text withFont:lbDesc.font andMaxWidth:SCREEN_WIDTH].width + 5.0;
        [lbDesc mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(sizeDesc);
        }];
    }else{
        [lbDesc mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(0);
        }];
    }
    
    if ([lbTitle.text isEqualToString:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Status"]]) {
        float sizeStatus = [AppUtils getSizeWithText:lbValue.text withFont:lbValue.font andMaxWidth:SCREEN_WIDTH].width + 5.0;
        [lbValue mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-padding);
            make.top.bottom.equalTo(lbTitle);
            make.width.mas_equalTo(sizeStatus);
        }];
        
        [imgStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(lbValue.mas_left);
            make.centerY.equalTo(lbValue.mas_centerY);
            make.width.height.mas_equalTo(20.0);
        }];
    }
    
}

@end
