//
//  BankAccountViewController.m
//  NhanHoa
//
//  Created by OS on 11/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BankAccountViewController.h"
#import "UpdateBankInfoView.h"
#import "BankObject.h"

@interface BankAccountViewController ()<UIScrollViewDelegate, UpdateBankInfoViewDelegate>{
    AppDelegate *appDelegate;
    float padding;
    float hBTN;
    UIFont *textFont;
    
    NSMutableArray *searchList;
    UpdateBankInfoView *updateInfoView;
    float hLogoBank;
}

@end

@implementation BankAccountViewController

@synthesize scvContent, viewHeader, viewTop, icBack, lbHeader, icCart, lbCount, viewInfo, imgBank, lbBankName, lbAccountName, lbAccountNo, btnUpdate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self updateCartCountForView];
    
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Bank account"];
    [btnUpdate setTitle:[appDelegate.localization localizedStringForKey:@"Update"] forState:UIControlStateNormal];
    
    if (appDelegate.listBank == nil) {
        [self createListBank];
    }
    
    if (searchList == nil) {
        searchList = [[NSMutableArray alloc] init];
    }else{
        [searchList removeAllObjects];
    }
    
    [self displayBankInfo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    if (updateInfoView) {
        [updateInfoView removeFromSuperview];
        updateInfoView = nil;
    }
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)displayBankInfo {
    lbBankName.text = [AccountModel getCusBankName];
    lbAccountName.text = [AccountModel getCusBankAccount];
    lbAccountNo.text = [AccountModel getCusBankNumber];
    
    NSString *bankName = [AccountModel getCusBankName];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[cd] %@ OR code CONTAINS[cd] %@", bankName, bankName];
    NSArray *filter = [appDelegate.listBank filteredArrayUsingPredicate: predicate];
    if (filter.count > 0) {
        BankObject *bank = [filter firstObject];
        
        UIImage *bankIMG = [UIImage imageNamed:bank.logo];
        float wLogo = hLogoBank * bankIMG.size.width / bankIMG.size.height;
        imgBank.image = bankIMG;
        
        [imgBank mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(wLogo);
        }];
    }
}

