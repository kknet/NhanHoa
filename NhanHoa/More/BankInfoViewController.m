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
    self.title = text_bank_account_info;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"BankInfoViewController"];
    
    self.navigationController.navigationBarHidden = FALSE;
    
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
    float hLabel = 30.0;
    float mTop = 15.0;
    float hBTN = 45.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hLabel = 50.0;
        mTop = 20.0;
        hBTN = 55.0;
        hCell = 50.0;
    }
    
    lbBankName.text = text_bank_name;
    [lbBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfBankName borderColor:BORDER_COLOR];
    tfBankName.placeholder = enter_bank_name;
    [tfBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbBankName);
        make.top.equalTo(lbBankName.mas_bottom);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfBankName.delegate = self;
    tfBankName.returnKeyType = UIReturnKeyNext;
    [tfBankName addTarget:self
                   action:@selector(tfBankDidChanged:)
         forControlEvents:UIControlEventEditingChanged];
    
    lbOwner.text = text_owner_name;
    [lbOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfBankName);
        make.top.equalTo(tfBankName.mas_bottom).offset(mTop);
        make.height.equalTo(lbBankName.mas_height);
    }];
    
    [AppUtils setBorderForTextfield:tfOwner borderColor:BORDER_COLOR];
    tfOwner.placeholder = enter_owner_name;
    [tfOwner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbOwner);
        make.top.equalTo(lbOwner.mas_bottom);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfOwner.delegate = self;
    tfOwner.returnKeyType = UIReturnKeyNext;
    
    lbAccNo.text = text_bank_account_number;
    [lbAccNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(tfOwner);
        make.top.equalTo(tfOwner.mas_bottom).offset(mTop);
        make.height.equalTo(lbBankName.mas_height);
    }];
    
    [AppUtils setBorderForTextfield:tfAccNo borderColor:BORDER_COLOR];
    tfAccNo.placeholder = enter_bank_account_number;
    [tfAccNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbAccNo);
        make.top.equalTo(lbAccNo.mas_bottom);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    tfAccNo.delegate = self;
    tfAccNo.returnKeyType = UIReturnKeyDone;
    
    btnUpdate.layer.cornerRadius = hBTN/2;
    btnUpdate.backgroundColor = BLUE_COLOR;
    btnUpdate.layer.borderColor = BLUE_COLOR.CGColor;
    btnUpdate.layer.borderWidth = 1.0;
    [btnUpdate setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnUpdate setTitle:text_update forState:UIControlStateNormal];
    [btnUpdate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.bottom.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbBank = [[UITableView alloc] init];
    tbBank.backgroundColor = UIColor.whiteColor;
    tbBank.layer.cornerRadius = 5.0;
    tbBank.layer.borderColor = GRAY_230.CGColor;
    tbBank.layer.borderWidth = 1.0;
    [tbBank registerNib:[UINib nibWithNibName:@"BankCell" bundle:nil] forCellReuseIdentifier:@"BankCell"];
    tbBank.delegate = self;
    tbBank.dataSource = self;
    tbBank.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview: tbBank];
    [tbBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBankName.mas_bottom).offset(2.0);
        make.left.right.equalTo(tfBankName);
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
        [self.view makeToast:pls_fill_full_informations duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_updating Interaction:FALSE];
    
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
            make.top.equalTo(tfBankName.mas_bottom).offset(2.0);
            make.left.right.equalTo(tfBankName);
            make.height.mas_equalTo(hTbView);
        }];
        [tbBank reloadData];
    }
}

- (void)createListBank {
    
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
