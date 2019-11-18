//
//  AccSettingsViewController.m
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AccSettingsViewController.h"
#import "ChangePassViewController.h"
#import "MoreTbvCell.h"

@interface AccSettingsViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>
{
    float hCell;
    UIFont *textFont;
}

@end

@implementation AccSettingsViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Account settings"];
    [self updateCartCountForView];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}


- (void)setupUIForView
{
    hCell = 80.0;
    float padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hCell = 60.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hCell = 70.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hCell = 80.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //  header view
    self.view.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.textColor = GRAY_50;
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = [AppDelegate sharedInstance].sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].sizeCartCount);
    }];
    
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  content
    tbContent.scrollEnabled = FALSE;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent registerNib:[UINib nibWithNibName:@"MoreTbvCell" bundle:nil] forCellReuseIdentifier:@"MoreTbvCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-[AppDelegate sharedInstance].safeAreaBottomPadding);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [[AppDelegate sharedInstance] showCartScreenContent];
}

- (void)showLogoutConfirm {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Do you want to sign out?"]];
        [attrTitle addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:NSMakeRange(0, attrTitle.string.length)];
        [alertVC setValue:attrTitle forKey:@"attributedTitle"];
        
        UIAlertAction *btnClose = [UIAlertAction actionWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"No"] style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){}];
        [btnClose setValue:BLUE_COLOR forKey:@"titleTextColor"];
        
        UIAlertAction *btnSignOut = [UIAlertAction actionWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Sign out"] style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action){
                                                               if (![AppUtils checkNetworkAvailable]) {
                                                                   [self logoutScreen];
                                                               }else{
                                                                   [self clearTokenOfUser];
                                                               }
                                                           }];
        [btnSignOut setValue:UIColor.redColor forKey:@"titleTextColor"];
        [alertVC addAction:btnClose];
        [alertVC addAction:btnSignOut];
        [self presentViewController:alertVC animated:YES completion:nil];
    });
}

- (void)logoutScreen {
    //  reset token for call
    [[WebServiceUtils getInstance] updateTokenForCallWithToken: @"ios"];
    [AppDelegate sharedInstance].callTokenReady = FALSE;
    
    [AppDelegate sharedInstance].userInfo = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:login_state];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:key_password];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NewLaunchViewController *launchVC = [[NewLaunchViewController alloc] initWithNibName:@"NewLaunchViewController" bundle:nil];
    UINavigationController *launchNav = [[UINavigationController alloc] initWithRootViewController:launchVC];
    [self presentViewController:launchNav animated:TRUE completion:nil];
}


- (void)clearTokenOfUser {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please wait a moment..."] Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateTokenWithValue:@""];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:{
            cell.imgMenu.image = [UIImage imageNamed:@"locked"];
            cell.lbName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Change password"];
            cell.lbSepa.hidden = FALSE;
            break;
        }
        case 1:{
            cell.imgMenu.image = [UIImage imageNamed:@"signout"];
            cell.lbName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Sign out"];
            cell.lbSepa.hidden = TRUE;
            break;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ChangePassViewController *changePassVC = [[ChangePassViewController alloc] initWithNibName:@"ChangePassViewController" bundle:nil];
        [self.navigationController pushViewController:changePassVC animated:TRUE];
    }else{
        [self showLogoutConfirm];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (void)clickOnPhoneSupport {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Do you want to call to customer care service?"]];
    
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize - 2] range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Close"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnCall = [UIAlertAction actionWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Call"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                              {
                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SFM(@"tel:%@", phone_support)] options:[[NSDictionary alloc] init] completionHandler:nil];
                              }];
    [btnCall setValue:BLUE_COLOR forKey:@"titleTextColor"];
    [alertVC addAction:btnClose];
    [alertVC addAction:btnCall];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - Web services

-(void)failedToUpdateToken {
    [ProgressHUD dismiss];
}

-(void)updateTokenSuccessful {
    [ProgressHUD dismiss];
    
    [self logoutScreen];
}

@end
