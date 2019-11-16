//
//  PromotionsViewController.m
//  NhanHoa
//
//  Created by OS on 10/17/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PromotionsViewController.h"
#import "PromotionTbvCell.h"

@interface PromotionsViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    float padding;
    
    NSMutableArray *listPromos;
    UIFont *textFont;
}
@end

@implementation PromotionsViewController
@synthesize viewHeader, icBack, lbHeader, tbPromotions;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self createListPromotionsForView];
    
    [self showContentWithCurrentLanguage];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Promotions"];
}

- (void)createListPromotionsForView {
    if (listPromos == nil) {
        listPromos = [[NSMutableArray alloc] init];
    }else{
        [listPromos removeAllObjects];
    }
    
    NSDictionary *promos1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos1.png", @"photo", @"GIẢM 5% TẤT CẢ SẢN PHẨM TẠI 9TECH.VN", @"title", @"10/2019", @"datetime", @"Ưu đãi liên kết giữa Nhân Hòa và 9TECH", @"content", nil];
    [listPromos addObject: promos1];
    
    NSDictionary *promos2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos2.png", @"photo", @"ƯU ĐÃI TÊN MIỀN .XYZ", @"title", @"10/2019 - 11/2019", @"datetime", @"Ưu đãi khủng 19k/ năm đầu (giá gốc 280k)", @"content", nil];
    [listPromos addObject: promos2];
    
    NSDictionary *promos3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos3.png", @"photo", @"ƯU ĐÃI HÓA ĐƠN ĐIỆN TỬ", @"title", @"11/2019", @"datetime", @"Tặng 1.000.000đ khi đăng ký hóa đơn điện tử tại Nhân Hòa", @"content", nil];
    [listPromos addObject: promos3];
    
    NSDictionary *promos4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos4.png", @"photo", @"GIẢM 50% TÊN MIỀN .VN", @"title", @"10/2019", @"datetime", @"Giảm 50% tên miền .VN khi đăng ký qua NHAN HOA APP", @"content", nil];
    [listPromos addObject: promos4];
    
    NSDictionary *promos5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos5.png", @"photo", @"Kinh Doanh Không Thể Thiếu .ONLINE", @"title", @"11/2019", @"datetime", @"Ưu đãi 28k/ năm đầu (giá gốc 850k/ năm)", @"content", nil];
    [listPromos addObject: promos5];
    
    NSDictionary *promos6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos6.png", @"photo", @"Tặng Máy Chủ Và Gói Quản Trị Chuyên Nghiệp", @"title", @"11/2019", @"datetime", @"Giá shock chỉ từ 2.100.000đ/ tháng", @"content", nil];
    [listPromos addObject: promos6];
    
    NSDictionary *promos7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos7.png", @"photo", @"Ưu Đãi Shock Tổng Đài VFone", @"title", @"- Chỉ 75.000đ/ tổng đài/ 10 máy nhánh\n- Tặng miễn phí số cố định tam hoa 999 cực", @"datetime", @"", @"content", nil];
    [listPromos addObject: promos7];
    
    NSDictionary *promos8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos8.png", @"photo", @"Đăng ký tên miền .ORG chỉ 229K/năm đầu", @"title", @"11/2019 - 12/2019", @"datetime", @"Không yêu cầu điều kiện đi kèm", @"content", nil];
    [listPromos addObject: promos8];
    
    NSDictionary *promos9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos9.jpg", @"photo", @"Khẳng định vị thế với tên miền .BEST", @"title", @"12/2019", @"datetime", @"Đăng ký tên miền .BEST chỉ 219K/năm đầu", @"content", nil];
    [listPromos addObject: promos9];
    
    NSDictionary *promos10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"promos10.jpg", @"photo", @"Tặng SSL khi đăng ký Web4s", @"title", @"12/2019", @"datetime", @"Thiết kế Website bán hàng đa kênh - Mua 1 Tặng 5", @"content", nil];
    [listPromos addObject: promos10];
}

- (void)setupUIForView
{
    self.view.backgroundColor = GRAY_240;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    //  header view
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_100 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    lbHeader.textColor = GRAY_50;
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
    
    //  content
    tbPromotions.layer.cornerRadius = 10.0;
    [tbPromotions registerNib:[UINib nibWithNibName:@"PromotionTbvCell" bundle:nil] forCellReuseIdentifier:@"PromotionTbvCell"];
    tbPromotions.backgroundColor = UIColor.clearColor;
    tbPromotions.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbPromotions.delegate = self;
    tbPromotions.dataSource = self;
    [tbPromotions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listPromos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PromotionTbvCell *cell = [tbPromotions dequeueReusableCellWithIdentifier:@"PromotionTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listPromos objectAtIndex: indexPath.row];
    [cell displayContentWithInfo: info];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *info = [listPromos objectAtIndex: indexPath.row];
    return [self getHeightOfCellWithInfo: info];
}

- (float)getHeightOfCellWithInfo: (NSDictionary *)info {
    float hCell = 0;
    
    NSString *photo = [info objectForKey:@"photo"];
    UIImage *imgPhoto = [UIImage imageNamed: photo];
    
    float hImgPhoto = (SCREEN_WIDTH - 2*padding) * imgPhoto.size.height / imgPhoto.size.width;
    hCell += hImgPhoto + 5.0;
    
    //  height title
    //  NSString *title = [info objectForKey:@"title"];
    hCell += 25.0;
    
    //  height datetime
    hCell += 20.0;
    
    //  height content
    NSString *content = [info objectForKey:@"content"];
    float hContent = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:textFont.pointSize-4] andMaxWidth:(SCREEN_WIDTH - 4*padding)].height;
    hCell += (hContent + 5.0);
    
    hCell += padding + padding;
    
    return hCell;
}

@end
