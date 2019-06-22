//
//  ProfileManagerCell.h
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileManagerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbType;
@property (weak, nonatomic) IBOutlet UILabel *lbTypeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbCompanyValue;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbProfileValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@property (nonatomic, assign) float sizeType;
@property (nonatomic, assign) float sizeProfile;

- (void)setupUIForBusiness: (BOOL)business;

@end
