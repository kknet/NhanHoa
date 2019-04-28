//
//  HomeMenuObject.m
//  NhanHoa
//
//  Created by admin on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HomeMenuObject.h"

@implementation HomeMenuObject

@synthesize menuIcon, menuName, menuType;

- (HomeMenuObject *)initWithName: (NSString *)name icon: (NSString *)icon type: (TypeHomeMenu)type {
    HomeMenuObject *menu = [[HomeMenuObject alloc] init];
    menu.menuName = name;
    menu.menuIcon = icon;
    menu.menuType = type;
    return menu;
}

@end
