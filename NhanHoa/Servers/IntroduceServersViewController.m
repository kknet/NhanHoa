//
//  IntroduceServersViewController.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "IntroduceServersViewController.h"
#import "ServersViewController.h"
#import "QuesttionTbvCell.h"
#import "OnlyPhotoClvCell.h"
#import "PromotionClvCell.h"

@interface IntroduceServersViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource>
{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    UIFont *fontForGetHeight;
    
    float heightPromotion;
    float heightSlider;
    float hTopContent;
    
    float hSection;
    NSMutableArray *listQuestions;
    int selectedIndex;
}
@end

@implementation IntroduceServersViewController
@synthesize scvContent, bgHeader, lbTitle, viewHeader, icBack, lbHeader, icCart, lbCount, viewWindowsServer, imgWindowsServer, lbWindowsServer, viewLinuxServer, imgLinuxServer, lbLinuxServer, clvPromotions, clvSliders, tbQuestions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"SSD Cloud Server"];
    [self createListQuestionsIfNeed];
    selectedIndex = -1;
    
    [self setFrameForContentViewWithTableHeight];
    [self updateCartCountForView];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hSection = 70.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    float sizeIcon = 40.0;
    float hBlock = 35.0 + 65.0;
    
    fontForGetHeight = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:16.0];
        sizeIcon = 25.0;
        hBlock = 25.0 + 55.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:18.0];
        sizeIcon = 35.0;
        hBlock = 35.0 + 60.0;
        
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:20.0];
        sizeIcon = 40.0;
        hBlock = 40.0 + 65.0;
        
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.delegate = self;
    scvContent.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(242/255.0) blue:(244/255.0) alpha:1.0];
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UIImage *imgHosting = [UIImage imageNamed:@"bg_hosting"];
    float hBackground = SCREEN_WIDTH * imgHosting.size.height/imgHosting.size.width;
    bgHeader.backgroundColor = UIColor.clearColor;
    [bgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBackground);
    }];
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus);
        make.left.right.equalTo(bgHeader);
        make.height.mas_equalTo(self.navigationController.navigationBar.frame.size.height);
    }];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewHeader);
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
    
    //  view content
    viewWindowsServer.layer.cornerRadius = viewLinuxServer.layer.cornerRadius = 8.0;
    
    lbWindowsServer.font = lbLinuxServer.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-3];
    lbWindowsServer.textColor = lbLinuxServer.textColor = GRAY_80;
    
    float widthBlock = (SCREEN_WIDTH - 3*padding)/2;
    
    UITapGestureRecognizer *tapOnWindowsServer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnWindowsServer)];
    [viewWindowsServer addGestureRecognizer: tapOnWindowsServer];
    [viewWindowsServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgHeader.mas_bottom).offset(-sizeIcon);
        make.left.equalTo(bgHeader).offset(padding);
        make.width.mas_equalTo(widthBlock);
        make.height.mas_equalTo(hBlock);
    }];
    [AppUtils addBoxShadowForView:viewWindowsServer color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgWindowsServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWindowsServer.mas_centerX);
        make.bottom.equalTo(viewWindowsServer.mas_centerY).offset(5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbWindowsServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgWindowsServer.mas_bottom).offset(5.0);
        make.left.equalTo(viewWindowsServer).offset(2.0);
        make.right.equalTo(viewWindowsServer).offset(-2.0);
    }];
    
    UITapGestureRecognizer *tapOnLinuxServer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnLinuxServer)];
    [viewLinuxServer addGestureRecognizer: tapOnLinuxServer];
    [viewLinuxServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewWindowsServer);
        make.left.equalTo(viewWindowsServer.mas_right).offset(padding);
        make.width.mas_equalTo(widthBlock);
    }];
    [AppUtils addBoxShadowForView:viewLinuxServer color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgLinuxServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewLinuxServer.mas_centerX);
        make.bottom.equalTo(viewLinuxServer.mas_centerY);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbLinuxServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgLinuxServer.mas_bottom).offset(5.0);
        make.left.equalTo(viewLinuxServer).offset(2.0);
        make.right.equalTo(viewLinuxServer).offset(-2.0);
    }];
    
    //  lbtitle
    lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgHeader).offset(padding);
        make.right.equalTo(bgHeader).offset(-padding);
        make.bottom.equalTo(viewWindowsServer.mas_top).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    //  promotions
    UICollectionViewFlowLayout *layoutPromos = [[UICollectionViewFlowLayout alloc] init];
    layoutPromos.minimumLineSpacing = 0;
    layoutPromos.minimumInteritemSpacing = 0;
    layoutPromos.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
    clvPromotions.collectionViewLayout = layoutPromos;
    clvPromotions.delegate = self;
    clvPromotions.dataSource = self;
    [clvPromotions registerNib:[UINib nibWithNibName:@"OnlyPhotoClvCell" bundle:nil] forCellWithReuseIdentifier:@"OnlyPhotoClvCell"];
    clvPromotions.showsHorizontalScrollIndicator = FALSE;
    clvPromotions.pagingEnabled = TRUE;
    
    UIImage *imgPromotion = [UIImage imageNamed:@"hosting_promotion"];
    heightPromotion = (SCREEN_WIDTH - 2*padding) * imgPromotion.size.height / imgPromotion.size.width;
    clvPromotions.backgroundColor = UIColor.clearColor;
    clvPromotions.layer.cornerRadius = 10.0;
    clvPromotions.clipsToBounds = TRUE;
    [clvPromotions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewWindowsServer.mas_bottom).offset(padding);
        make.left.equalTo(viewWindowsServer);
        make.right.equalTo(viewLinuxServer);
        make.height.mas_equalTo(heightPromotion);
    }];
    
    //  sliders
    UICollectionViewFlowLayout *layoutSlider = [[UICollectionViewFlowLayout alloc] init];
    layoutSlider.minimumLineSpacing = 0;
    layoutSlider.minimumInteritemSpacing = 0;
    layoutSlider.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
    
    clvSliders.collectionViewLayout = layoutSlider;
    clvSliders.delegate = self;
    clvSliders.dataSource = self;
    [clvSliders registerNib:[UINib nibWithNibName:@"PromotionClvCell" bundle:nil] forCellWithReuseIdentifier:@"PromotionClvCell"];
    clvSliders.showsHorizontalScrollIndicator = FALSE;
    clvSliders.pagingEnabled = TRUE;
    
    UIImage *imgSlider = [UIImage imageNamed:@"hosting_slider"];
    float hImgSlider = (SCREEN_WIDTH - 2*padding) * imgSlider.size.height / imgSlider.size.width;
    heightSlider = hImgSlider + 30.0 + 50.0;
    
    clvSliders.layer.cornerRadius = 10.0;
    clvSliders.clipsToBounds = TRUE;
    [clvSliders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvPromotions.mas_bottom).offset(padding);
        make.left.equalTo(clvPromotions);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
        make.height.mas_equalTo(heightSlider);
    }];
    
    tbQuestions.scrollEnabled = FALSE;
    tbQuestions.backgroundColor = UIColor.whiteColor;
    tbQuestions.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbQuestions.delegate = self;
    tbQuestions.dataSource = self;
    [tbQuestions registerNib:[UINib nibWithNibName:@"QuesttionTbvCell" bundle:nil] forCellReuseIdentifier:@"QuesttionTbvCell"];
    [tbQuestions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvSliders.mas_bottom).offset(padding);
        make.left.right.equalTo(bgHeader);
        make.height.mas_equalTo(0);
    }];
    
    hTopContent = hBackground + ((sizeIcon + 55.0) - 35.0) + padding + heightPromotion + padding + heightSlider + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent);
}

