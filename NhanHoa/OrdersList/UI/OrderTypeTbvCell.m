//
//  OrderTypeTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/22/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderTypeTbvCell.h"

@implementation OrderTypeTbvCell
@synthesize lbName, lbCount, lbSepa;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:20.0];
    float padding = 15.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS) {
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
    }
    
    lbCount.layer.cornerRadius = 30.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.textColor = UIColor.whiteColor;
    lbCount.font = [UIFont fontWithName:RobotoThin size:textFont.pointSize];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(30.0);
    }];
    
    lbName.font = textFont;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.right.equalTo(lbCount.mas_left).offset(-padding);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(lbName);
        make.right.equalTo(lbCount);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCellIsSelected: (BOOL)select {
    if (select) {
        lbCount.backgroundColor = BLUE_COLOR;
        lbName.textColor = TITLE_COLOR;
    }else{
        lbCount.backgroundColor = GRAY_80;
        lbName.textColor = [UIColor colorWithRed:(180/255.0) green:(180/255.0) blue:(180/255.0) alpha:1.0];
    }
}

@end
