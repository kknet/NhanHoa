//
//  ProfileDetailViewController.m
//  NhanHoa
//
//  Created by OS on 10/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileDetailViewController.h"
#import "UpdateProfileViewController.h"
#import "ProfileInfoTbvCell.h"
#import "ProfilePassportTbvCell.h"

@interface ProfileDetailViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    float hCell;
    UIFont *textFont;
    int cusOwnType;
    float padding;
}

@end

@implementation ProfileDetailViewController
@synthesize viewHeader, icBack, lbHeader, tbInfo;
@synthesize profileInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    if (cusOwnType == type_personal) {
        lbHeader.text = [appDelegate.localization localizedStringForKey:@"Personal profile details"];
    }else{
        lbHeader.text = [appDelegate.localization localizedStringForKey:@"Business profile details"];
    }
}

- (void)setupUIForView {
    //  self.view.backgroundColor = GRAY_235;
    self.view.backgroundColor = UIColor.whiteColor;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hBTN = 50.0;
    
    hCell = 65.0;
    padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hCell = 60.0;
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hCell = 60.0;
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hCell = 65.0;
        hBTN = 50.0;
    }
    
    //  view header
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    if (cusOwnType == type_personal) {
        [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:2.0];
    }
    
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_50;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  content
    [tbInfo registerNib:[UINib nibWithNibName:@"ProfileInfoTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfileInfoTbvCell"];
    [tbInfo registerNib:[UINib nibWithNibName:@"ProfilePassportTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfilePassportTbvCell"];
    tbInfo.delegate = self;
    tbInfo.dataSource = self;
    tbInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbInfo mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    UIView *viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2*padding + hBTN + padding)];
    tbInfo.tableFooterView = viewFooter;
    
    UIButton *btnUpdateInfo = [UIButton buttonWithType: UIButtonTypeCustom];
    btnUpdateInfo.titleLabel.font = textFont;
    btnUpdateInfo.backgroundColor = BLUE_COLOR;
    btnUpdateInfo.layer.cornerRadius = 10.0;
    [btnUpdateInfo setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnUpdateInfo setTitle:[appDelegate.localization localizedStringForKey:@"Update information"] forState:UIControlStateNormal];
    [viewFooter addSubview: btnUpdateInfo];
    [btnUpdateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.bottom.right.equalTo(viewFooter).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    [btnUpdateInfo addTarget:self
                      action:@selector(goToUpdateProfileInformation)
            forControlEvents:UIControlEventTouchUpInside];
}

- (void)goToUpdateProfileInformation {
    UpdateProfileViewController *updateProfileVC = [[UpdateProfileViewController alloc] initWithNibName:@"UpdateProfileViewController" bundle:nil];
    [AppDelegate sharedInstance].profileEdit = [[NSMutableDictionary alloc] initWithDictionary: profileInfo];
    [self.navigationController pushViewController:updateProfileVC animated:TRUE];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (cusOwnType == type_personal) {
        return 3;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (cusOwnType == type_personal) {
        if (section == 0) {
            return 6;
        }else if (section == 1){
            return 3;
        }else{
            return 1;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Fullname"];
                
                NSString *fullname = [profileInfo objectForKey:@"cus_realname"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: fullname])? fullname : @"";
                
                break;
            }
            case 1:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Gender"];
                
                NSString *gender = [profileInfo objectForKey:@"cus_gender"];
                if ([gender isEqualToString:@"1"]) {
                    cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Male"];
                }else{
                    cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Female"];
                }
                
                break;
            }
            case 2:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Date of birth"];
                
                NSString *birthday = [profileInfo objectForKey:@"cus_birthday"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: birthday])? birthday : @"";
                
                break;
            }
            case 3:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Passport"];
                
                NSString *passport = [profileInfo objectForKey:@"cus_idcard_number"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: passport])? passport : @"";
                
                break;
            }
            case 4:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Phone number"];
                
                NSString *phone = [profileInfo objectForKey:@"cus_phone"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: phone])? phone : @"";
                
                break;
            }
            case 5:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Email"];
                
                NSString *email = [profileInfo objectForKey:@"cus_rl_email"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: email])? email : @"";
                
                break;
            }
            default:
                break;
        }
        [cell updateFrameWithContent];
        return cell;
    }else if (indexPath.section == 1){
        ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.row) {
            case 0:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Permanent address"];
                
                NSString *address = [profileInfo objectForKey:@"cus_address"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: address])? address : @"";
                
                break;
            }
            case 1:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Province/ City"];
                
                NSString *city = [profileInfo objectForKey:@"cus_city"];
                if (![AppUtils isNullOrEmpty: city]) {
                    cell.lbValue.text = [[AppDelegate sharedInstance] findCityObjectWithCityCode: city];
                }else{
                    cell.lbValue.text = @"";
                }
                
                break;
            }
            case 2:{
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Country"];
                cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Viet Nam"];
                
                break;
            }
        }
        [cell updateFrameWithContent];
        return cell;
    }else{
        ProfilePassportTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfilePassportTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbFront.text = [appDelegate.localization localizedStringForKey:@"Passport's front"];
        cell.lbBackside.text = [appDelegate.localization localizedStringForKey:@"Passport's backside"];
        
        //  passport's front
        NSString *cmnd_a = [profileInfo objectForKey:@"cmnd_a"];
        if (![AppUtils isNullOrEmpty: cmnd_a]) {
            [cell.imgFront sd_setImageWithURL:[NSURL URLWithString:cmnd_a] placeholderImage:FRONT_EMPTY_IMG];
        }else{
            cell.imgFront.image = FRONT_EMPTY_IMG;
        }
        
        //  passport's backside
        NSString *cmnd_b = [profileInfo objectForKey:@"cmnd_b"];
        if (![AppUtils isNullOrEmpty: cmnd_b]) {
            [cell.imgBackside sd_setImageWithURL:[NSURL URLWithString:cmnd_b] placeholderImage:BEHIND_EMPTY_IMG];
        }else{
            cell.imgBackside.image = BEHIND_EMPTY_IMG;
        }
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        return hCell;
    }else{
        float sizeImg = (SCREEN_WIDTH - 3*padding)/2;
        return 50.0 + (sizeImg*2/3) + padding;
    }
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }else{
        return 15.0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

@end
