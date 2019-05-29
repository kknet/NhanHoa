//
//  AddProfileViewController.h
//  NhanHoa
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProfileView.h"
#import "NewBusinessProfileView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddProfileViewController : UIViewController

@property (nonatomic, strong) NewProfileView *personalProfile;
@property (nonatomic, strong) NewBusinessProfileView *businessProfile;

@end

NS_ASSUME_NONNULL_END
