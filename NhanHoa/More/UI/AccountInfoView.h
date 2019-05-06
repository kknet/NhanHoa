//
//  AccountInfoView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountInfoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbEmail;
@property (weak, nonatomic) IBOutlet UIImageView *imgSepa;
@property (weak, nonatomic) IBOutlet UIView *viewWallet;
@property (weak, nonatomic) IBOutlet UIImageView *imgWallet;
@property (weak, nonatomic) IBOutlet UILabel *lbMainAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbMainMoney;

@property (weak, nonatomic) IBOutlet UIView *viewReward;
@property (weak, nonatomic) IBOutlet UIImageView *imgReward;
@property (weak, nonatomic) IBOutlet UILabel *lbRewardAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbRewardMoney;

- (void)setupUIForView;

@end
