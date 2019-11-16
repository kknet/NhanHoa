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

#define NUM_ROWS_PERSONAL_SEC_1     6
#define NUM_ROWS_PERSONAL_SEC_2     3
#define NUM_ROWS_PERSONAL_SEC_3     1

#define NUM_ROWS_REGISTRANT_SEC_1   7
#define NUM_ROWS_REGISTRANT_SEC_2   1
#define NUM_ROWS_REGISTRANT_SEC_3   1

#define NUM_ROWS_BUSINESS   6

@interface ProfileDetailViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    float hCell;
    float hSection;
    float hMenu;
    float hBTN;
    float hStatus;
    float hPassportView;
    
    UIFont *textFont;
    int profileType;
    float padding;
    float paddingTop;
    BOOL isRegistrantInfo;
    
    UIView *viewFooter;
    UIButton *btnUpdateInfo;
    
    float hAddress;
}

@end

@implementation ProfileDetailViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, viewMenu, btnRegistrant, btnBusiness, lbMenuActive, tbInfo;
@synthesize profileInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self updateCartCountForView];
    
    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
    if (type != nil && [type isKindOfClass:[NSString class]]) {
        if ([type isEqualToString:@"0"]) {
            profileType = type_personal;
        }else{
            profileType = type_business;
        }
    }
    
    isRegistrantInfo = TRUE;
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Chi tiết hồ sơ"];
    
    if (profileType == type_personal) {
        [viewMenu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:2.0];
    }else{
        [viewMenu mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hMenu);
        }];
        
        [AppUtils addBoxShadowForView:viewMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:2.0];
    }
    [btnBusiness setTitle:[appDelegate.localization localizedStringForKey:@"Business"]
                 forState:UIControlStateNormal];
    [btnRegistrant setTitle:[appDelegate.localization localizedStringForKey:@"Registrant"]
                   forState:UIControlStateNormal];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)setupUIForView {
    //  self.view.backgroundColor = GRAY_235;
    self.view.backgroundColor = UIColor.whiteColor;
    
    hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    hBTN = 53.0;
    
    hSection = 15.0;
    hCell = 65.0;
    padding = 15.0;
    paddingTop = 7.0;
    hMenu = 50.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hCell = 60.0;
        hBTN = 45.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hCell = 60.0;
        hBTN = 48.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hCell = 65.0;
        hBTN = 53.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    float widthPassport = (SCREEN_WIDTH - 3*padding)/2;
    hPassportView = 50.0 + (widthPassport*2/3) + padding;
    
    //  view header
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
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
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    //  menu
    viewMenu.clipsToBounds = TRUE;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0);
    }];
    
    lbMenuActive.backgroundColor = [UIColor colorWithRed:(41/255.0) green:(155/255.0)
                                                    blue:(218/255.0) alpha:1.0];
    [lbMenuActive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(padding);
        make.bottom.equalTo(viewMenu);
        make.width.mas_equalTo((SCREEN_WIDTH - 3*padding)/2);
        make.height.mas_equalTo(3.0);
    }];
    
    btnRegistrant.titleLabel.font = btnBusiness.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    [btnRegistrant setTitleColor:GRAY_50 forState:UIControlStateNormal];
    [btnRegistrant mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(viewMenu);
        make.right.equalTo(viewMenu.mas_centerX);
        make.bottom.equalTo(lbMenuActive.mas_top);
    }];
    
    [btnBusiness setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnBusiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnRegistrant);
        make.left.equalTo(viewMenu.mas_centerX);
        make.right.equalTo(viewMenu);
    }];
    
    //  content
    [tbInfo registerNib:[UINib nibWithNibName:@"ProfileInfoTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfileInfoTbvCell"];
    [tbInfo registerNib:[UINib nibWithNibName:@"ProfilePassportTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfilePassportTbvCell"];
    tbInfo.delegate = self;
    tbInfo.dataSource = self;
    tbInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewMenu.mas_bottom).offset(paddingTop);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    viewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2*padding + hBTN + padding)];
    tbInfo.tableFooterView = viewFooter;
    
    btnUpdateInfo = [UIButton buttonWithType: UIButtonTypeCustom];
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
    if (profileType == type_personal) {
        return 3;
    }else {
        if (isRegistrantInfo) {
            return 3;
        }else{
            return 1;
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (profileType == type_personal) {
        if (section == 0) {
            return NUM_ROWS_PERSONAL_SEC_1;
        }else if (section == 1){
            return NUM_ROWS_PERSONAL_SEC_2;
        }else{
            return NUM_ROWS_PERSONAL_SEC_3;
        }
    }else{
        if (isRegistrantInfo) {
            if (section == 0) {
                return NUM_ROWS_REGISTRANT_SEC_1;
                
            }else if (section == 1){
                return NUM_ROWS_REGISTRANT_SEC_2;
                
            }else{
                return NUM_ROWS_REGISTRANT_SEC_3;
            }
        }else{
            return NUM_ROWS_BUSINESS;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (profileType == type_personal) {
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
            cell.lbSepa.hidden = (indexPath.row == (NUM_ROWS_PERSONAL_SEC_1-1))? TRUE : FALSE;
            
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
            cell.lbSepa.hidden = (indexPath.row == (NUM_ROWS_PERSONAL_SEC_2-1))? TRUE : FALSE;

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
    }else{
        if (isRegistrantInfo) {
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
                        cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Position"];
                        
                        NSString *position = [profileInfo objectForKey:@"cus_position"];
                        cell.lbValue.text = (![AppUtils isNullOrEmpty: position])? position : @"";
                        
                        break;
                    }
                    case 4:{
                        cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Passport"];
                        
                        NSString *passport = [profileInfo objectForKey:@"cus_idcard_number"];
                        cell.lbValue.text = (![AppUtils isNullOrEmpty: passport])? passport : @"";
                        
                        break;
                    }
                    case 5:{
                        cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Phone number"];
                        
                        NSString *phone = [profileInfo objectForKey:@"cus_phone"];
                        cell.lbValue.text = (![AppUtils isNullOrEmpty: phone])? phone : @"";
                        
                        break;
                    }
                    case 6:{
                        cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Email"];
                        
                        NSString *cus_rl_email = [profileInfo objectForKey:@"cus_rl_email"];
                        cell.lbValue.text = (![AppUtils isNullOrEmpty: cus_rl_email])? cus_rl_email : @"";
                        
                        break;
                    }
                }
                cell.lbSepa.hidden = (indexPath.row == (NUM_ROWS_REGISTRANT_SEC_1-1))? TRUE : FALSE;
                
                return cell;
                
            }else if (indexPath.section == 1){
                ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Permanent address"];
                
                NSString *address = [profileInfo objectForKey:@"cus_address"];
                cell.lbValue.text = (![AppUtils isNullOrEmpty: address])? address : @"";
                
                cell.lbSepa.hidden = (indexPath.row == (NUM_ROWS_REGISTRANT_SEC_2-1))? TRUE : FALSE;
                
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
        }else{
            ProfileInfoTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileInfoTbvCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            switch (indexPath.row) {
                case 0:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Business name"];
                    
                    NSString *company = [profileInfo objectForKey:@"cus_company"];
                    cell.lbValue.text = (![AppUtils isNullOrEmpty: company])? company : @"";
                    
                    break;
                }
                case 1:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Tax code"];
                    
                    NSString *taxcode = [profileInfo objectForKey:@"cus_taxcode"];
                    cell.lbValue.text = (![AppUtils isNullOrEmpty: taxcode])? taxcode : @"";
                    
                    break;
                }
                case 2:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Business address"];
                    
                    NSString *address = [profileInfo objectForKey:@"cus_company_address"];
                    cell.lbValue.text = (![AppUtils isNullOrEmpty: address])? address : @"";
                    
                    break;
                }
                case 3:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Business phone number"];
                    
                    NSString *phone = [profileInfo objectForKey:@"cus_company_phone"];
                    cell.lbValue.text = (![AppUtils isNullOrEmpty: phone])? phone : @"";
                    
                    break;
                }
                case 4:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Province/ City"];
                    
                    NSString *cus_city = [profileInfo objectForKey:@"cus_city"];
                    if (![AppUtils isNullOrEmpty: cus_city]) {
                        NSString *city = [appDelegate findCityObjectWithCityCode: cus_city];
                        cell.lbValue.text = city;
                    }else{
                        cell.lbValue.text = @"";
                    }
                    
                    break;
                }
                case 5:{
                    cell.lbTitle.text = [appDelegate.localization localizedStringForKey:@"Country"];
                    cell.lbValue.text = [appDelegate.localization localizedStringForKey:@"Viet Nam"];
                    
                    break;
                }
            }
            cell.lbSepa.hidden = (indexPath.row == 5)? TRUE : FALSE;
            
            return cell;
        }
    }
}

