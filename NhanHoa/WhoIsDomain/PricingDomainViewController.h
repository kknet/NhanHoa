//
//  PricingDomainViewController.h
//  NhanHoa
//
//  Created by Khai Leo on 6/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    eTypePriceVN,
    eTypePriceQT,
}eTypeDomainPrice;

NS_ASSUME_NONNULL_BEGIN

@interface PricingDomainViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *btnVietnam;
@property (weak, nonatomic) IBOutlet UIButton *btnQT;
@property (weak, nonatomic) IBOutlet UITableView *tbContent;

- (IBAction)btnViewNamPress:(UIButton *)sender;
- (IBAction)btnQTPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
