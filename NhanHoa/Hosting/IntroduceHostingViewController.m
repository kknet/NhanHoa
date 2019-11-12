//
//  IntroduceHostingViewController.m
//  NhanHoa
//
//  Created by OS on 11/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "IntroduceHostingViewController.h"
#import "HostingViewController.h"
#import "HostingPromotionClvCell.h"
#import "HostingSliderClvCell.h"
#import "QuesttionTbvCell.h"

@interface IntroduceHostingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    float sizeBlock;
    float heightPromotion;
    float heightSlider;
    
    float hSection;
    NSMutableArray *listQuestions;
    int selectedIndex;
    
    UIFont *fontForGetHeight;
    float hTopContent;
    
    UIFont *textFont;
}
@end

@implementation IntroduceHostingViewController

@synthesize scvContent, bgHosting, lbTitle, viewHeader, icBack, lbHeader, icCart, lbCount, viewWindows, imgWindows, lbWindows, viewLinux, imgLinux, lbLinux, viewWordpress, imgWordpress, lbWordpress, clvPromotions, clvSliders, tbQuestions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Hosting"];
    [self createListQuestionsIfNeed];
    selectedIndex = -1;
    
    [self setFrameForContentViewWithTableHeight];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hSection = 60.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    float sizeIcon = 35.0;
    
    fontForGetHeight = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:16.0];
        sizeIcon = 25.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:18.0];
        sizeIcon = 30.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:20.0];
        sizeIcon = 35.0;
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
    bgHosting.backgroundColor = UIColor.clearColor;
    [bgHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBackground);
    }];
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus);
        make.left.right.equalTo(bgHosting);
        make.height.mas_equalTo(self.navigationController.navigationBar.frame.size.height);
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
    
    //  view content
    viewWindows.layer.cornerRadius = viewLinux.layer.cornerRadius = viewWordpress.layer.cornerRadius = 8.0;
    viewWindows.layer.cornerRadius = viewLinux.layer.cornerRadius = viewWordpress.layer.cornerRadius = 8.0;
    
    lbWindows.font = lbLinux.font = lbWordpress.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-3];
    lbWindows.textColor = lbLinux.textColor = lbWordpress.textColor = GRAY_80;
    
    sizeBlock = (SCREEN_WIDTH - 4*padding)/3;
    
    UITapGestureRecognizer *tapOnLinux = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnLinuxView)];
    [viewLinux addGestureRecognizer: tapOnLinux];
    [viewLinux mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgHosting.mas_bottom).offset(-35.0);
        make.centerX.equalTo(bgHosting.mas_centerX);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewLinux color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgLinux mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewLinux.mas_centerX);
        make.bottom.equalTo(viewLinux.mas_centerY).offset(-5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbLinux mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgLinux.mas_bottom).offset(5.0);
        make.left.equalTo(viewLinux).offset(2.0);
        make.right.equalTo(viewLinux).offset(-2.0);
    }];
    
    UITapGestureRecognizer *tapOnWindows = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnWindowsView)];
    [viewWindows addGestureRecognizer: tapOnWindows];
    [viewWindows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewLinux);
        make.right.equalTo(viewLinux.mas_left).offset(-padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewWindows color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgWindows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWindows.mas_centerX);
        make.bottom.equalTo(viewWindows.mas_centerY).offset(-5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbWindows mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgWindows.mas_bottom).offset(5.0);
        make.left.equalTo(viewWindows).offset(2.0);
        make.right.equalTo(viewWindows).offset(-2.0);
    }];
    
    UITapGestureRecognizer *tapOnWordpress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnWordpressView)];
    [viewWordpress addGestureRecognizer: tapOnWordpress];
    [viewWordpress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewLinux);
        make.left.equalTo(viewLinux.mas_right).offset(padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewWordpress color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgWordpress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewWordpress.mas_centerX);
        make.bottom.equalTo(viewWordpress.mas_centerY).offset(-5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbWordpress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgWordpress.mas_bottom).offset(5.0);
        make.left.equalTo(viewWordpress).offset(2.0);
        make.right.equalTo(viewWordpress).offset(-2.0);
    }];
    
    //  lbtitle
    lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize+2];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgHosting).offset(padding);
        make.right.equalTo(bgHosting).offset(-padding);
        make.bottom.equalTo(viewLinux.mas_top).offset(-padding);
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
    [clvPromotions registerNib:[UINib nibWithNibName:@"HostingPromotionClvCell" bundle:nil] forCellWithReuseIdentifier:@"HostingPromotionClvCell"];
    clvPromotions.showsHorizontalScrollIndicator = FALSE;
    clvPromotions.pagingEnabled = TRUE;
    
    UIImage *imgPromotion = [UIImage imageNamed:@"hosting_promotion"];
    heightPromotion = (SCREEN_WIDTH - 2*padding) * imgPromotion.size.height / imgPromotion.size.width;
    clvPromotions.backgroundColor = UIColor.clearColor;
    clvPromotions.layer.cornerRadius = 10.0;
    clvPromotions.clipsToBounds = TRUE;
    [clvPromotions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewLinux.mas_bottom).offset(padding);
        make.left.equalTo(viewWindows);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
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
    [clvSliders registerNib:[UINib nibWithNibName:@"HostingSliderClvCell" bundle:nil] forCellWithReuseIdentifier:@"HostingSliderClvCell"];
    clvSliders.showsHorizontalScrollIndicator = FALSE;
    clvSliders.pagingEnabled = TRUE;
    
    UIImage *imgSlider = [UIImage imageNamed:@"hosting_slider"];
    float hImgSlider = (SCREEN_WIDTH - 2*padding) * imgSlider.size.height / imgSlider.size.width;
    heightSlider = hImgSlider + 30.0 + 50.0;
    
    clvSliders.backgroundColor = ORANGE_COLOR;
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
    tbQuestions.delegate = self;
    tbQuestions.dataSource = self;
    [tbQuestions registerNib:[UINib nibWithNibName:@"QuesttionTbvCell" bundle:nil] forCellReuseIdentifier:@"QuesttionTbvCell"];
    [tbQuestions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(clvSliders.mas_bottom).offset(padding);
        make.left.right.equalTo(bgHosting);
        make.height.mas_equalTo(0);
    }];
    
    hTopContent = hBackground + (sizeBlock - 35.0) + padding + heightPromotion + padding + heightSlider + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent);
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (void)whenTapOnLinuxView {
    HostingViewController *hostingVC = [[HostingViewController alloc] initWithNibName:@"HostingViewController" bundle:nil];
    hostingVC.curMenu = eMenuLinuxHosting;
    [self.navigationController pushViewController: hostingVC animated:TRUE];
}

