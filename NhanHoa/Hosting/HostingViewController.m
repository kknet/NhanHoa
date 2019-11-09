//
//  HostingViewController.m
//  NhanHoa
//
//  Created by OS on 11/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingViewController.h"
#import "HostingTbvCell.h"

@interface HostingViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    
    float hWindowsHostingCell;
}
@end

@implementation HostingViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvMenu, btnLinuxHosting, btnWindowsHosting, btnWordpressHosting, tbContent, lbMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Register hosting"];
    
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hMenu = 50.0;
    
    padding = 15.0;
    float hBTN = 45.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    hWindowsHostingCell = padding + 40.0*2 + padding + 25.0*9 + padding + 1.0 + padding + hBTN + padding + 15.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = 18.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(18.0);
    }];
    
    //  scrollview menu
    [scvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    float sizeContent = 0;
    
    btnWindowsHosting.titleLabel.font = btnLinuxHosting.titleLabel.font = btnWordpressHosting.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    float sizeText = [AppUtils getSizeWithText:@"Windows Hosting" withFont:btnWordpressHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnWindowsHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnWindowsHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    btnWindowsHosting.selected = TRUE;
    [btnWindowsHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu).offset(padding);
        make.top.equalTo(scvMenu);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hMenu-5.0);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Linux Hosting" withFont:btnLinuxHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnLinuxHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnLinuxHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnLinuxHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnWindowsHosting.mas_right).offset(padding);
        make.top.bottom.equalTo(btnWindowsHosting);
        make.width.mas_equalTo(sizeText);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Wordpress Hosting" withFont:btnWordpressHosting.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText + padding;
    
    [btnWordpressHosting setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnWordpressHosting setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnWordpressHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnLinuxHosting.mas_right).offset(padding);
        make.top.bottom.equalTo(btnLinuxHosting);
        make.width.mas_equalTo(sizeText);
    }];
    
    lbMenu.backgroundColor = BLUE_COLOR;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWindowsHosting.mas_bottom);
        make.left.right.equalTo(btnWindowsHosting);
        make.height.mas_equalTo(5.0);
    }];
    scvMenu.contentSize = CGSizeMake(sizeContent, hMenu);
    
    [AppUtils addBoxShadowForView:scvMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  table content
    
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"HostingTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvMenu.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}


- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    
}

- (IBAction)btnWindowsHostingPress:(UIButton *)sender {
    btnWindowsHosting.selected = TRUE;
    btnLinuxHosting.selected = btnWordpressHosting.selected = FALSE;
    
    [lbMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWindowsHosting.mas_bottom);
        make.left.right.equalTo(btnWindowsHosting);
        make.height.mas_equalTo(5.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)btnLinuxHostingPress:(UIButton *)sender {
    btnLinuxHosting.selected = TRUE;
    btnWindowsHosting.selected = btnWordpressHosting.selected = FALSE;
    
    [lbMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnLinuxHosting.mas_bottom);
        make.left.right.equalTo(btnLinuxHosting);
        make.height.mas_equalTo(5.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)btnWordpressHostingPress:(UIButton *)sender {
    btnWordpressHosting.selected = TRUE;
    btnLinuxHosting.selected = btnWindowsHosting.selected = FALSE;
    
    [lbMenu mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWordpressHosting.mas_bottom);
        make.left.right.equalTo(btnWordpressHosting);
        make.height.mas_equalTo(5.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HostingTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingTbvCell"];
    
    if (indexPath.row == 0) {
        
    }else if (indexPath.row == 1){
        
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        
    }else if (indexPath.row == 5){
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hWindowsHostingCell;
}

@end
