//
//  ProfileInfoViewController.h
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    eTypeAvatarTitle,
    eTypeViewAvatar,
    eTypeCapture,
    eTypeChooseGallery,
    eTypeClearAvatar,
}TypeOnAvatar;

NS_ASSUME_NONNULL_BEGIN

@interface ProfileInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UIButton *icBack;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UIView *viewMenu;
@property (weak, nonatomic) IBOutlet UIButton *btnRegistrant;
@property (weak, nonatomic) IBOutlet UIButton *btnBusiness;
@property (weak, nonatomic) IBOutlet UILabel *lbMenuActive;

@property (weak, nonatomic) IBOutlet UITableView *tbInfo;
@property (weak, nonatomic) IBOutlet UITableView *tbBusiness;

- (IBAction)icBackClick:(UIButton *)sender;
- (IBAction)btnRegistrantPress:(UIButton *)sender;
- (IBAction)btnBusinessPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
