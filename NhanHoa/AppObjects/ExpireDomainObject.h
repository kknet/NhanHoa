//
//  ExpireDomainObject.h
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpireDomainObject : NSObject

@property (nonatomic, strong) NSString *domainName;
@property (nonatomic, strong) NSString *registerDate;
@property (nonatomic, strong) NSString *state;

@end

NS_ASSUME_NONNULL_END
