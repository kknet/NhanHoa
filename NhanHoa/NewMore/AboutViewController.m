//
//  AboutViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
{
    AppDelegate *appDelegate;
    NSString *linkToAppStore;
    NSString* appStoreVersion;
    
    UIFont *textFont;
}
@end

@implementation AboutViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, imgInfo, lbVersion, lbTitle, lbReleaseDate, btnCheckUpdate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = TRUE;
    
    linkToAppStore = @"";
    [self displayContentWithCurrentLanguage];
    
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

- (IBAction)btnCheckUpdatePress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startCheckNewVersionOnAppStore) withObject:nil afterDelay:0.05];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (void)displayContentWithCurrentLanguage
{
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Application info"];
    
    lbVersion.text = [AppUtils getAppVersionWithBuildVersion: FALSE];
    
    lbReleaseDate.text = SFM(@"%@: %@", [appDelegate.localization localizedStringForKey:@"Release date"], [AppUtils getBuildDate]);
    
    [btnCheckUpdate setTitle:[appDelegate.localization localizedStringForKey:@"Check for update"] forState:UIControlStateNormal];
    
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Application version"];
}

- (void)startCheckNewVersionOnAppStore {
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"No network connection. Please check again!"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString* appID = infoDictionary[@"CFBundleIdentifier"];
        if (appID.length > 0) {
            NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
            NSData* data = [NSData dataWithContentsOfURL:url];
            
            if (data) {
                NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                if ([lookup[@"resultCount"] integerValue] == 1){
                    appStoreVersion = lookup[@"results"][0][@"version"];
                    NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
                    if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                        // app needs to be updated
                        linkToAppStore = lookup[@"results"][0][@"trackViewUrl"] ? lookup[@"results"][0][@"trackViewUrl"] : @"";
                    }
                }
            }
        }
        
        if (![AppUtils isNullOrEmpty: linkToAppStore] && ![AppUtils isNullOrEmpty: appStoreVersion]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[appDelegate.localization localizedStringForKey:@"Have a new version on AppStore. Do you want to update now?"]];
                
                [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize - 2] range:NSMakeRange(0, attrTitle.string.length)];
                [alertVC setValue:attrTitle forKey:@"attributedTitle"];
                
                UIAlertAction *btnClose = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Close"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
                [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
                
                UIAlertAction *btnUpdate = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Update"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkToAppStore] options:[[NSDictionary alloc] init] completionHandler:nil];
                }];
                [btnUpdate setValue:BLUE_COLOR forKey:@"titleTextColor"];
                [alertVC addAction:btnClose];
                [alertVC addAction:btnUpdate];
                [self presentViewController:alertVC animated:YES completion:nil];
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
                
                NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[appDelegate.localization localizedStringForKey:@"You are using the newest version"]];
                [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize - 2] range:NSMakeRange(0, attrTitle.string.length)];
                [alertVC setValue:attrTitle forKey:@"attributedTitle"];
                
                UIAlertAction *btnClose = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Close"] style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction *action){}];
                [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
                [alertVC addAction:btnClose];
                [self presentViewController:alertVC animated:YES completion:nil];
            });
        }
    });
}

//  setup ui trong view
- (void)setupUIForView
{
    float hBTN = 53.0;
    
    float padding = 15.0;
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 53.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //  header view
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.textColor = GRAY_100;
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
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  content
    btnCheckUpdate.layer.cornerRadius = 8.0;
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnCheckUpdate.titleLabel.font = textFont;
    [btnCheckUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-padding-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(hBTN);
    }];
    
    float hInfoImg = SCREEN_WIDTH/2 + 50.0;
    [imgInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.height.mas_equalTo(hInfoImg);
    }];
    
    lbVersion.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize+8];
    lbVersion.textColor = BLUE_COLOR;
    [lbVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgInfo.mas_bottom).offset(40.0);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(35.0);
    }];
    
    lbTitle.textColor = GRAY_50;
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize+4];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVersion.mas_bottom);
        make.left.right.equalTo(lbVersion);
        make.height.mas_equalTo(35.0);
    }];
    
    lbReleaseDate.textColor = GRAY_150;
    lbReleaseDate.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-3];
    [lbReleaseDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbVersion);
        make.height.mas_equalTo(45.0);
    }];
}

@end
