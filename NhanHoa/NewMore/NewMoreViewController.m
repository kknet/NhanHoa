//
//  NewMoreViewController.m
//  NhanHoa
//
//  Created by OS on 10/24/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NewMoreViewController.h"
#import "WalletViewController.h"
#import "RenewedDomainViewController.h"
#import "SupportViewController.h"
#import "BankInfoViewController.h"
#import "AccSettingsViewController.h"
#import "AboutViewController.h"
#import "ProfileInfoViewController.h"
#import "ContactViewController.h"
#import "MoreTbvCell.h"

#define NUM_ROW_OF_SECTION_1    5
#define NUM_ROW_OF_SECTION_2    4

@interface NewMoreViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>{
    AppDelegate *appDelegate;
    UIFont *textFont;
    float hCell;
    float hSection;
}
@end

@implementation NewMoreViewController
@synthesize viewHeader, lbHeader, icCart, scvContent, lbTop, viewInfo, lbMoreBG, imgAvatar, lbName, lbEmail, tbContent, imgLogo, lbVersion;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    [appDelegate hideTabbarCustomSubviews:FALSE withDuration:TRUE];
    
    [self displayAccountInfo];
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Account"];
    lbVersion.text = SFM(@"%@: %@", [appDelegate.localization localizedStringForKey:@"Version"], [AppUtils getAppVersionWithBuildVersion: FALSE]);
}

- (void)displayAccountInfo
{
    NSString *realName = [AccountModel getCusRealName];
    lbName.text = (![AppUtils isNullOrEmpty: realName])? realName : [appDelegate.localization localizedStringForKey:@"Have not updated yet!"];
    
    NSString *email = [AccountModel getCusEmail];
    lbEmail.text = (![AppUtils isNullOrEmpty: email])? email : @"";
    
    NSString *avatarURL = [AccountModel getCusPhoto];
    if (![AppUtils isNullOrEmpty: avatarURL]) {
        [imgAvatar sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:DEFAULT_AVATAR];
    }else{
        imgAvatar.image = DEFAULT_AVATAR;
    }
}

- (void)setupUIForView {
    float padding = 15.0;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.view.backgroundColor = UIColor.whiteColor;
    scvContent.backgroundColor = GRAY_240;
    
    hCell = 60.0;
    hSection = 15.0;
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    }
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:2.0];
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  scrollview
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(5.0);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-self.tabBarController.tabBar.frame.size.height);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(padding);
    }];
    
    //  info view
    float hInfo = 80.0;
    
    UITapGestureRecognizer *tapOnProfile = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnProfile)];
    [viewInfo addGestureRecognizer: tapOnProfile];
    
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(padding);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(hInfo);
    }];
    
    lbMoreBG.layer.cornerRadius = 10.0;
    lbMoreBG.clipsToBounds = TRUE;
    [lbMoreBG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
        make.top.bottom.equalTo(viewInfo);
    }];
    [self addGradienForView:lbMoreBG height:hInfo width: SCREEN_WIDTH-2*padding];
    
    imgAvatar.clipsToBounds = TRUE;
    imgAvatar.layer.borderColor = UIColor.whiteColor.CGColor;
    imgAvatar.layer.borderWidth = 2.0;
    imgAvatar.layer.cornerRadius = 55.0/2;
    [imgAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewInfo).offset(2*padding);
        make.centerY.equalTo(viewInfo.mas_centerY);
        make.width.height.mas_equalTo(55.0);
    }];
    
    lbName.textColor = GRAY_240;
    lbName.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgAvatar.mas_right).offset(padding);
        make.bottom.equalTo(viewInfo.mas_centerY).offset(-2.0);
        make.right.equalTo(viewInfo).offset(-2*padding);
    }];
    
    lbEmail.textColor = GRAY_220;
    lbEmail.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2.0];
    [lbEmail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.equalTo(viewInfo.mas_centerY).offset(2.0);
    }];
    
    float hTbView = NUM_ROW_OF_SECTION_1*hCell + hSection + NUM_ROW_OF_SECTION_2*hCell;
    [tbContent registerNib:[UINib nibWithNibName:@"MoreTbvCell" bundle:nil] forCellReuseIdentifier:@"MoreTbvCell"];
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo.mas_bottom);
        make.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTbView);
    }];
    
    UIImage *logo = [UIImage imageNamed:@"signin_logo"];
    float hLogo = 40.0;
    float wLogo = hLogo * logo.size.width / logo.size.height;
    
    [imgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tbContent.mas_bottom).offset(2*padding);
        make.centerX.equalTo(viewInfo.mas_centerX);
        make.width.mas_equalTo(wLogo);
        make.height.mas_equalTo(hLogo);
    }];
    
    //  label version
    lbVersion.textColor = GRAY_80;
    lbVersion.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [lbVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgLogo.mas_bottom).offset(2*padding);
        make.left.right.equalTo(viewInfo);
        make.height.mas_equalTo(20.0);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, padding + hInfo + hTbView + 2*padding + hLogo + 2*padding + 20.0 + padding);
}

