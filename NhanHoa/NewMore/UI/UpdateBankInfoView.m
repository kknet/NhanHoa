//
//  UpdateBankInfoView.m
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "UpdateBankInfoView.h"
#import "BankCell.h"
#import "BankObject.h"

@implementation UpdateBankInfoView
@synthesize viewHeader, icClose, lbHeader, lbBankName, tfBankName, lbOwnerName, tfOwnerName, lbBankAccountNumber, tfBankAccountNumber, btnCancel, btnSave;
@synthesize padding, searchTimer, searchList, hCell, tbBank, delegate;

- (void)setupUIForViewWithHeightNav: (float)hNav
{
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnScreen.delegate = self;
    [self addGestureRecognizer: tapOnScreen];
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    float hBTN = 53.0;
    
    float hLabel = 50.0;
    hCell = 70.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        hLabel = 40.0;
        hCell = 50.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        hLabel = 45.0;
        hCell = 60.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 53.0;
        hLabel = 50.0;
        hCell = 70.0;
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Update bank account"];
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  footer buttons
    btnCancel.layer.cornerRadius = 8.0;
    btnCancel.layer.borderWidth = 1.0;
    btnCancel.layer.borderColor = GRAY_80.CGColor;
    [btnCancel setTitleColor:GRAY_80 forState:UIControlStateNormal];
    [btnCancel setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Reset"] forState:UIControlStateNormal];
    [btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.bottom.equalTo(self).offset(-padding-[AppDelegate sharedInstance].safeAreaBottomPadding);
        make.right.equalTo(self.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnSave.layer.cornerRadius = 8.0;
    btnSave.backgroundColor = BLUE_COLOR;
    [btnSave setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnSave setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Save"] forState:UIControlStateNormal];
    [btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(btnCancel);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  content
    lbBankName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Bank name"];
    [lbBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.equalTo(viewHeader.mas_bottom).offset(2*padding);
        make.right.equalTo(self).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBankName.delegate = self;
    tfBankName.returnKeyType = UIReturnKeyNext;
    tfBankName.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter bank name"];
    [tfBankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBankName.mas_bottom);
        make.left.right.equalTo(lbBankName);
        make.height.mas_equalTo(hBTN);
    }];
    tfBankName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hBTN)];
    tfBankName.leftViewMode = UITextFieldViewModeAlways;
    
    [tfBankName addTarget:self
                   action:@selector(tfBankDidChanged:)
         forControlEvents:UIControlEventEditingChanged];
    
    //  owner name
    lbOwnerName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Owner name"];
    [lbOwnerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBankName.mas_bottom).offset(padding);
        make.left.right.equalTo(tfBankName);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfOwnerName.delegate = self;
    tfOwnerName.returnKeyType = UIReturnKeyNext;
    tfOwnerName.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter owner name"];
    [tfOwnerName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbOwnerName.mas_bottom);
        make.left.right.equalTo(lbOwnerName);
        make.height.mas_equalTo(hBTN);
    }];
    tfOwnerName.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hBTN)];
    tfOwnerName.leftViewMode = UITextFieldViewModeAlways;
    
    //  bank account number
    lbBankAccountNumber.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Bank account number"];
    [lbBankAccountNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfOwnerName.mas_bottom).offset(padding);
        make.left.right.equalTo(tfOwnerName);
        make.height.mas_equalTo(hLabel);
    }];
    
    tfBankAccountNumber.delegate = self;
    tfBankAccountNumber.returnKeyType = UIReturnKeyDone;
    tfBankAccountNumber.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter bank account number"];
    [tfBankAccountNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBankAccountNumber.mas_bottom);
        make.left.right.equalTo(lbBankAccountNumber);
        make.height.mas_equalTo(hBTN);
    }];
    tfBankAccountNumber.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10.0, hBTN)];
    tfBankAccountNumber.leftViewMode = UITextFieldViewModeAlways;
    
    btnCancel.titleLabel.font = btnSave.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize+2];
    lbBankName.font = lbOwnerName.font = lbBankAccountNumber.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    tfBankName.font = tfOwnerName.font = tfBankAccountNumber.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    
    lbBankName.textColor = lbOwnerName.textColor = lbBankAccountNumber.textColor = GRAY_100;
    tfBankName.textColor = tfOwnerName.textColor = tfBankAccountNumber.textColor = GRAY_50;
    
    tfBankName.layer.borderWidth = tfOwnerName.layer.borderWidth = tfBankAccountNumber.layer.borderWidth = 1.0;
    tfBankName.layer.cornerRadius = tfOwnerName.layer.cornerRadius = tfBankAccountNumber.layer.cornerRadius = 5.0;
    tfBankName.layer.borderColor = tfOwnerName.layer.borderColor = tfBankAccountNumber.layer.borderColor = GRAY_200.CGColor;
    
    tbBank = [[UITableView alloc] init];
    tbBank.backgroundColor = UIColor.whiteColor;
    tbBank.layer.cornerRadius = 5.0;
    tbBank.layer.borderColor = GRAY_230.CGColor;
    tbBank.layer.borderWidth = 1.0;
    [tbBank registerNib:[UINib nibWithNibName:@"BankCell" bundle:nil] forCellReuseIdentifier:@"BankCell"];
    tbBank.delegate = self;
    tbBank.dataSource = self;
    tbBank.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview: tbBank];
    [tbBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfBankName.mas_bottom).offset(2.0);
        make.left.right.equalTo(tfBankName);
        make.height.mas_equalTo(0.0);
    }];
    
    if (searchList == nil) {
        searchList = [[NSMutableArray alloc] init];
    }else{
        [searchList removeAllObjects];
    }
    
    [self showBankInfo];
}

