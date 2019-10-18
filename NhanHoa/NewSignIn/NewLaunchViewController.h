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

@property (weak, nonatomic) IBOutlet UIView *viewPageControl;
@property (weak, nonatomic) IBOutlet UILabel *lbDot1;
@property (weak, nonatomic) IBOutlet UILabel *lbDot2;
@property (weak, nonatomic) IBOutlet UILabel *lbDot3;

- (IBAction)btnSignInPress:(UIButton *)sender;
- (IBAction)btnSignUpPress:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
