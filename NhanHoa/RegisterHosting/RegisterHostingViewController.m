//
//  RegisterHostingViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterHostingViewController.h"
#import "LinuxHostingCell.h"
#import "WindowsHostingCell.h"

typedef enum TypeHosting{
    eHostingLinux,
    eHostingWindows,
    eHostingWorldPress,
}TypeHosting;

@interface RegisterHostingViewController ()<UITableViewDelegate, UITableViewDataSource>{
    float hMenu;
    float typeHosting;
}

@end

@implementation RegisterHostingViewController
@synthesize viewMenu, btnLinux, btnWindows, btnWorldPress, imgArr, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký Hosting";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    typeHosting = eHostingLinux;
    [self setSelectedMenu: typeHosting];
}

- (IBAction)btnLinuxPress:(UIButton *)sender {
    typeHosting = eHostingLinux;
    [self setSelectedMenu: typeHosting];
    [tbContent reloadData];
}

- (IBAction)btnWindowsPress:(UIButton *)sender {
    typeHosting = eHostingWindows;
    [self setSelectedMenu: typeHosting];
    [tbContent reloadData];
}

- (IBAction)btnWorldpressPPress:(UIButton *)sender {
    typeHosting = eHostingWorldPress;
    [self setSelectedMenu: typeHosting];
    [tbContent reloadData];
}

- (void)setupUIForView {
    //  menu view
    float wButton = 120.0;
    if ([DeviceUtils isScreen320]) {
        wButton = 100.0;
    }
    hMenu = 70.0;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    [btnWindows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewMenu.mas_centerX);
        make.centerY.equalTo(viewMenu.mas_centerY);
        make.width.mas_equalTo(wButton);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnWorldPress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnWindows);
        make.left.equalTo(btnWindows.mas_right);
        make.width.mas_equalTo(wButton);
    }];
    
    [btnLinux mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnWindows);
        make.right.equalTo(btnWindows.mas_left);
        make.width.mas_equalTo(wButton);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btnLinux.mas_centerX);
        make.top.equalTo(btnLinux.mas_bottom);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(8.0);
    }];
    
    //  content
    [tbContent registerNib:[UINib nibWithNibName:@"LinuxHostingCell" bundle:nil] forCellReuseIdentifier:@"LinuxHostingCell"];
    [tbContent registerNib:[UINib nibWithNibName:@"WindowsHostingCell" bundle:nil] forCellReuseIdentifier:@"WindowsHostingCell"];
    
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
    }];
}

- (void)setSelectedMenu: (TypeHosting)hosting {
    UIColor *grayCOLOR = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0];
    float sizeIcon = 20.0;
    UIFont *textFont = [AppDelegate sharedInstance].fontDesc;
    
    float arrowWidth = 16.0;
    float arrowHeight = 8.0;
    
    if (hosting == eHostingLinux) {
        btnLinux.backgroundColor = BLUE_COLOR;
        btnWindows.backgroundColor = btnWorldPress.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *linuxActAttr = [AppUtils generateTextWithContent:@"LINUX" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"linux_act"] size:sizeIcon imageFirst:TRUE];
        [btnLinux setAttributedTitle:linuxActAttr forState:UIControlStateNormal];
        
        NSAttributedString *windowsArr = [AppUtils generateTextWithContent:@"WINDOWS" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnWindows setAttributedTitle:windowsArr forState:UIControlStateNormal];
        
        NSAttributedString *worldpressAttr = [AppUtils generateTextWithContent:@"WORLDPRESS" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"worldpress"] size:sizeIcon imageFirst:TRUE];
        [btnWorldPress setAttributedTitle:worldpressAttr forState:UIControlStateNormal];
        
        [imgArr mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnLinux.mas_centerX);
            make.top.equalTo(btnLinux.mas_bottom);
            make.width.mas_equalTo(arrowWidth);
            make.height.mas_equalTo(arrowHeight);
        }];
        
    }else if (hosting == eHostingWindows) {
        btnWindows.backgroundColor = BLUE_COLOR;
        btnLinux.backgroundColor = btnWorldPress.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *linuxAttr = [AppUtils generateTextWithContent:@"LINUX" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"linux"] size:sizeIcon imageFirst:TRUE];
        [btnLinux setAttributedTitle:linuxAttr forState:UIControlStateNormal];
        
        NSAttributedString *windowsActArr = [AppUtils generateTextWithContent:@"WINDOWS" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"windows_act"] size:sizeIcon imageFirst:TRUE];
        [btnWindows setAttributedTitle:windowsActArr forState:UIControlStateNormal];
        
        NSAttributedString *worldpressAttr = [AppUtils generateTextWithContent:@"WORLDPRESS" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"worldpress"] size:sizeIcon imageFirst:TRUE];
        [btnWorldPress setAttributedTitle:worldpressAttr forState:UIControlStateNormal];
        
        [imgArr mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnWindows.mas_centerX);
            make.top.equalTo(btnWindows.mas_bottom);
            make.width.mas_equalTo(arrowWidth);
            make.height.mas_equalTo(arrowHeight);
        }];
    }else{
        btnWorldPress.backgroundColor = BLUE_COLOR;
        btnLinux.backgroundColor = btnWindows.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *linuxAttr = [AppUtils generateTextWithContent:@"LINUX" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"linux"] size:sizeIcon imageFirst:TRUE];
        [btnLinux setAttributedTitle:linuxAttr forState:UIControlStateNormal];
        
        NSAttributedString *windowsArr = [AppUtils generateTextWithContent:@"WINDOWS" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows_act"] size:sizeIcon imageFirst:TRUE];
        [btnWindows setAttributedTitle:windowsArr forState:UIControlStateNormal];
        
        NSAttributedString *worldpressActAttr = [AppUtils generateTextWithContent:@"WORLDPRESS" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"worldpress_act"] size:sizeIcon imageFirst:TRUE];
        [btnWorldPress setAttributedTitle:worldpressActAttr forState:UIControlStateNormal];
        
        [imgArr mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(btnWorldPress.mas_centerX);
            make.top.equalTo(btnWorldPress.mas_bottom);
            make.width.mas_equalTo(arrowWidth);
            make.height.mas_equalTo(arrowHeight);
        }];
    }
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (typeHosting == eHostingLinux) {
        LinuxHostingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinuxHostingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (typeHosting == eHostingWindows){
        WindowsHostingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WindowsHostingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        WindowsHostingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WindowsHostingCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 10 + 80 + 9 * 40.0 + 9*1.0 + [AppDelegate sharedInstance].hTextfield + 15.0 + 15.0 + 45.0 + 15.0;
}



@end
