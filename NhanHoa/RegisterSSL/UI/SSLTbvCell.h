//
//  SSLTbvCell.h
//  NhanHoa
//
//  Created by Khai Leo on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrapper;
@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPrice;

@property (weak, nonatomic) IBOutlet UILabel *lbFeeSetup;
@property (weak, nonatomic) IBOutlet UILabel *lbFeeSetupValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;

@property (weak, nonatomic) IBOutlet UILabel *lbFeeRenew;
@property (weak, nonatomic) IBOutlet UILabel *lbFeeRenewValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;

@property (weak, nonatomic) IBOutlet UILabel *lbEncrypt;
@property (weak, nonatomic) IBOutlet UILabel *lbEncryptValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;

@property (weak, nonatomic) IBOutlet UILabel *lbCert;
@property (weak, nonatomic) IBOutlet UILabel *lbCertValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa4;

@property (weak, nonatomic) IBOutlet UILabel *lbDomainNum;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainNumValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa5;

@property (weak, nonatomic) IBOutlet UILabel *lbSAN;
@property (weak, nonatomic) IBOutlet UILabel *lbSANValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa6;

@property (weak, nonatomic) IBOutlet UILabel *lbBlueAddr;
@property (weak, nonatomic) IBOutlet UILabel *lbBlueAddrValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa7;

@property (weak, nonatomic) IBOutlet UILabel *lbPolicy;
@property (weak, nonatomic) IBOutlet UILabel *lbPolicyValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa8;

@property (weak, nonatomic) IBOutlet UILabel *lbTrust;
@property (weak, nonatomic) IBOutlet UILabel *lbTrustValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa9;

@property (weak, nonatomic) IBOutlet UILabel *lbTimeRegister;
@property (weak, nonatomic) IBOutlet UILabel *lbTimeRegisterValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa10;

@property (weak, nonatomic) IBOutlet UILabel *lbSupport;
@property (weak, nonatomic) IBOutlet UILabel *lbSupportValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa11;

@property (weak, nonatomic) IBOutlet UIButton *btnAddCart;

@end

NS_ASSUME_NONNULL_END
