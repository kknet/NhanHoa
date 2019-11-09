//
//  DomainNotSupportTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainNotSupportTbvCell.h"

@implementation DomainNotSupportTbvCell
@synthesize viewWrap, imgBackground, lbDomain, lbContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    viewWrap.clipsToBounds = TRUE;
    viewWrap.layer.cornerRadius = 12.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15.0);
    }];
    
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewWrap);
    }];
    
    lbDomain.font = textFont;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBackground).offset(padding);
        make.right.equalTo(imgBackground).offset(-padding);
        make.bottom.equalTo(imgBackground.mas_centerY).offset(-10.0);
    }];
    
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-4.0];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom).offset(2.0);
        make.left.right.equalTo(lbDomain);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
