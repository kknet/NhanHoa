//
//  BankInfoViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 6/11/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BankInfoViewController.h"
#import "AccountModel.h"
#import "BankObject.h"
#import "BankCell.h"

@interface BankInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate, UITextFieldDelegate, WebServiceUtilsDelegate>{
    UITableView *tbBank;
    NSMutableArray *searchList;
    NSTimer *searchTimer;
    float hCell;
}

@end

@implementation BankInfoViewController
@synthesize lbBankName, tfBankName, lbOwner, tfOwner, lbAccNo, tfAccNo, btnUpdate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thông tin ngân hàng";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"BankInfoViewController"];
    
    if ([AppDelegate sharedInstance].listBank == nil) {
        [self createListBank];
    }
    
    if (searchList == nil) {
        searchList = [[NSMutableArray alloc] init];
    }else{
        [searchList removeAllObjects];
    }
    
    [self displayBankInfo];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    searchList = nil;
}

- (void)displayBankInfo {
    tfBankName.text = [AccountModel getCusBankName];
    tfOwner.text = [AccountModel getCusBankAccount];
    tfAccNo.text = [AccountModel getCusBankNumber];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView {
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnScreen.delegate = self;
    [self.view addGestureRecognizer: tapOnScreen];
    
    hCell = 40.0;
    
    float padding = 15.0;
    [lbBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(30.0);
    }];
    
    [AppUtils setBorderForTextfield:tfBankName borderColor:BORDER_COLOR];
    [tfBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbBankName);
        make.top.equalTo(self.lbBankName.mas_bottom);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBankName.delegate = self;
    tfBankName.returnKeyType = UIReturnKeyNext;
    [tfBankName addTarget:self
                   action:@selector(tfBankDidChanged:)
         forControlEvents:UIControlEventEditingChanged];
    
    [lbOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfBankName);
        make.top.equalTo(self.tfBankName.mas_bottom).offset(padding);
        make.height.equalTo(self.lbBankName.mas_height);
    }];
    
    [AppUtils setBorderForTextfield:tfOwner borderColor:BORDER_COLOR];
    [tfOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbOwner);
        make.top.equalTo(self.lbOwner.mas_bottom);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfOwner.delegate = self;
    tfOwner.returnKeyType = UIReturnKeyNext;
    
    [lbAccNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfOwner);
        make.top.equalTo(self.tfOwner.mas_bottom).offset(padding);
        make.height.equalTo(self.lbBankName.mas_height);
    }];
    
    [AppUtils setBorderForTextfield:tfAccNo borderColor:BORDER_COLOR];
    [tfAccNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbAccNo);
        make.top.equalTo(self.lbAccNo.mas_bottom);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfAccNo.delegate = self;
    tfAccNo.returnKeyType = UIReturnKeyDone;
    
    btnUpdate.layer.cornerRadius = 45.0/2;
    btnUpdate.backgroundColor = BLUE_COLOR;
    btnUpdate.layer.borderColor = BLUE_COLOR.CGColor;
    btnUpdate.layer.borderWidth = 1.0;
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.bottom.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    tbBank = [[UITableView alloc] init];
    tbBank.backgroundColor = UIColor.whiteColor;
    tbBank.layer.cornerRadius = 5.0;
    tbBank.layer.borderColor = BORDER_COLOR.CGColor;
    tbBank.layer.borderWidth = 1.0;
    [tbBank registerNib:[UINib nibWithNibName:@"BankCell" bundle:nil] forCellReuseIdentifier:@"BankCell"];
    tbBank.delegate = self;
    tbBank.dataSource = self;
    tbBank.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: tbBank];
    [tbBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBankName.mas_bottom).offset(2.0);
        make.left.right.equalTo(self.tfBankName);
        make.height.mas_equalTo(0.0);
    }];
    
    lbBankName.font = lbOwner.font = lbAccNo.font = [AppDelegate sharedInstance].fontMedium;
    tfBankName.font = tfOwner.font = tfAccNo.font = [AppDelegate sharedInstance].fontRegular;
    btnUpdate.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbBankName.textColor = lbOwner.textColor = lbAccNo.textColor = tfBankName.textColor = tfOwner.textColor = tfAccNo.textColor = TITLE_COLOR;
    
    
}

- (IBAction)btnUpdatePress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startUpdateBankInfo) withObject:nil afterDelay:0.05];
}

