//
//  SuggestMenuObject.h
//  NhanHoa
//
//  Created by admin on 4/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SuggestMenuObject : NSObject

@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *domain;

@end

NS_ASSUME_NONNULL_END
