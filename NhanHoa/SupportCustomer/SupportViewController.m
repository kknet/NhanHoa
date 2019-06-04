//
//  SupportViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()<UIWebViewDelegate>
@end

@implementation SupportViewController
@synthesize btnCall, btnSendMsg, lbTitle, viewContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Hỗ trợ khách hàng";
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSendMsgPress:(UIButton *)sender {
}

- (IBAction)btnCallPress:(UIButton *)sender {
    
}

- (void)setupUIForView {
    float padding = 15.0;
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(2*padding + 60.0 + 45.0 + 2*padding);
    }];
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [AppDelegate sharedInstance].fontBold;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.view).offset(2*padding);
        make.height.mas_equalTo(60.0);
    }];
    
    
    NSAttributedString *msgTitle = [AppUtils generateTextWithContent:@"Gửi tin nhắn" font:[AppDelegate sharedInstance].fontRegular color:BLUE_COLOR image:[UIImage imageNamed:@"support_message"] size:22.0 imageFirst:TRUE];
    btnSendMsg.layer.cornerRadius = 5.0;
    [btnSendMsg setAttributedTitle:msgTitle forState:UIControlStateNormal];
    
    btnSendMsg.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:0.2];
    [btnSendMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(45.0);
    }];
    
    NSAttributedString *callTitle = [AppUtils generateTextWithContent:@"Gọi tổng đài" font:[AppDelegate sharedInstance].fontRegular color:BLUE_COLOR image:[UIImage imageNamed:@"support_call"] size:22.0 imageFirst:TRUE];
    btnCall.layer.cornerRadius = 5.0;
    [btnCall setAttributedTitle:callTitle forState:UIControlStateNormal];
    btnCall.backgroundColor = btnSendMsg.backgroundColor;
    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnSendMsg.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.bottom.equalTo(self.btnSendMsg);
    }];
}

@end
