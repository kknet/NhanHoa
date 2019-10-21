//
//  CartDomainTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLCustomSwitch.h"

NS_ASSUME_NONNULL_BEGIN

@interface CartDomainTbvCell : UITableViewCell<KLCustomSwitchDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbNo;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstPriceTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstPriceMoney;
@property (weak, nonatomic) IBOutlet UITextField *tfYear;
@property (weak, nonatomic) IBOutlet UIImageView *imgArr;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectYear;

@property (weak, nonatomic) IBOutlet UIButton *icRemove;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UIView *viewWhoisProtect;
@property (weak, nonatomic) IBOutlet UILabel *lbWhoisProtect;
@property (weak, nonatomic) IBOutlet UIButton *icShowDesc;
@property (weak, nonatomic) IBOutlet UILabel *lbWhoisProtectFee;
@property (weak, nonatomic) IBOutlet UILabel *lbBotSepa;

@property (nonatomic, assign) float hBTN;
@property (nonatomic, strong) KLCustomSwitch *swWhoIsProtect;

- (void)displayDomainInfoForCart: (NSDictionary *)domainInfo;

@end

NS_ASSUME_NONNULL_END
