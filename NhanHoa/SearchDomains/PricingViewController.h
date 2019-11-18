//
//  PricingViewController.h
//  NhanHoa
//
//  Created by OS on 11/18/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum TypePricingDomains{
    eVietNamPricing,
    eInternationalPricing,
}TypePricingDomains;

@interface PricingViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;
@property (weak, nonatomic) IBOutlet UIButton *icCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnVietNamDomains;
@property (weak, nonatomic) IBOutlet UIButton *btnInternationalDomains;
@property (weak, nonatomic) IBOutlet UILabel *lbMenuActive;

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbSetupFee;
@property (weak, nonatomic) IBOutlet UILabel *lbRenewFee;
@property (weak, nonatomic) IBOutlet UILabel *lbTransferFee;

@property (weak, nonatomic) IBOutlet UITableView *tbDomains;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)icCartClick:(UIButton *)sender;
- (IBAction)btnVietNamDomainsPress:(UIButton *)sender;
- (IBAction)btnInternationalDomainsPress:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
