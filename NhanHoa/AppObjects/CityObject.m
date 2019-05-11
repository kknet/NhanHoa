//
//  CityObject.m
//  NhanHoa
//
//  Created by lam quang quan on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CityObject.h"

@implementation CityObject

@synthesize code, name;

- (CityObject *)initWithCode: (NSString *)cityCode name: (NSString *)cityName {
    CityObject *city = [[CityObject alloc] init];
    city.code = cityCode;
    city.name = cityName;
    
    return city;
}

@end
