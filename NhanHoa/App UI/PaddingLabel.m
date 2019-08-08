//
//  PaddingLabel.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaddingLabel.h"

@implementation PaddingLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = {0, 7.5, 0, 7.5};
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
