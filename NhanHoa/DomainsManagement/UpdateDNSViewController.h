//
//  UpdateDNSViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateDNSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UILabel *lbDNS1;
@property (weak, nonatomic) IBOutlet UITextField *tfDNS1;
@property (weak, nonatomic) IBOutlet UILabel *lbDNS2;
@property (weak, nonatomic) IBOutlet UITextField *tfDNS2;
@property (weak, nonatomic) IBOutlet UILabel *lbDNS3;
@property (weak, nonatomic) IBOutlet UITextField *tfDNS3;
@property (weak, nonatomic) IBOutlet UILabel *lbDNS4;
@property (weak, nonatomic) IBOutlet UITextField *tfDNS4;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (nonatomic, strong) NSString *domain;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)btnSavePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
