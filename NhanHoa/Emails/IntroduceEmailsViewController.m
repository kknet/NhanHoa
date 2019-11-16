//
//  IntroduceEmailsViewController.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "IntroduceEmailsViewController.h"
#import "EmailsViewController.h"
#import "PromotionClvCell.h"
#import "QuesttionTbvCell.h"

@interface IntroduceEmailsViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *appDelegate;
    float padding;
    UIFont *fontForGetHeight;
    float hBlock;
    float heightSlider;
    float hTopContent;
    
    NSMutableArray *listQuestions;
    int selectedIndex;
    float hSection;
    
    UIFont *textFont;
}
@end

@implementation IntroduceEmailsViewController
@synthesize scvContent, bgHeader, lbTitle, viewHeader, icBack, lbHeader, icCart, lbCount, viewMenu, viewEmailHosting, imgEmailHosting, lbEmailHosting, viewEmailGoogle, imgEmailGoogle, lbEmailGoogle, viewEmailMicrosoft, imgEmailMicrosoft, lbEmailMicrosoft, viewEmailServerRieng, imgEmailServerRieng, lbEmailServerRieng, clvSliders, tbQuestions;

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Register Email"];
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
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    float hIcon = 30.0;
    hBlock = 100.0;
    hSection = 60.0;
    
    fontForGetHeight = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:16.0];
        hIcon = 18.0;
        hBlock = 60.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:18.0];
        hIcon = 24.0;
        hBlock = 80.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        fontForGetHeight = [UIFont fontWithName:RobotoRegular size:20.0];
        hIcon = 30.0;
        hBlock = 100.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.delegate = self;
    scvContent.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UIImage *imgHeader = [UIImage imageNamed:@"bg_email"];
    float hBackground = SCREEN_WIDTH * imgHeader.size.height/imgHeader.size.width;
    bgHeader.backgroundColor = UIColor.clearColor;
    [bgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBackground);
    }];
    
    //  header
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
    viewMenu.layer.cornerRadius = 10.0;
    viewMenu.clipsToBounds = TRUE;
    lbEmailHosting.font = lbEmailGoogle.font = lbEmailMicrosoft.font = lbEmailServerRieng.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-3];
    lbEmailHosting.textColor = lbEmailGoogle.textColor = lbEmailMicrosoft.textColor = lbEmailServerRieng.textColor = GRAY_80;

    float widthBlock = (SCREEN_WIDTH - 2*padding - 7.0)/2;

    //  view menu
    viewMenu.backgroundColor = UIColor.clearColor;
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgHeader.mas_bottom).offset(-40.0);
        make.left.equalTo(bgHeader).offset(padding);
        make.right.equalTo(bgHeader).offset(-padding);
        make.height.mas_equalTo(2*hBlock + 7.0);
    }];
    
    //  email hosting
    UIImage *imgIcon = [UIImage imageNamed:@"ic_email_hosting"];
    float wIcon = (hIcon+3) * imgIcon.size.width / imgIcon.size.height;
    
    UITapGestureRecognizer *tapOnEmailHosting = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnEmailHosting)];
    [viewEmailHosting addGestureRecognizer: tapOnEmailHosting];
    [viewEmailHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(viewMenu);
        make.width.mas_equalTo(widthBlock);
        make.height.mas_equalTo(hBlock);
    }];
    
    [imgEmailHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewEmailHosting.mas_centerY).offset(-2.0);
        make.centerX.equalTo(viewEmailHosting.mas_centerX);
        make.height.mas_equalTo(hIcon+3);
        make.width.mas_equalTo(wIcon);
    }];

    [lbEmailHosting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewEmailHosting.mas_centerY).offset(5.0);
        make.left.equalTo(viewEmailHosting).offset(2.0);
        make.right.equalTo(viewEmailHosting).offset(-2.0);
    }];

    //  email google
    UITapGestureRecognizer *tapOnEmailGoogle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnEmailGoogle)];
    [viewEmailGoogle addGestureRecognizer: tapOnEmailGoogle];
    [viewEmailGoogle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(viewMenu);
        make.width.mas_equalTo(widthBlock);
        make.height.mas_equalTo(hBlock);
    }];

    imgIcon = [UIImage imageNamed:@"ic_email_google"];
    wIcon = hIcon * imgIcon.size.width / imgIcon.size.height;
    [imgEmailGoogle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewEmailGoogle.mas_centerY).offset(-2.0);
        make.centerX.equalTo(viewEmailGoogle.mas_centerX);
        make.height.mas_equalTo(hIcon);
        make.width.mas_equalTo(wIcon);
    }];

    [lbEmailGoogle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewEmailGoogle.mas_centerY).offset(5.0);
        make.left.equalTo(viewEmailGoogle).offset(2.0);
        make.right.equalTo(viewEmailGoogle).offset(-2.0);
    }];

    //  email microsoft
    UITapGestureRecognizer *tapOnEmailMicrosoft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnEmailMicrosoft)];
    [viewEmailMicrosoft addGestureRecognizer: tapOnEmailMicrosoft];
    [viewEmailMicrosoft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(viewMenu);
        make.width.mas_equalTo(widthBlock);
        make.height.mas_equalTo(hBlock);
    }];

    imgIcon = [UIImage imageNamed:@"ic_email_microsoft"];
    wIcon = (hIcon + 5) * imgIcon.size.width / imgIcon.size.height;
    [imgEmailMicrosoft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewEmailMicrosoft.mas_centerY).offset(-2.0);
        make.centerX.equalTo(viewEmailMicrosoft.mas_centerX);
        make.height.mas_equalTo(hIcon + 5);
        make.width.mas_equalTo(wIcon);
    }];

    [lbEmailMicrosoft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewEmailMicrosoft.mas_centerY).offset(5.0);
        make.left.equalTo(viewEmailMicrosoft).offset(2.0);
        make.right.equalTo(viewEmailMicrosoft).offset(-2.0);
    }];

    //  email server rieng
    UITapGestureRecognizer *tapOnEmailServer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnEmailServer)];
    [viewEmailServerRieng addGestureRecognizer: tapOnEmailServer];
    [viewEmailServerRieng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(viewMenu);
        make.width.mas_equalTo(widthBlock);
        make.height.mas_equalTo(hBlock);
    }];

    imgIcon = [UIImage imageNamed:@"ic_email_server"];
    wIcon = (hIcon+8) * imgIcon.size.width / imgIcon.size.height;
    [imgEmailServerRieng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewEmailServerRieng.mas_centerY).offset(-2.0);
        make.centerX.equalTo(viewEmailServerRieng.mas_centerX);
        make.height.mas_equalTo(hIcon+8);
        make.width.mas_equalTo(wIcon);
    }];

    [lbEmailServerRieng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewEmailServerRieng.mas_centerY).offset(5.0);
        make.left.equalTo(viewEmailServerRieng).offset(2.0);
        make.right.equalTo(viewEmailServerRieng).offset(-2.0);
    }];

    //  lbtitle
    lbTitle.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewMenu);
        make.bottom.equalTo(viewMenu.mas_top).offset(-padding);
        make.height.mas_equalTo(30.0);
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
        make.top.equalTo(viewMenu.mas_bottom).offset(padding);
        make.left.right.equalTo(viewMenu);
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

    hTopContent = hBackground + ((2*hBlock + 10) - 40.0) + padding + heightSlider + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent);
}

