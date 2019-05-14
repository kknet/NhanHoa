//
//  CartModel.h
//  NhanHoa
//
//  Created by lam quang quan on 5/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartModel : UIView

+(CartModel *)getInstance;
@property (nonatomic, strong) NSMutableArray *listDomain;
- (void)clearAllListDomainFromCart;
- (void)addDomainToCart: (NSDictionary *)info;
- (void)removeDomainFromCart: (NSDictionary *)info;
- (int)countItemInCart;
- (void)displayCartInfoWithView: (UILabel *)lbCount;
- (BOOL)checkCurrentDomainExistsInCart: (NSDictionary *)info;
- (long)getTotalPriceForDomain: (NSDictionary *)info;
- (long)getTotalVATForCart;
- (long)getTotalDomainPriceForCart;
- (long)getTotalPriceForCart;
- (NSDictionary *)getCartPriceInfo ;
- (BOOL)checkAllProfileForCart;

@end
