//
//  HaveNotSignedView.m
//  NhanHoa
//
//  Created by lam quang quan on 6/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HaveNotSignedView.h"

@implementation HaveNotSignedView
@synthesize imgAvatar, lbNotSigned;

- (void)setupUIForView {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 7.0;
    
    float padding = 15.0;
    
    imgAvatar.layer.cornerRadius = 45.0/2;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(45.0);
    }];
    
    lbNotSigned.textColor = UIColor.grayColor;
    lbNotSigned.font = [AppDelegate sharedInstance].fontBTN;
    [lbNotSigned mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgAvatar.mas_right).offset(5.0);
        make.top.bottom.equalTo(self.imgAvatar);
        make.right.equalTo(self).offset(-padding);
    }];
}

@end
