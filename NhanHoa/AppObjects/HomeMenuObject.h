//
//  HomeMenuObject.h
//  NhanHoa
//
//  Created by admin on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface HomeMenuObject : NSObject

@property (nonatomic, strong) NSString *menuIcon;
@property (nonatomic, strong) NSString *menuName;
@property (nonatomic, assign) TypeHomeMenu menuType;

- (HomeMenuObject *)initWithName: (NSString *)name icon: (NSString *)icon type: (TypeHomeMenu)type;

@end

NS_ASSUME_NONNULL_END