- (void)setFrameForContentViewWithTableHeight {
    float hTableView = [self getHeightForTableView] + hSection;
    if (hTableView < SCREEN_HEIGHT-hTopContent) {
        hTableView = SCREEN_HEIGHT - hTopContent;
    }
    [tbQuestions mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent + hTableView);
}

- (void)whenTapOnWindowsServer {
    ServersViewController *serversVC = [[ServersViewController alloc] initWithNibName:@"ServersViewController" bundle:nil];
    [self.navigationController pushViewController:serversVC animated:TRUE];
}

- (void)whenTapOnLinuxServer {
    ServersViewController *serversVC = [[ServersViewController alloc] initWithNibName:@"ServersViewController" bundle:nil];
    [self.navigationController pushViewController:serversVC animated:TRUE];
}

#pragma mark - UIScrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}


#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listQuestions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuesttionTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuesttionTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listQuestions objectAtIndex: indexPath.row];
    NSString *question = [info objectForKey:@"question"];
    NSString *content = [info objectForKey:@"content"];
    
    cell.lbTitle.text = question;
    cell.lbContent.text = content;
    
    if (selectedIndex == indexPath.row) {
        [cell updateUIForSelected: TRUE];
    }else{
        [cell updateUIForSelected: FALSE];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hSection)];
    
    UILabel *lbSection = [[UILabel alloc] init];
    lbSection.text = @"Giải pháp Máy chủ ảo trên nền tảng OpenStack từ Nhân Hòa";
    lbSection.numberOfLines = 5;
    lbSection.font = textFont;
    lbSection.textColor = GRAY_80;
    [viewSection addSubview: lbSection];
    [lbSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewSection);
        make.left.equalTo(viewSection).offset(padding);
        make.right.equalTo(viewSection).offset(-padding);
    }];
    
    return viewSection;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == selectedIndex) {
        selectedIndex = -1;
    }else{
        selectedIndex = (int)indexPath.row;
    }
    [tbQuestions reloadData];
    [self setFrameForContentViewWithTableHeight];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedIndex == indexPath.row) {
        return [self getHeghtForRowAtIndex: (int)indexPath.row selected: TRUE];
    }else{
        return [self getHeghtForRowAtIndex: (int)indexPath.row selected: FALSE];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hSection;
}

