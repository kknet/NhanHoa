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
    here
}
@end

@implementation AboutViewController
@synthesize imgApp, btnCheckUpdate, lbVersion, lbCompany;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thông tin ứng dụng";
}

- (void)viewWillAppear:(BOOL)animated {
    [WriteLogsUtils writeForGoToScreen:@"AboutViewController"];
    
    linkToAppStore = @"";
    [btnCheckUpdate setTitle:@"Kiểm tra cập nhật" forState:UIControlStateNormal];
    
    NSString *str = [NSString stringWithFormat:@"Phiên bản: %@\nNgày phát hành: %@", [AppUtils getAppVersionWithBuildVersion: FALSE], [AppUtils getBuildDate]];
    lbVersion.text = str;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCheckUpdatePress:(UIButton *)sender {
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:1.5 position:CSToastPositionBottom style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    //  Add new by Khai Le on 23/03/2018
//    linkToAppStore = [self checkNewVersionOnAppStore];
//    if (![AppUtils isNullOrEmpty: linkToAppStore] && ![AppUtils isNullOrEmpty: appStoreVersion]) {
//        NSString *content = [NSString stringWithFormat:[[LanguageUtil sharedInstance] getContent:@"Current version on App Store is %@. Do you want to update right now?"], appStoreVersion];
//
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"] message:content delegate:self cancelButtonTitle:[[LanguageUtil sharedInstance] getContent:@"Close"] otherButtonTitles:[[LanguageUtil sharedInstance] getContent:@"Update"], nil];
//        alert.tag = 2;
//        [alert show];
//    }else{
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"] message:[[LanguageUtil sharedInstance] getContent:@"You are the newest version!"] delegate:self cancelButtonTitle:[[LanguageUtil sharedInstance] getContent:@"Close"] otherButtonTitles:nil, nil];
//        [alert show];
//    }
//    return;
}

- (NSString *)checkNewVersionOnAppStore {
    return @"";
    
//    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    NSString* appID = infoDictionary[@"CFBundleIdentifier"];
//    if (appID.length > 0) {
//        NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?bundleId=%@", appID]];
//        NSData* data = [NSData dataWithContentsOfURL:url];
//
//        if (data) {
//            NSDictionary* lookup = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//
//            if ([lookup[@"resultCount"] integerValue] == 1){
//                appStoreVersion = lookup[@"results"][0][@"version"];
//                NSString* currentVersion = infoDictionary[@"CFBundleShortVersionString"];
//
//                if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
//                    // app needs to be updated
//                    return lookup[@"results"][0][@"trackViewUrl"] ? lookup[@"results"][0][@"trackViewUrl"] : @"";
//                }
//            }
//        }
//    }
    
    return @"";
}

//  setup ui trong view
- (void)setupUIForView
{
    //
    imgApp.clipsToBounds = YES;
    imgApp.layer.cornerRadius = 10.0;
    [imgApp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_bottom).offset(60.0);
        make.width.height.mas_equalTo(120.0);
    }];
    
    lbVersion.font = [AppDelegate sharedInstance].fontBTN;
    lbVersion.textColor = TITLE_COLOR;
    [lbVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgApp.mas_bottom).offset(40.0);
        make.left.equalTo(self.view).offset(20.0);
        make.right.equalTo(self.view).offset(-20.0);
        make.height.mas_lessThanOrEqualTo(100.0);
    }];
    
    btnCheckUpdate.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    btnCheckUpdate.clipsToBounds = YES;
    btnCheckUpdate.layer.cornerRadius = 45.0/2;
    [btnCheckUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVersion.mas_bottom).offset(40.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(200.0);
        make.height.mas_equalTo(45.0);
    }];
}

@end
