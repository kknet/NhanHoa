//
//  DomainProfileCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainProfileCell.h"

@implementation DomainProfileCell
@synthesize lbDomain, btnChooseProfile, viewProfileInfo, imgType, lbProfileDesc, lbSepa;
@synthesize padding, hBTN;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    padding = 15.0;
    hBTN = 35.0;
    
    btnChooseProfile.layer.cornerRadius = hBTN/2;
    btnChooseProfile.titleLabel.font = [UIFont fontWithName:RobotoRegular size:16.0];
    btnChooseProfile.backgroundColor = BLUE_COLOR;
    [btnChooseProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.padding);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(100.0);
        make.height.mas_equalTo(self.hBTN);
    }];
    
    lbDomain.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbDomain.textColor = TITLE_COLOR;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self.btnChooseProfile.mas_left).offset(-10.0);
        make.top.bottom.equalTo(self.btnChooseProfile);
    }];
    
    //  profile info
    viewProfileInfo.clipsToBounds = TRUE;
    [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnChooseProfile.mas_bottom);
        make.bottom.equalTo(self).offset(-10.0);
        make.left.equalTo(self).offset(self.padding);
        make.right.equalTo(self).offset(-self.padding);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.viewProfileInfo.mas_centerY);
        make.left.equalTo(self.viewProfileInfo);
        make.width.height.mas_equalTo(35.0);
    }];
    
    lbProfileDesc.numberOfLines = 10;
    lbProfileDesc.font = [UIFont fontWithName:RobotoRegular size:15.0];
    lbProfileDesc.textColor = [UIColor colorWithRed:(100/255.0) green:(100/255.0) blue:(100/255.0) alpha:1.0];
    [lbProfileDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.viewProfileInfo);
        make.left.equalTo(self.imgType.mas_right).offset(10.0);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(self.padding);
        make.bottom.right.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)showProfileView: (BOOL)show {
    NSString *content = btnChooseProfile.currentTitle;
    float wText = [AppUtils getSizeWithText:content withFont:btnChooseProfile.titleLabel.font].width;
    
    [btnChooseProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-self.padding);
        make.top.equalTo(self).offset(10.0);
        make.width.mas_equalTo(wText + 20);
        make.height.mas_equalTo(self.hBTN);
    }];
    
    if (show) {
        [viewProfileInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnChooseProfile.mas_bottom);
            make.bottom.equalTo(self).offset(-10.0);
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
        }];
    }else{
        [viewProfileInfo mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.btnChooseProfile.mas_bottom);
            make.left.equalTo(self).offset(self.padding);
            make.right.equalTo(self).offset(-self.padding);
            make.height.mas_equalTo(0);
        }];
    }
}

@end
