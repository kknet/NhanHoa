//
//  ProfileDetailsViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProfileView.h"
#import "NewBusinessProfileView.h"

@interface ProfileDetailsViewController : UIViewController<NewBusinessProfileViewDelegate, NewProfileViewDelegate>

@property (nonatomic, strong) NSDictionary *profileInfo;
@property (nonatomic, strong) NewProfileView *personalProfileView;
@property (nonatomic, strong) NewBusinessProfileView *businessProfileView;

@end
