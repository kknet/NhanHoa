//
//  BOViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/27/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BOViewController.h"

@interface BOViewController ()
@end

@implementation BOViewController
@synthesize lbNotSupport, lbBotSepa;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setupUIForView {
    lbBotSepa.backgroundColor = LIGHT_GRAY_COLOR;
    [lbBotSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(1.0);
    }];
    
    lbNotSupport.font = [AppDelegate sharedInstance].fontBTN;
    lbNotSupport.textColor = TITLE_COLOR;
    lbNotSupport.text = text_not_support;
    [lbNotSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.lbBotSepa.mas_top);
    }];
}

@end
