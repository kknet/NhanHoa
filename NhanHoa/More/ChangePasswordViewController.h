//
//  ChangePasswordViewController.h
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ChangePasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbOldPass;
@property (weak, nonatomic) IBOutlet UITextField *tfOldPass;
@property (weak, nonatomic) IBOutlet UILabel *lbNewPass;
@property (weak, nonatomic) IBOutlet UITextField *tfNewPass;
@property (weak, nonatomic) IBOutlet UILabel *lbConfirm;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UILabel *lbWarning;

- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)btnSavePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
