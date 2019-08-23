//
//  HostingUpgradeViewController.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingUpgradeViewController.h"
#import "HostingDetailTbvCell.h"
#import "HostingDetailSelectTbvCell.h"
#import "HostingPackageCell.h"

@interface HostingUpgradeViewController ()<UITableViewDelegate, UITableViewDataSource>{
    float paddingContent;
    float hTitle;
    float hFooter;
    NSMutableArray *listPackages;
    UITableView *tbListPackage;
    
    NSArray *listTimes;
    UITableView *tbListTimes;
    
    float hNormalCell;
    float hSelectCell;
    
    NSDictionary *transferPackage;
    NSString *transferTime;
}
@end

@implementation HostingUpgradeViewController
@synthesize tbChoosePackage, lbHeader, tbPreview;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self addTableListToMainView];
    [self addTableChooseTimeForMainView];
    
    transferPackage = nil;
    transferTime = @"";
}

- (void)setupUIForView {
    paddingContent = 7.0;
    hTitle = 50.0;
    
    hFooter = 70.0;
    hNormalCell = 55.0;
    hSelectCell = 65.0;
    
    lbHeader.font = [AppDelegate sharedInstance].fontMedium;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).offset(paddingContent);
        make.right.equalTo(self.view).offset(-paddingContent);
        make.height.mas_equalTo(hTitle);
    }];
    
    float hTbChoosePackage = hNormalCell + hSelectCell + hSelectCell + hFooter;
    [tbChoosePackage registerNib:[UINib nibWithNibName:@"HostingDetailTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingDetailTbvCell"];
    [tbChoosePackage registerNib:[UINib nibWithNibName:@"HostingDetailSelectTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingDetailSelectTbvCell"];
    tbChoosePackage.scrollEnabled = FALSE;
    tbChoosePackage.layer.borderWidth = 1.0;
    tbChoosePackage.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    tbChoosePackage.separatorStyle = UITableViewCellSelectionStyleNone;
    tbChoosePackage.delegate = self;
    tbChoosePackage.dataSource = self;
    [tbChoosePackage mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.left.bottom.right.equalTo(self.view);
        //  make.bottom.right.equalTo(self.view).offset(-paddingContent);
        make.top.equalTo(lbHeader.mas_bottom);
        make.left.equalTo(self.view).offset(paddingContent);
        make.right.equalTo(self.view).offset(-paddingContent);
        make.height.mas_equalTo(hTbChoosePackage);
    }];
    [AppUtils addBoxShadowForView:tbChoosePackage color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [self addFooterForTableChoosePackage];
    
    //  table preview info
    [tbPreview registerNib:[UINib nibWithNibName:@"HostingDetailTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingDetailTbvCell"];
    [tbPreview registerNib:[UINib nibWithNibName:@"HostingDetailSelectTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingDetailSelectTbvCell"];
    tbPreview.layer.borderWidth = 1.0;
    tbPreview.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    tbPreview.separatorStyle = UITableViewCellSelectionStyleNone;
    tbPreview.delegate = self;
    tbPreview.dataSource = self;
    tbPreview.clipsToBounds = TRUE;
    tbPreview.hidden = TRUE;
    [tbPreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(0.0);
    }];
    [AppUtils addBoxShadowForView:tbPreview color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    [self addFooterForTablePreview];
}

- (void)addFooterForTableChoosePackage {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*paddingContent, hFooter)];
    UIButton *btnChooseAndView = [[UIButton alloc] init];
    btnChooseAndView.backgroundColor = ORANGE_BUTTON;
    btnChooseAndView.layer.borderColor = ORANGE_BUTTON.CGColor;
    btnChooseAndView.layer.borderWidth = 1.0;
    [btnChooseAndView setTitle:@"Chọn dịch vụ và xem thử thông tin" forState:UIControlStateNormal];
    [btnChooseAndView setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnChooseAndView.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnChooseAndView.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [footerView addSubview: btnChooseAndView];
    
    float sizeBTN = [AppUtils getSizeWithText:btnChooseAndView.currentTitle withFont:btnChooseAndView.titleLabel.font].width + 20.0;
    [btnChooseAndView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footerView.mas_centerX);
        make.centerY.equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(45.0);
        make.width.mas_equalTo(sizeBTN);
    }];
    
    tbChoosePackage.tableFooterView = footerView;
    [btnChooseAndView addTarget:self
                         action:@selector(onButtonChooseAndViewPress:)
               forControlEvents:UIControlEventTouchUpInside];
}

