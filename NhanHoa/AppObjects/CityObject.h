//
//  CityObject.h
//  NhanHoa
//
//  Created by lam quang quan on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityObject : NSObject

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *name;

- (CityObject *)initWithCode: (NSString *)cityCode name: (NSString *)cityName;

@end
