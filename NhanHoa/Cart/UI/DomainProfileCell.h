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
@property (weak, nonatomic) IBOutlet UILabel *lbProfileDesc;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa;

@property (nonatomic, assign) float padding;
@property (nonatomic, assign) float hBTN;

- (void)showProfileView: (BOOL)show;

@end