- (void)onButtonChooseAndViewPress: (UIButton *)sender {
    [self showHostingPackageList: FALSE];
    [self showSelectTimeTableView: FALSE];
    
    [sender setTitleColor:ORANGE_BUTTON forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    [self performSelector:@selector(goToScreenViewInformation:) withObject:sender afterDelay:0.1];
}

- (void)goToScreenViewInformation: (UIButton *)sender {
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sender.backgroundColor = ORANGE_BUTTON;
    
    [self showPreviewInformation];
}

- (void)showPreviewInformation {
    tbPreview.hidden = FALSE;
    [tbPreview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)addFooterForTablePreview {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*paddingContent, hFooter)];
    UIButton *btnBack = [[UIButton alloc] init];
    
    float leftSize = [AppUtils getSizeWithText:@"Quay lại" withFont:[AppDelegate sharedInstance].fontBTN].width + 10.0;
    float rightSize = [AppUtils getSizeWithText:@"Xác nhận chuyển dịch vụ" withFont:[AppDelegate sharedInstance].fontBTN].width + 10.0;
    [btnBack setTitle:@"Quay lại" forState:UIControlStateNormal];
    [footerView addSubview: btnBack];
    [btnBack addTarget:self
                action:@selector(onButtonBackPressed:)
      forControlEvents:UIControlEventTouchUpInside];
    
    float originX = (SCREEN_WIDTH - 2*paddingContent - (leftSize + 2*paddingContent + rightSize))/2;
    
    [btnBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).offset(originX);
        make.centerY.equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(45.0);
        make.width.mas_equalTo(leftSize);
    }];
    
    UIButton *btnConfirm = [[UIButton alloc] init];
    [btnConfirm setTitle:@"Xác nhận chuyển dịch vụ" forState:UIControlStateNormal];
    [footerView addSubview: btnConfirm];
    
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnBack);
        make.left.equalTo(btnBack.mas_right).offset(2*paddingContent);
        make.width.mas_equalTo(rightSize);
    }];
    
    btnBack.backgroundColor = btnConfirm.backgroundColor = ORANGE_BUTTON;
    btnBack.layer.borderColor = btnConfirm.layer.borderColor = ORANGE_BUTTON.CGColor;
    btnBack.layer.borderWidth = btnConfirm.layer.borderWidth = 1.0;
    [btnBack setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    btnBack.titleLabel.font = btnConfirm.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnBack.layer.cornerRadius = btnConfirm.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    
    tbPreview.tableFooterView = footerView;
}

