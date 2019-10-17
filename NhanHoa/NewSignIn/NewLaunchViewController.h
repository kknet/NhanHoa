//
//  NewLaunchViewController.h
//  NhanHoa
//
//  Created by OS on 10/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewLaunchViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UICollectionView *clvDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;

@end

NS_ASSUME_NONNULL_END
