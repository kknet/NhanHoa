//
//  ProfileDetailsViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/10/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailsViewController.h"
#import "EditProfileViewController.h"

@interface ProfileDetailsViewController (){
    
}
@end

@implementation ProfileDetailsViewController
@synthesize personalProfileView, businessProfileView;

@synthesize profileInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_profile_detail;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"ProfileDetailsViewController"];
    
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            [self addUpdatePersonalProfileViewIfNeed];
            [personalProfileView displayInfoForPersonalProfileWithInfo: profileInfo];
            [personalProfileView setupUIForOnlyView];
            personalProfileView.mode = eViewProfile;
            
        }else{
            [self addUpdateBusinessProfileViewIfNeed];
            [businessProfileView displayInfoForProfileWithInfo: profileInfo];
            [businessProfileView setupUIForOnlyView];
            businessProfileView.mode = eViewBusinessProfile;
        }
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if (personalProfileView != nil) {
        [personalProfileView removeFromSuperview];
        personalProfileView = nil;
    }
    
    if (businessProfileView != nil) {
        [businessProfileView removeFromSuperview];
        businessProfileView = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addUpdatePersonalProfileViewIfNeed {
    if (personalProfileView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewProfileView class]]) {
                personalProfileView = (NewProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: personalProfileView];
    }
    personalProfileView.delegate = self;
    [personalProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [personalProfileView setupForAddProfileUIForAddNew: FALSE isUpdate: TRUE];
}

- (void)addUpdateBusinessProfileViewIfNeed {
    if (businessProfileView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewBusinessProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewBusinessProfileView class]]) {
                businessProfileView = (NewBusinessProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: businessProfileView];
    }
    businessProfileView.delegate = self;
    [businessProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [businessProfileView setupUIForViewForAddProfile:FALSE update:TRUE];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    if (personalProfileView != nil) {
        [personalProfileView reUpdateLayoutForView];
    }
    
    if (businessProfileView != nil) {
        [businessProfileView reUpdateLayoutForView];
    }
}

#pragma mark - ProfileView Delegate
-(void)onButtonEditPressed {
    EditProfileViewController *editVC = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
    [AppDelegate sharedInstance].profileEdit = [[NSMutableDictionary alloc] initWithDictionary: profileInfo];
    [self.navigationController pushViewController:editVC animated:TRUE];
}

-(void)onButtonEditPersonalProfilePressed {
    EditProfileViewController *editVC = [[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
    [AppDelegate sharedInstance].profileEdit = [[NSMutableDictionary alloc] initWithDictionary: profileInfo];
    [self.navigationController pushViewController:editVC animated:TRUE];
}

@end