- (void)whenTapOnProfile {
    ProfileInfoViewController *profileInfoVC = [[ProfileInfoViewController alloc] initWithNibName:@"ProfileInfoViewController" bundle:nil];
    profileInfoVC.hidesBottomBarWhenPushed = TRUE;
    [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
    [self.navigationController pushViewController:profileInfoVC animated:TRUE];
}

- (void)addGradienForView: (UIView *)view height: (float)height width:(float)width
{
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint: CGPointMake(0, 0)];
    [path addLineToPoint: CGPointMake(0, height)];
    [path addLineToPoint: CGPointMake(width, height)];
    [path addLineToPoint: CGPointMake(width, 0)];
    [path closePath];
    
    //Add gradient layer to top view
    
    CAShapeLayer *shapeLayer = [CAShapeLayer new];
    shapeLayer.path = path.CGPath;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.backgroundColor = UIColor.clearColor.CGColor;
    gradientLayer.frame = CGRectMake(0, 0, width, height);
    gradientLayer.startPoint = CGPointMake(0.5, 1);
    gradientLayer.endPoint = CGPointMake(0.5, 0);
    gradientLayer.colors = @[(id)[UIColor colorWithRed:(27/255.0) green:(100/255.0) blue:(202/255.0) alpha:1].CGColor, (id)[UIColor colorWithRed:(29/255.0) green:(104/255.0) blue:(209/255.0) alpha:0.9].CGColor];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    gradientLayer.mask = shapeLayer;
}

- (IBAction)icCartClick:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return NUM_ROW_OF_SECTION_1;
    }else{
        return NUM_ROW_OF_SECTION_2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoreTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_wallet"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Nhan Hoa wallet"];
                break;
            }
            case 1:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_domains_management"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Domains management"];
                break;
            }
            case 2:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_trans_his"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Transactions history"];
                break;
            }
            case 3:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_help"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Customers support"];
                break;
            }
            case 4:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_bank"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Bank account"];
                break;
            }
        }
        
        cell.lbSepa.hidden = (indexPath.row == NUM_ROW_OF_SECTION_1-1)? TRUE : FALSE;
        
    }else {
        switch (indexPath.row) {
            case 0:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_setting"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Account settings"];
                break;
            }
            case 1:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_policy"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Terms and policy"];
                break;
            }
            case 2:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_contact"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Contact"];
                break;
            }
            case 3:{
                cell.imgMenu.image = [UIImage imageNamed:@"more_app_info"];
                cell.lbName.text = [appDelegate.localization localizedStringForKey:@"Application information"];
                break;
            }
        }
        cell.lbSepa.hidden = (indexPath.row == NUM_ROW_OF_SECTION_2-1)? TRUE : FALSE;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                WalletViewController *walletVC = [[WalletViewController alloc] initWithNibName:@"WalletViewController" bundle:nil];
                walletVC.hidesBottomBarWhenPushed = TRUE;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController:walletVC animated:TRUE];
                break;
            }
            case 1:{
                RenewedDomainViewController *renewedDomainVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
                renewedDomainVC.hidesBottomBarWhenPushed = TRUE;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController:renewedDomainVC animated:TRUE];
                break;
            }
            case 2:{
                break;
            }
            case 3:{
                SupportViewController *supportVC = [[SupportViewController alloc] initWithNibName:@"SupportViewController" bundle:nil];
                supportVC.hidesBottomBarWhenPushed = YES;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController: supportVC animated:YES];
                break;
            }
            case 4:{
                BankInfoViewController *bankInfoVC = [[BankInfoViewController alloc] initWithNibName:@"BankInfoViewController" bundle:nil];
                bankInfoVC.hidesBottomBarWhenPushed = YES;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController: bankInfoVC animated:YES];
                break;
            }
                
            default:
                break;
        }
    }else{
        switch (indexPath.row) {
            case 0:{
                AccSettingsViewController *accSettingVC = [[AccSettingsViewController alloc] initWithNibName:@"AccSettingsViewController" bundle:nil];
                accSettingVC.hidesBottomBarWhenPushed = TRUE;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController:accSettingVC animated:TRUE];
                break;
            }
            case 1:{
                break;
            }
            case 2:{
                ContactViewController *contactVC = [[ContactViewController alloc] initWithNibName:@"ContactViewController" bundle:nil];
                contactVC.hidesBottomBarWhenPushed = TRUE;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController:contactVC animated:TRUE];
                break;
            }
            case 3:{
                AboutViewController *aboutVC = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:nil];
                aboutVC.hidesBottomBarWhenPushed = YES;
                [appDelegate hideTabbarCustomSubviews:TRUE withDuration:FALSE];
                [self.navigationController pushViewController: aboutVC animated:YES];
                break;
            }
                
            default:
                break;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
        
    }else{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hSection)];
        label.backgroundColor = GRAY_240;
        return label;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return hSection;
}

#pragma mark - UIScroll Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

@end
