//
//  RegisterDomainViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterDomainViewController.h"
#import "SearchDomainViewController.h"
#import "RenewedDomainViewController.h"
#import "WhoIsViewController.h"
#import "SuggestDomainCell.h"

@interface RegisterDomainViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate>{
    NSMutableArray *listData;
    float hCell;
    float padding;
    float hBanner;
    float backagePadding;
    float hItemView;
}

@end

@implementation RegisterDomainViewController
@synthesize scvContent, imgBanner, tfSearch, lbWWW, icSearch, viewInfo, viewSearch, imgSearch, lbSearch, viewRenew, imgRenew, lbRenew, viewTransferDomain, imgTransferDomain, lbTransferDomain, lbManyOptions, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_register_domains;
    
    [self createListDomainPrice];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"RegisterDomainViewController"];
    
    //  show banner image
    UIImage *bannerPhoto = [AccountModel getBannerPhotoFromUser];
    imgBanner.image = bannerPhoto;
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createListDomainPrice {
    listData = [[NSMutableArray alloc] init];
    id listPrice = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_price"];
    if (listPrice != nil && [listPrice isKindOfClass:[NSArray class]]) {
        listData = [[NSMutableArray alloc] initWithArray:listPrice];
    }
}

- (void)setupUIForView
{
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    float hSearch = 38.0;
    float searchPadding = 1.0;
    padding = 15.0;
    hCell = 90.0;
    backagePadding = 5.0;
    float wItemImg = 50.0;
    float radius = [AppDelegate sharedInstance].radius;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
        lbRenew.font = lbSearch.font = lbTransferDomain.font = [UIFont fontWithName:RobotoRegular size:12];
    }else{
        lbRenew.font = lbSearch.font = lbTransferDomain.font = [UIFont fontWithName:RobotoRegular size:13];
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        searchPadding = 2.0;
        padding = 30.0;
        hSearch = 50.0;
        backagePadding = 20.0;
        wItemImg = 80.0;
        radius = 10.0;
        hCell = 120.0;
        
        lbRenew.font = lbSearch.font = lbTransferDomain.font = [AppDelegate sharedInstance].fontDesc;
    }
    
    scvContent.delegate = self;
    scvContent.showsVerticalScrollIndicator = FALSE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [self getHeightBannerForView];
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBanner);
    }];
    
    //  search UI
    tfSearch.text = @"";
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.layer.cornerRadius = hSearch/2;
    tfSearch.layer.borderColor = BLUE_COLOR.CGColor;
    tfSearch.layer.borderWidth = 2;
    tfSearch.font = [AppDelegate sharedInstance].fontRegular;
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBanner).offset(padding);
        make.right.equalTo(imgBanner).offset(-padding);
        make.centerY.equalTo(imgBanner.mas_bottom);
        make.height.mas_equalTo(hSearch);
    }];
    
    icSearch.layer.cornerRadius = (hSearch-2*searchPadding)/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfSearch).offset(searchPadding);
        make.right.bottom.equalTo(tfSearch).offset(-searchPadding);
        make.width.mas_equalTo(hSearch-2*searchPadding);
    }];
    
    lbWWW.backgroundColor = UIColor.clearColor;
    lbWWW.text = @"www.";
    lbWWW.textColor = BLUE_COLOR;
    lbWWW.font = [AppDelegate sharedInstance].fontMediumDesc;
    
    float sizeWWW = [AppUtils getSizeWithText:lbWWW.text withFont:lbWWW.font].width + 5.0;
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(3.0);
        make.top.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(sizeWWW);
    }];
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeWWW, hSearch)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    //  info view
    UIImage *itemImg = [UIImage imageNamed:@"search_multi_domain"];
    float hItemImg = wItemImg * itemImg.size.height / itemImg.size.width;
    
    hItemView = (hSearch/2 + 10.0) + 10.0 + hItemImg + 50.0 + 5.0;
    viewInfo.backgroundColor = UIColor.clearColor;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgBanner);
        make.top.equalTo(imgBanner.mas_bottom);
        make.height.mas_equalTo(hItemView);
    }];
    
    float sizeItem = (SCREEN_WIDTH - 2*padding - 2*backagePadding)/3;
    
    //  view re-order domain
    viewRenew.layer.cornerRadius = viewSearch.layer.cornerRadius = viewTransferDomain.layer.cornerRadius = radius;
    viewRenew.userInteractionEnabled = viewSearch.userInteractionEnabled = TRUE;
    
    [viewRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo).offset(hSearch/2 + 10.0);
        make.centerX.equalTo(viewInfo.mas_centerX);
        make.width.mas_equalTo(sizeItem);
        make.bottom.equalTo(viewInfo);
    }];
    UITapGestureRecognizer *tapRenew = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSearchDomains)];
    [viewRenew addGestureRecognizer: tapRenew];
    
    [imgRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewRenew).offset(10.0);
        make.centerX.equalTo(viewRenew.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    lbRenew.text = text_check_multi_domains;
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewRenew).offset(3.0);
        make.right.equalTo(viewRenew).offset(-3.0);
        make.top.equalTo(imgRenew.mas_bottom);
        make.height.mas_equalTo(50.0);
    }];
    
    //  view check multi domain
    [viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewRenew);
        make.right.equalTo(viewRenew.mas_left).offset(-backagePadding);
        make.width.mas_equalTo(sizeItem);
    }];
    UITapGestureRecognizer *tapSearchDomain = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToRenewDomains)];
    [viewSearch addGestureRecognizer: tapSearchDomain];
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewSearch).offset(10.0);
        make.centerX.equalTo(viewSearch.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    lbSearch.text = text_renew_domains;
    [lbSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSearch).offset(3.0);
        make.right.equalTo(viewSearch).offset(-3.0);
        make.top.equalTo(imgSearch.mas_bottom);
        make.height.mas_equalTo(lbRenew.mas_height);
    }];
    
    //  view transfer domain
    [viewTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewRenew);
        make.left.equalTo(viewRenew.mas_right).offset(backagePadding);
        make.width.mas_equalTo(sizeItem);
    }];
    
    [imgTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTransferDomain).offset(10.0);
        make.centerX.equalTo(viewTransferDomain.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    lbTransferDomain.text = text_transfer_to_nhanhoa;
    [lbTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgTransferDomain.mas_bottom);
        make.left.equalTo(viewTransferDomain).offset(3.0);
        make.right.equalTo(viewTransferDomain).offset(-3.0);
        make.height.mas_equalTo(lbRenew.mas_height);
    }];
    
    //  many options
    lbManyOptions.text = many_options_with_attractive_offers;
    lbManyOptions.font = [AppDelegate sharedInstance].fontMedium;
    lbManyOptions.textColor = [UIColor colorWithRed:(57/255.0) green:(65/255.0) blue:(86/255.0) alpha:1.0];
    [lbManyOptions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo.mas_bottom).offset(20.0);
        make.left.right.equalTo(imgBanner);
        make.height.mas_equalTo(40.0);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"SuggestDomainCell" bundle:nil] forCellReuseIdentifier:@"SuggestDomainCell"];
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.scrollEnabled = NO;
    float hTableView = listData.count * hCell;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbManyOptions.mas_bottom).offset(20.0);
        make.left.right.equalTo(imgBanner);
        make.height.mas_equalTo(hTableView);
    }];
    
    float contentHeight = hBanner + hItemView + 20.0 + 40.0 + 20.0 + hTableView + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
}

