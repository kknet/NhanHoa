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
    float hLabel = 35.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:15.0];
        hLabel = 25.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:17.0];
        hLabel = 30.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        textFont = [UIFont fontWithName:RobotoMedium size:19.0];
        hLabel = 35.0;
    }
    
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(15.0);
        make.height.mas_equalTo(hLabel);
    }];
    
    lbValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.top.bottom.equalTo(lbTitle);
    }];
    
    lbDesc.backgroundColor = BLUE_COLOR;
    lbDesc.clipsToBounds = TRUE;
    lbDesc.layer.cornerRadius = 4.0;
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-1];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbValue);
        make.top.equalTo(lbValue.mas_bottom);
        make.height.mas_equalTo(hLabel);
    }];
    
    [imgStatus mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbValue.mas_left).offset(-10.0);
        make.centerY.equalTo(lbValue.mas_centerY);
        make.width.height.mas_equalTo(20.0);
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

@end
