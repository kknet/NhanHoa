//
//  WalletViewController.m
//  NhanHoa
//
//  Created by OS on 10/25/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WalletViewController.h"
#import "TopUpMoneyView.h"
#import "WalletTransHistoryCell.h"

@interface WalletViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    UIColor *disableColor;
    float hCell;
    float hSection;
    float hTopView;
    
    TopUpMoneyView *topupView;
    float hBgWallet;
}
@end

@implementation WalletViewController

@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvContent, btnMainWallet, btnBonusWallet, lbBalance, lbCurrency, lbMoney, tbHistory, viewFooter, btnTopUp, bgWallet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self reUpdateFrameForView];
    [self showContentWithCurrentLanguage];
    
    [self showUserMainWalletView];
}

- (void)showUserMainWalletView {
    NSString *totalBalance = [AccountModel getCusBalance];
    if (![AppUtils isNullOrEmpty: totalBalance]) {
        totalBalance = [AppUtils convertStringToCurrencyFormat: totalBalance];
        lbMoney.text = [NSString stringWithFormat:@"%@", totalBalance];
    }else{
        lbMoney.text = @"0";
    }
}

- (void)reUpdateFrameForView{
    [tbHistory mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hCell * 6 + hSection);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hTopView + hSection + hCell*6 + padding);
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Nhan Hoa wallet"];
    [btnMainWallet setTitle:[appDelegate.localization localizedStringForKey:@"Main wallet"] forState:UIControlStateNormal];
    [btnBonusWallet setTitle:[appDelegate.localization localizedStringForKey:@"Bonus wallet"] forState:UIControlStateNormal];
    lbBalance.text = [appDelegate.localization localizedStringForKey:@"Balance"];
    [btnTopUp setTitle:[appDelegate.localization localizedStringForKey:@"Top up"] forState:UIControlStateNormal];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    float hBTN = 50.0;
    hCell = 80.0;
    hSection = 60.0;
    
    disableColor = [UIColor colorWithRed:(53/255.0) green:(123/255.0) blue:(214/255.0) alpha:1.0];
    
    textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hBTN = 42.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        hBTN = 50.0;
    }
    
    //  content
    UIImage *imgBgWallet = [UIImage imageNamed:@"bg_wallet"];
    hBgWallet = SCREEN_WIDTH * imgBgWallet.size.height / imgBgWallet.size.width;
    
    bgWallet.clipsToBounds = TRUE;
    bgWallet.backgroundColor = UIColor.clearColor;
    [bgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBgWallet);
    }];
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //  scvContent.contentInset = UIEdgeInsetsMake(hBgWallet, 0, 0, 0);
    scvContent.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(242/255.0)
                                                  blue:(246/255.0) alpha:1.0];
    scvContent.backgroundColor = UIColor.clearColor;
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-hBTN - 20.0);
    }];
    
    //  header view
    viewHeader.backgroundColor = UIColor.clearColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus);
        make.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
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
    
    hTopView = padding + hBTN + padding + 25.0 + hBTN + padding;
    
    btnMainWallet.layer.cornerRadius = btnBonusWallet.layer.cornerRadius = hBTN/2;
    btnMainWallet.titleLabel.font = btnBonusWallet.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];

    float sizeBTN = [AppUtils getSizeWithText:[appDelegate.localization localizedStringForKey:@"Bonus wallet"]
                                     withFont:btnMainWallet.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 20.0;

    btnMainWallet.backgroundColor = UIColor.whiteColor;
    [btnMainWallet setTitleColor:TITLE_COLOR forState:UIControlStateNormal];
    [btnMainWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.right.equalTo(viewHeader.mas_centerX).offset(-padding);
        make.width.mas_equalTo(sizeBTN);
        make.height.mas_equalTo(hBTN);
    }];

    btnBonusWallet.backgroundColor = disableColor;
    [btnBonusWallet setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnBonusWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnMainWallet.mas_right).offset(padding);
        make.top.bottom.equalTo(btnMainWallet);
        make.width.mas_equalTo(sizeBTN);
    }];

    //  caculate originY of label balance
    float originY = (hBgWallet - (hStatus + self.navigationController.navigationBar.frame.size.height + padding + hBTN + 25.0 + hBTN))/2;
    
    lbBalance.textColor = UIColor.whiteColor;
    lbBalance.font = btnBonusWallet.titleLabel.font;
    [lbBalance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnMainWallet.mas_bottom).offset(originY);
        make.left.right.equalTo(viewHeader);
        make.height.mas_equalTo(25.0);
    }];

    lbMoney.textColor = UIColor.whiteColor;
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:30.0];
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBalance.mas_bottom);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbCurrency.textColor = UIColor.whiteColor;
    lbCurrency.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-4.0];
    [lbCurrency mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMoney);
        make.left.equalTo(lbMoney.mas_right).offset(2.0);
    }];

    tbHistory.backgroundColor = UIColor.clearColor;
    tbHistory.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbHistory registerNib:[UINib nibWithNibName:@"WalletTransHistoryCell" bundle:nil] forCellReuseIdentifier:@"WalletTransHistoryCell"];
    tbHistory.delegate = self;
    tbHistory.dataSource = self;
    tbHistory.scrollEnabled = FALSE;
    [tbHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMoney.mas_bottom).offset(originY);
        make.left.equalTo(viewHeader).offset(padding);
        make.right.equalTo(viewHeader).offset(-padding);
        make.height.mas_equalTo(0);
    }];

    //  footer view
    viewFooter.backgroundColor = UIColor.clearColor;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hBTN + 20.0);
    }];

    btnTopUp.layer.cornerRadius = 8.0;
    btnTopUp.backgroundColor = BLUE_COLOR;
    btnTopUp.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    [btnTopUp setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnTopUp setTitle:[appDelegate.localization localizedStringForKey:@"Top up"]
              forState:UIControlStateNormal];
    [btnTopUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnMainWalletPress:(UIButton *)sender {
}

- (IBAction)btnBonusWalletPress:(UIButton *)sender {
}

- (IBAction)btnTopUpPress:(UIButton *)sender {
    if (topupView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"TopUpMoneyView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[TopUpMoneyView class]]) {
                topupView = (TopUpMoneyView *) currentObject;
                break;
            }
        }
        [topupView.icClose addTarget:self
                              action:@selector(closeChooseMoneyView)
                    forControlEvents:UIControlEventTouchUpInside];
        [topupView setupUIForView];
        [self.view addSubview: topupView];
        [topupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
    }
    [topupView performSelector:@selector(showMoneyListToTopUp) withObject:nil afterDelay:0.2];
}

