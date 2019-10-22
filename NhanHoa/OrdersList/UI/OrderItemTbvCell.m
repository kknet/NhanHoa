//
//  OrderItemTbvCell.m
//  NhanHoa
//
//  Created by OS on 10/22/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderItemTbvCell.h"

@implementation OrderItemTbvCell

@synthesize viewWrap, lbID, lbIDValue, lbDomain, lbDomainValue, lbCreatedDate, lbCreatedDateValue, lbState, lbStateValue, imgState;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float hLabel = 25.0;
    float padding = 15.0;
    self.backgroundColor = self.contentView.backgroundColor = UIColor.clearColor;
    
    UIFont *textFont = [UIFont fontWithName:RobotoMedium size:18.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:14.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:16.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
    }
    
    lbID.font = lbDomain.font = lbCreatedDate.font = lbState.font = textFont;
    lbID.textColor = lbDomain.textColor = lbCreatedDate.textColor = lbState.textColor = GRAY_50;
    
    lbIDValue.font = lbDomainValue.font = lbCreatedDateValue.font = lbStateValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    lbIDValue.textColor = lbDomainValue.textColor = lbCreatedDateValue.textColor = lbStateValue.textColor = GRAY_80;
    
    float leftSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Created date"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 30;
    
    viewWrap.backgroundColor = UIColor.whiteColor;
    viewWrap.layer.cornerRadius = 5.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15.0);
    }];
    
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrap).offset(padding);
        make.bottom.equalTo(viewWrap.mas_centerY);
        make.width.mas_equalTo(leftSize);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbDomain.mas_right);
        make.top.bottom.equalTo(lbDomain);
        make.right.equalTo(viewWrap).offset(-padding);
    }];
    
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomain);
        make.bottom.equalTo(lbDomain.mas_top);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainValue);
        make.top.bottom.equalTo(lbID);
    }];
    
    [lbCreatedDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomain);
        make.top.equalTo(lbDomain.mas_bottom);
        make.height.mas_equalTo(hLabel);
    }];

    [lbCreatedDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainValue);
        make.top.bottom.equalTo(lbCreatedDate);
    }];
    
    [lbState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbCreatedDate);
        make.top.equalTo(lbCreatedDate.mas_bottom);
        make.height.mas_equalTo(hLabel);
    }];

    [imgState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbCreatedDateValue);
        make.centerY.equalTo(lbState.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];

    [lbStateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgState.mas_right).offset(5.0);
        make.right.equalTo(lbCreatedDateValue);
        make.top.bottom.equalTo(lbState);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
