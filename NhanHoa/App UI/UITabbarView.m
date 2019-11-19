//
//  UITabbarView.m
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UITabbarView.h"

@implementation UITabbarView
@synthesize viewHomeMenu, icHome, lbHome, viewProfileMenu, icProfile, lbProfile, viewNotifMenu, icNotif, lbNotif, viewAccountMenu, icAccount, lbAccount, lbTopSepa;
@synthesize curMenu, delegate;

- (void)setupUIForMenuView
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    float sizeMenu = SCREEN_WIDTH/5;
    float sizeIcon = 40.0;
    float sizeSearchIcon = 56.0;
    
    UIFont *menuFont = [UIFont fontWithName:HelveticaNeue size:14.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        icHome.imageEdgeInsets = icProfile.imageEdgeInsets = icNotif.imageEdgeInsets = icAccount.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        menuFont = [UIFont fontWithName:HelveticaNeue size:12.0];
        sizeSearchIcon = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        sizeIcon = 35.0;
        icHome.imageEdgeInsets = icProfile.imageEdgeInsets = icNotif.imageEdgeInsets = icAccount.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        menuFont = [UIFont fontWithName:HelveticaNeue size:13.0];
        sizeSearchIcon = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        icHome.imageEdgeInsets = icProfile.imageEdgeInsets = icNotif.imageEdgeInsets = icAccount.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        menuFont = [UIFont fontWithName:HelveticaNeue size:14.0];
        sizeSearchIcon = 58.0;
    }
    lbHome.font = lbProfile.font = lbNotif.font = lbAccount.font = menuFont;
    
    lbTopSepa.backgroundColor = GRAY_220;
    [lbTopSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(1.5);
    }];
    
    //  menu home
    [icHome setImage:[UIImage imageNamed:@"icon_home_act"] forState:UIControlStateSelected];
    [icHome setImage:[UIImage imageNamed:@"icon_home_def"] forState:UIControlStateNormal];
    if (appDelegate.safeAreaBottomPadding > 0) {
        [viewHomeMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.bottom.equalTo(self).offset(-appDelegate.safeAreaBottomPadding+5.0);
            make.width.mas_equalTo(sizeMenu);
        }];
        
        [lbHome mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(viewHomeMenu);
        }];
        
        [icHome mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lbHome.mas_top).offset(-0.0);
            make.centerX.equalTo(viewHomeMenu.mas_centerX);
            make.width.height.mas_equalTo(sizeIcon);
        }];
        
        //  profile menu
        [viewProfileMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewHomeMenu.mas_right);
            make.top.bottom.equalTo(viewHomeMenu);
            make.width.mas_equalTo(sizeMenu);
        }];
        
        [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(viewProfileMenu);
        }];
        
        [icProfile setImage:[UIImage imageNamed:@"icon_profile_act"] forState:UIControlStateSelected];
        [icProfile setImage:[UIImage imageNamed:@"icon_profile_def"] forState:UIControlStateNormal];
        [icProfile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(lbProfile.mas_top).offset(-0.0);
            make.centerX.equalTo(viewProfileMenu.mas_centerX);
            make.width.height.mas_equalTo(sizeIcon);
        }];
        
    }else{
        [viewHomeMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self);
            make.bottom.equalTo(self).offset(-appDelegate.safeAreaBottomPadding);
            make.width.mas_equalTo(sizeMenu);
        }];
        
        [icHome mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewHomeMenu).offset(5.0);
            make.centerX.equalTo(viewHomeMenu.mas_centerX);
            make.width.height.mas_equalTo(sizeIcon);
        }];
        
        [lbHome mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icHome.mas_bottom);
            make.left.right.equalTo(viewHomeMenu);
        }];
        
        //  profile menu
        [viewProfileMenu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(viewHomeMenu.mas_right);
            make.top.bottom.equalTo(viewHomeMenu);
            make.width.mas_equalTo(sizeMenu);
        }];
        
        [icProfile setImage:[UIImage imageNamed:@"icon_profile_act"] forState:UIControlStateSelected];
        [icProfile setImage:[UIImage imageNamed:@"icon_profile_def"] forState:UIControlStateNormal];
        [icProfile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewProfileMenu).offset(5.0);
            make.centerX.equalTo(viewProfileMenu.mas_centerX);
            make.width.height.mas_equalTo(sizeIcon);
        }];
        
        [lbProfile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(icProfile.mas_bottom);
            make.left.right.equalTo(viewProfileMenu);
        }];
    }
    
    //  account menu
    [viewAccountMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewHomeMenu);
        make.right.equalTo(self);
        make.width.mas_equalTo(sizeMenu);
    }];
    
    [icAccount setImage:[UIImage imageNamed:@"icon_acc_act"] forState:UIControlStateSelected];
    [icAccount setImage:[UIImage imageNamed:@"icon_acc_def"] forState:UIControlStateNormal];
    [icAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewAccountMenu).offset(5.0);
        make.centerX.equalTo(viewAccountMenu.mas_centerX);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icAccount.mas_bottom);
        make.left.right.equalTo(viewAccountMenu);
    }];
    
    //  notification menu
    [viewNotifMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewAccountMenu.mas_left);
        make.top.bottom.equalTo(viewAccountMenu);
        make.width.mas_equalTo(sizeMenu);
    }];
    
    [icNotif setImage:[UIImage imageNamed:@"icon_notif_act"] forState:UIControlStateSelected];
    [icNotif setImage:[UIImage imageNamed:@"icon_notif_def"] forState:UIControlStateNormal];
    [icNotif mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewNotifMenu).offset(5.0);
        make.centerX.equalTo(viewNotifMenu.mas_centerX);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbNotif mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icNotif.mas_bottom);
        make.left.right.equalTo(viewNotifMenu);
    }];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource: @"search" ofType: @"gif"];
    NSData *data = [NSData dataWithContentsOfFile: filePath];
    
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
    appDelegate.imgSearchBar = [[FLAnimatedImageView alloc] init];
    appDelegate.imgSearchBar.animatedImage = image;
    appDelegate.imgSearchBar.backgroundColor = [UIColor colorWithRed:(18/255.0) green:(92/255.0) blue:(200/255.0) alpha:1.0];
    appDelegate.imgSearchBar.layer.cornerRadius = sizeSearchIcon/2;
    appDelegate.imgSearchBar.layer.borderWidth = 2.0;
    appDelegate.imgSearchBar.clipsToBounds = TRUE;
    appDelegate.imgSearchBar.layer.borderColor = appDelegate.imgSearchBar.backgroundColor.CGColor;
    [self addSubview: appDelegate.imgSearchBar];
    
    if (appDelegate.safeAreaBottomPadding > 0) {
        [appDelegate.imgSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(viewHomeMenu.mas_bottom).offset(2.5);
            make.width.height.mas_equalTo(sizeSearchIcon);
        }];
        
    }else{
        [appDelegate.imgSearchBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self).offset((appDelegate.hTabbar - appDelegate.safeAreaBottomPadding - sizeSearchIcon)/2);
            make.width.height.mas_equalTo(sizeSearchIcon);
        }];
    }
    
    
    UITapGestureRecognizer *tapOnSearch = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnSearchIcon)];
    [appDelegate.imgSearchBar addGestureRecognizer: tapOnSearch];
    
    curMenu = eTabbarMenuHome;
    [self updateMenuWithCurrentState];
}

