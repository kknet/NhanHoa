//
//  ServersViewController.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ServersViewController.h"
#import "CloudServerTbvCell.h"

@interface ServersViewController ()<UITableViewDataSource, UITableViewDelegate>{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    float hWindowsServerCell;
}
@end

@implementation ServersViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvMenu, btnWindowsServer, btnLinuxServer, tbContent, lbMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hMenu = 50.0;
    
    padding = 15.0;
    float hBTN = 45.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    hWindowsServerCell = padding + 40.0 + padding + 35.0*8 + padding + 1.0 + padding + hBTN + padding + 15.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
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
    
    //  scrollview menu
    [scvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    float sizeContent = 0;
    
    btnWindowsServer.titleLabel.font = btnLinuxServer.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    float sizeText = [AppUtils getSizeWithText:@"Windows Server" withFont:btnWindowsServer.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnWindowsServer setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnWindowsServer setTitleColor:GRAY_150 forState:UIControlStateNormal];
    btnWindowsServer.selected = TRUE;
    [btnWindowsServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu).offset(padding);
        make.top.equalTo(scvMenu);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hMenu-5.0);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Linux Server" withFont:btnLinuxServer.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnLinuxServer setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnLinuxServer setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnLinuxServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnWindowsServer.mas_right).offset(padding);
        make.top.bottom.equalTo(btnWindowsServer);
        make.width.mas_equalTo(sizeText);
    }];
    
    lbMenu.backgroundColor = BLUE_COLOR;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnWindowsServer.mas_bottom);
        make.left.right.equalTo(btnWindowsServer);
        make.height.mas_equalTo(5.0);
    }];
    scvMenu.contentSize = CGSizeMake(sizeContent, hMenu);
    scvMenu.showsHorizontalScrollIndicator = FALSE;
    
    [AppUtils addBoxShadowForView:scvMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  table content
    
    tbContent.showsVerticalScrollIndicator = FALSE;
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"CloudServerTbvCell" bundle:nil] forCellReuseIdentifier:@"CloudServerTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvMenu.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}

- (IBAction)btnWindowsServerPress:(UIButton *)sender {
}

- (IBAction)btnLinuxServerPress:(UIButton *)sender {
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CloudServerTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CloudServerTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"SSD CLOUD SERVER A";
        cell.lbPrice.text = @"1.299.000 đ/tháng";
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"SSD CLOUD SERVER B";
        cell.lbPrice.text = @"1.699.000 đ/tháng";
        
    }else if (indexPath.row == 2){
        cell.lbTitle.text = @"SSD CLOUD SERVER C";
        cell.lbPrice.text = @"2.199.000 đ/tháng";
        
    }else if (indexPath.row == 3){
        cell.lbTitle.text = @"SSD CLOUD SERVER D";
        cell.lbPrice.text = @"2.699.000 đ/tháng";
        
    }else if (indexPath.row == 4){
        cell.lbTitle.text = @"SSD CLOUD SERVER E";
        cell.lbPrice.text = @"3.199.000 đ/tháng";
        
    }else if (indexPath.row == 5){
        cell.lbTitle.text = @"SSD CLOUD SERVER F";
        cell.lbPrice.text = @"4.299.000 đ/tháng";
    }
    
    cell.btnBuy.tag = indexPath.row;
    [cell.btnBuy addTarget:self
                    action:@selector(onBuyButtonPress:)
          forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hWindowsServerCell;
}

- (void)onBuyButtonPress: (UIButton *)sender {
//    if (choosePackageView == nil) {
//        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"ChooseHostingPackgeView" owner:nil options:nil];
//        for(id currentObject in toplevelObject){
//            if ([currentObject isKindOfClass:[ChooseHostingPackgeView class]]) {
//                choosePackageView = (ChooseHostingPackgeView *) currentObject;
//                break;
//            }
//        }
//        choosePackageView.delegate = self;
//        [appDelegate.window addSubview: choosePackageView];
//    }
//    [choosePackageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.bottom.right.equalTo(appDelegate.window);
//    }];
//    [choosePackageView setupUIForViewWithInfo:[self getListTimeInfoForCurrentPackage]];
//
//    if (sender.tag == eWindowsHostingStudent) {
//        choosePackageView.lbTitle.text = SFM(@"%@\n%@", @"Chọn thời gian cho gói", @"Sinh viên");
//
//    }else if (sender.tag == eWindowsHostingPersonal){
//        choosePackageView.lbTitle.text = SFM(@"%@\n%@", @"Chọn thời gian cho gói", @"Cá nhân");
//
//    }else if (sender.tag == eWindowsHostingPersonalPlus){
//        choosePackageView.lbTitle.text = SFM(@"%@\n%@", @"Chọn thời gian cho gói", @"Cá nhân+");
//
//    }else if (sender.tag == eWindowsHostingBusiness){
//        choosePackageView.lbTitle.text = SFM(@"%@\n%@", @"Chọn thời gian cho gói", @"Doanh nghiệp");
//
//    }else if (sender.tag == eWindowsHostingECommerce){
//        choosePackageView.lbTitle.text = SFM(@"%@\n%@", @"Chọn thời gian cho gói", @"Thương mại điện tử");
//
//    }else if (sender.tag == eWindowsHostingProfessional){
//        choosePackageView.lbTitle.text = SFM(@"%@\n%@", @"Chọn thời gian cho gói", @"Chuyên nghiệp");
//    }
//
//    [choosePackageView performSelector:@selector(showContentInfoView) withObject:nil afterDelay:0.05];
}

- (NSArray *)getListTimeInfoForCurrentPackage {
    NSMutableArray *times = [[NSMutableArray alloc] init];
    
    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:@"6", @"month", @"36000", @"price", @"432000", @"total", nil];
    [times addObject: info];
    
    NSDictionary *info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"12", @"month", @"32400", @"price", @"777000", @"total", nil];
    [times addObject: info1];
    
    NSDictionary *info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"36", @"month", @"30600", @"price", @"1101600", @"total", nil];
    [times addObject: info2];
    
    NSDictionary *info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"48", @"month", @"28800", @"price", @"1382400", @"total", nil];
    [times addObject: info3];
    
    NSDictionary *info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"60", @"month", @"27000", @"price", @"1620000", @"total", nil];
    [times addObject: info4];
    
    return times;
}

@end
