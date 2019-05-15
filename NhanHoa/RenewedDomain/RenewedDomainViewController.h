//
//  RenewedDomainViewController.h
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RenewedDomainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnAllDomain;
@property (weak, nonatomic) IBOutlet UIButton *btnExpireDomain;
@property (weak, nonatomic) IBOutlet UITableView *tbDomain;
@property (weak, nonatomic) IBOutlet UIButton *btnPriceList;

- (IBAction)btnAllDomainPress:(UIButton *)sender;
- (IBAction)btnExpirePress:(UIButton *)sender;
- (IBAction)btnPriceListPress:(UIButton *)sender;

@property (nonatomic, assign) float padding;

@end

NS_ASSUME_NONNULL_END