- (void)onButtonBackPressed: (UIButton *)sender {
    [sender setTitleColor:ORANGE_BUTTON forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    [self performSelector:@selector(backToChooseService:) withObject:sender afterDelay:0.1];
}

- (void)backToChooseService: (UIButton *)sender {
    [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    sender.backgroundColor = ORANGE_BUTTON;
    
    [tbPreview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(0.0);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        tbPreview.hidden = TRUE;
    }];
}

- (void)addTableListToMainView {
    [self checkToCreateDemoList];
    
    if (tbListPackage == nil) {
        tbListPackage = [[UITableView alloc] init];
        [self.view addSubview: tbListPackage];
    }
    
    [tbListPackage registerNib:[UINib nibWithNibName:@"HostingPackageCell" bundle:nil] forCellReuseIdentifier:@"HostingPackageCell"];
    tbListPackage.delegate = self;
    tbListPackage.dataSource = self;
    tbListPackage.showsVerticalScrollIndicator = FALSE;
    tbListPackage.layer.borderWidth = 1.0;
    tbListPackage.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tbListPackage.layer.borderColor = BORDER_COLOR.CGColor;
    tbListPackage.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbListPackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(hTitle + hNormalCell + (hSelectCell - [AppDelegate sharedInstance].hTextfield)/2 + [AppDelegate sharedInstance].hTextfield + 2.0);
        make.right.equalTo(self.view).offset(-paddingContent - 5.0);
        make.width.mas_equalTo(0.0);
        //  make.width.mas_equalTo(SCREEN_WIDTH - 2*paddingContent - 3*5.0 - 130.0);
        make.height.mas_equalTo(0.0);
    }];
}

- (void)addTableChooseTimeForMainView {
    if (listTimes == nil) {
        listTimes = @[@"6", @"7",  @"8",  @"9",  @"10",  @"11",  @"12",  @"13",  @"14",  @"15",  @"16",  @"17",  @"18",  @"24",  @"36",  @"48",  @"60"];
    }
    
    if (tbListTimes == nil) {
        tbListTimes = [[UITableView alloc] init];
        [self.view addSubview: tbListTimes];
    }
    
    [tbListTimes registerNib:[UINib nibWithNibName:@"HostingPackageCell" bundle:nil] forCellReuseIdentifier:@"HostingPackageCell"];
    tbListTimes.delegate = self;
    tbListTimes.dataSource = self;
    tbListTimes.showsVerticalScrollIndicator = FALSE;
    tbListTimes.layer.borderWidth = 1.0;
    tbListTimes.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tbListTimes.layer.borderColor = BORDER_COLOR.CGColor;
    tbListTimes.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbListTimes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(hTitle + hNormalCell + hSelectCell + (hSelectCell - [AppDelegate sharedInstance].hTextfield)/2 + [AppDelegate sharedInstance].hTextfield + 2.0);
        make.right.equalTo(self.view).offset(-paddingContent - 5.0);
        make.width.mas_equalTo(0.0);
        make.height.mas_equalTo(0.0);
    }];
}

- (void)checkToCreateDemoList {
    if (listPackages == nil) {
        listPackages = [[NSMutableArray alloc] init];
        
        NSDictionary *package1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – BASIC 1 (Space:5GB;Email:50)", @"name", nil];
        [listPackages addObject: package1];
        
        NSDictionary *package2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – BASIC 2 (Space:10GB;Email:100)", @"name", nil];
        [listPackages addObject: package2];
        
        NSDictionary *package3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – BASIC 3 (Space:20GB;Email:200)", @"name", nil];
        [listPackages addObject: package3];
        
        NSDictionary *package4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – ADVANCE (Space:50GB;Email:500)", @"name", nil];
        [listPackages addObject: package4];
        
        NSDictionary *package5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – PRO (Space:200GB;Email:unlimited)", @"name", nil];
        [listPackages addObject: package5];
        
        NSDictionary *package6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – CLASSIC 1 (Space:500MB;Email:5)", @"name", nil];
        [listPackages addObject: package6];
        
        NSDictionary *package7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – CLASSIC 2 (Space:1GB;Email:10)", @"name", nil];
        [listPackages addObject: package7];
        
        NSDictionary *package8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – CLASSIC 3 (Space:2 GB;Email:20)", @"name", nil];
        [listPackages addObject: package8];
        
        NSDictionary *package9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – CLASSIC 1 (New) (Space:5GB;Email:5)", @"name", nil];
        [listPackages addObject: package9];
        
        NSDictionary *package10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – CLASSIC 2 (New) (Space:10GB;Email:20)", @"name", nil];
        [listPackages addObject: package10];
        
        NSDictionary *package11 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – CLASSIC 3 (New) (Space:15 GB;Email:25)", @"name", nil];
        [listPackages addObject: package11];
        
        NSDictionary *package12 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – BASIC 1 (Space:20GB;Email:50)", @"name", nil];
        [listPackages addObject: package12];
        
        NSDictionary *package13 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – BASIC 3 (Space:100GB;Email:200)", @"name", nil];
        [listPackages addObject: package13];
        
        NSDictionary *package14 = [[NSDictionary alloc] initWithObjectsAndKeys:@"DT Email Hosting – BASIC 2 (Space:50GB;Email:100)", @"name", nil];
        [listPackages addObject: package14];
    }
}

