//
//  BankInfoViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BankInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lbBankName;
@property (weak, nonatomic) IBOutlet UITextField *tfBankName;
@property (weak, nonatomic) IBOutlet UILabel *lbOwner;
@property (weak, nonatomic) IBOutlet UITextField *tfOwner;
@property (weak, nonatomic) IBOutlet UILabel *lbAccNo;
@property (weak, nonatomic) IBOutlet UITextField *tfAccNo;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdate;

- (IBAction)btnUpdatePress:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
