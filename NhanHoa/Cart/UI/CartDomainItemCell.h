//
//  CartDomainItemCell.h
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CartDomainItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbNum;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbFirstYear;
@property (weak, nonatomic) IBOutlet UIButton *icRemove;
@property (weak, nonatomic) IBOutlet UITextField *tfYears;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;
@property (weak, nonatomic) IBOutlet UIButton *btnYears;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@property (weak, nonatomic) IBOutlet UIView *protectView;
@property (weak, nonatomic) IBOutlet UILabel *lbProtect;
@property (weak, nonatomic) IBOutlet UILabel *lbProtectDomain;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;
@property (weak, nonatomic) IBOutlet UISwitch *swProtect;
@property (weak, nonatomic) IBOutlet UILabel *lbFree;

- (IBAction)swProtectChanged:(UISwitch *)sender;
- (IBAction)btnInfoPress:(UIButton *)sender;

- (void)displayDataWithInfo: (NSDictionary *)info forYear: (int)yearsForRenew;
- (void)displayDomainInfoForCart: (NSDictionary *)domainInfo;

@end

NS_ASSUME_NONNULL_END