- (void)startUpdateBankInfo {
    btnUpdate.backgroundColor = BLUE_COLOR;
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    if ([AppUtils isNullOrEmpty: tfBankName.text] || [AppUtils isNullOrEmpty: tfOwner.text] || [AppUtils isNullOrEmpty: tfAccNo.text]) {
        [self.view makeToast:@"Vui lòng nhập đầy đủ thông tin của bạn" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang cập nhật..." Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateBankInfoWithBankName:tfBankName.text bankaccount:tfOwner.text banknumber:tfAccNo.text];
}

- (void)tfBankDidChanged: (UITextField *)textfield {
    if (searchTimer) {
        searchTimer = nil;
        [searchTimer invalidate];
    }
    searchTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(searchBankForUser:) userInfo:textfield.text repeats:FALSE];
}

- (void)searchBankForUser: (NSTimer *)timer {
    NSString *search = timer.userInfo;
    if ([search isKindOfClass:[NSString class]]) {
        if (search.length > 0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code CONTAINS[cd] %@ OR name CONTAINS[cd] %@", search, search];
            NSArray *filter = [[AppDelegate sharedInstance].listBank filteredArrayUsingPredicate: predicate];
            
            [searchList removeAllObjects];
            if (filter.count > 0) {
                [searchList addObjectsFromArray: filter];
            }
        }else{
            [searchList removeAllObjects];
        }
        
        float hTbView = 5*hCell;
        if (searchList.count == 0) {
            hTbView = 0;
        }
        
        [tbBank mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tfBankName.mas_bottom).offset(2.0);
            make.left.right.equalTo(self.tfBankName);
            make.height.mas_equalTo(hTbView);
        }];
        [tbBank reloadData];
    }
}

