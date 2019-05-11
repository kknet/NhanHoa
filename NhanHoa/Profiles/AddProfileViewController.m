//
//  AddProfileViewController.m
//  NhanHoa
//
//  Created by admin on 5/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddProfileViewController.h"

@interface AddProfileViewController ()

@end

@implementation AddProfileViewController
@synthesize addNewProfile;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.title = @"Tạo hồ sơ";
    [self addNewProfileViewIfNeed];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)addNewProfileViewIfNeed {
    if (addNewProfile == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"NewProfileView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[NewProfileView class]]) {
                addNewProfile = (NewProfileView *) currentObject;
                break;
            }
        }
        [self.view addSubview: addNewProfile];
    }
    [addNewProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [addNewProfile setupForAddProfileUI];
}

@end
