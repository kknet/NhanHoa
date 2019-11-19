//
//  ChooseProfileView.m
//  NhanHoa
//
//  Created by OS on 11/19/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ChooseProfileView.h"
#import "SelectProfileTbvCell.h"

@implementation ChooseProfileView
@synthesize viewHeader, icClose, lbHeader, tbProfiles, btnAdd, tfSearch, imgSearch, icClear, lbNoData;
@synthesize delegate, listProfiles, listSearch, searching, hCell, cusIdSelected, searchTimer, selectedRow;

- (void)setupUIForViewWithHeightNav:(float)hNav
{
    self.backgroundColor = GRAY_235;
    self.clipsToBounds = TRUE;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    float padding = 15.0;
    float hBTN = 53.0;
    float hTextfield = 45.0;
    hCell = 120.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        hTextfield = 38.0;
        hCell = 100.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        hTextfield = 40.0;
        hCell = 110.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 53.0;
        hTextfield = 45.0;
        hCell = 120.0;
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.textColor = GRAY_50;
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  search
    tfSearch.clipsToBounds = TRUE;
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.borderStyle = UITextBorderStyleNone;
    tfSearch.layer.cornerRadius = 10.0;
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldChanged:)
       forControlEvents:UIControlEventEditingChanged];
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(padding);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    icClear.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(hTextfield);
    }];
    
    [btnAdd setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    btnAdd.backgroundColor = BLUE_COLOR;
    btnAdd.layer.cornerRadius = 8.0;
    float bottomY = padding;
    if ([AppDelegate sharedInstance].safeAreaBottomPadding > 0) {
        bottomY = [AppDelegate sharedInstance].safeAreaBottomPadding;
    }
    
    [btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.right.equalTo(self).offset(-bottomY);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbProfiles.delegate = self;
    tbProfiles.dataSource = self;
    tbProfiles.backgroundColor = UIColor.clearColor;
    tbProfiles.separatorStyle = UITableViewCellSelectionStyleNone;
    tbProfiles.layer.cornerRadius = 10.0;
    tbProfiles.clipsToBounds = TRUE;
    [tbProfiles registerNib:[UINib nibWithNibName:@"SelectProfileTbvCell" bundle:nil] forCellReuseIdentifier:@"SelectProfileTbvCell"];
    [tbProfiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
        make.left.equalTo(self).offset(padding);
        make.right.equalTo(self).offset(-padding);
        make.bottom.equalTo(btnAdd.mas_top).offset(-padding);
    }];
    
    lbNoData.textColor = GRAY_80;
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tbProfiles);
    }];
    
    selectedRow = -1;
    [self getListProfilesForAccount];
}

- (IBAction)btnAddPress:(UIButton *)sender {
}

- (IBAction)icCloseClick:(UIButton *)sender {
    if ([delegate respondsToSelector:@selector(closeChooseProfileView)]) {
        [delegate closeChooseProfileView];
    }
}

- (IBAction)icClearClick:(UIButton *)sender {
    tfSearch.text = @"";
    sender.hidden = TRUE;
    searching = FALSE;
    [listSearch removeAllObjects];
    
    lbNoData.hidden = TRUE;
    tbProfiles.hidden = FALSE;
    [tbProfiles reloadData];
}

- (void)getListProfilesForAccount {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Loading..."] Interaction:FALSE];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getListProfilesForAccount:[AccountModel getCusUsernameOfUser]];
}

- (void)searchTextfieldChanged: (UITextField *)textfield {
    selectedRow = -1;
    if (textfield.text.length > 0) {
        icClear.hidden = FALSE;
        searching = TRUE;
        
        if (searchTimer) {
            [searchTimer invalidate];
            searchTimer = nil;
        }
        searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(searchOnRegisteredDomains:) userInfo:textfield.text repeats:FALSE];
        
    }else{
        icClear.hidden = TRUE;
        searching = FALSE;
        lbNoData.hidden = TRUE;
        tbProfiles.hidden = FALSE;
        [tbProfiles reloadData];
        tbProfiles.contentOffset = CGPointMake(0, 0);
    }
}

