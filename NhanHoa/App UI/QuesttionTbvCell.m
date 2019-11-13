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
@synthesize padding;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    UIFont *textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
    }
    
    [imgDropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.width.height.mas_equalTo(18.0);
    }];
    
    lbTitle.font = textFont;
    lbTitle.textColor = GRAY_80;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(imgDropdown.mas_left).offset(-padding);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-1];
    lbContent.textColor = GRAY_100;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(0);
    }];
    
    lbSepa.backgroundColor = GRAY_235;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(lbContent);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)updateUIForSelected: (BOOL)selected {
    if (selected) {
        imgDropdown.image = [UIImage imageNamed:@"ic_dropdown_up"];
        float maxSize = (SCREEN_WIDTH - 2*padding);
        float hContent = [AppUtils getSizeWithText:lbContent.text withFont:lbContent.font andMaxWidth:maxSize].height + 5.0;
        [lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hContent);
        }];
        
        lbTitle.textColor = BLUE_COLOR;
    }else{
        imgDropdown.image = [UIImage imageNamed:@"ic_dropdown"];
        [lbContent mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        lbTitle.textColor = GRAY_80;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
