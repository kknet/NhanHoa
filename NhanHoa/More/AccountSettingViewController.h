//
//  AccountSettingViewController.h
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnAvatar;
@property (weak, nonatomic) IBOutlet UIButton *btnChoosePhoto;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lbID;
@property (weak, nonatomic) IBOutlet UILabel *lbIDValue;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailValue;

@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UILabel *lbPasswordInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbPassword;
@property (weak, nonatomic) IBOutlet UILabel *lbPasswordValue;
@property (weak, nonatomic) IBOutlet UIButton *btnChangePassword;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdateInfo;

- (IBAction)btnChangePasswordPress:(UIButton *)sender;
- (IBAction)btnAvatarPress:(UIButton *)sender;
- (IBAction)btnChoosePhotoPress:(UIButton *)sender;
- (IBAction)btnUpdateInfoPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
