//
//  WhoIsResultViewController.h
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhoIsDomainView.h"
#import "WhoIsNoResult.h"
#import "WebServices.h"

NS_ASSUME_NONNULL_BEGIN

@interface WhoIsResultViewController : UIViewController<WebServicesDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;

@property (nonatomic, strong) NSMutableArray *listSearch;
@property (nonatomic, assign) float padding;
@property (nonatomic, strong) WhoIsDomainView *whoisView;
@property (nonatomic, strong) WhoIsNoResult *noResultView;

@property (nonatomic, strong) WebServices *webService;

@end

NS_ASSUME_NONNULL_END
