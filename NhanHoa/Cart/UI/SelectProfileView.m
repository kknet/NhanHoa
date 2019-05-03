//
//  SelectProfileView.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SelectProfileView.h"

@implementation SelectProfileView
@synthesize viewHeader, icAdd, lbTitle, tbProfile, icClose;
@synthesize hHeader, delegate;

- (void)setupUIForView {
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(self.hHeader);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(13, 13, 13, 13);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.equalTo(self);
        make.width.height.mas_equalTo(self.hHeader - [AppDelegate sharedInstance].hStatusBar);
    }];
    
    icAdd.imageEdgeInsets = UIEdgeInsetsMake(11, 11, 11, 11);
    [icAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.right.equalTo(self.mas_right);
        make.width.equalTo(self.icClose.mas_width);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icClose);
        make.left.equalTo(self.icClose.mas_right).offset(5.0);
        make.right.equalTo(self.icAdd.mas_left).offset(-5.0);
    }];
    
    [tbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
}

- (IBAction)icAddClick:(UIButton *)sender {
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [delegate onIconCloseClicked];
}
@end
