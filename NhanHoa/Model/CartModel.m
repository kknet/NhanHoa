//
//  CartModel.m
//  NhanHoa
//
//  Created by lam quang quan on 5/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartModel.h"

@implementation CartModel
@synthesize listDomain;

+(CartModel *)getInstance{
    static CartModel* cartModel = nil;
    if(cartModel == nil){
        cartModel = [[CartModel alloc] init];
        cartModel.listDomain = [[NSMutableArray alloc] init];
    }
    return cartModel;
}

- (void)clearAllListDomainFromCart {
    [listDomain removeAllObjects];
}

- (void)addDomainToCart: (NSDictionary *)info {
    NSMutableDictionary *domainInfo = [[NSMutableDictionary alloc] initWithDictionary: info];
    [domainInfo setObject:@"1" forKey:year_for_domain];
    
    if (listDomain.count == 0) {
        [listDomain addObject: domainInfo];
    }else{
        [listDomain insertObject:domainInfo atIndex:0];
    }
}

- (void)removeDomainFromCart: (NSDictionary *)info {
    NSString *domain = [info objectForKey:@"domain"];
    if (![AppUtils isNullOrEmpty: domain]) {
        for (int index=0; index<listDomain.count; index++) {
            NSDictionary *curInfo = [listDomain objectAtIndex: index];
            NSString *curDomain = [curInfo objectForKey:@"domain"];
            if (![AppUtils isNullOrEmpty: curDomain]) {
                if ([curDomain isEqualToString: domain]) {
                    [listDomain removeObject: curInfo];
                    break;
                }
            }
        }
    }
}

- (int)countItemInCart {
    return (int)listDomain.count;
}

- (void)displayCartInfoWithView: (UILabel *)lbCount {
    if ([self countItemInCart] > 0) {
        lbCount.text = [NSString stringWithFormat:@"%d", [self countItemInCart]];
        lbCount.hidden = FALSE;
    }else{
        lbCount.hidden = TRUE;
    }
}

- (BOOL)checkCurrentDomainExistsInCart: (NSDictionary *)info {
    NSString *domain = [info objectForKey:@"domain"];
    if (![AppUtils isNullOrEmpty: domain]) {
        for (int index=0; index<listDomain.count; index++) {
            NSDictionary *curInfo = [listDomain objectAtIndex: index];
            NSString *curDomain = [curInfo objectForKey:@"domain"];
            if (![AppUtils isNullOrEmpty: curDomain]) {
                if ([curDomain isEqualToString: domain]) {
                    return TRUE;
                }
            }
        }
    }
    return FALSE;
}

- (long)getTotalPriceForDomain: (NSDictionary *)info {
    NSNumber *totalFirstYear = [info objectForKey:@"total_first_year"];
    NSNumber *totalNextYears = [info objectForKey:@"total_next_years"];
    
    if (totalFirstYear != nil && totalNextYears != nil) {
        NSString *years = [info objectForKey: year_for_domain];
        if ([years intValue] == 1) {
            return [totalFirstYear longValue];
        }else{
            int nextYears = [years intValue] - 1;
            return [totalFirstYear longValue] + nextYears*[totalNextYears intValue];
        }
    }
    return 0;
}

@end
