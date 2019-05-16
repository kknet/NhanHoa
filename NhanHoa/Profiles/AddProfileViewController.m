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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [addNewProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [addNewProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
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
    [addNewProfile setupViewForAddNewProfileView];
}

@end
