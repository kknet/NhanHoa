//
//  DNSRecordManagerView.m
//  NhanHoa
//
//  Created by OS on 8/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DNSRecordManagerView.h"
#import "DNSRecordTypeCell.h"

@implementation DNSRecordManagerView
@synthesize viewHeader, lbHeader, icClose;
@synthesize scvContent, lbTitle, lbName, tfName, lbType, tfType, btnType, imgArrow, lbMX, tfMX, lbValue, tfValue, lbTTL, tfTTL, btnAddRecord, btnReset, lbWarning;
@synthesize domain, margin, tbType, listType, delegate, curType, curInfo;

- (void)setupUIForViewWithType: (DNSRecordType)type
{
    curType = type;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapOnScreen.delegate = self;
    [self addGestureRecognizer: tapOnScreen];
    
    float padding = 15.0;
    margin = 15.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 7.5;
    }
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    }];
    
    lbHeader.font = [AppDelegate sharedInstance].fontBTN;
    if (type == DNSRecordAddNew) {
        lbHeader.text = @"Thêm mới record";
    }else{
        lbHeader.text = @"Cập nhật record";
    }
    
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.right.equalTo(viewHeader);
        make.width.height.mas_equalTo(40.0);
    }];
    
    scvContent.backgroundColor = UIColor.whiteColor;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.bottom.right.equalTo(self);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-[AppDelegate sharedInstance].hStatusBar - [AppDelegate sharedInstance].hNav);
    
    
    lbTitle.numberOfLines = 10;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
    }];
    
    lbName.textColor = lbType.textColor = lbValue.textColor = lbMX.textColor = lbTTL.textColor = TITLE_COLOR;
    lbName.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = [AppDelegate sharedInstance].fontRegular;
    tfName.font = tfType.font = tfValue.font = tfMX.font = tfTTL.font = [AppDelegate sharedInstance].fontRegular;
    
    lbWarning.font = [AppDelegate sharedInstance].fontRegular;
    lbWarning.text = @"Nếu là A record thì sau khi tạo, đợi 1 phút sau hãy truy cập để tránh bị dính cache DNS.";
    
    float leftSize = [AppUtils getSizeWithText:@"Giá trị record" withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:SCREEN_WIDTH].width + 5.0;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(20.0);
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(leftSize);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfName borderColor:BORDER_COLOR];
    tfName.returnKeyType = UIReturnKeyNext;
    tfName.delegate = self;
    [tfName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbName);
        make.left.equalTo(lbName.mas_right).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-(3*padding + leftSize));
    }];
    
    //  type value
    [lbType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom).offset(margin);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfType borderColor:BORDER_COLOR];
    tfType.placeholder = @"Chọn loại record";
    tfType.returnKeyType = UIReturnKeyNext;
    tfType.delegate = self;
    tfType.enabled = FALSE;
    [tfType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbType);
        make.left.right.equalTo(tfName);
    }];
    
    [imgArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tfType.mas_centerY);
        make.right.equalTo(tfType.mas_right).offset(-5.0);
        make.width.mas_equalTo(22.0);
        make.height.mas_equalTo(16.0);
    }];
    
    [btnType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfType);
    }];
    
    //  mx value
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbType.mas_bottom).offset(margin);
        make.left.right.equalTo(lbType);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfMX borderColor:BORDER_COLOR];
    tfMX.keyboardType = UIKeyboardTypeNumberPad;
    tfMX.returnKeyType = UIReturnKeyNext;
    tfMX.delegate = self;
    [tfMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbMX);
        make.left.right.equalTo(tfType);
    }];
    
    //  value
    [lbValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMX.mas_bottom).offset(margin);
        make.left.right.equalTo(lbMX);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfValue borderColor:BORDER_COLOR];
    tfValue.returnKeyType = UIReturnKeyNext;
    tfValue.delegate = self;
    [tfValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbValue);
        make.left.right.equalTo(tfMX);
    }];
    
    //  TTL
    [lbTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbValue.mas_bottom).offset(margin);
        make.left.right.equalTo(lbValue);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfTTL borderColor:BORDER_COLOR];
    tfTTL.text = [NSString stringWithFormat:@"%d]", TTL_MIN];
    tfTTL.keyboardType = UIKeyboardTypeNumberPad;
    tfTTL.returnKeyType = UIReturnKeyNext;
    tfTTL.delegate = self;
    [tfTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbTTL);
        make.left.right.equalTo(tfValue);
    }];
    
    [btnAddRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfTTL.mas_bottom).offset(margin);
        make.left.equalTo(tfTTL);
        make.right.equalTo(tfTTL.mas_centerX).offset(-5.0);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnReset setTitle:text_reset forState:UIControlStateNormal];
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnAddRecord);
        make.left.equalTo(tfTTL.mas_centerX).offset(5.0);
        make.right.equalTo(tfTTL);
    }];
    
    lbWarning.textColor = UIColor.redColor;
    [lbWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scvContent).offset(SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + padding));
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
    }];
    
    btnAddRecord.layer.cornerRadius = btnReset.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnAddRecord.backgroundColor = btnReset.backgroundColor = BLUE_COLOR;
    btnAddRecord.titleLabel.font = btnReset.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnAddRecord setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnReset setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}