- (void)closeChooseMoneyView {
    [UIView animateWithDuration:0.2 animations:^{
        topupView.viewContent.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, topupView.hContent);
    }completion:^(BOOL finished) {
        [topupView removeFromSuperview];
        topupView = nil;
    }];
}


#pragma mark - UITablview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WalletTransHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WalletTransHistoryCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 5) {
        cell.lbTitle.text = @"Thanh toán";
        cell.lbValue.text = @"Gia hạn tên miền";
        cell.imgType.image = [UIImage imageNamed:@"money_out"];
        
        cell.lbMoney.text = @"-1.200.000 VNĐ";
    }else{
        cell.lbTitle.text = @"Nạp tiền";
        cell.lbValue.text = @"Nạp tiền vào ví";
        cell.imgType.image = [UIImage imageNamed:@"money_in"];
        
        cell.lbMoney.text = @"+500.000 VNĐ";
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*padding, hSection)];
    
    UIButton *btnMore = [[UIButton alloc] init];
    [btnMore setTitle:[appDelegate.localization localizedStringForKey:@"View more"] forState:UIControlStateNormal];
    [btnMore setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    btnMore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btnMore.titleLabel.font = textFont;
    [viewSection addSubview: btnMore];
    [btnMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewSection);
        make.centerY.equalTo(viewSection.mas_centerY);
        make.height.mas_equalTo(40.0);
        make.width.mas_equalTo(120.0);
    }];
    
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.textColor = GRAY_100;
    lbTitle.backgroundColor = UIColor.clearColor;
    lbTitle.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-1];
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Recent activity"];
    [viewSection addSubview: lbTitle];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSection);
        make.top.bottom.equalTo(btnMore);
        make.right.equalTo(btnMore.mas_left).offset(-5.0);
    }];
    
    return viewSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

#pragma mark - UIScrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        float height = hBgWallet - scrollView.contentOffset.y;
        [bgWallet mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
    }else{
        [bgWallet mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(-scrollView.contentOffset.y);
        }];
        
        NSLog(@"y = %f", scrollView.contentOffset.y);
    }
    
//    float y = hBgWallet - (scrollView.contentOffset.y + hBgWallet);
//    float height = MIN(MAX(y, hBgWallet), 400);
//    [bgWallet mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(height);
//    }];
}

@end

