//
//  ProfileDetailCell.h
//  NhanHoa
//
//  Created by admin on 5/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomain;

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeName;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lbProfileName;
@property (weak, nonatomic) IBOutlet UILabel *lbProfileNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;
@property (weak, nonatomic) IBOutlet UILabel *lbCompanyValue;

@property (weak, nonatomic) IBOutlet UIButton *btnChoose;

@property (weak, nonatomic) IBOutlet UIView *viewDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainType;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbNameValue;
@property (weak, nonatomic) IBOutlet UILabel *lbBOD;
@property (weak, nonatomic) IBOutlet UILabel *lbBODValue;
@property (weak, nonatomic) IBOutlet UILabel *lbPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbPassportValue;
@property (weak, nonatomic) IBOutlet UILabel *lbAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbAddressValue;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneValue;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel *lbEmailValue;
@property (weak, nonatomic) IBOutlet UIImageView *iconPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbTitlePassport;
@property (weak, nonatomic) IBOutlet UIImageView *imgFrontPassport;
@property (weak, nonatomic) IBOutlet UIImageView *imgBehindPassport;
@property (weak, nonatomic) IBOutlet UILabel *lbBehind;
@property (weak, nonatomic) IBOutlet UILabel *lbFront;

@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

- (void)updateUIForBusinessProfile: (BOOL)business;
- (void)showProfileDetailWithDomainView;

@property (nonatomic, assign) float sizeType;
@property (nonatomic, assign) float sizeCompany;
@property (nonatomic, assign) float sizeProfile;

@end

NS_ASSUME_NONNULL_END
