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
    self.title = @"Thông tin ứng dụng";
    [self setupUIForView];
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
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    
    [self performSelector:@selector(startCheckForInfo) withObject:nil afterDelay:0.05];
}

- (void)startCheckForInfo {
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:no_internet duration:1.5 position:CSToastPositionBottom style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    linkToAppStore = [self checkNewVersionOnAppStore];
    if (![AppUtils isNullOrEmpty: linkToAppStore] && ![AppUtils isNullOrEmpty: appStoreVersion]) {
        NSString *content = [NSString stringWithFormat:@"Phiên bản hiện tại trên AppStore là %@. Bạn có muốn cập nhật ngay không?", appStoreVersion];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:content delegate:self cancelButtonTitle:@"Đóng" otherButtonTitles:@"Cập nhật", nil];
        alert.tag = 2;
        [alert show];
    }else{
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"Bạn đang sử dụng phiên bản mới nhất" delegate:nil cancelButtonTitle:@"Đóng" otherButtonTitles:nil, nil];
        [alert show];
    }
    return;
}
    

- (NSString *)checkNewVersionOnAppStore {
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
                    return lookup[@"results"][0][@"trackViewUrl"] ? lookup[@"results"][0][@"trackViewUrl"] : @"";
                }
            }
        }
    }
    
    return @"";
}

//  setup ui trong view
- (void)setupUIForView
{
    //
    btnLogo.clipsToBounds = YES;
    btnLogo.layer.cornerRadius = 10.0;
    btnLogo.layer.borderColor = BORDER_COLOR.CGColor;
    btnLogo.layer.borderWidth = 1.0;
    btnLogo.imageEdgeInsets = UIEdgeInsetsMake(15, 15, 15, 15);
    [btnLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(60.0);
        make.width.height.mas_equalTo(120.0);
    }];
    
    lbVersion.font = [AppDelegate sharedInstance].fontBTN;
    lbVersion.textColor = TITLE_COLOR;
    [lbVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnLogo.mas_bottom).offset(40.0);
        make.left.equalTo(self.view).offset(20.0);
        make.right.equalTo(self.view).offset(-20.0);
        make.height.mas_lessThanOrEqualTo(100.0);
    }];
    
    btnCheckUpdate.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnCheckUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnCheckUpdate.backgroundColor = BLUE_COLOR;
    btnCheckUpdate.layer.borderColor = BLUE_COLOR.CGColor;
    btnCheckUpdate.layer.borderWidth = 1.0;
    btnCheckUpdate.clipsToBounds = YES;
    btnCheckUpdate.layer.cornerRadius = 45.0/2;
    [btnCheckUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVersion.mas_bottom).offset(40.0);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(200.0);
        make.height.mas_equalTo(45.0);
    }];
    
    lbCompany.font = [AppDelegate sharedInstance].fontRegular;
    lbCompany.textColor = BLUE_COLOR;
    [lbCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(60.0);
    }];
}

#pragma mark - UIAlertview Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 2 && buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkToAppStore]];
    }
}

@end