- (void)buttonSelectPackagePress {
    [self showSelectTimeTableView: FALSE];
    
    if (tbListPackage.frame.size.height == 0) {
        [self showHostingPackageList: TRUE];
        
    }else{
        [self showHostingPackageList: FALSE];
    }
}

- (void)buttonSelectTimePress {
    [self showHostingPackageList: FALSE];
    
    if (tbListTimes.frame.size.height == 0) {
        [self showSelectTimeTableView: TRUE];
        
    }else{
        [self showSelectTimeTableView: FALSE];
    }
}

- (void)showHostingPackageList: (BOOL)show {
    float width = 0.0;
    float height = 0.0;
    if (show) {
        height = 45.0 * 8;
        width = 340.0;
        if ([DeviceUtils isScreen320]) {
            width = 300.0;
        }
    }
    [tbListPackage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [tbListPackage reloadData];
    }];
}

- (void)showSelectTimeTableView: (BOOL)show {
    float width = 0.0;
    float height = 0.0;
    if (show) {
        height = 45.0 * 8;
        width = SCREEN_WIDTH - 2*paddingContent - 5.0*3 - 130.0;
    }
    [tbListTimes mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(width);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {
        [tbListTimes reloadData];
    }];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == tbPreview) {
        return 2;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbChoosePackage) {
        return 3;
        
    }else if (tableView == tbListPackage) {
        return listPackages.count;
        
    }else if (tableView == tbListTimes) {
        return listTimes.count;
        
    }else if (tableView == tbPreview) {
        if (section == 0) {
            return 2;
        }else {
            return 6;
        }
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbChoosePackage) {
        if (indexPath.row == 0) {
            HostingDetailTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailTbvCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.lbTitle.text = @"Dịch vụ hiện tại:";
            cell.lbValue.text = @"ĐK Email Hosting – BASIC 1 (Space:20GB;Email:50)";
            return cell;
            
        }else if (indexPath.row == 1) {
            HostingDetailSelectTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailSelectTbvCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.lbTitle.text = @"Chọn dịch vụ muốn chuyển:";
            cell.tfValue.placeholder = @"--- GIỎ HÀNG ---";
            
            if (transferPackage != nil) {
                cell.tfValue.text = [transferPackage objectForKey:@"name"];
                
            }else{
                cell.tfValue.text = @"";
            }
            
            [cell.btnChoose addTarget:self
                               action:@selector(buttonSelectPackagePress)
                     forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
        }else if (indexPath.row == 2) {
            HostingDetailSelectTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailSelectTbvCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.lbTitle.text = @"Thời hạn:";
            cell.tfValue.placeholder = @"--- THỜI HẠN ---";
            
            if (transferPackage != nil) {
                cell.tfValue.backgroundColor = UIColor.whiteColor;
                [cell.btnChoose addTarget:self
                                   action:@selector(buttonSelectTimePress)
                         forControlEvents:UIControlEventTouchUpInside];
            }else{
                cell.tfValue.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
            }
            cell.tfValue.text = (![AppUtils isNullOrEmpty: transferTime]) ? transferTime : @"";
            
            return cell;
        }else{
            HostingDetailTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailTbvCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.lbTitle.text = @"";
            
            return cell;
        }
        
    }else if (tableView == tbListTimes){
        HostingPackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingPackageCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *time = [listTimes objectAtIndex: indexPath.row];
        cell.lbContent.text = SFM(@"%@ THÁNG", time);
        if ([time isEqualToString:transferTime]) {
            cell.imgTick.hidden = FALSE;
        }else{
            cell.imgTick.hidden = TRUE;
        }
        
        return cell;
        
    }else if (tableView == tbListPackage){
        HostingPackageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingPackageCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *packageInfo = [listPackages objectAtIndex: indexPath.row];
        cell.lbContent.text = [packageInfo objectForKey:@"name"];
        
        if ([[packageInfo objectForKey:@"name"] isEqualToString:[transferPackage objectForKey:@"name"]]) {
            cell.imgTick.hidden = FALSE;
        }else{
            cell.imgTick.hidden = TRUE;
        }
        
        return cell;
        
    }else{
        HostingDetailTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.lbTitle.text = @"Tên dịch vụ:";
                cell.lbValue.text = @"ĐK Email Hosting – BASIC 1 (Space:20GB;Email:50)";
            }else{
                cell.lbTitle.text = @"Tiền còn dư của đơn hàng trước:";
                cell.lbValue.text = @"0 đ";
            }
        }else{
            if (indexPath.row == 0) {
                cell.lbTitle.text = @"Tên dịch vụ:";
                cell.lbValue.text = @"DT Email Hosting – BASIC 1 (Space:5GB;Email:50)";
                
            }else if (indexPath.row == 1){
                cell.lbTitle.text = @"Phí duy trì:";
                cell.lbValue.text = @"126.000 đ / Tháng (Đã giảm: 30%, Giá gốc: 180.000 đ / Tháng)";
                
            }else if (indexPath.row == 2){
                cell.lbTitle.text = @"Thời hạn:";
                cell.lbValue.text = @"6 Tháng";
                
            }else if (indexPath.row == 3){
                cell.lbTitle.text = @"Thành tiền:";
                cell.lbValue.text = @"756.000 đ";
                
            }else if (indexPath.row == 4){
                cell.lbTitle.text = @"Chiết khấu nâng cấp:";
                cell.lbValue.text = @"0 đ";
            }
            else{
                cell.lbTitle.text = @"Số tiền phải thanh toán:";
                cell.lbValue.text = @"756.000 đ";
            }
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbListPackage) {
        [self showHostingPackageList: FALSE];
        
        NSDictionary *info = [listPackages objectAtIndex: indexPath.row];
        transferPackage = [[NSDictionary alloc] initWithDictionary: info];
        [tbChoosePackage reloadData];
        
    }else if (tableView == tbListTimes) {
        [self showSelectTimeTableView: FALSE];
        
        transferTime = [listTimes objectAtIndex: indexPath.row];
        [tbChoosePackage reloadData];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbChoosePackage) {
        if (indexPath.row == 0) {
            return hNormalCell;
        }
        return hSelectCell;
        
    }else if (tableView == tbListPackage || tableView == tbListTimes) {
        return 45.0;
        
    }else if (tableView == tbPreview) {
        return hNormalCell;
    }
    return 50.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == tbPreview) {
        return 40.0;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == tbPreview) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tbPreview.frame.size.width, 40.0)];
        sectionView.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.font = [AppDelegate sharedInstance].fontMedium;
        [sectionView addSubview: lbTitle];
        [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(sectionView);
            make.left.equalTo(sectionView).offset(paddingContent);
            make.right.equalTo(sectionView).offset(-paddingContent);
        }];
        
        if (section == 0) {
            lbTitle.text = @"Dịch vụ hiện tại";
        }else{
            lbTitle.text = @"Dịch vụ đã chọn";
        }
        return sectionView;
    }
    return nil;
}

@end
