//
//  RenewDomainDetailViewController.h
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpireDomainObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface RenewDomainDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbTopDomain;
@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbID;
@property (weak, nonatomic) IBOutlet UILabel *lbIDValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lbServiceNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;
@property (weak, nonatomic) IBOutlet UILabel *lbPriceValue;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterDate;
@property (weak, nonatomic) IBOutlet UILabel *lbRegisterDateValue;
@property (weak, nonatomic) IBOutlet UILabel *lbState;
@property (weak, nonatomic) IBOutlet UILabel *lbStateValue;
@property (weak, nonatomic) IBOutlet UIButton *btnRenewDomain;
@property (weak, nonatomic) IBOutlet UIButton *btnChangeDNS;
@property (weak, nonatomic) IBOutlet UIButton *btnUpdatePassport;

- (IBAction)btnRenewDomainPress:(UIButton *)sender;
- (IBAction)btnUpdatePassportPress:(UIButton *)sender;
- (IBAction)btnChangeDNSPress:(UIButton *)sender;

@property (nonatomic, strong) ExpireDomainObject *domainObj;

@end

NS_ASSUME_NONNULL_END
