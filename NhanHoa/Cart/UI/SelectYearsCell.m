//
//  SelectYearsCell.m
//  NhanHoa
//
//  Created by lam quang quan on 5/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SelectYearsCell.h"

@implementation SelectYearsCell
@synthesize lbContent;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if (IS_IPHONE || IS_IPOD) {
        lbContent.font = [UIFont fontWithName:RobotoRegular size:16.0];
    }else{
        lbContent.font = [AppDelegate sharedInstance].fontNormal;
    }
    
    lbContent.textColor = TITLE_COLOR;
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5.0);
        make.right.equalTo(self).offset(-5.0);
        make.top.bottom.equalTo(self);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