- (void)whenTapOnEmailHosting {
    EmailsViewController *emailsVC = [[EmailsViewController alloc] initWithNibName:@"EmailsViewController" bundle:nil];
    [self.navigationController pushViewController:emailsVC animated:TRUE];
}

- (void)whenTapOnEmailGoogle {
    EmailsViewController *emailsVC = [[EmailsViewController alloc] initWithNibName:@"EmailsViewController" bundle:nil];
    [self.navigationController pushViewController:emailsVC animated:TRUE];
}

- (void)whenTapOnEmailMicrosoft {
    EmailsViewController *emailsVC = [[EmailsViewController alloc] initWithNibName:@"EmailsViewController" bundle:nil];
    [self.navigationController pushViewController:emailsVC animated:TRUE];
}

- (void)whenTapOnEmailServer {
    EmailsViewController *emailsVC = [[EmailsViewController alloc] initWithNibName:@"EmailsViewController" bundle:nil];
    [self.navigationController pushViewController:emailsVC animated:TRUE];
}

- (void)setFrameForContentViewWithTableHeight {
    float hTableView = [self getHeightForTableView] + hSection;
    [tbQuestions mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent + hTableView);
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
        
        NSDictionary *question = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tại sao bạn nên dùng Host Việt Nam?", @"question", @"Với Host Việt Nam, tốc độ truy cập tại Việt Nam sẽ nhanh hơn, dễ dàng đăng ký và thanh toán. Bạn sẽ không bị hạn chế về rào cản ngôn ngữ, quyền lợi của bạn được pháp luật Việt Nam bảo vệ.", @"content", nil];
        [listQuestions addObject: question];
        
        NSDictionary *question1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Account Hosting của tôi có thể sử dụng cho nhiều tên miền được không?", @"question", @"Đối với mỗi account hosting, bạn có thể dùng cho 1 hay nhiều tên miền tùy thuộc vào gói hosting mà bạn sử dụng là nhỏ hay lớn. Bạn xem thông số mục (tài khoản FTP, CSDL) trên hosting chính là số lượng tên miền được sử dụng trong account hosting.", @"content", nil];
        [listQuestions addObject: question1];
        
        NSDictionary *question2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Email hosting là gì?", @"question",  @"Mail hosting là dịch vụ lưu trữ phục vụ cho việc dùng email của bạn, mail hosting luôn sẳn sàng cho việc gửi và nhận mail của bạn bấn kỳ lúc nào, ngay cả khi bạn không dùng mail thì máy chủ vẫn hoạt động với vai trò như hộp thư, đảm bảo mail được gửi tới bạn lúc nào cũng được.", @"content", nil];
        [listQuestions addObject: question2];
        
        
        NSDictionary *question3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"E-mail gởi thế nào bị gọi là spam?", @"question",  @"E-mail bị đánh giá là spam thường là do người nhận (Yahoo/Gmail/Hotmail/AOL…) đánh giá bằng cách nhấn vào nút đánh dấu Spam (Mark as Spam), vì vậy không phải do máy móc kiểm soát mà là do sự phản hồi của người nhận được Mail.Việc bị liệt vào spam còn phụ thuộc vào danh sách người nhận có đồng thuận nhận nội dung bạn gửi không.", @"content", nil];
        [listQuestions addObject: question3];
        
        NSDictionary *question4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"SSL trong Pro Mail để làm gì?", @"question",  @"Chứng thực SSL trong kết nối POP3, SMTP, IMAP, WebMail giúp thông tin email truyền đi được mã hóa, tránh việc nghe lén dữ liệu trong quá trình truyền đi.", @"content", nil];
        [listQuestions addObject: question4];
        
        NSDictionary *question5= [[NSDictionary alloc] initWithObjectsAndKeys:@"Băng thông Hosting là gì?", @"question",  @"Băng thông hosting được hiểu là tổng lưu lượng dữ liệu được truyền up/down qua hostingĐơn vị thường dùng là MB hay GB.", @"content", nil];
        [listQuestions addObject: question5];
        
        NSDictionary *question6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Dung lượng hosting là gì?", @"question",  @"Dung lượng hosting là tổng số MB mà bạn sử dụng để lưu trữ dữ liệu trên hosting của bạnDung lượng được tính trên tất cả các tập tin thuộc thư mục gốc và thư mục con trên hosting của bạn, bao gồm web, mail, log, ...", @"content", nil];
        [listQuestions addObject: question6];
        
        NSDictionary *question7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi có thể nâng cấp gói dịch vụ hosting tôi đang dùng được không?", @"question",  @"Chúng tôi có thể tiến hành nâng cấp tài khoản hosing của bạn trong vòng 5 phút mà không anh hưởng tới hoạt động của web site. Hơn nữa khoản phí chưa sử dụng đến của gói hosting trước sẽ được tính cho gói hosting mới được nâng cấp.", @"content", nil];
        [listQuestions addObject: question7];
        
        NSDictionary *question8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Vì sao lại Email Hosting trong khi dịch vụ Web Hosting cũng có Email?", @"question",  @"Email Hosting là dịch vụ chuyên dụng, chúng tôi thiết kế riêng cụm máy chủ chỉ dùng cho Email nên việc sử dụng chắc chắn sẽ có nhiều khác biệt. Bạn có thể quan tâm những vấn đề sau:\n - Có máy chủ dự phòng trong trường hợp có sự cố.\n - Email đính kèm tập tin lớn gởi nhanh hơn rất nhiều, dung lượng hộp thư lớn hơn.\n - Nhiều tính năng, thông số để người quản trị kiểm soát người dùng và thư từ.\n - Email kèm theo Web Hosting được cung cấp không có sự ràng buộc về chất lượng. Trên thực tế, có khá nhiều khách hàng lợi dung Email này để gởi thư rác, quảng cáo... điều này sẽ ảnh hưởng đến những người dùng khác trên cùng Server, có thể là bạn?", @"content", nil];
        [listQuestions addObject: question8];
        
        NSDictionary *question9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi có thể yêu cầu hỗ trợ từ Nhân Hòa như thế nào?", @"question",  @"Bạn có thể yêu cầu hỗ trợ từ chúng tôi thông qua hệ thống hỗ trợ trực tuyến trên website, hệ thống support ticket hoặc Liên hệ trực tiếp với chúng tôi.", @"content", nil];
        [listQuestions addObject: question9];
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
    PromotionClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PromotionClvCell" forIndexPath:indexPath];
    cell.lbTitle.text = @"Giới thiệu dịch vụ Email Nhân Hòa";
    cell.lbContent.text = @"Để có một hệ thống email chuyên nghiệp, tin cậy các tổ chức/ doanh nghiệp nên sử dụng dịch vụ email từ các nhà cung cấp có uy tín và kinh nghiệm như Nhân Hòa. Tùy theo nhu cầu Quý khách hàng có thể chọn 1 trong 2 dịch vụ Email Hosting hoặc Email server cho tổ chức/ doanh nghiệp của mình.";
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(SCREEN_WIDTH - 2*padding, heightSlider);
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
    lbSection.text = @"Câu hỏi thường gặp về Email";
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

#pragma mark - UIScrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

@end