- (void)getHeightBannerForView {
    if (!IS_IPHONE && !IS_IPOD) {
        float hNavBar = [AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav;
        hBanner = (SCREEN_HEIGHT - hNavBar)/2;
    }else{
        UIImage *bannerPhoto = [AccountModel getBannerPhotoFromUser];
        hBanner = SCREEN_WIDTH * bannerPhoto.size.height / bannerPhoto.size.width;
    }
}

- (IBAction)icSearchClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] search text = %@", __FUNCTION__, tfSearch.text)];
    
    [self.view endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfSearch.text]) {
        [self.view makeToast:text_enter_domains_to_check duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    SearchDomainViewController *searchDomainVC = [[SearchDomainViewController alloc] init];
    searchDomainVC.strSearch = tfSearch.text;
    [self.navigationController pushViewController:searchDomainVC animated:YES];
}

- (void)tapToSearchDomains {
    WhoIsViewController *whoisVC = [[WhoIsViewController alloc] initWithNibName:@"WhoIsViewController" bundle:nil];
    [self.navigationController pushViewController: whoisVC animated:TRUE];
}

- (void)tapToRenewDomains {
    RenewedDomainViewController *renewedVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
    [self.navigationController pushViewController: renewedVC animated:TRUE];
}

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    float wScreen = [DeviceUtils getWidthOfScreen];
    
    UIImage *banner = [AccountModel getBannerPhotoFromUser];
    hBanner = wScreen * banner.size.height / banner.size.width;
    
    [imgBanner mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(wScreen);
        make.height.mas_equalTo(hBanner);
    }];
    
    float sizeItem = (wScreen - 2*padding - 2*backagePadding)/3;
    [viewRenew mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeItem);
    }];
    
    [viewSearch mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeItem);
    }];
    
    [viewTransferDomain mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeItem);
    }];

    if ([DeviceUtils isLandscapeMode]) {
        scvContent.contentOffset = CGPointMake(0, hBanner/2);
    }
    
    float contentHeight = hBanner + hItemView + 20.0 + 40.0 + 20.0 + listData.count * hCell + padding;
    scvContent.contentSize = CGSizeMake(wScreen, contentHeight);
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestDomainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestDomainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listData objectAtIndex: indexPath.row];
    NSString *name = [info objectForKey:@"name"];
    id price = [info objectForKey:@"price"];
    
    NSString *content;
    if ([name hasSuffix:@".vn"]) {
        content = SFM(@"%@ %@", register_vietnam_domains, name);
    }else{
        content = SFM(@"%@ %@", register_international_domains, name);
    }
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
    NSRange range = [content rangeOfString: name];
    [attr addAttribute:NSForegroundColorAttributeName value:ORANGE_COLOR range:range];
    cell.lbDomain.attributedText = attr;
    
    if ([price isKindOfClass:[NSNumber class]]) {
        NSString *strPrice = SFM(@"%d", [price intValue]);
        cell.lbPrice.text = SFM(@"%@đ/%@", [AppUtils convertStringToCurrencyFormat: strPrice], text_year);
        
    }else if ([price isKindOfClass:[NSString class]]) {
        cell.lbPrice.text = SFM(@"%@đ/%@", [AppUtils convertStringToCurrencyFormat: (NSString *)price], text_year);
    }
    
    NSString *image = name;
    if ([image hasPrefix:@"."]) {
        image = [image substringFromIndex: 1];
    }
    cell.imgType.image = [UIImage imageNamed: image];
    
    
    cell.padding = padding;
    cell.hItem = hCell;
    [cell addBoxShadowForView:cell.viewParent withColor:UIColor.blackColor];
    [cell showOldPriceForCell: FALSE];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    [self.view endEditing: TRUE];
    
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [tfSearch resignFirstResponder];
    }
    return TRUE;
}

@end
