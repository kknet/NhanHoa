//
//  EditProfileViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController
@synthesize profileInfo, personalProfileView, businessProfileView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"EditProfileViewController"];
    
    self.title = @"Cập nhật hồ sơ";
    [self displayProfileInformation];
}

- (void)displayProfileInformation {
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            [self addUpdatePersonalProfileViewIfNeed];
            [personalProfileView displayInfoForPersonalProfileWithInfo: profileInfo];
            
        }else{
            [self addUpdateBusinessProfileViewIfNeed];
            [businessProfileView displayInfoForProfileWithInfo: profileInfo];
        }
    }
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
    [personalProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    personalProfileView.delegate = self;
    [personalProfileView setupForAddProfileUIForAddNew: FALSE isUpdate: TRUE];
    //  [personalProfileView setupViewForAddNewProfileView];
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
    [businessProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    businessProfileView.delegate = self;
    [businessProfileView setupUIForViewForAddProfile:FALSE update:TRUE];
}

@end
