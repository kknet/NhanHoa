//
//  RegisterEmailViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterEmailViewController.h"
#import "EmailHostingCell.h"
#import "EmailServerCell.h"

typedef enum TypeEmail{
    eEmailHosting,
    eEmailServer,
}TypeEmail;

@interface RegisterEmailViewController ()<UITableViewDelegate, UITableViewDataSource>{
    TypeEmail currentType;
}

@end

@implementation RegisterEmailViewController
@synthesize viewHeader, btnEmailServer, btnEmailHosting, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký Email";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    currentType = eEmailHosting;
    [self setSelectedMenu: currentType];
}

- (void)setupUIForView {
    float hMenu = 70.0;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    [btnEmailHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader.mas_centerX).offset(-5.0);
        make.centerY.equalTo(viewHeader.mas_centerY);
        make.width.mas_equalTo(150.0);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnEmailServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader.mas_centerX).offset(5.0);
        make.top.bottom.equalTo(btnEmailHosting);
        make.width.equalTo(btnEmailHosting.mas_width);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"EmailHostingCell" bundle:nil] forCellReuseIdentifier:@"EmailHostingCell"];
    [tbContent registerNib:[UINib nibWithNibName:@"EmailServerCell" bundle:nil] forCellReuseIdentifier:@"EmailServerCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbContent.showsVerticalScrollIndicator = FALSE;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (IBAction)btnEmailHostingPress:(UIButton *)sender {
    currentType = eEmailHosting;
    [self setSelectedMenu: currentType];
    [tbContent reloadData];
}

- (IBAction)btnEmailServerPress:(UIButton *)sender {
    currentType = eEmailServer;
    [self setSelectedMenu: currentType];
    [tbContent reloadData];
}

- (void)setSelectedMenu: (TypeEmail)email {
    UIColor *grayCOLOR = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0];
    float sizeIcon = 20.0;
    UIFont *textFont = [AppDelegate sharedInstance].fontMedium;
    if ([DeviceUtils isScreen320]) {
        sizeIcon = 16.0;
    }
    
    if (email == eEmailHosting) {
        btnEmailHosting.backgroundColor = BLUE_COLOR;
        btnEmailServer.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *emailHosting = [AppUtils generateTextWithContent:@"EMAIL-HOSTING" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"email_hosting_act"] size:sizeIcon imageFirst:TRUE];
        [btnEmailHosting setAttributedTitle:emailHosting forState:UIControlStateNormal];
        
        NSAttributedString *emailServer = [AppUtils generateTextWithContent:@"EMAIL-SERVER" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"email_server"] size:sizeIcon imageFirst:TRUE];
        [btnEmailServer setAttributedTitle:emailServer forState:UIControlStateNormal];
        
    }else{
        btnEmailHosting.backgroundColor = UIColor.whiteColor;
        btnEmailServer.backgroundColor = BLUE_COLOR;
        
        NSAttributedString *emailHosting = [AppUtils generateTextWithContent:@"EMAIL-HOSTING" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"email_hosting"] size:sizeIcon imageFirst:TRUE];
        [btnEmailHosting setAttributedTitle:emailHosting forState:UIControlStateNormal];
        
        NSAttributedString *emailServer = [AppUtils generateTextWithContent:@"EMAIL-SERVER" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"email_server_act"] size:sizeIcon imageFirst:TRUE];
        [btnEmailServer setAttributedTitle:emailServer forState:UIControlStateNormal];
    }
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (currentType == eEmailHosting) {
        EmailHostingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmailHostingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        EmailServerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmailServerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (currentType == eEmailHosting) {
        float paddingContent = 7.0;
        float mTop = 15.0;
        return paddingContent + 60.0 + 4*45.0 + 4*1.0 + mTop + 45.0 + mTop + paddingContent + mTop;
        
    }else{
        float paddingContent = 7.0;
        float mTop = 15.0;
        return paddingContent + (5 + 30 + 20 + 5 + [AppDelegate sharedInstance].hTextfield + 5) + 8*40.0 + 8*1.0 + mTop + 45.0 + mTop + paddingContent + mTop;
    }
}

@end
