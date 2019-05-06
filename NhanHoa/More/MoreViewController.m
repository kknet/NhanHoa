//
//  MoreViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "MoreViewController.h"
#import "AccountSettingViewController.h"
#import "ContactInfoViewController.h"
#import "RenewedDomainViewController.h"
#import "SignInViewController.h"
#import "SettingMenuCell.h"

@interface MoreViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>

@end

@implementation MoreViewController
@synthesize viewHeader, tfSearch, icSearch, icNotify, icClose, tbContent, accInfoView;
@synthesize hAccount, padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    self.navigationController.navigationBarHidden = FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)icCloseClick:(UIButton *)sender {
}

- (IBAction)icNotifyClick:(UIButton *)sender {
}

- (IBAction)icSearchClick:(UIButton *)sender {
}

- (void)setupUIForView {
    hAccount = 135; //  10 + 30 + 30 + 10 + 10 + 40.0 + 10;
    padding = 15.0;
    self.view.backgroundColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0];
    
    viewHeader.backgroundColor = UIColor.orangeColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.hAccount);
    }];
    
    float hSearch = 32.0;
    float mTop = [AppDelegate sharedInstance].hStatusBar + (hAccount/2 - [AppDelegate sharedInstance].hStatusBar - 32.0)/2;
    
    icNotify.layer.cornerRadius = hSearch/2;
    icNotify.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icNotify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewHeader).offset(-self.padding+3.0);
        make.top.equalTo(self.viewHeader).offset(mTop);
        make.width.height.mas_equalTo(hSearch);
    }];
    
    tfSearch.backgroundColor = [UIColor colorWithRed:(40/255.0) green:(123/255.0) blue:(229/255.0) alpha:1.0];
    tfSearch.layer.cornerRadius = 32.0/2;
    tfSearch.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewHeader).offset(self.padding);
        make.right.equalTo(self.icNotify.mas_left).offset(-5.0);
        make.top.equalTo(self.viewHeader).offset(mTop);
        make.height.mas_equalTo(32.0);
    }];
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hSearch);
    }];
    
    icClose.hidden = TRUE;
    icClose.layer.cornerRadius = hSearch/2;
    icClose.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hSearch);
    }];
    
    
    UIView *tbHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.hAccount/2 + 10)];
    tbHeaderView.backgroundColor = UIColor.whiteColor;
    tbContent.tableHeaderView = tbHeaderView;
    
    [tbContent registerNib:[UINib nibWithNibName:@"SettingMenuCell" bundle:nil] forCellReuseIdentifier:@"SettingMenuCell"];
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self addAccountInfoView];
    
    CAGradientLayer *bottomGradientLayer = [CAGradientLayer layer];
    bottomGradientLayer.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.hAccount);
    bottomGradientLayer.startPoint = CGPointMake(0, 0);
    bottomGradientLayer.endPoint = CGPointMake(1, 1);
    bottomGradientLayer.colors = @[(id)[UIColor colorWithRed:(14/255.0) green:(91/255.0) blue:(181/255.0) alpha:1.0].CGColor, (id)[UIColor colorWithRed:(10/255.0) green:(87/255.0) blue:(179/255.0) alpha:1.0].CGColor];
    [viewHeader.layer insertSublayer:bottomGradientLayer atIndex:0];
}

- (void)addAccountInfoView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"AccountInfoView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[AccountInfoView class]]) {
            accInfoView = (AccountInfoView *) currentObject;
            break;
        }
    }
    [self.view addSubview: accInfoView];
    
    [accInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.hAccount/2);
        make.left.equalTo(self.view).offset(self.padding);
        make.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(self.hAccount);
    }];
    [accInfoView setupUIForView];
    
    [self addBoxShadowForView:accInfoView withColor:UIColor.blackColor];
}

- (void)addBoxShadowForView: (UIView *)view withColor: (UIColor *)color
{
    view.layer.masksToBounds = NO;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowColor = color.CGColor;
    view.layer.shadowOpacity = 0.4;
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingMenuCell *cell = (SettingMenuCell *)[tableView dequeueReusableCellWithIdentifier:@"SettingMenuCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case eSettingAccount:{
            cell.lbName.text = @"Cài đặt tài khoản";
            break;
        }
        case eContactInfo:{
            cell.lbName.text = @"Thông tin liên lạc";
            break;
        }
        case eManagerDomainList:{
            cell.lbName.text = @"Quản lý tên miền";
            break;
        }
        case eCustomnerSupport:{
            cell.lbName.text = @"Hỗ trợ khách hàng";
            break;
        }
        case eApplicationInfo:{
            cell.lbName.text = @"Thông tin ứng dụng";
            break;
        }
        case eSignOut:{
            cell.lbName.text = @"Đăng xuất";
            break;
        }
            
        default:
            break;
    }
    
    if (indexPath.row == eSignOut) {
        cell.backgroundColor = UIColor.clearColor;
        cell.lbSepa.hidden = TRUE;
    }else{
        cell.backgroundColor = UIColor.whiteColor;
        cell.lbSepa.hidden = FALSE;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case eSettingAccount:{
            AccountSettingViewController *accSettingVC = [[AccountSettingViewController alloc] initWithNibName:@"AccountSettingViewController" bundle:nil];
            accSettingVC.hidesBottomBarWhenPushed = TRUE;
            [self.navigationController pushViewController:accSettingVC animated:TRUE];
            break;
        }
        case eContactInfo:{
            ContactInfoViewController *contactInfoVC = [[ContactInfoViewController alloc] initWithNibName:@"ContactInfoViewController" bundle:nil];
            contactInfoVC.hidesBottomBarWhenPushed = TRUE;
            [self.navigationController pushViewController:contactInfoVC animated:TRUE];
            break;
        }
        case eManagerDomainList:{
            RenewedDomainViewController *renewedDomainVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
            renewedDomainVC.hidesBottomBarWhenPushed = TRUE;
            [self.navigationController pushViewController:renewedDomainVC animated:TRUE];
            break;
        }
        case eSignOut:{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"Bạn có muốn đăng xuất khỏi ứng dụng hay không?" delegate:self cancelButtonTitle:@"Đăng xuất" otherButtonTitles:@"Không", nil];
            alertView.tag = 1;
            [alertView show];
            break;
        }
            
        default:
            break;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UIAlertview
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            [AppDelegate sharedInstance].userInfo = nil;
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:login_state];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:key_password];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            SignInViewController *signInVC = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
            [self presentViewController:signInVC animated:TRUE completion:nil];
        }
    }
}

@end
