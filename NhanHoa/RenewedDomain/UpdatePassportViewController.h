//
//  UpdatePassportViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdatePassportViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnCMND_a;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imgWaitCMND_a;

@property (weak, nonatomic) IBOutlet UILabel *lbCMND_a;
@property (weak, nonatomic) IBOutlet UILabel *lbCMND_b;
@property (weak, nonatomic) IBOutlet UIButton *btnCMND_b;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *imgWaitCMND_b;

@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (nonatomic, strong) NSString *linkCMND_a;
@property (nonatomic, strong) NSString *linkCMND_b;
@property (nonatomic, strong) NSString *cusId;

@property (nonatomic, strong) NSString *curCMND_a;
@property (nonatomic, strong) NSString *curCMND_b;

- (IBAction)btnCMND_a_Press:(UIButton *)sender;
- (IBAction)btnCMND_b_Press:(UIButton *)sender;

- (IBAction)btnCancelPress:(UIButton *)sender;
- (IBAction)btnSavePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