- (void)whenTapOnWindowsView {
    HostingViewController *hostingVC = [[HostingViewController alloc] initWithNibName:@"HostingViewController" bundle:nil];
    hostingVC.curMenu = eMenuWindowsHosting;
    [self.navigationController pushViewController: hostingVC animated:TRUE];
}

- (void)whenTapOnWordpressView {
    HostingViewController *hostingVC = [[HostingViewController alloc] initWithNibName:@"HostingViewController" bundle:nil];
    hostingVC.curMenu = eMenuWordpressHosting;
    [self.navigationController pushViewController: hostingVC animated:TRUE];
}

- (void)createListQuestionsIfNeed {
    if (listQuestions == nil) {
        listQuestions = [[NSMutableArray alloc] init];
        
        NSDictionary *question = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tại sao bạn nên dùng Host Việt Nam ?", @"question", @"Với Host Việt Nam, tốc độ truy cập tại Việt Nam sẽ nhanh hơn, dễ dàng đăng ký và thanh toán. Bạn sẽ không bị hạn chế về rào cản ngôn ngữ, quyền lợi của bạn được pháp luật Việt Nam bảo vệ.", @"content", nil];
        [listQuestions addObject: question];
        
        NSDictionary *question1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Account Hosting của tôi có thể sử dụng cho nhiều tên miền được không?", @"question", @"Đối với mỗi account hosting, bạn có thể dùng cho 1 hay nhiều tên miền tùy thuộc vào gói hosting mà bạn sử dụng là nhỏ hay lớn. Bạn xem thông số mục (tài khoản FTP, CSDL) trên hosting chính là số lượng tên miền được sử dụng trong account hosting.", @"content", nil];
        [listQuestions addObject: question1];
        
        NSDictionary *question2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Làm cách nào để tôi có thể quản lý được tài khoản hosting của mình?", @"question",  @"Chúng tôi gửi thông tin tài khoản qua email của bạn với đường dẫn truy cập, thông tin user và password quản trị.", @"content", nil];
        [listQuestions addObject: question2];
        
        NSDictionary *question3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Nếu không hài lòng với dịch vụ tôi có được hoàn lại phí không?", @"question",  @"Chúng tôi sẽ hoàn trả lại 100% số tiền chúng tôi đã nhận với điều kiện: lý do bạn không hài lòng là đúng hoặc bạn không vi phạm quy định sử dụng dịch vụ của chúng tôi.", @"content", nil];
        [listQuestions addObject: question3];
        
        NSDictionary *question4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Nhân Hòa có thể hỗ trợ (support) các khách hàng của tôi không?", @"question",  @"Nhân Hòa sẽ đảm bảo mọi công tác support liên quan. Bạn có thể liên hệ trực tiếp với chúng tôi để support cho các khách hàng của bạn. Khách hàng của bạn cũng có thể liên hệ với chúng tôi để yêu cầu support.", @"content", nil];
        [listQuestions addObject: question4];
        
        
        NSDictionary *question5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Sau bao lâu kể từ khi thanh toán tôi có thể sử dụng dịch vụ hosting?", @"question",  @"Thông thường sau 30 phút đến 1 tiếng kể từ khi chúng tôi nhận được thanh toán thì bên bạn sẽ nhận được thông tin quản lý hosting thông qua email của mình.", @"content", nil];
        [listQuestions addObject: question5];
        
        NSDictionary *question6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi có thể cài đặt diễn đàn trên tài khoản hosting của tôi không?", @"question",  @"Bạn có thể cài đặt diễn đàn lên tài khoản hosting của bạn nhưng phải tuân theo các quy định sử dụng dịch vụ của chúng tôi. Tham khảo Quy định sử dụng dịch vụ", @"content", nil];
        [listQuestions addObject: question6];
        
        
        NSDictionary *question7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi có thể nâng cấp gói dịch vụ hosting tôi đang dùng được không?", @"question",  @"Chúng tôi có thể tiến hành nâng cấp tài khoản hosing của bạn trong vòng 5 phút mà không anh hưởng tới hoạt động của web site. Hơn nữa khoản phí chưa sử dụng đến của gói hosting trước sẽ được tính cho gói hosting mới được nâng cấp.", @"content", nil];
        [listQuestions addObject: question7];
        
        NSDictionary *question8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi có thể sang nhượng, cho, bán lại dịch vụ không?", @"question", @"Bạn toàn quyền sang nhượng, cho, bán lại dịch vụ đã đăng ký sử dụng và phải thông báo cho chúng tôi bằng văn bản kèm theo thông tin về chủ sở hữu mới.", @"content",  nil];
        [listQuestions addObject: question8];
        
        NSDictionary *question9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi có thể yêu cầu hỗ trợ từ Nhân Hòa như thế nào?", @"question", @"Bạn có thể yêu cầu hỗ trợ từ chúng tôi thông qua hệ thống hỗ trợ trực tuyến trên website, hệ thống support ticket hoặc Liên hệ trực tiếp với chúng tôi.", @"content",  nil];
        [listQuestions addObject: question9];
    }
}

- (void)setFrameForContentViewWithTableHeight {
    float hTableView = [self getHeightForTableView] + hSection;
    [tbQuestions mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent + hTableView);
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
        HostingPromotionClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostingPromotionClvCell" forIndexPath:indexPath];
        
        return cell;
    }else {
        HostingSliderClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HostingSliderClvCell" forIndexPath:indexPath];
        cell.lbTitle.text = @"Vì sao nên thuê hosting Nhân Hòa";
        cell.lbContent.text = @"Với bề dày kinh nghiệm, Nhân Hòa luôn nằm trong top đầu các đơn vị cùng lĩnh vực cung cấp dịch vụ chuyên nghiệp nhất.";
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
    lbSection.text = @"Hỏi đáp về Hosting";
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

#pragma mark - UIScrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

@end
