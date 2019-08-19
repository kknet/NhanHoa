//
//  DomainProfileCell.h
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DomainProfileCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseProfile;

@property (weak, nonatomic) IBOutlet UIView *viewProfileInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imgType;
@property (weak, nonatomic) IBOutlet UILabel *lbType;

@property (weak, nonatomic) IBOutlet UILabel *lbSepa;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbCompanyValue;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbProfileValue;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hBTN;
@property (nonatomic, assign) float sizeType;
@property (nonatomic, assign) float sizeProfile;
@property (nonatomic, assign) float mTop;
@property (nonatomic, assign) float hLabel;

- (void)showProfileView: (BOOL)show withBusiness: (BOOL)business;
- (void)showProfileContentWithInfo: (NSDictionary *)profile;
@end