- (float)getHeghtForRowAtIndex: (int)index selected: (BOOL)selected {
    NSDictionary *info = [listQuestions objectAtIndex: index];
    NSString *question = [info objectForKey:@"question"];
    NSString *content = [info objectForKey:@"content"];
    
    float maxSize = (SCREEN_WIDTH - 3*padding - 18.0);
    float hTitle = [AppUtils getSizeWithText:question withFont:fontForGetHeight andMaxWidth:maxSize].height;
    float hTop = padding + hTitle + padding + 1.0;
    
    if (index == selectedIndex) {
        float hContent = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize-1] andMaxWidth:(SCREEN_WIDTH - 2*padding)].height + 5.0;
        return hTop + padding + hContent + padding;
    }else{
        return hTop;
    }
}

- (float)getHeightForTableView {
    float hTableView = 0;
    for (int index=0; index<listQuestions.count; index++) {
        if (index == selectedIndex) {
            hTableView += [self getHeghtForRowAtIndex:index selected:TRUE];
        }else{
            hTableView += [self getHeghtForRowAtIndex:index selected:FALSE];
        }
    }
    return hTableView;
}

- (void)createListQuestionsIfNeed {
    if (listQuestions == nil) {
        listQuestions = [[NSMutableArray alloc] init];
        
        NSDictionary *question = [[NSDictionary alloc] initWithObjectsAndKeys:@"Máy chủ ảo (VPS) là gì ?", @"question", @"Máy chủ ảo (Virtual Private Server - VPS) là dịch vụ máy chủ hoạt động dưới dạng chia sẻ tài nguyên từ một máy chủ vật lý ban đầu. VPS có tính năng như một máy chủ riêng (Dedicated Server). Người sử dụng được cấp quyền cao nhất để toàn quyền quản trị máy chủ.\n\nVPS kết nối Internet với 01 IP tĩnh và được cài đặt sẵn hệ điều hành tùy chọn. VPS cho phép quản trị từ xa và cài đặt các phần mềm theo nhu cầu mà không bị giới hạn số lượng domain.\n\nVPS thích hợp cho việc xây dựng hệ thống Mail Server, Web Server, Backup, Storage Server... dùng riêng hoặc truyền tải file dữ liệu giữa các chi nhánh với nhau một cách dễ dàng, nhanh chóng thuận tiện và bảo mật.\n\nCloud VPS là máy chủ ảo trên nền tảng điện toán đám mây. Cloud VPS có nhiều ưu điểm vượt trội so với VPS thông thường về độ ổn định và khả năng linh hoạt trong việc cấp phát, mở rộng tài nguyên.", @"content", nil];
        [listQuestions addObject: question];
        
        NSDictionary *question1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Sự khác biệt trong giải pháp Cloud VPS/Cloud Server của Nhân Hòa:", @"question", @"Hệ thống cung cấp dịch vụ Cloud VPS/Cloud Server của Nhân Hòa được được xây dựng và phát triển trên nền tảng điện toán đám mây OpenStack kết hợp với giải pháp lưu trữ CEPH. Đây là các giải pháp được rất nhiều hãng công nghệ hàng đầu trên thế giới sử dụng để cung cấp hạ tầng về máy chủ, lưu trữ cho các hệ thống với quy mô lớn trong nhiều năm qua như Redhat, IBM, DELL EMC, Cisco, HP.\n\nDịch vụ Cloud VPS/Cloud Server của Nhân Hòa được triển khai trên hạ tầng các cụm máy chủ DELL & HP cực mạnh, sử dụng 100% ổ cứng SSD nhằm tối ưu hóa tốc độ truy suất và độ an toàn dữ liệu cho khách hàng.\n\nNgoài ra, Cloud VPS/ Cloud Server tại Nhân Hòa còn được giám sát liên tục và được sao lưu dữ liệu định kỳ theo nhu cầu của khách hàng.", @"content", nil];
        [listQuestions addObject: question1];
    }
}

#pragma mark - UICollectionview menu
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == clvPromotions) {
        OnlyPhotoClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OnlyPhotoClvCell" forIndexPath:indexPath];
        cell.imgPromotion.image = [UIImage imageNamed:@"hosting_promotion"];
        return cell;
    }else {
        PromotionClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PromotionClvCell" forIndexPath:indexPath];
        cell.lbTitle.text = @"Vì sao nên thuê Server Nhân Hòa";
        cell.lbContent.text = @"Hệ thống máy chủ được đặt tại Trung tâm dữ liệu lớn, đáp ứng theo chuẩn quốc tế. Cam kết ổn định, an toàn, bảo mật, tiết kiệm thời gian.";
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == clvPromotions) {
        return CGSizeMake(SCREEN_WIDTH - 2*padding, heightPromotion);
    }else {
        return CGSizeMake(SCREEN_WIDTH - 2*padding, heightSlider);
    }
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

@end