- (void)createListBank {
    [AppDelegate sharedInstance].listBank = [[NSMutableArray alloc] init];
    
    BankObject *acb = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Á Châu" code:@"ACB"];
    [[AppDelegate sharedInstance].listBank addObject: acb];
    
    BankObject *vietcomBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Ngoại Thương Việt Nam" code:@"VietcomBank"];
    [[AppDelegate sharedInstance].listBank addObject: vietcomBank];
    
    BankObject *vietinBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Công Thương Việt Nam" code:@"VietinBank"];
    [[AppDelegate sharedInstance].listBank addObject: vietinBank];
    
    BankObject *techcombank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Kỹ Thương Việt Nam" code:@"Techcombank"];
    [[AppDelegate sharedInstance].listBank addObject: techcombank];
    
    BankObject *BIDV = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Đầu Tư Và Phát Triển Việt Nam" code:@"BIDV"];
    [[AppDelegate sharedInstance].listBank addObject: BIDV];
    
    BankObject *MaritimeBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Hàng Hải Việt Nam" code:@"MaritimeBank"];
    [[AppDelegate sharedInstance].listBank addObject: MaritimeBank];
    
    BankObject *VPBank = [[BankObject alloc] initWithName:@"Ngân hàng Việt Nam Thịnh Vượng" code:@"VPBank"];
    [[AppDelegate sharedInstance].listBank addObject: VPBank];
    
    BankObject *Agribank = [[BankObject alloc] initWithName:@"Ngân hàng Nông nghiệp và Phát triển Việt Nam" code:@"Agribank"];
    [[AppDelegate sharedInstance].listBank addObject: Agribank];
    
    BankObject *Eximbank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Xuất nhập khẩu Việt Nam" code:@"Eximbank"];
    [[AppDelegate sharedInstance].listBank addObject: Eximbank];
    
    BankObject *Sacombank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Sài Gòn Thương Tín" code:@"Sacombank"];
    [[AppDelegate sharedInstance].listBank addObject: Sacombank];
    
    BankObject *DongABank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Đông Á" code:@"DongA Bank"];
    [[AppDelegate sharedInstance].listBank addObject: DongABank];
    
    BankObject *NASB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Bắc Á" code:@"NASB"];
    [[AppDelegate sharedInstance].listBank addObject: NASB];
    
    BankObject *ANZBank = [[BankObject alloc] initWithName:@"Ngân hàng TNHH một thành viên ANZ Việt Nam" code:@"ANZ Bank"];
    [[AppDelegate sharedInstance].listBank addObject: ANZBank];
    
    BankObject *PhuongNamBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Phương Nam" code:@"Phuong Nam Bank"];
    [[AppDelegate sharedInstance].listBank addObject: PhuongNamBank];
    
    BankObject *VIB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Quốc tế Việt Nam" code:@"VIB"];
    [[AppDelegate sharedInstance].listBank addObject: VIB];
    
    BankObject *VietABank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Việt Á" code:@"VietABank"];
    [[AppDelegate sharedInstance].listBank addObject: VietABank];
    
    BankObject *TPBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Tiên Phong" code:@"TP Bank"];
    [[AppDelegate sharedInstance].listBank addObject: TPBank];
    
    BankObject *MBBank = [[BankObject alloc] initWithName:@"Ngân hàng thương mại cổ phần Quân đội" code:@"MB Bank"];
    [[AppDelegate sharedInstance].listBank addObject: MBBank];
    
    BankObject *OceanBank = [[BankObject alloc] initWithName:@"Ngân hàng TM TNHH 1 thành viên Đại Dương" code:@"OceanBank"];
    [[AppDelegate sharedInstance].listBank addObject: OceanBank];
    
    BankObject *PGBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Xăng dầu Petrolimex" code:@"PG Bank"];
    [[AppDelegate sharedInstance].listBank addObject: PGBank];
    
    BankObject *LienVietPostBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Bưu Điện Liên Việt" code:@"LienVietPostBank"];
    [[AppDelegate sharedInstance].listBank addObject: LienVietPostBank];
    
    BankObject *HSBCBank = [[BankObject alloc] initWithName:@"Ngân hàng TNHH một thành viên HSBC (Việt Nam)" code:@"HSBC Bank"];
    [[AppDelegate sharedInstance].listBank addObject: HSBCBank];
    
    BankObject *MHBBank = [[BankObject alloc] initWithName:@"Ngân hàng Phát triển nhà đồng bằng sông Cửu Long" code:@"MHB Bank"];
    [[AppDelegate sharedInstance].listBank addObject: MHBBank];
    
    BankObject *SeABank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Đông Nam Á" code:@"SeABank"];
    [[AppDelegate sharedInstance].listBank addObject: SeABank];
    
    BankObject *ABBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP An Bình" code:@"ABBank"];
    [[AppDelegate sharedInstance].listBank addObject: ABBank];
    
    BankObject *CITIBANK = [[BankObject alloc] initWithName:@"Ngân hàng Citibank Việt Nam" code:@"CITIBANK"];
    [[AppDelegate sharedInstance].listBank addObject: CITIBANK];
    
    BankObject *HDBank = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Phát triển Thành phố Hồ Chí Minh" code:@"HDBank"];
    [[AppDelegate sharedInstance].listBank addObject: HDBank];
    
    BankObject *GBBank = [[BankObject alloc] initWithName:@"Ngân hàng Dầu khí toàn cầu" code:@"GBBank"];
    [[AppDelegate sharedInstance].listBank addObject: GBBank];
    
    BankObject *OCB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Phương Đông" code:@"OCB"];
    [[AppDelegate sharedInstance].listBank addObject: OCB];
    
    BankObject *SHB = [[BankObject alloc] initWithName:@"Ngân Hàng Thương Mại cổ phần Sài Gòn – Hà Nội" code:@"SHB"];
    [[AppDelegate sharedInstance].listBank addObject: SHB];
    
    BankObject *NamABank  = [[BankObject alloc] initWithName:@"Ngân hàng Thương Mại cổ phần Nam Á" code:@"Nam A Bank"];
    [[AppDelegate sharedInstance].listBank addObject: NamABank];
    
    BankObject *SaigonBank = [[BankObject alloc] initWithName:@"Ngân Hàng TMCP Sài Gòn Công Thương" code:@"Saigon Bank"];
    [[AppDelegate sharedInstance].listBank addObject: SaigonBank];
    
    BankObject *SCB = [[BankObject alloc] initWithName:@"Ngân hàng TMCP Sài Gòn" code:@"SCB"];
    [[AppDelegate sharedInstance].listBank addObject: SCB];
    
    BankObject *VNCB = [[BankObject alloc] initWithName:@"Ngân hàng thương mại TNHH MTV Xây dựng Việt Nam" code:@"VNCB"];
    [[AppDelegate sharedInstance].listBank addObject: VNCB];
    
    BankObject *Kienlongbank = [[BankObject alloc] initWithName:@"Ngân hàng Thương mại Cổ phần Kiên Long" code:@"Kienlongbank"];
    [[AppDelegate sharedInstance].listBank addObject: Kienlongbank];
    
    BankObject *SHINHANBank = [[BankObject alloc] initWithName:@"Ngân hàng Shinhan" code:@"SHINHAN Bank"];
    [[AppDelegate sharedInstance].listBank addObject: SHINHANBank];
    
    BankObject *BaovietBank = [[BankObject alloc] initWithName:@"Ngân hàng Bảo Việt" code:@"Baoviet Bank"];
    [[AppDelegate sharedInstance].listBank addObject: BaovietBank];
    
    BankObject *Vietbank = [[BankObject alloc] initWithName:@"Ngân hàng Việt Nam Thương Tín" code:@"Vietbank"];
    [[AppDelegate sharedInstance].listBank addObject: Vietbank];
}

#pragma mark - UITableviw Controller
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return searchList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BankCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BankObject *bank = [searchList objectAtIndex: indexPath.row];
    cell.lbSepa.hidden = TRUE;
    cell.lbName.text = bank.name;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BankObject *bank = [searchList objectAtIndex: indexPath.row];
    tfBankName.text = bank.name;
    
    [tbBank mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfBankName.mas_bottom).offset(2.0);
        make.left.right.equalTo(self.tfBankName);
        make.height.mas_equalTo(0);
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UITableViewCell class]] || [touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")])
    {
        return NO;
    }
    return YES;
}

#pragma mark - WebServiceUtil Delegate
-(void)failedToUpdateBankInfoWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)updateBankInfoSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [self tryLoginToUpdateInformation];
}

-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    [self.view makeToast:@"Thông tin tài khoản ngân hàng đã được cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
}

- (void)tryLoginToUpdateInformation
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfBankName) {
        [tfOwner becomeFirstResponder];
        
    }else if (textField == tfOwner) {
        [tfAccNo becomeFirstResponder];
        
    }else if (textField == tfAccNo) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

@end
