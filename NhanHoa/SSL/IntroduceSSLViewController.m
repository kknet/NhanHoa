//
//  IntroduceSSLViewController.m
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "IntroduceSSLViewController.h"
#import "SSLViewController.h"
#import "OnlyPhotoClvCell.h"
#import "PromotionClvCell.h"
#import "QuesttionTbvCell.h"

@interface IntroduceSSLViewController ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
{
    AppDelegate *appDelegate;
    float padding;
    float hSection;
    UIFont *textFont;
    UIFont *fontForGetHeight;
    float hTopContent;
    float heightPromotion;
    float heightSlider;
    
    NSMutableArray *listQuestions;
    int selectedIndex;
}
@end

@implementation IntroduceSSLViewController
@synthesize scvContent, bgHeader, lbTitle, viewHeader, icBack, lbHeader, icCart, lbCount, viewComodo, imgComodo, lbComodo, viewGeotrust, imgGeotrust, lbGeotrust, viewSymantec, imgSymantec, lbSymantec, clvPromotions, clvSliders, tbQuestions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Đăng ký SSL"];
    [self createListQuestionsIfNeed];
    selectedIndex = -1;
    
    [self setFrameForContentViewWithTableHeight];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (void)createListQuestionsIfNeed {
    if (listQuestions == nil) {
        listQuestions = [[NSMutableArray alloc] init];
        
        NSDictionary *question = [[NSDictionary alloc] initWithObjectsAndKeys:@"Công cụ kiểm tra chứng chỉ SSL", @"question", @"Tôi vừa cài đặt xong chứng chỉ SSL trên máy chủ của tôi. Làm thế nào để tôi kiểm tra ngày hết hạn của SSL và các thông tin khác?\nĐể kiểm tra chứng chỉ ssl, bạn có thể sử dụng các trang web sau đây:\n\nComodo: https://sslanalyzer.comodoca.com/\nDigicert: https://www.digicert.com/help/\nThawte: https://search.thawte.com/support/ssl-digital-certificates/index?page=content&id=SO9555\nVerisign: https://knowledge.verisign.com/support/ssl-certificates-support/index?page=content&id=AR1130\nRapidSSL: https://knowledge.rapidssl.com/support/ssl-certificate-support/index?page=content&id=SO9556\nGeoTrust: https://knowledge.geotrust.com/support/knowledge-base/index?page=content&id=SO9557", @"content", nil];
        [listQuestions addObject: question];
        
        NSDictionary *question1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Quy trình và thủ tục đăng ký OV & EV SSL", @"question", @"Sau khi đăng ký và thanh toán các loại SSL có mức thứng thực tên miền như OV(Tổ Chức) hay EV (Mở Rộng).Bạn sẽ nhận được Email hướng dẫn, tự động và ngay lập tức.\n\nBạn khởi tạo CSR trên máy chủ hoặc trên các Control Panel Hosting với tên miền của bạn.\nNhập CSR theo như hướng dẫn trong Email.\nSau khi nhập CSR thành công.Tùy loại SSL mà tổ chức CA sẽ gửi mail xác nhận tới email sở hữu tên miền (trong Whois database). Hoặc gửi tới email tên miền của bạn như administrator@tenmien.vn , webmaster@tenmien.vn hay postmaster@tenmien.vn .\n\nSau khi hoàn tất chứng thực tên miền.CA sẽ gửi tiếp các hướng dẫn để chứng thực tổ chức hoặc doanh nghiệp của bạn.Trong đó yêu cầu quan trọng là các bản scan giấy tờ hoạt động hợp lệ,được chính phủ cấp phát và công nhận.Đối với tổ chức thì yêu cầu có giấy phép hoạt động của chính phủ.Còn đối với Doanh Nghiệp thì phải có giấy phép đăng ký kinh doanh.\nSau khi CA hoàn tất việc chứng thực(mất từ 5-10 ngày) thì họ sẽ gửi thông tin chứng chỉ SSL cho bạn qua Email.\n\nChú ý: đối với Wildcard SSL. Khi tạo CSR thì Common Name (tên miền) bạn phải điền có dấu * ở đầu.Ví dụ tôi đăng ký Wildcard SSL cho tên miền nhanhoa.com.vn thì tôi sẽ điền Common Name là: *.nhanhoa.com.vn\n\nCA (Certificate Authority) : là tổ chức quản lý và phát hành chứng chỉ SSL cho người dùng.CA quản lý các nhà cung cấp SSL thứ ba như: Verisign,Comodo,Geotrust,Thawte...", @"content", nil];
        [listQuestions addObject: question1];
        
        NSDictionary *question2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Quy trình và thủ tục đăng ký DV SSL (chứng thực tên miền)", @"question",  @"Sau khi đăng ký và thanh toán các loại SSL có mức thứng thực tên miền(DV SSL).Bạn sẽ nhận được Email hướng dẫn, tự động và ngay lập tức.\n\nBạn khởi tạo CSR trên máy chủ hoặc trên các Control Panel Hosting với tên miền của bạn.\n\nNhập CSR theo như hướng dẫn trong Email.\n\nSau khi nhập CSR thành công,tùy loại SSL tổ chức CA sẽ gửi mail xác nhận tới email sở hữu tên miền (trong Whois database). Hoặc gửi tới email tên miền của bạn như administrator@tenmien.vn , webmaster@tenmien.vn hay postmaster@tenmien.vn .\n\nSau khi hoàn tất chứng thực tên miền.\n\nCA sẽ gửi các thông tin chứng chỉ tới Email của bạn để cài đặt.\n\nChú ý: đối với Wildcard SSL. Khi tạo CSR thì Common Name (tên miền) bạn phải điền có dấu * ở đầu.Ví dụ tôi đăng ký Wildcard SSL cho tên miền nhanhoa.com.vn thì tôi sẽ điền Common Name là: *.nhanhoa.com.vn\n\nCA (Certificate Authority) : là tổ chức quản lý và phát hành chứng chỉ SSL cho người dùng.CA quản lý các nhà cung cấp SSL thứ ba như: Verisign,Comodo,Geotrust,Thawte...", @"content", nil];
        [listQuestions addObject: question2];
        
        NSDictionary *question3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Tôi nên lựa chọn chứng chỉ SSL nào ?", @"question",  @"Hỏi: Sau khi tham khảo SSL tại Nhân Hòa, tôi thấy có rất nhiều loại chứng chỉ SSL và không biết nên lựa chọn loại nào cho phù hợp?\nTrả lời: Để lựa chọn các loại SSL phù hợp, bạn cần phân tích nhu cầu của mình cũng như các chức năng của từng loại SSL. Dựa trên các tiêu chí dưới đây.\n1. Quy mô hoạt động website của bạn được đứng tên bởi tổ chức,doanh nghiệp hay cá nhân ?\n- Nếu hoạt động với tư cách cá nhân bạn chỉ có thể đăng ký SSL với kiểu chứng thực DV(Chứng thực qua Tên Miền).\n- Nếu hoạt động với tư cách tổ chức hoặc doanh nghiệp. Ngoài DV SSL bạn còn có thể đăng ký SSL với các kiểu chứng thực khác như OV SSL hay EV SSL\n2. Mục đích sử dụng SSL?\n- Bảo mật các trang web thương mại điện tử,ngân hàng điện tử,sàn chứng khoán với các giao dịch có giá trị lớn hay truy xuất các thông tin nhạy cảm.\nQuý khách chỉ nên sử dụng EV SSL với mức chứng thực mở rộng.Là loại chứng chỉ uy tín nhất,EV SSL có thanh địa chỉ màu xanh chứa thông tin tổ chức và doanh nghiệp.Kèm theo với các mức bảo hiểm lớn lên tới hàng trăm nghìn đô la một vụ.\n- Bảo mật các trang đăng nhập,đăng ký,thanh toán,webmail và các nhu cầu đơn giản.\nDV SSL sẽ đáp ứng tốt các nhu cầu cơ bản này.Với thời gian cung cấp và triển khai nhanh chóng gần như ngay lập tức.\nChứng thực tên miền được sở hữu bởi doanh nghiệp hay tổ chức. Nâng cao uy tín của website.\nOV SSL đáp ứng được các nhu này.EV SSL sẽ là tốt nhất vì nó cung cấp thêm thanh địa chỉ chứng thực màu xanh chứa thông tin tổ chức.Tuy nhiên thời gian triển khai và quy trình chứng thực mất khá nhiều thời gian từ 5-10 ngày.\n- Có nhu cầu sử dụng cho nhiều Subdomain (tên miền phụ) của một tên miền.Ví dụ như :\npayments.nhanhoa.com.vn\nlogin.nhanhoa.com.vn\nwebmail.nhanhoa.com.vn\n*.nhanhoa.com.vn\nWildcard SSL là giải pháp tiết kiệm dành cho bạn.Nó có khả năng cung cấp cho không giới hạn subdomain chỉ với một chứng chỉ duy nhất.Wildcard SSL bao gồm 2 kiểu chứng thực là DV và OV.", @"content", nil];
        [listQuestions addObject: question3];
    }
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
    
    UIImage *imgHosting = [UIImage imageNamed:@"bg_ssl_header"];
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
    
    lbCount.textColor = ORANGE_COLOR;
    lbCount.backgroundColor = UIColor.whiteColor;
    lbCount.layer.cornerRadius = 18.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(18.0);
    }];
    
    //  view content
    viewComodo.layer.cornerRadius = viewGeotrust.layer.cornerRadius = viewSymantec.layer.cornerRadius = 8.0;
    lbComodo.font = lbGeotrust.font = lbSymantec.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-3];
    lbComodo.textColor = lbGeotrust.textColor = lbSymantec.textColor = GRAY_80;
    
    float sizeBlock = (SCREEN_WIDTH - 4*padding)/3;
    
    UITapGestureRecognizer *tapOnGeotrust = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnGeotrustView)];
    [viewGeotrust addGestureRecognizer: tapOnGeotrust];
    [viewGeotrust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgHeader.mas_bottom).offset(-35.0);
        make.centerX.equalTo(bgHeader.mas_centerX);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewGeotrust color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgGeotrust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewGeotrust.mas_centerX);
        make.bottom.equalTo(viewGeotrust.mas_centerY).offset(-5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbGeotrust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgGeotrust.mas_bottom).offset(5.0);
        make.left.equalTo(viewGeotrust).offset(5.0);
        make.right.equalTo(viewGeotrust).offset(-5.0);
    }];
    
    UITapGestureRecognizer *tapOnComodo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnComodoView)];
    [viewComodo addGestureRecognizer: tapOnComodo];
    [viewComodo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewGeotrust);
        make.right.equalTo(viewGeotrust.mas_left).offset(-padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewComodo color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgComodo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewComodo.mas_centerX);
        make.bottom.equalTo(viewComodo.mas_centerY).offset(-5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbComodo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgComodo.mas_bottom).offset(5.0);
        make.left.equalTo(viewComodo).offset(5.0);
        make.right.equalTo(viewComodo).offset(-5.0);
    }];
    
    UITapGestureRecognizer *tapOnSymantec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(whenTapOnSymantecView)];
    [viewSymantec addGestureRecognizer: tapOnSymantec];
    [viewSymantec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewGeotrust);
        make.left.equalTo(viewGeotrust.mas_right).offset(padding);
        make.width.height.mas_equalTo(sizeBlock);
    }];
    [AppUtils addBoxShadowForView:viewSymantec color:GRAY_150 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [imgSymantec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewSymantec.mas_centerX);
        make.bottom.equalTo(viewSymantec.mas_centerY).offset(-5.0);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    [lbSymantec mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgSymantec.mas_bottom).offset(5.0);
        make.left.equalTo(viewSymantec).offset(5.0);
        make.right.equalTo(viewSymantec).offset(-5.0);
    }];
    
    //  lbtitle
    lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize+2];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgHeader).offset(padding);
        make.right.equalTo(bgHeader).offset(-padding);
        make.bottom.equalTo(viewGeotrust.mas_top).offset(-padding);
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
        make.top.equalTo(viewGeotrust.mas_bottom).offset(padding);
        make.left.equalTo(viewComodo);
        make.right.equalTo(viewSymantec);
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
    
    UIImage *imgSlider = [UIImage imageNamed:@"ssl_promotion"];
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
        make.left.right.equalTo(bgHeader);
        make.height.mas_equalTo(0);
    }];
    
    hTopContent = hBackground + (sizeBlock - 35.0) + padding + heightPromotion + padding + heightSlider + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent);
}

