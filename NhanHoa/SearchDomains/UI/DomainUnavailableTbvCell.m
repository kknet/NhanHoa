//
//  DomainUnavailableTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainUnavailableTbvCell.h"

@implementation DomainUnavailableTbvCell
@synthesize viewWrap, imgBackground, lbTopDomain, lbDesc, tbSubs;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    
    float padding = 15.0;
    UIImage *bg = [UIImage imageNamed:@"domain-search-unavailabel"];
    float hBG = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    
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
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hBG);
    }];
    
    lbTopDomain.font = textFont;
    [lbTopDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBackground).offset(padding);
        make.right.equalTo(imgBackground).offset(-padding);
        make.bottom.equalTo(imgBackground.mas_centerY).offset(-10.0);
    }];
    
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2.0];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTopDomain.mas_bottom).offset(2.0);
        make.left.right.equalTo(lbTopDomain);
    }];
    
    tbSubs.backgroundColor = ORANGE_COLOR;
    tbSubs.backgroundColor = UIColor.whiteColor;
    [tbSubs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBackground.mas_bottom);
        make.left.right.bottom.equalTo(viewWrap);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
