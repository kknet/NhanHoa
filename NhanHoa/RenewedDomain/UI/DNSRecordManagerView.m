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
@synthesize scvContent, lbTitle, lbName, tfName, lbType, tfType, btnType, imgArrow, lbMX, tfMX, lbValue, tfValue, lbTTL, tfTTL, lbDesc, tvDesc, btnAddRecord, lbWarning;
@synthesize domain, margin, tbType, listType, delegate;

- (void)setupUIForViewWithType: (DNSRecordType)type
{
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    tapOnScreen.delegate = self;
    [self addGestureRecognizer: tapOnScreen];
    
    float padding = 15.0;
    margin = 10.0;
    
    if ([DeviceUtils isScreen320]) {
        padding = 7.5;
        margin = 7.0;
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
    
    lbName.textColor = lbType.textColor = lbValue.textColor = lbMX.textColor = lbTTL.textColor = lbDesc.textColor = TITLE_COLOR;
    lbName.font = lbType.font = lbValue.font = lbMX.font = lbTTL.font = lbDesc.font = [AppDelegate sharedInstance].fontRegular;
    tfName.font = tfType.font = tfValue.font = tfMX.font = tfTTL.font = tvDesc.font = [AppDelegate sharedInstance].fontRegular;
    
    lbWarning.font = [AppDelegate sharedInstance].fontNormal;
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
    tfMX.placeholder = [NSString stringWithFormat:@"[%d -> %d]", MX_MIN, MX_MAX];
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
    tfTTL.placeholder = [NSString stringWithFormat:@"[%d -> %d]", TTL_MIN, TTL_MAX];
    tfTTL.keyboardType = UIKeyboardTypeNumberPad;
    tfTTL.returnKeyType = UIReturnKeyNext;
    tfTTL.delegate = self;
    [tfTTL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbTTL);
        make.left.right.equalTo(tfValue);
    }];
    
    //  Description
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTTL.mas_bottom).offset(margin);
        make.left.right.equalTo(lbTTL);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    tvDesc.layer.borderColor = BORDER_COLOR.CGColor;
    tvDesc.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    tvDesc.layer.borderWidth = 1.0;
    tvDesc.returnKeyType = UIReturnKeyDone;
    [tvDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDesc);
        make.left.right.equalTo(tfValue);
        make.height.mas_equalTo(2.5*[AppDelegate sharedInstance].hTextfield);
    }];
    
    btnAddRecord.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnAddRecord.backgroundColor = ORANGE_COLOR;
    [btnAddRecord setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnAddRecord setTitle:@"TẠO RECORD" forState:UIControlStateNormal];
    btnAddRecord.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnAddRecord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tvDesc.mas_bottom).offset(margin);
        make.left.equalTo(tvDesc);
        make.height.mas_equalTo(45.0);
        make.width.mas_equalTo(150.0);
    }];
    
    lbWarning.textColor = UIColor.redColor;
    [lbWarning mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(scvContent).offset(SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav + padding));
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*padding);
    }];
}

- (void)hideKeyboard {
    [self endEditing: TRUE];
}

- (void)showContentForView {
    NSString *content = [NSString stringWithFormat:@"Bạn đang thêm record cho tên miền:\n %@", domain];
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
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [scvContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self).offset(-keyboardSize.height);
    }];
    
    if (tvDesc.isFirstResponder) {
        [scvContent setContentOffset:CGPointMake(0, tfTTL.frame.origin.y) animated:TRUE];
    }
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
    [ProgressHUD show:@"Đang thêm record. Vui lòng chờ..." Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] addDNSRecordForDomain:domain name:tfName.text value:tfValue.text type:tfType.text ttl:tfTTL.text mx:tfMX.text];
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

- (void)showDNSRecordContentWithInfo: (NSDictionary *)info {
    
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
        tfMX.text = @"";
    }
    
    [self showListTypeRecord: FALSE withSender: nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AppDelegate sharedInstance].hTextfield;
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfName) {
        [tfType becomeFirstResponder];
        
    }else if (textField == tfType) {
        [tfMX becomeFirstResponder];
        
    }else if (textField == tfMX) {
        [tfValue becomeFirstResponder];
        
    }else if (textField == tfValue) {
        [tfTTL becomeFirstResponder];
        
    }else if (textField == tfTTL) {
        [tvDesc becomeFirstResponder];
    }
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
    [self makeToast:@"Thêm record thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}


- (void)dismissView{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([delegate respondsToSelector:@selector(closeAddDNSRecordView)]) {
        [delegate closeAddDNSRecordView];
    }
    
    if ([delegate respondsToSelector:@selector(addNewRecordSuccessful)]) {
        [delegate addNewRecordSuccessful];
    }
}

@end
