//
//  DomainModel.m
//  NhanHoa
//
//  Created by lam quang quan on 5/7/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainModel.h"

@implementation DomainModel

+ (NSString *)getPriceFromDomainInfo: (NSDictionary *)info {
    NSString *result = @"";
    id price = [info objectForKey:@"price_first_year"];
    if ([price isKindOfClass:[NSNumber class]]) {
        result = [NSString stringWithFormat:@"%d", [price intValue]];
        
    }else if ([price isKindOfClass:[NSString class]] && ![AppUtils isNullOrEmpty: price]) {
        result = price;
    }
    return result;
    
    /*
     available = 1;
     domain = "lequangkhai.xyz";
     "price_first_year" = 280000;
     "price_next_years" = 280000;
     "price_vat_first_year" = 28000;
     "price_vat_next_year" = 28000;
     "total_first_year" = 308000;
     "total_next_years" = 308000;
     vat = 10;
     */
}

@end