- (float)getHeightOfAddressForCellWithContent: (NSString *)content {
    UIFont *font = [UIFont fontWithName:RobotoRegular size:19.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        font = [UIFont fontWithName:RobotoRegular size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        font = [UIFont fontWithName:RobotoRegular size:17.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        font = [UIFont fontWithName:RobotoRegular size:19.0];
    }
    
    float maxLeftSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Permanent address"] withFont:textFont andMaxWidth:SCREEN_WIDTH].width + 5.0;
    
    float maxSize = (SCREEN_WIDTH - 2*padding - maxLeftSize - 5.0);
    
    float hContent = [AppUtils getSizeWithText:content withFont:font andMaxWidth:maxSize].height + 30.0;
    if (hContent >= hCell) {
        hAddress = hContent;
        return hContent;
    }
    hAddress = hCell;
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (profileType == type_business && indexPath.section == 1 && indexPath.row == 0 && isRegistrantInfo) {
        NSString *address = [profileInfo objectForKey:@"cus_address"];
        return [self getHeightOfAddressForCellWithContent: address];
    }
    
    if (profileType == type_business && indexPath.section == 0 && indexPath.row == 2 && !isRegistrantInfo) {
        NSString *address = [profileInfo objectForKey:@"cus_company_address"];
        return [self getHeightOfAddressForCellWithContent: address];
    }
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        return hCell;
    }else{
        return hPassportView;
    }
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    }else{
        return hSection;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (IBAction)btnRegistrantPress:(UIButton *)sender
{
    float hTableView = NUM_ROWS_REGISTRANT_SEC_1 * hCell + (NUM_ROWS_REGISTRANT_SEC_2-1)*hCell + hAddress + NUM_ROWS_REGISTRANT_SEC_3*hPassportView + 2*hSection;
    float realHeight = hStatus + self.navigationController.navigationBar.frame.size.height + hMenu + hTableView + paddingTop + appDelegate.safeAreaBottomPadding;
    
    if (realHeight + 2*padding + hBTN + padding < SCREEN_HEIGHT) {
        viewFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-realHeight);
    }else{
        viewFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH, 2*padding + hBTN + padding);
    }

    isRegistrantInfo = TRUE;
    [tbInfo reloadData];
    [tbInfo scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:TRUE];
    
    [lbMenuActive mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(padding);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [btnRegistrant setTitleColor:GRAY_50 forState:UIControlStateNormal];
        [btnBusiness setTitleColor:GRAY_150 forState:UIControlStateNormal];
    }];
}

- (IBAction)btnBusinessPress:(UIButton *)sender
{
    float hTableView = (NUM_ROWS_BUSINESS-1) * hCell + hAddress;
    float realHeight = hStatus + self.navigationController.navigationBar.frame.size.height + hMenu + hTableView + paddingTop + appDelegate.safeAreaBottomPadding;

    if (realHeight + 2*padding + hBTN + padding < SCREEN_HEIGHT) {
        viewFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-realHeight);
    }else{
        viewFooter.frame = CGRectMake(0, 0, SCREEN_WIDTH, 2*padding + hBTN + padding);
    }
    
    isRegistrantInfo = FALSE;
    [tbInfo reloadData];
    [tbInfo scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:TRUE];
    
    [lbMenuActive mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewMenu).offset(SCREEN_WIDTH/2 + padding/2);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [btnBusiness setTitleColor:GRAY_50 forState:UIControlStateNormal];
        [btnRegistrant setTitleColor:GRAY_150 forState:UIControlStateNormal];
    }];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

@end
