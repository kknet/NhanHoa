//
//  UpdateMyInfoViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdatePersonalProfile.h"
#import "UpdateBusinessProfile.h"

NS_ASSUME_NONNULL_BEGIN

@interface UpdateMyInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scvContent;

@property (nonatomic, strong) UpdatePersonalProfile *editPersonalView;
@property (nonatomic, strong) UpdateBusinessProfile *editBusinessView;

@end

NS_ASSUME_NONNULL_END
