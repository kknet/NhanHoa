//
//  DomainObject.h
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainObject : NSObject

@property (nonatomic, strong) NSString *domain;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, assign) BOOL special;
@property (nonatomic, assign) BOOL warning;
@property (nonatomic, strong) NSString *warningContent;
@property (nonatomic, assign) BOOL isRegistered;

@end

NS_ASSUME_NONNULL_END
