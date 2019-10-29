//
//  UpdateBusinessProfileView.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateBusinessProfileView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnBusinessInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistrantInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbMenuActive;

@property (weak, nonatomic) IBOutlet UIScrollView *scvBusiness;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessName;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessName;

@property (weak, nonatomic) IBOutlet UILabel *lbTaxCode;
@property (weak, nonatomic) IBOutlet UITextField *tfTaxCode;
@property (weak, nonatomic) IBOutlet UILabel *lbBotTaxCode;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessAddr;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessAddr;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessPhone;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessCountry;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessCountry;
@property (weak, nonatomic) IBOutlet UILabel *lbBotBusinessCountry;

@property (weak, nonatomic) IBOutlet UILabel *lbBusinessCity;
@property (weak, nonatomic) IBOutlet UITextField *tfBusinessCity;
@property (weak, nonatomic) IBOutlet UILabel *lbBusinessBotCity;
@property (weak, nonatomic) IBOutlet UIImageView *imgBusinessCity;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseBusinessCity;

@property (weak, nonatomic) IBOutlet UIButton *btnSaveInfo;

@property (nonatomic, assign) float padding;

- (void)setupUIForView;

- (IBAction)btnRegistrantInfoPress:(UIButton *)sender;
- (IBAction)btnBusinessInfoPress:(UIButton *)sender;
- (IBAction)btnChooseBusinessCityPress:(UIButton *)sender;
- (IBAction)btnSaveInfoBusinessPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
