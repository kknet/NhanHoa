//
//  ServersViewController.m
//  NhanHoa
//
//  Created by OS on 11/12/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ServersViewController.h"
#import "CloudServerTbvCell.h"
#import "ChooseCloudServerPackageView.h"

@interface ServersViewController ()<UITableViewDataSource, UITableViewDelegate, ChooseCloudServerPackageViewDelegate>
{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    float hWindowsServerCell;
    ChooseCloudServerPackageView *choosePackageView;
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    lbHeader.text = @"SSD Cloud Server";
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
    float hBTN = 45.0;
    float hMenu = 60.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hMenu = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hMenu = 55.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hMenu = 60.0;
    }
    hWindowsServerCell = padding + 40.0 + padding + 35.0*8 + padding + 1.0 + padding + hBTN + padding + 15.0;
    
    self.view.backgroundColor = GRAY_240;
    
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
    if (choosePackageView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"ChooseCloudServerPackageView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[ChooseCloudServerPackageView class]]) {
                choosePackageView = (ChooseCloudServerPackageView *) currentObject;
                break;
            }
        }
        choosePackageView.delegate = self;
        [appDelegate.window addSubview: choosePackageView];
    }
    [choosePackageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(appDelegate.window);
    }];
    [choosePackageView setupUIForViewWithInfo:[self getListDataInfoForCurrentPackage]];
    choosePackageView.lbTitle.text = @"Chọn template";
    [choosePackageView.btnConfirm setTitle:[appDelegate.localization localizedStringForKey:@"Continue"] forState:UIControlStateNormal];
    
    if (sender.tag == 0) {
        choosePackageView.lbDesc.text = @"SSD Cloud Server A";

    }else if (sender.tag == 1){
        choosePackageView.lbDesc.text = @"SSD Cloud Server B";

    }else if (sender.tag == 2){
        choosePackageView.lbDesc.text = @"SSD Cloud Server C";

    }else if (sender.tag == 3){
        choosePackageView.lbDesc.text = @"SSD Cloud Server D";

    }else if (sender.tag == 4){
        choosePackageView.lbDesc.text = @"SSD Cloud Server E";

    }else if (sender.tag == 5){
        choosePackageView.lbDesc.text = @"SSD Cloud Server F";
    }

    [choosePackageView performSelector:@selector(showContentInfoView) withObject:nil afterDelay:0.05];
}

- (NSArray *)getListDataInfoForCurrentPackage {
    NSMutableArray *times = [[NSMutableArray alloc] initWithObjects:@"CentOS6 64bit + WHM", @"CentOS6 64bit + Zimbra", @"CentOS7 64bit", @"Ubuntu12 64bit", @"Ubuntu14 64bit", @"CentOS7 64bit + DirectAdmin", @"CentOS6 64bit + DirectAdmin", @"Ubuntu16 64bit", @"CentOS6 64bit", @"CentOS6 32bit", @"CentOS7 64bit + Plesk", @"CentOS7 64bit + WHM", @"Ubuntu14 64bit + DirectAdmin", @"Ubuntu16 64bit + DirectAdmin", @"CentOS6 64bit + Kerio", @"Ubuntu18 64bit", @"CentOS7 NextCloud", @"Ubuntu18 NextCloud", @"CentOS7 Owncloud", @"Ubuntu18 Owncloud", @"Pfsense-2.3", @"CentOS7 64bit Pritunl", @"CentOS7 VestaCP", @"CentOS8 64bit", @"CentOS7 LAMP", @"CentOS7 LEMP", @"CentOS7 Zabbix", nil];
    return times;
}

#pragma mark - ChooseCloudServerPackageViewDelegate
-(void)closeChooseSSDCloudServerPackageView {
    if (choosePackageView) {
        [choosePackageView removeFromSuperview];
        choosePackageView = nil;
    }
}

-(void)confirmAfterChooseSSDCloudServerPackageView {
    if (choosePackageView) {
        [choosePackageView removeFromSuperview];
        choosePackageView = nil;
    }
}

@end
