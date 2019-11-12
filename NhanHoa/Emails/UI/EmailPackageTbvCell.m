//
//  EmailPackageTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "EmailPackageTbvCell.h"

@implementation EmailPackageTbvCell
@synthesize viewWrap, lbMonths, lbPrice, lbTotal;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:24.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:24.0];
    }
    
    viewWrap.layer.cornerRadius = 5.0;
    viewWrap.layer.borderColor = UIColor.clearColor.CGColor;
    viewWrap.layer.borderWidth = 2.0;
    viewWrap.clipsToBounds = TRUE;
    viewWrap.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(244/255.0) blue:(246/255.0) alpha:1.0];
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-10.0);
    }];
    
    lbMonths.textColor = BLUE_COLOR;
    lbMonths.font = textFont;
    [lbMonths mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap).offset(padding);
        make.centerY.equalTo(viewWrap.mas_centerY);
        make.width.mas_equalTo(120.0);
    }];
    
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-6.0];
    lbPrice.textColor = GRAY_100;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbMonths.mas_right).offset(10.0);
        make.right.equalTo(viewWrap).offset(-padding);
        make.bottom.equalTo(viewWrap.mas_centerY).offset(-1.0);
    }];
    
    lbTotal.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-4.0];
    lbTotal.textColor = GRAY_50;
    [lbTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbPrice);
        make.top.equalTo(viewWrap.mas_centerY).offset(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected) {
        viewWrap.backgroundColor = UIColor.whiteColor;
        viewWrap.layer.borderColor = [UIColor colorWithRed:(240/255.0) green:(155/255.0) blue:(52/255.0) alpha:1.0].CGColor;
    }else{
        viewWrap.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(244/255.0) blue:(246/255.0) alpha:1.0];
        viewWrap.layer.borderColor = UIColor.clearColor.CGColor;
    }
}

@end