- (void)hideKeyboard {
    [self endEditing: TRUE];
    [self showListTypeRecord:FALSE withSender:nil];
}

- (void)showContentForView {
    if ([AppUtils isNullOrEmpty: domain]) {
        lbTitle.text = @"Không tìm thấy tên miền!";
        return;
    }
    
    NSString *content;
    if (curType == DNSRecordAddNew) {
        content = [NSString stringWithFormat:@"Bạn đang thêm record cho tên miền:\n %@", domain];
        lbWarning.hidden = FALSE;
        [btnAddRecord setTitle:@"Tạo Record" forState:UIControlStateNormal];
        
    }else{
        content = [NSString stringWithFormat:@"Bạn đang cập nhật record cho tên miền:\n %@", domain];
        lbWarning.hidden = TRUE;
        [btnAddRecord setTitle:@"Sửa Record" forState:UIControlStateNormal];
    }
    
    NSRange range = [content rangeOfString: domain];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontRegular, NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontMedium, NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
        lbTitle.attributedText = attr;
    }else{
        lbTitle.text = content;
    }
    
    if (tbType == nil) {
        tbType = [[UITableView alloc] init];
        tbType.scrollEnabled = FALSE;
        tbType.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tbType registerNib:[UINib nibWithNibName:@"DNSRecordTypeCell" bundle:nil] forCellReuseIdentifier:@"DNSRecordTypeCell"];
        tbType.delegate = self;
        tbType.dataSource = self;
        tbType.layer.cornerRadius = [AppDelegate sharedInstance].radius;
        tbType.layer.borderColor = BORDER_COLOR.CGColor;
        tbType.layer.borderWidth = 1.0;
        [scvContent addSubview: tbType];
        [tbType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tfType);
            make.top.equalTo(tfType.mas_bottom).offset(2.0);
            make.height.mas_equalTo(0);
        }];
    }
    
    [self showMXField: FALSE];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
}

- (void)showMXField: (BOOL)show {
    if (show) {
        [lbMX mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbType.mas_bottom).offset(margin);
            make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
        }];
    }else{
        [lbMX mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbType.mas_bottom);
            make.height.mas_equalTo(0.0);
        }];
    }
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
}

- (void)keyboardDidHide: (NSNotification *) notif{
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self endEditing: TRUE];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([delegate respondsToSelector:@selector(closeAddDNSRecordView)]) {
        [delegate closeAddDNSRecordView];
    }
}

- (IBAction)btnResetPress:(UIButton *)sender {
    if (curType == DNSRecordAddNew) {
        tfName.text = tfType.text = tfMX.text = tfValue.text = @"";
        [self showMXField: FALSE];
    }else{
        [self showDNSRecordContentWithInfo: curInfo];
    }
}

