//
//  EditProfileViewController.h
//  NhanHoa
//
//  Created by lam quang quan on 5/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewProfileView.h"
#import "NewBusinessProfileView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController<NewProfileViewDelegate, NewBusinessProfileViewDelegate>

@property (nonatomic, strong) NewProfileView *personalProfileView;
@property (nonatomic, strong) NewBusinessProfileView *businessProfileView;

@property (nonatomic, assign) int type;
@property (nonatomic, assign) int profileType;

@end

NS_ASSUME_NONNULL_END
