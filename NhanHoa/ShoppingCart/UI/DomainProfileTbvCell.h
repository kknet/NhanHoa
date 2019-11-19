//
//  DomainProfileTbvCell.h
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DomainProfileTbvCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;
@property (weak, nonatomic) IBOutlet UIButton *icProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbPhone;
@property (weak, nonatomic) IBOutlet UILabel *lbCompany;
@property (weak, nonatomic) IBOutlet UIButton *btnChoose;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

- (void)showProfileContentForCell: (BOOL)show;
- (void)displayContentWithInfo: (NSDictionary *)profile;

@end

NS_ASSUME_NONNULL_END
