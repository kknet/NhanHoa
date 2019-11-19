//
//  UITabbarView.h
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum TypeTabbarMenu{
    eTabbarMenuHome,
    eTabbarMenuProfile,
    eTabbarMenuSearch,
    eTabbarMenuNotif,
    eTabbarMenuAccount,
}TypeTabbarMenu;

NS_ASSUME_NONNULL_BEGIN

@protocol UITabbarViewDelegate <NSObject>
@optional
- (void)selectedMenuTabbar:(TypeTabbarMenu)selectedMenu;
@end

@interface UITabbarView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbTopSepa;

@property (weak, nonatomic) IBOutlet UIView *viewHomeMenu;
@property (weak, nonatomic) IBOutlet UIButton *icHome;
@property (weak, nonatomic) IBOutlet UILabel *lbHome;

@property (weak, nonatomic) IBOutlet UIView *viewProfileMenu;
@property (weak, nonatomic) IBOutlet UIButton *icProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;

@property (weak, nonatomic) IBOutlet UIView *viewNotifMenu;
@property (weak, nonatomic) IBOutlet UIButton *icNotif;
@property (weak, nonatomic) IBOutlet UILabel *lbNotif;

@property (weak, nonatomic) IBOutlet UIView *viewAccountMenu;
@property (weak, nonatomic) IBOutlet UIButton *icAccount;
@property (weak, nonatomic) IBOutlet UILabel *lbAccount;

@property (nonatomic, assign) TypeTabbarMenu curMenu;

- (IBAction)icHomeClick:(UIButton *)sender;
- (IBAction)icProfileClick:(UIButton *)sender;
- (IBAction)icNotifClick:(UIButton *)sender;
- (IBAction)icAccountClick:(UIButton *)sender;

@property (nonatomic, strong) id<UITabbarViewDelegate, NSObject> delegate;
- (void)setupUIForMenuView;

@end

NS_ASSUME_NONNULL_END
