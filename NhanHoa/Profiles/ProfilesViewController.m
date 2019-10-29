//
//  ProfilesViewController.m
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfilesViewController.h"
#import "ProfileDetailViewController.h"
#import "ProfileTbvCell.h"

@interface ProfilesViewController ()<UIScrollViewDelegate, WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    UIFont *textFont;
    float hBottom;
    
    NSMutableArray *listProfiles;
    NSMutableArray *listSearch;
    BOOL searching;
    NSTimer *searchTimer;
    
    float hCell;
    float padding;
    float hTextfield;
    float hFooter;
}
@end

@implementation ProfilesViewController
@synthesize viewHeader, bgTop, icBack, lbHeader, icCart, lbCount, scvContent, bgBottom, tfSearch, imgSearch, tbProfiles, viewFooter, btnAddProfile, lbNoData, icClear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
    
    appDelegate.needReloadListProfile = FALSE;
    [self getListProfilesForAccount];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    if (appDelegate.needReloadListProfile) {
        appDelegate.needReloadListProfile = FALSE;
        [self getListProfilesForAccount];
        
        tfSearch.text = @"";
        icClear.hidden = TRUE;
    }else{
        if (tfSearch.text.length > 0) {
            [self searchTextfieldChanged: tfSearch];
            icClear.hidden = FALSE;
        }else{
            icClear.hidden = TRUE;
        }
    }
    
    if (listSearch == nil) {
        listSearch = [[NSMutableArray alloc] init];
    }else{
        [listSearch removeAllObjects];
    }
    
    [self showContentWithCurrentLanguage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [viewFooter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight+hFooter);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [viewFooter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Profiles list"];
    tfSearch.placeholder = [appDelegate.localization localizedStringForKey:@"Search name, phone number, ..."];
    [btnAddProfile setTitle:[appDelegate.localization localizedStringForKey:@"Add profile"] forState:UIControlStateNormal];
    lbNoData.text = [appDelegate.localization localizedStringForKey:@"Empty list"];
}

- (void)setupUIForView {
    padding = 20.0;
    float hBTN = 50.0;
    hTextfield = 45.0;
    hCell = 100.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        hTextfield = 40.0;
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        hTextfield = 45.0;
        hBTN = 48.0;
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        hTextfield = 45.0;
        hBTN = 50.0;
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    hFooter = hBTN + padding;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    UIImage *imgTop = [UIImage imageNamed:@"bg_profile_top"];
    float hHeader = SCREEN_WIDTH * imgTop.size.height / imgTop.size.width;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    [bgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewHeader);
    }];
    
    lbHeader.font = textFont;
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
    
    UITapGestureRecognizer *tapOnHeader = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [viewHeader addGestureRecognizer: tapOnHeader];
    
    //  footer view
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(hFooter);
    }];
    
    btnAddProfile.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    btnAddProfile.backgroundColor = BLUE_COLOR;
    [btnAddProfile setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAddProfile.layer.cornerRadius = 8.0;
    [btnAddProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  no data
    lbNoData.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize + 2];
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding + hTextfield);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top);
    }];
    
    //  content
    self.view.backgroundColor = viewFooter.backgroundColor = GRAY_235;
    scvContent.delegate = self;
    scvContent.backgroundColor = UIColor.clearColor;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top);
    }];
    
    UIImage *imgBottom = [UIImage imageNamed:@"bg_profile_bottom"];
    hBottom = SCREEN_WIDTH * imgBottom.size.height / imgBottom.size.width;
    
    [bgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        //  make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBottom);
    }];
    
//    [bgBottom mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(scvContent);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(hBottom);
//    }];
    
    tfSearch.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    tfSearch.layer.cornerRadius = 12.0;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(padding/2);
        make.left.equalTo(bgBottom).offset(padding);
        make.right.equalTo(bgBottom).offset(-padding);
        //  make.centerY.equalTo(bgBottom.mas_bottom).offset(-7.0);
        make.height.mas_equalTo(hTextfield);
    }];
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0+20.0+5.0, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    [AppUtils addBoxShadowForView:tfSearch color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [tfSearch addTarget:self
                 action:@selector(searchTextfieldChanged:)
       forControlEvents:UIControlEventEditingChanged];
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(10.0);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(20.0);
    }];
    
    icClear.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(tfSearch);
        make.width.height.mas_equalTo(hTextfield);
    }];
    
    tbProfiles.backgroundColor = UIColor.clearColor;
    tbProfiles.delegate = self;
    tbProfiles.dataSource = self;
    tbProfiles.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbProfiles registerNib:[UINib nibWithNibName:@"ProfileTbvCell" bundle:nil] forCellReuseIdentifier:@"ProfileTbvCell"];
    [tbProfiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgBottom).offset(padding/2);
        make.right.equalTo(bgBottom).offset(-padding/2);
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
        make.height.mas_equalTo(0);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnAddProfilePress:(UIButton *)sender {
}

