//
//  WhoIsResultViewController.h
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhoIsDomainView.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhoIsResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;

@property (nonatomic, strong) NSMutableArray *listSearch;
@property (nonatomic, assign) float padding;
@property (nonatomic, strong) WhoIsDomainView *whoisView;

@end

NS_ASSUME_NONNULL_END