- (IBAction)btnTypePress:(UIButton *)sender {
    [self endEditing: TRUE];
    
    if (listType == nil) {
        listType = @[type_A, type_AAAA, type_CNAME, type_MX, type_URL_Redirect, type_URL_Frame, type_TXT, type_SRV, type_SPF];
    }
    sender.enabled = FALSE;
    [tbType reloadData];
    if (tbType.frame.size.height == 0) {
        [self showListTypeRecord: TRUE withSender: sender];
    }else{
        [self showListTypeRecord: FALSE withSender: sender];
    }
}

- (IBAction)btnAddRecordPress:(UIButton *)sender
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [self endEditing: TRUE];
    [self showListTypeRecord: FALSE withSender: nil];
    
    if ([AppUtils isNullOrEmpty: tfName.text]) {
        [self makeToast:@"Vui lòng nhập Tên record!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfType.text]) {
        [self makeToast:@"Vui lòng chọn Loại record!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfType.text isEqualToString: type_MX]) {
        if ([AppUtils isNullOrEmpty: tfMX.text]) {
            [self makeToast:@"Vui lòng nhập MX" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
        
        if (![AppUtils stringContainsOnlyNumber: tfMX.text]) {
            [self makeToast:@"Giá trị MX chỉ được là số. Vui lòng kiểm tra lại!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
        
        if ([tfMX.text intValue] < MX_MIN || [tfMX.text intValue] > MX_MAX) {
            [self makeToast:@"Giá trị MX không hợp lệ!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
    }else{
        tfMX.text = @"";
    }
    
    if ([AppUtils isNullOrEmpty: tfValue.text]) {
        [self makeToast:@"Vui lòng nhập Giá trị record!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTTL.text]) {
        [self makeToast:@"Vui lòng nhập TTL!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (![AppUtils stringContainsOnlyNumber: tfTTL.text]) {
        [self makeToast:@"Giá trị TTL chỉ được là số. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfTTL.text intValue] < TTL_MIN || [tfTTL.text intValue] > TTL_MAX) {
        [self makeToast:@"Giá trị TTL không hợp lệ!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    if (curType == DNSRecordAddNew) {
        [ProgressHUD show:@"Đang thêm record..." Interaction:NO];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] addDNSRecordForDomain:domain name:tfName.text value:tfValue.text type:tfType.text ttl:tfTTL.text mx:tfMX.text];
    }else{
        NSString *recordId = [curInfo objectForKey:@"record_id"];
        if ([AppUtils isNullOrEmpty: recordId]) {
            [self makeToast:@"Không tìm thấy giá trị recordId, vui lòng thực hiện lại!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
        [ProgressHUD show:@"Đang cập nhật record..." Interaction:NO];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] updateDNSRecordForDomain:domain name:tfName.text value:tfValue.text type:tfType.text ttl:tfTTL.text mx:tfMX.text record_id:recordId];
    }
}

- (void)showListTypeRecord: (BOOL)show withSender: (UIButton *)sender {
    float newHeight;
    if (show) {
        imgArrow.image = [UIImage imageNamed:@"arrow_up"];
        newHeight = listType.count * [AppDelegate sharedInstance].hTextfield;
    }else{
        imgArrow.image = [UIImage imageNamed:@"arrow_down"];
        newHeight = 0;
    }
    
    [tbType mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(newHeight);
    }];
    
    [UIView animateWithDuration:0.1 animations:^{
        [self layoutIfNeeded];
    }completion:^(BOOL finished) {
        if (sender!= nil && [sender isKindOfClass:[UIButton class]]) {
            sender.enabled = TRUE;
        }
    }];
}

- (void)showDNSRecordContentWithInfo: (NSDictionary *)info
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s] info = %@", __FUNCTION__, @[info])];
    
    if (info != nil) {
        curInfo = [[NSDictionary alloc] initWithDictionary: info];
        
        NSString *record_name = [info objectForKey:@"record_name"];
        tfName.text = (![AppUtils isNullOrEmpty: record_name]) ? record_name : @"";
        
        NSString *record_type = [info objectForKey:@"record_type"];
        tfType.text = (![AppUtils isNullOrEmpty: record_type]) ? record_type : @"";
        
        NSString *record_mx = [info objectForKey:@"record_mx"];
        tfMX.text = (![AppUtils isNullOrEmpty: record_mx]) ? record_mx : @"";
        
        NSString *record_value = [info objectForKey:@"record_value"];
        tfValue.text = (![AppUtils isNullOrEmpty: record_value]) ? record_value : @"";
        
        NSString *record_ttl = [info objectForKey:@"record_ttl"];
        tfTTL.text = (![AppUtils isNullOrEmpty: record_ttl]) ? record_ttl : @"";
        
        if (![AppUtils isNullOrEmpty: record_type] && [record_type isEqualToString: type_MX]) {
            [self showMXField: TRUE];
        }else{
            [self showMXField: FALSE];
        }
    }
    
    /*
    "record_id" = 840096;
    "record_mx" = 50;
    "record_name" = "khaile.skype.";
    "record_ttl" = 300;
    "record_type" = MX;
    "record_value" = "103.101.163.135";
    */
}

- (void)resetAllValue {
    tfName.text = tfType.text = tfMX.text = tfValue.text = @"";
    tfTTL.text = [NSString stringWithFormat:@"%d", TTL_MIN];
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listType.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DNSRecordTypeCell *cell = (DNSRecordTypeCell *)[tableView dequeueReusableCellWithIdentifier:@"DNSRecordTypeCell"];
    cell.lbName.text = [listType objectAtIndex: indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lbSepa.hidden = TRUE;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *type = [listType objectAtIndex: indexPath.row];
    tfType.text = type;
    
    if ([type isEqualToString: type_MX]) {
        [self showMXField: TRUE];
    }else{
        [self showMXField: FALSE];
        if (curType == DNSRecordAddNew) {
            tfMX.text = @"";
        }
    }
    
    [self showListTypeRecord: FALSE withSender: nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AppDelegate sharedInstance].hTextfield;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfName) {
        [tfValue becomeFirstResponder];
        
    }else if (textField == tfType) {
        [tfMX becomeFirstResponder];
        
    }else if (textField == tfMX) {
        [tfValue becomeFirstResponder];
        
    }else if (textField == tfValue) {
        [tfTTL becomeFirstResponder];
        
    }else if (textField == tfTTL) {
        [self endEditing: TRUE];
    }
    return TRUE;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    return TRUE;
}


#pragma mark - UIGestureRecognizerDelegate
-(BOOL)gestureRecognizer:(UIGestureRecognizer * __unused)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if([touch.view isKindOfClass:[UIButton class]] || [touch.view isKindOfClass:NSClassFromString(@"UIButton")])
    {
        return FALSE;
    }else if ([touch.view isKindOfClass:[UITableViewCell class]] || [touch.view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
        return FALSE;
    }
    return TRUE;
}

#pragma mark - WebserviceUtil delegate
-(void)failedToAddDNSRecord:(id)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString *content = [AppUtils getErrorContentFromData: error];
        [self makeToast:content duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([error isKindOfClass:[NSString class]]) {
        [self makeToast:error duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)addDNSRecordsSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *message = [data objectForKey:@"message"];
        if (![AppUtils isNullOrEmpty: message]) {
            [self makeToast:message duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }else{
            [self makeToast:@"Thêm record thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }
    }else{
        [self makeToast:@"Thêm record thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)failedToUpdateDNSRecord:(id)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    if ([error isKindOfClass:[NSDictionary class]]) {
        NSString *content = [AppUtils getErrorContentFromData: error];
        [self makeToast:content duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
    }else if ([error isKindOfClass:[NSString class]]) {
        [self makeToast:error duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)updateDNSRecordsSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *message = [data objectForKey:@"message"];
        if (![AppUtils isNullOrEmpty: message]) {
            [self makeToast:message duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }else{
            [self makeToast:@"Cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }
    }else{
        [self makeToast:@"Cập nhật thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
    
    
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}


- (void)dismissView{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([delegate respondsToSelector:@selector(closeAddDNSRecordView)]) {
        [delegate closeAddDNSRecordView];
    }
    
    if ([delegate respondsToSelector:@selector(reloadDNSRecordListAfterAndOrEdit)]) {
        [delegate reloadDNSRecordListAfterAndOrEdit];
    }
}

@end