- (void)whenTapOnGeotrustView{
    SSLViewController *sslVC = [[SSLViewController alloc] initWithNibName:@"SSLViewController" bundle:nil];
    [self.navigationController pushViewController:sslVC animated:TRUE];
}

- (void)whenTapOnComodoView{
    SSLViewController *sslVC = [[SSLViewController alloc] initWithNibName:@"SSLViewController" bundle:nil];
    [self.navigationController pushViewController:sslVC animated:TRUE];
}

- (void)whenTapOnSymantecView {
    SSLViewController *sslVC = [[SSLViewController alloc] initWithNibName:@"SSLViewController" bundle:nil];
    [self.navigationController pushViewController:sslVC animated:TRUE];
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
        cell.imgPromotion.image = [UIImage imageNamed:@"ssl_promotion"];
        return cell;
    }else {
        PromotionClvCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PromotionClvCell" forIndexPath:indexPath];
        cell.lbTitle.text = @"Giới thiệu dịch vụ SSL Nhân Hòa";
        cell.lbContent.text = @"SSL là viết tắt của từ Secure Sockets Layer. Đây là một tiêu chuẩn an ninh công nghệ toàn cầu tạo ra một liên kết giữa máy chủ web và trình duyệt. Liên kết này đảm bảo tất cả dữ liệu trao đổi giữa máy chủ web và trình duyệt luôn được bảo mật và an toàn.";
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

- (void)setFrameForContentViewWithTableHeight {
    float hTableView = [self getHeightForTableView] + hSection;
    [tbQuestions mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopContent + hTableView);
}

#pragma mark - UIScrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

@end
