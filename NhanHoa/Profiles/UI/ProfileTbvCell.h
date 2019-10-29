//
//  ProfileTbvCell.h
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfileTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *viewWrap;
@property (weak, nonatomic) IBOutlet UILabel *lbRepresentative;
@property (weak, nonatomic) IBOutlet UILabel *lbRepresentativeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbProfileValue;

- (void)showProfileContentWithInfo: (NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