- (IBAction)icClearClick:(UIButton *)sender {
    [self.view endEditing: TRUE];
    
    tfSearch.text = @"";
    sender.hidden = TRUE;
    searching = FALSE;
    [listSearch removeAllObjects];
    
    lbNoData.hidden = TRUE;
    tbProfiles.hidden = FALSE;
    [tbProfiles reloadData];
    
    [self reUpdateLayoutAfterLoadedData];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)searchTextfieldChanged: (UITextField *)textfield {
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
        
        [self reUpdateLayoutAfterLoadedData];
    }
}

- (void)searchOnRegisteredDomains: (NSTimer *)timer {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cus_company CONTAINS[cd] %@ OR cus_realname CONTAINS[cd] %@ OR cus_phone CONTAINS[cd] %@", timer.userInfo, timer.userInfo, timer.userInfo];
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
    
    [self reUpdateLayoutAfterLoadedData];
}

- (void)getListProfilesForAccount {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Loading profiles list..."] Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getListProfilesForAccount:[AccountModel getCusUsernameOfUser]];
}

- (void)reUpdateLayoutAfterLoadedData {
    float hTableView = 0;
    if (searching) {
        hTableView = listSearch.count*hCell;
    }else{
        hTableView = listProfiles.count*hCell;
    }
    
    [tbProfiles mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, padding/2 + hTextfield + padding + hTableView);
}

#pragma mark - UIScrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        [bgBottom mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewHeader.mas_bottom);
        }];
    }else{
        [bgBottom mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewHeader.mas_bottom).offset(-scrollView.contentOffset.y);
        }];
    }
}

#pragma mark - Webservice delegate
-(void)failedToGetProfilesForAccount:(NSString *)error {
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
    
    tbProfiles.hidden = TRUE;
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
    
    if ([data isKindOfClass:[NSArray class]]) {
        if (data == nil || [(NSArray *)data count] == 0) {
            lbNoData.text = text_no_data;
            lbNoData.hidden = FALSE;
            tbProfiles.hidden = TRUE;
            
        }else{
            listProfiles = [[NSMutableArray alloc] initWithArray: data];
            
            lbNoData.hidden = TRUE;
            tbProfiles.hidden = FALSE;
            [tbProfiles reloadData];
        }
        [self reUpdateLayoutAfterLoadedData];
    }
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
    ProfileTbvCell *cell = (ProfileTbvCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileTbvCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *profileInfo;
    if (searching) {
        profileInfo = [listSearch objectAtIndex: indexPath.row];
    }else{
        profileInfo = [listProfiles objectAtIndex: indexPath.row];
    }
    
    //  Show profile type
    [cell showProfileContentWithInfo: profileInfo];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileDetailViewController *detailVC = [[ProfileDetailViewController alloc] initWithNibName:@"ProfileDetailViewController" bundle:nil];
    if (searching) {
        detailVC.profileInfo = [listSearch objectAtIndex: indexPath.row];
    }else{
        detailVC.profileInfo = [listProfiles objectAtIndex: indexPath.row];
    }
    [self.navigationController pushViewController:detailVC animated:TRUE];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
//    NSDictionary *profileInfo = [listProfiles objectAtIndex: indexPath.row];
//    NSString *type = [profileInfo objectForKey:@"cus_own_type"];
//
//    if (type != nil && [type isKindOfClass:[NSString class]]) {
//        if ([type isEqualToString:@"0"]) {
//            if (IS_IPHONE || IS_IPOD) {
//                return 70.0;
//            }
//            return 75.0;
//        }
//    }
//    if (IS_IPHONE || IS_IPOD) {
//        return 95.0;
//    }else{
//        return 110.0;
//    }
}

@end
