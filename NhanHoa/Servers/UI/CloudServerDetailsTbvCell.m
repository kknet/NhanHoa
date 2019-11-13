//
//  CloudServerDetailsTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CloudServerDetailsTbvCell.h"

@implementation CloudServerDetailsTbvCell
@synthesize imgChecked, lbTitle, lbValue;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        textFont = [UIFont fontWithName:RobotoRegular size:19.0];
    }
    
    [imgChecked mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbValue.textColor = [UIColor colorWithRed:(63/255.0) green:(63/255.0) blue:(63/255.0) alpha:1.0];
    lbValue.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.left.equalTo(lbTitle.mas_right).offset(10.0);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-padding);
    }];
    
    lbTitle.textColor = [UIColor colorWithRed:(85/255.0) green:(85/255.0) blue:(85/255.0) alpha:1.0];
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgChecked.mas_right).offset(10.0);
        make.top.bottom.equalTo(self);
        make.right.equalTo(lbValue.mas_left).offset(-10.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
