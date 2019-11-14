//
//  DomainInfoRowTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainInfoRowTbvCell.h"

@implementation DomainInfoRowTbvCell
@synthesize lbTitle, lbContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:16.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:14.0];
        padding = 5.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:15.0];
        padding = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:17.0];
        padding = 15.0;
    }
    float maxSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Registration date"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 10.0;
    
    lbTitle.font = textFont;
    lbTitle.textColor = TITLE_COLOR;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(maxSize);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    lbContent.textColor = TITLE_COLOR;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbTitle.mas_right);
        make.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-padding);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
