//
//  NewProfileViewController.h
//  NhanHoa
//
//  Created by OS on 10/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIView *viewType;
@property (weak, nonatomic) IBOutlet UIImageView *bgIntro;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIView *viewPersonal;
@property (weak, nonatomic) IBOutlet UIImageView *imgPersonal;
@property (weak, nonatomic) IBOutlet UILabel *lbPersonal;

@property (weak, nonatomic) IBOutlet UIView *viewBusiness;
@property (weak, nonatomic) IBOutlet UIImageView *imgBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbBusiness;
@property (weak, nonatomic) IBOutlet UIButton *btnContinue;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)btnContinuePress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