- (void)searchOnRegisteredDomains: (NSTimer *)timer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cus_company CONTAINS[cd] %@ OR cus_realname CONTAINS[cd] %@", timer.userInfo, timer.userInfo];
    NSArray *filter = [listProfiles filteredArrayUsingPredicate: predicate];
    if (filter.count > 0) {
        [listSearch removeAllObjects];
        [listSearch addObjectsFromArray: filter];
        
        [tbProfiles reloadData];
        lbNoData.hidden = TRUE;
        tbProfiles.hidden = FALSE;
    }else{
        [listSearch removeAllObjects];
        lbNoData.hidden = FALSE;
        tbProfiles.hidden = TRUE;
    }
    [tbProfiles setContentOffset:CGPointZero animated:FALSE];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching) {
        return listSearch.count;
    }else{
        return listProfiles.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectProfileTbvCell *cell = (SelectProfileTbvCell *)[tableView dequeueReusableCellWithIdentifier:@"SelectProfileTbvCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profileInfo;
    if (searching) {
        profileInfo = [listSearch objectAtIndex: indexPath.row];
    }else{
        profileInfo = [listProfiles objectAtIndex: indexPath.row];
    }
    
    NSString *cusId = [profileInfo objectForKey:@"cus_id"];
    if (cusId != nil && ![AppUtils isNullOrEmpty: cusId] && [cusId isEqualToString: cusIdSelected]) {
        [cell setSelectedForCell: TRUE];
    }else{
        [cell setSelectedForCell: FALSE];
    }

//    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
//    if ([type isEqualToString:@"0"]) {
//        cell.lbTypeNameValue.text = text_personal;
//        [cell updateUIForBusinessProfile: FALSE];
//
//        cell.profileType  = type_personal;
//    }else{
//        cell.lbTypeNameValue.text = text_business;
//
//        NSString *cus_company = [profileInfo objectForKey:@"cus_company"];
//        if (cus_company != nil) {
//            cell.lbProfileNameValue.text = cell.lbCompanyValue.text = cus_company;
//        }
//        [cell updateUIForBusinessProfile: TRUE];
//
//        cell.profileType  = type_business;
//    }
//
//    //  Show profile name
//    NSString *name = [profileInfo objectForKey:@"cus_realname"];
//    if (name != nil && [name isKindOfClass:[NSString class]]) {
//        cell.lbProfileNameValue.text = name;
//    }
//    [cell displayProfileInfo: profileInfo];
//    cell.delegate = self;
//
//    cell.btnChoose.tag = indexPath.row;
//    [cell.btnChoose addTarget:self
//                       action:@selector(chooseProfileForDomain:)
//             forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self endEditing: TRUE];
    
    if (searching) {
//        if (sender.tag < listSearch.count && cartIndexItemSelect >= 0 && cartIndexItemSelect < [[CartModel getInstance] countItemInCart])
//        {
//            if ([sender.currentTitle isEqualToString:@"Bỏ chọn"]) {
//                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
//                [domainInfo removeObjectForKey:profile_cart];
//                [delegate onSelectedProfileForDomain];
//
//            }else{
//                NSDictionary *profile = [listSearch objectAtIndex: sender.tag];
//                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
//                [domainInfo setObject:profile forKey:profile_cart];
//
//                [delegate onSelectedProfileForDomain];
//            }
//        }
        
    }else{
        if (indexPath.row < listProfiles.count && self.tag >= 0 && self.tag < [[CartModel getInstance] countItemInCart])
        {
            NSDictionary *profile = [listProfiles objectAtIndex: indexPath.row];
            NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: self.tag];
            [domainInfo setObject:profile forKey:profile_cart];
            
            if ([delegate respondsToSelector:@selector(choosedProfileForDomain)]) {
                [delegate choosedProfileForDomain];
            }
            
//            if ([sender.currentTitle isEqualToString:@"Bỏ chọn"]) {
//                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: cartIndexItemSelect];
//                [domainInfo removeObjectForKey:profile_cart];
//                [delegate onSelectedProfileForDomain];
//
//            }else{
//                NSDictionary *profile = [listProfiles objectAtIndex: indexPath.row];
//                NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: self.tag];
//                [domainInfo setObject:profile forKey:profile_cart];
//
//                [delegate onSelectedProfileForDomain];
//            }
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

#pragma mark - WebserviceUtils Delegate
-(void)failedToGetProfilesForAccount:(NSString *)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self performSelector:@selector(closeView) withObject:nil afterDelay:2.0];
}

-(void)getProfilesForAccountSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self displayInformationWithData: data];
}

- (void)displayInformationWithData: (id)data {
    if (listProfiles == nil) {
        listProfiles = [[NSMutableArray alloc] init];
    }
    [listProfiles removeAllObjects];
    [tbProfiles reloadData];
    
    if ([data isKindOfClass:[NSArray class]]) {
        [listProfiles addObject: [AppDelegate sharedInstance].userInfo];
        
        if (data != nil && [(NSArray *)data count] > 0) {
            [listProfiles addObjectsFromArray: data];
        }
        lbNoData.hidden = TRUE;
        tbProfiles.hidden = FALSE;
        [tbProfiles reloadData];
    }
}

- (void)closeView {
    if ([delegate respondsToSelector:@selector(closeChooseProfileView)]) {
        [delegate closeChooseProfileView];
    }
}

@end