- (void)createListBank {
    appDelegate.listBank = [[NSMutableArray alloc] init];
    
    BankObject *acb = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Á Châu" code:@"ACB" logo:@"ACB_logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: acb];
    
    BankObject *vietcomBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Ngoại Thương Việt Nam" code:@"VietcomBank" logo:@"VCB_logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: vietcomBank];
    
    BankObject *vietinBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Công Thương Việt Nam" code:@"VietinBank" logo:@"Vietinbank_logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: vietinBank];
    
    BankObject *techcombank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Kỹ Thương Việt Nam" code:@"Techcombank" logo:@"Techcombank_logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: techcombank];
    
    BankObject *BIDV = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Đầu Tư Và Phát Triển Việt Nam" code:@"BIDV" logo:@"BIDV_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: BIDV];
    
    BankObject *MaritimeBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Hàng Hải Việt Nam" code:@"MaritimeBank" logo:@"MSB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: MaritimeBank];
    
    BankObject *VPBank = [[BankObject alloc] initWithName:@"Ngân hàng Việt Nam Thịnh Vượng" code:@"VPBank" logo:@"VPBank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: VPBank];
    
    BankObject *Agribank = [[BankObject alloc] initWithName:@"Ngân hàng Nông nghiệp và Phát triển Việt Nam" code:@"Agribank" logo:@"Agribank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: Agribank];
    
    BankObject *Eximbank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Xuất nhập khẩu Việt Nam" code:@"Eximbank" logo:@"Eximbank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: Eximbank];
    
    BankObject *Sacombank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Sài Gòn Thương Tín" code:@"Sacombank" logo:@"Sacombank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: Sacombank];
    
    BankObject *DongABank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Đông Á" code:@"DongA Bank" logo:@"DongA_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: DongABank];
    
    BankObject *NASB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Bắc Á" code:@"NASB" logo:@"NASB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: NASB];
    
    BankObject *ANZBank = [[BankObject alloc] initWithName:@"Ngân hàng TNHH một thành viên ANZ Việt Nam" code:@"ANZ Bank" logo:@"ANZ_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: ANZBank];
    
    BankObject *PhuongNamBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Phương Nam" code:@"Phuong Nam Bank" logo:@"phuongnam_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: PhuongNamBank];
    
    BankObject *VIB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Quốc tế Việt Nam" code:@"VIB" logo:@"VIB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: VIB];
    
    BankObject *VietABank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Việt Á" code:@"VietABank" logo:@"VietABank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: VietABank];
    
    BankObject *TPBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Tiên Phong" code:@"TP Bank" logo:@"TPBank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: TPBank];
    
    BankObject *MBBank = [[BankObject alloc] initWithName:@"Ngân hàng thương mại cổ phần Quân đội" code:@"MB Bank" logo:@"MBBank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: MBBank];
    
    BankObject *OceanBank = [[BankObject alloc] initWithName:@"Ngân hàng TM TNHH 1 thành viên Đại Dương" code:@"OceanBank" logo:@"OceanBank_Logo.jpeg"];
    [[AppDelegate sharedInstance].listBank addObject: OceanBank];
    
    BankObject *PGBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Xăng dầu Petrolimex" code:@"PG Bank" logo:@"PGBank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: PGBank];
    
    BankObject *LienVietPostBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Bưu Điện Liên Việt" code:@"LienVietPostBank" logo:@"LPB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: LienVietPostBank];
    
    BankObject *HSBCBank = [[BankObject alloc] initWithName:@"Ngân hàng TNHH một thành viên HSBC (Việt Nam)" code:@"HSBC Bank" logo:@"HSBC_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: HSBCBank];
    
    BankObject *MHBBank = [[BankObject alloc] initWithName:@"Ngân hàng Phát triển nhà đồng bằng sông Cửu Long" code:@"MHB Bank" logo:@"MHBBank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: MHBBank];
    
    BankObject *SeABank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Đông Nam Á" code:@"SeABank" logo:@"seabank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: SeABank];
    
    BankObject *ABBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP An Bình" code:@"ABBank" logo:@"ABBANK_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: ABBank];
    
    BankObject *CITIBANK = [[BankObject alloc] initWithName:@"Ngân hàng Citibank Việt Nam" code:@"CITIBANK" logo:@"Citibank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: CITIBANK];
    
    BankObject *HDBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Phát triển Thành phố Hồ Chí Minh" code:@"HDBank" logo:@"HDBank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: HDBank];
    
    BankObject *GBBank = [[BankObject alloc] initWithName:@"Ngân hàng Dầu khí toàn cầu" code:@"GBBank" logo:@"GPBank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: GBBank];
    
    BankObject *OCB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Phương Đông" code:@"OCB" logo:@"OCB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: OCB];
    
    BankObject *SHB = [[BankObject alloc] initWithName:@"Ngân Hàng Thương Mại cổ phần Sài Gòn – Hà Nội" code:@"SHB" logo:@"SHB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: SHB];
    
    BankObject *NamABank  = [[BankObject alloc] initWithName:@"Ngân hàng Thương Mại cổ phần Nam Á" code:@"Nam A Bank" logo:@"Nam_A_Bank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: NamABank];
    
    BankObject *SaigonBank = [[BankObject alloc] initWithName:@"Ngân Hàng TMCP Sài Gòn Công Thương" code:@"Saigon Bank" logo:@"SGBank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: SaigonBank];
    
    BankObject *SCB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Sài Gòn" code:@"SCB" logo:@"SCB_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: SCB];
    
    BankObject *VNCB = [[BankObject alloc] initWithName:@"Ngân hàng thương mại TNHH MTV Xây dựng Việt Nam" code:@"VNCB" logo:@"VNCB_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: VNCB];
    
    BankObject *Kienlongbank = [[BankObject alloc] initWithName:@"Ngân hàng Thương mại Cổ phần Kiên Long" code:@"Kienlongbank" logo:@"KienlongBank_Logo.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: Kienlongbank];
    
    BankObject *SHINHANBank = [[BankObject alloc] initWithName:@"Ngân hàng Shinhan" code:@"SHINHAN Bank" logo:@"SHINHANBank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: SHINHANBank];
    
    BankObject *BaovietBank = [[BankObject alloc] initWithName:@"Ngân hàng Bảo Việt" code:@"Baoviet Bank" logo:@"BaoVietBank_Logo.png"];
    [[AppDelegate sharedInstance].listBank addObject: BaovietBank];
    
    BankObject *Vietbank = [[BankObject alloc] initWithName:@"Ngân hàng Việt Nam Thương Tín" code:@"Vietbank" logo:@"vietbank.jpg"];
    [[AppDelegate sharedInstance].listBank addObject: Vietbank];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hNav = self.navigationController.navigationBar.frame.size.height;
    float hInfo = 250.0;
    hLogoBank = 70.0;
    
    padding = 15.0;
    hBTN = 53.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hInfo = 230.0;
        hLogoBank = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hInfo = 230.0;
        hLogoBank = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 53.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hInfo = 250.0;
        hLogoBank = 70.0;
    }
    
    //  scrollview content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.view.backgroundColor = GRAY_240;
    scvContent.backgroundColor = UIColor.clearColor;
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
    
    //  view top
    float hTop = hStatus + hNav + padding + hInfo/3;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTop);
    }];
    [AppUtils addCurvePathForViewWithHeight:hTop forView:viewTop heightCurve:15.0 startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5) startColor:[UIColor colorWithRed:(16/255.0) green:(103/255.0) blue:(222/255.0) alpha:1] endColor:[UIColor colorWithRed:(16/255.0) green:(103/255.0) blue:(222/255.0) alpha:1]];
    
    //  header view
    viewHeader.backgroundColor = UIColor.clearColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + hNav);
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
    
    //  view info
    viewInfo.layer.cornerRadius = 10.0;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom).offset(-hInfo/4);
        make.left.equalTo(viewHeader).offset(padding);
        make.right.equalTo(viewHeader).offset(-padding);
        make.height.mas_equalTo(hInfo);
    }];
    
    UIFont *accFont = [UIFont fontWithName:lbAccountNo.font.fontName size:25.0];
    lbAccountName.font = accFont;
    lbAccountNo.font = [UIFont fontWithName:lbAccountNo.font.fontName size:30.0];
    
    [lbAccountName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewInfo.mas_centerY).offset(padding);
        make.left.equalTo(viewInfo).offset(padding);
        make.right.equalTo(viewInfo).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    
    [lbAccountNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAccountName.mas_bottom);
        make.left.right.equalTo(lbAccountName);
        make.height.mas_equalTo(40.0);
    }];
    
    lbBankName.font = [UIFont fontWithName:lbAccountNo.font.fontName size:textFont.pointSize-2];
    lbBankName.numberOfLines = 3;
    [lbBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewInfo.mas_centerY).offset(-padding/2);
        make.left.right.equalTo(lbAccountName);
    }];
    
    UIImage *bankIMG = [UIImage imageNamed:@"VCB_logo.jpg"];
    float wLogo = hLogoBank * bankIMG.size.width / bankIMG.size.height;
    
    [imgBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lbBankName.mas_top);
        make.left.equalTo(lbBankName);
        make.width.mas_equalTo(wLogo);
        make.height.mas_equalTo(hLogoBank);
    }];
    
    
    btnUpdate.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    btnUpdate.layer.borderColor = BLUE_COLOR.CGColor;
    btnUpdate.layer.borderWidth = 1.0;
    btnUpdate.backgroundColor = BLUE_COLOR;
    btnUpdate.layer.cornerRadius = 8.0;
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    float topY = SCREEN_HEIGHT - padding - hBTN;
    if (appDelegate.safeAreaBottomPadding > 0) {
        topY = SCREEN_HEIGHT - hBTN - appDelegate.safeAreaBottomPadding;
    }
    
    [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(topY);
        make.left.right.equalTo(viewInfo);
        make.height.mas_equalTo(hBTN);
    }];
    
    lbBankName.textColor = lbAccountName.textColor = lbAccountNo.textColor = GRAY_80;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}


- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

- (IBAction)btnUpdatePress:(UIButton *)sender {
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    sender.backgroundColor = UIColor.whiteColor;
    [self performSelector:@selector(startShowUpdateBankInfoView) withObject:nil afterDelay:0.1];
}

- (void)startShowUpdateBankInfoView {
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnUpdate.backgroundColor = BLUE_COLOR;
    
    if (updateInfoView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"UpdateBankInfoView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[UpdateBankInfoView class]]) {
                updateInfoView = (UpdateBankInfoView *) currentObject;
                break;
            }
        }
        [self.view addSubview: updateInfoView];
    }
    updateInfoView.delegate = self;
    [updateInfoView setupUIForViewWithHeightNav: self.navigationController.navigationBar.frame.size.height];
    [updateInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(SCREEN_HEIGHT);
    }];
    
    [self performSelector:@selector(showUpdateBankInfoView) withObject:nil afterDelay:0.2];
}

- (void)showUpdateBankInfoView {
    [updateInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UpdateBankInfoViewDelegate
-(void)closeUpdateBankInfoView {
    [updateInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)bankInfoHasBeenUpdatedSuccessful {
    [self closeUpdateBankInfoView];
    [self displayBankInfo];
}

@end
