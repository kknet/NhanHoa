//
//  AboutViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 6/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController (){
    NSString *linkToAppStore;
    NSString* appStoreVersion;
}
@end

@implementation AboutViewController
@synthesize btnLogo, btnCheckUpdate, lbVersion, lbCompany;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_app_info;
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [WriteLogsUtils writeForGoToScreen:@"AboutViewController"];
    
    linkToAppStore = @"";
    NSString *str = SFM(@"%@: %@\n%@: %@", text_version, [AppUtils getAppVersionWithBuildVersion: FALSE], text_release_date, [AppUtils getBuildDate]);
    lbVersion.text = str;
}

- (IBAction)btnCheckUpdatePress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startCheckNewVersionOnAppStore) withObject:nil afterDelay:0.05];
}

- (void)startCheckNewVersionOnAppStore {
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:1.5 position:CSToastPositionBottom style:[AppDelegate sharedInstance].errorStyle];
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
                
                NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:SFM(text_update_version_now, appStoreVersion)];
                [attrTitle addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:NSMakeRange(0, attrTitle.string.length)];
                [alertVC setValue:attrTitle forKey:@"attributedTitle"];
                
                UIAlertAction *btnClose = [UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
                [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
                
                UIAlertAction *btnUpdate = [UIAlertAction actionWithTitle:text_update style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
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
                
                NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:you_are_using_newest_version];
                [attrTitle addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:NSMakeRange(0, attrTitle.string.length)];
                [alertVC setValue:attrTitle forKey:@"attributedTitle"];
                
                UIAlertAction *btnClose = [UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleDefault
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
    //
    float wAvatar = 120.0;
    float hBTN = 45.0;
    btnLogo.layer.cornerRadius = 10.0;
    btnLogo.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    
    if (!IS_IPHONE && !IS_IPOD) {
        btnLogo.layer.cornerRadius = 20.0;
        btnLogo.imageEdgeInsets = UIEdgeInsetsMake(25, 25, 25, 25);
        wAvatar = 180.0;
        hBTN = 55.0;
    }
    
    btnLogo.clipsToBounds = YES;
    btnLogo.layer.borderColor = GRAY_200.CGColor;
    btnLogo.layer.borderWidth = 1.0;
    [btnLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(60.0);
        make.width.height.mas_equalTo(wAvatar);
    }];
    
    lbVersion.font = [AppDelegate sharedInstance].fontBTN;
    lbVersion.textColor = TITLE_COLOR;
    [lbVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnLogo.mas_bottom).offset(40.0);
        make.left.equalTo(self.view).offset(20.0);
        make.right.equalTo(self.view).offset(-20.0);
        make.height.mas_lessThanOrEqualTo(100.0);
    }];
    
    [btnCheckUpdate setTitle:text_check_for_update forState:UIControlStateNormal];
    btnCheckUpdate.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    btnCheckUpdate.layer.borderColor = BLUE_COLOR.CGColor;
    btnCheckUpdate.layer.borderWidth = 1.0;
    btnCheckUpdate.clipsToBounds = YES;
    btnCheckUpdate.layer.cornerRadius = hBTN/2;
    
    float sizeText = [AppUtils getSizeWithText:btnCheckUpdate.currentTitle withFont:btnCheckUpdate.titleLabel.font].width + 40.0;
    [btnCheckUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVersion.mas_bottom).offset(40.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbCompany.font = [AppDelegate sharedInstance].fontRegular;
    lbCompany.textColor = BLUE_COLOR;
    lbCompany.text = nhanhoa_software_company;
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(60.0);
    }];
}

@end
