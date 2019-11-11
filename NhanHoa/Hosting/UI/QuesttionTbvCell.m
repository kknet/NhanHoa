//
//  QuesttionTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "QuesttionTbvCell.h"

@implementation QuesttionTbvCell
@synthesize lbTitle, lbContent, lbSepa, imgDropdown;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    }
    
    [imgDropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.width.height.mas_equalTo(15.0);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_80;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(imgDropdown.mas_left).offset(padding);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(1.0);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbContent.textColor = GRAY_100;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa.mas_bottom).offset(padding);
        make.left.right.equalTo(lbSepa);
        make.bottom.equalTo(self).offset(-padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
