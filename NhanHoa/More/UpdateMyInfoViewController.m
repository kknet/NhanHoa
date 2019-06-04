//
//  UpdateMyInfoViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 6/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateMyInfoViewController.h"
#import "AccountModel.h"

@interface UpdateMyInfoViewController ()

@end

@implementation UpdateMyInfoViewController
@synthesize editPersonalView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    int type = [AccountModel getCusOwnType];
    if (type == type_personal) {
        [self addUpdatePersonalProfileView];
        
    }else{
        
    }
}

- (void)addUpdatePersonalProfileView {
    if (editPersonalView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdatePersonalProfile" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdatePersonalProfile class]]) {
                editPersonalView = (UpdatePersonalProfile *) currentObject;
                break;
            }
        }
        [self.view addSubview: editPersonalView];
    }
    [editPersonalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [editPersonalView setupUIForView];
}

@end
