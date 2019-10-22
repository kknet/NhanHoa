//
//  SuggestDomainCell.m
//  NhanHoa
//
//  Created by admin on 4/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SuggestDomainCell.h"

@implementation SuggestDomainCell
@synthesize imgType, lbSepa, lbDomain, lbPrice, viewParent, padding, hItem, paddingX;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    paddingX = 5.0;
    float sizeIcon = 60.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:18.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:14.0];
        sizeIcon = 40.0;
        padding = 5.0;
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
    }
    
    self.backgroundColor = UIColor.clearColor;
    viewParent.layer.cornerRadius = 5.0;
    
    [viewParent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(self).offset(7.5);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(self).offset(-7.5);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewParent).offset(paddingX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgType.mas_right).offset(paddingX);
        make.top.equalTo(viewParent).offset(5.0);
        make.bottom.equalTo(viewParent).offset(-5.0);
        make.width.mas_equalTo(1.0);
    }];
    
    lbPrice.textColor = [UIColor colorWithRed:(213/255.0) green:(52/255.0) blue:(93/255.0) alpha:1.0];
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewParent.mas_centerY).offset(2.0);
        make.left.equalTo(lbSepa.mas_right).offset(paddingX);
        make.right.equalTo(viewParent).offset(-5.0);
    }];
    
    lbDomain.textColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0];
    lbDomain.font = textFont;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbPrice);
        make.bottom.equalTo(viewParent.mas_centerY).offset(-2.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