- (IBAction)icHomeClick:(UIButton *)sender {
    curMenu = eTabbarMenuHome;
    [self updateMenuWithCurrentState];
    
    if ([delegate respondsToSelector:@selector(selectedMenuTabbar:)]) {
        [delegate selectedMenuTabbar: curMenu];
    }
}

- (IBAction)icProfileClick:(UIButton *)sender {
    curMenu = eTabbarMenuProfile;
    [self updateMenuWithCurrentState];
    
    if ([delegate respondsToSelector:@selector(selectedMenuTabbar:)]) {
        [delegate selectedMenuTabbar: curMenu];
    }
}

- (void)whenTapOnSearchIcon {
    curMenu = eTabbarMenuSearch;
    [self updateMenuWithCurrentState];
    
    if ([delegate respondsToSelector:@selector(selectedMenuTabbar:)]) {
        [delegate selectedMenuTabbar: curMenu];
    }
}

- (IBAction)icNotifClick:(UIButton *)sender {
    curMenu = eTabbarMenuNotif;
    [self updateMenuWithCurrentState];
    
    if ([delegate respondsToSelector:@selector(selectedMenuTabbar:)]) {
        [delegate selectedMenuTabbar: curMenu];
    }
}

- (IBAction)icAccountClick:(UIButton *)sender {
    curMenu = eTabbarMenuAccount;
    [self updateMenuWithCurrentState];
    
    if ([delegate respondsToSelector:@selector(selectedMenuTabbar:)]) {
        [delegate selectedMenuTabbar: curMenu];
    }
}

- (void)updateMenuWithCurrentState {
    switch (curMenu) {
        case eTabbarMenuHome:{
            lbHome.textColor = BLUE_COLOR;
            icHome.selected = TRUE;
            
            lbProfile.textColor = lbNotif.textColor = lbAccount.textColor = GRAY_100;
            icProfile.selected = icNotif.selected = icAccount.selected = FALSE;
            
            break;
        }
        case eTabbarMenuProfile:{
            lbProfile.textColor = BLUE_COLOR;
            icProfile.selected = TRUE;
            
            lbHome.textColor = lbNotif.textColor = lbAccount.textColor = GRAY_100;
            icHome.selected = icNotif.selected = icAccount.selected = FALSE;
            
            break;
        }
        case eTabbarMenuSearch:{
            lbHome.textColor = lbProfile.textColor = lbNotif.textColor = lbAccount.textColor = GRAY_100;
            icHome.selected = icProfile.selected = icNotif.selected = icAccount.selected = FALSE;
            break;
        }
        case eTabbarMenuNotif:{
            lbNotif.textColor = BLUE_COLOR;
            icNotif.selected = TRUE;
            
            lbHome.textColor = lbProfile.textColor = lbAccount.textColor = GRAY_100;
            icHome.selected = icProfile.selected = icAccount.selected = FALSE;
            
            break;
        }
        case eTabbarMenuAccount:{
            lbAccount.textColor = BLUE_COLOR;
            icAccount.selected = TRUE;
            
            lbHome.textColor = lbProfile.textColor = lbNotif.textColor = GRAY_100;
            icHome.selected = icProfile.selected = icNotif.selected = FALSE;
            
            break;
        }
    }
}

@end