- (void)closeKeyboard {
    [self endEditing: TRUE];
}

- (IBAction)btnSavePress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfBankName.text] || [AppUtils isNullOrEmpty: tfOwnerName.text] || [AppUtils isNullOrEmpty: tfBankAccountNumber.text])
    {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter full informations"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating..."] Interaction:FALSE];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] updateBankInfoWithBankName:tfBankName.text bankaccount:tfOwnerName.text banknumber:tfBankAccountNumber.text];
}

- (IBAction)btnCancelPress:(UIButton *)sender {
    [self showBankInfo];
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if ([delegate respondsToSelector:@selector(closeUpdateBankInfoView)]) {
        [delegate closeUpdateBankInfoView];
    }
}

- (void)showBankInfo {
    tfBankName.text = [AccountModel getCusBankName];
    tfOwnerName.text = [AccountModel getCusBankAccount];
    tfBankAccountNumber.text = [AccountModel getCusBankNumber];
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
        
        [tbBank mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hTbView);
        }];
        [tbBank reloadData];
    }
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
    cell.lbName.text = SFM(@"%@ - %@", bank.name, bank.code);
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
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)updateBankInfoSuccessfulWithData:(NSDictionary *)data {
    [self tryLoginToUpdateInformation];
}

-(void)failedToLoginWithError:(NSString *)error {
    [ProgressHUD dismiss];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your bank account info has been updated successful"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(bankInfoHasBeenUpdated) withObject:nil afterDelay:2.0];
}

- (void)tryLoginToUpdateInformation
{
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

- (void)bankInfoHasBeenUpdated {
    if ([delegate respondsToSelector:@selector(bankInfoHasBeenUpdatedSuccessful)]) {
        [delegate bankInfoHasBeenUpdatedSuccessful];
    }
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfBankName) {
        [tfOwnerName becomeFirstResponder];
        
    }else if (textField == tfOwnerName) {
        [tfBankAccountNumber becomeFirstResponder];
        
    }else if (textField == tfBankAccountNumber) {
        [self endEditing: TRUE];
    }
    return TRUE;
}

@end
