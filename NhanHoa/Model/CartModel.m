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
    NSNumber *priceFirstYear = [info objectForKey:@"price_first_year"];
    NSNumber *priceNextYears = [info objectForKey:@"price_next_years"];
    
    if (priceFirstYear != nil && priceNextYears != nil) {
        NSString *years = [info objectForKey: year_for_domain];
        if ([years intValue] == 1) {
            return [priceFirstYear longValue];
        }else{
            int nextYears = [years intValue] - 1;
            return [priceFirstYear longValue] + nextYears*[priceNextYears intValue];
        }
    }
    return 0;
}

- (long)getTotalVATForCart {
    long totalVAT = 0;
    for (int index=0; index<listDomain.count; index++) {
        NSDictionary *domainInfo = [listDomain objectAtIndex: index];
        NSNumber *priceVATFirstYear = [domainInfo objectForKey:@"price_vat_first_year"];
        NSNumber *priceVATNextYears = [domainInfo objectForKey:@"price_vat_next_year"];
        
        NSString *years = [domainInfo objectForKey: year_for_domain];
        if ([years intValue] == 1) {
            totalVAT = totalVAT + [priceVATFirstYear longValue];
        }else{
            int nextYears = [years intValue] - 1;
            totalVAT = totalVAT + [priceVATFirstYear longValue] + nextYears*[priceVATNextYears intValue];
        }
    }
    return totalVAT;
}

- (long)getTotalDomainPriceForCart {
    long priceDomain = 0;
    
    for (int index=0; index<listDomain.count; index++)
    {
        NSDictionary *domainInfo = [listDomain objectAtIndex: index];
        NSNumber *priceFirstYear = [domainInfo objectForKey:@"price_first_year"];
        NSNumber *priceNextYears = [domainInfo objectForKey:@"price_next_years"];
        
        NSString *years = [domainInfo objectForKey: year_for_domain];
        if ([years intValue] == 1) {
            priceDomain = priceDomain + [priceFirstYear longValue];
        }else{
            int nextYears = [years intValue] - 1;
            priceDomain = priceDomain + [priceFirstYear longValue] + nextYears*[priceNextYears intValue];
        }
    }
    return priceDomain;
}

- (long)getTotalPriceForCart {
    long totalPrice = 0;
    
    for (int index=0; index<listDomain.count; index++)
    {
        NSDictionary *domainInfo = [listDomain objectAtIndex: index];
        NSNumber *totalFirstYear = [domainInfo objectForKey:@"total_first_year"];
        NSNumber *totalNextYears = [domainInfo objectForKey:@"total_next_years"];
        
        NSString *years = [domainInfo objectForKey: year_for_domain];
        if ([years intValue] == 1) {
            totalPrice = totalPrice + [totalFirstYear longValue];
        }else{
            int nextYears = [years intValue] - 1;
            totalPrice = totalPrice + [totalFirstYear longValue] + nextYears*[totalNextYears intValue];
        }
    }
    return totalPrice;
}

- (long)demoGetPriceForRenewDomain {
    return 600000;
}

//  Get all value such as: total price for all domain, VAT fee, total money
- (NSDictionary *)getCartPriceInfo {
    long totalVAT = 0;
    long domainPrice = 0;
    long totalPrice = 0;
    
    for (int index=0; index<listDomain.count; index++)
    {
        NSDictionary *domainInfo = [listDomain objectAtIndex: index];
        
        NSNumber *priceVATFirstYear = [domainInfo objectForKey:@"price_vat_first_year"];
        NSNumber *priceVATNextYears = [domainInfo objectForKey:@"price_vat_next_year"];
        
        NSNumber *priceFirstYear = [domainInfo objectForKey:@"price_first_year"];
        NSNumber *priceNextYears = [domainInfo objectForKey:@"price_next_years"];
        
        NSNumber *totalFirstYear = [domainInfo objectForKey:@"total_first_year"];
        NSNumber *totalNextYears = [domainInfo objectForKey:@"total_next_years"];
        
        NSString *years = [domainInfo objectForKey: year_for_domain];
        if ([years intValue] == 1) {
            totalVAT = totalVAT + [priceVATFirstYear longValue];
            domainPrice = domainPrice + [priceFirstYear longValue];
            totalPrice = totalPrice + [totalFirstYear longValue];
        }else{
            int nextYears = [years intValue] - 1;
            totalVAT = totalVAT + [priceVATFirstYear longValue] + nextYears*[priceVATNextYears longValue];
            domainPrice = domainPrice + [priceFirstYear longValue] + nextYears*[priceNextYears longValue];
            totalPrice = totalPrice + [totalFirstYear longValue] + nextYears*[totalNextYears longValue];
        }
    }
    return [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithLong:totalVAT], @"VAT", [NSNumber numberWithLong:domainPrice], @"domain_price", [NSNumber numberWithLong:totalPrice], @"total_price", nil];
}

- (BOOL)checkAllProfileForCart {
    BOOL result = TRUE;
    for (int index=0; index<listDomain.count; index++)
    {
        NSDictionary *domainInfo = [listDomain objectAtIndex: index];
        NSDictionary *profile = [domainInfo objectForKey:@"profile"];
        if (profile == nil) {
            result = FALSE;
            break;
        }
    }
    return result;
}

/* Json of one domain item
available = 1;
domain = "anvatsaigon.org";
flag = 0;
"price_first_year" = 280000;
"price_next_years" = 280000;
"price_vat_first_year" = 28000;
"price_vat_next_year" = 28000;
"total_first_year" = 308000;
"total_next_years" = 308000;
vat = 10;
"year_for_domain" = 1;
*/

@end
