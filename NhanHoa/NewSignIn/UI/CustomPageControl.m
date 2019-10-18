//
//  CustomPageControl.m
//  NhanHoa
//
//  Created by OS on 10/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CustomPageControl.h"

@implementation CustomPageControl

- (id)initWithNumberPage:(int)page {
    self = [super init];
    if (self) {
        for (int i=0; i<page; i++) {
            UIImageView *subImage = [[UIImageView alloc] init];
            [self addSubview: subImage];
            
        }
    }
    return self;
}

@end
