//
//  AddDNSRecordsView.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddDNSRecordsView.h"
#import "DNSRecordTypeCell.h"

@implementation AddDNSRecordsView

@synthesize viewHeader, lbHeader, icClose, scvContent, viewTop, lbTop, lbRecordName, tfRecordName, lbRecordType, tfRecordType, btnRecordType, imgRecordType, lbRecordValue, tfRecordValue, lbMX, tfMX, lbTTLValue, tfTTLValue, lbDesc, btnReset, btnSaveRecords;
@synthesize domain, listType, tbType, paddingY, padding, hTextfield, hLabel;
@synthesize delegate, typeView, editInfo;

- (void)setupUIForViewWithHeighNav: (float)hNav
{
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height + hNav);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    if (typeView == eDNSRecordAddNew) {
        lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Add new DNS Records"];
    }else{
        lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Edit DNS Records"];
    }
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset([UIApplication sharedApplication].statusBarFrame.size.height);
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
    
    //  scrollview content
    padding = 15.0;
    paddingY = 10.0;
    hLabel = 30.0;
    hTextfield = 42.0;
    
    UITapGestureRecognizer *tapOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    tapOnView.delegate = self;
    [scvContent addGestureRecognizer: tapOnView];
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(5.0);
        make.left.right.bottom.equalTo(self);
    }];
    
    viewTop.backgroundColor = GRAY_245;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(70.0);
    }];
    
    //  set content for top
    NSString *content = @"";
    if (typeView == eDNSRecordAddNew) {
        content = SFM(@"%@\n%@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"You're adding new record for domain"], domain);
    }else{
        content = SFM(@"%@\n%@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"You're updating record for domain"], domain);
    }
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoMedium size:textFont.pointSize-2] range:NSMakeRange(0, content.length)];
    [attr addAttribute:NSForegroundColorAttributeName value:GRAY_80 range:NSMakeRange(0, content.length)];
    
    NSRange domainRange = [content rangeOfString: domain];
    if (domainRange.location != NSNotFound) {
        [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:domainRange];
    }
    lbTop.attributedText = attr;
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewTop);
    }];
    
    //  record name
    lbRecordName.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Record name"];
    [lbRecordName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom).offset(paddingY);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRecordName borderColor:BORDER_COLOR];
    tfRecordName.returnKeyType = UIReturnKeyNext;
    tfRecordName.delegate = self;
    [tfRecordName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRecordName.mas_bottom);
        make.left.right.equalTo(lbRecordName);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  record type
    lbRecordType.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Record type"];
    [lbRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfRecordName.mas_bottom).offset(paddingY);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRecordType borderColor:BORDER_COLOR];
    tfRecordType.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Choose record type"];
    [tfRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRecordType.mas_bottom);
        make.left.right.equalTo(lbRecordType);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [imgRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfRecordType).offset(-padding);
        make.centerY.equalTo(tfRecordType.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnRecordType setTitleColor:GRAY_80 forState:UIControlStateNormal];
    btnRecordType.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-1];
    [btnRecordType setTitle:@"" forState:UIControlStateNormal];
    [btnRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfRecordType).offset(padding);
        make.top.bottom.right.equalTo(tfRecordType);
    }];
    
    //  MX Value
    lbMX.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"MX value"];
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnRecordType.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfRecordType);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfMX borderColor:BORDER_COLOR];
    [tfMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMX.mas_bottom);
        make.left.right.equalTo(lbMX);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  Record value
    lbRecordValue.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Record value"];
    [lbRecordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfMX.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfMX);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfRecordValue borderColor:BORDER_COLOR];
    tfRecordValue.returnKeyType = UIReturnKeyNext;
    tfRecordValue.delegate = self;
    [tfRecordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRecordValue.mas_bottom);
        make.left.right.equalTo(lbRecordValue);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  TTL value
    lbTTLValue.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"TTL value"];
    [lbTTLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfRecordValue.mas_bottom).offset(paddingY);
        make.left.right.equalTo(tfRecordValue);
        make.height.mas_equalTo(hLabel);
    }];
    
    [AppUtils setBorderForTextfield:tfTTLValue borderColor:BORDER_COLOR];
    tfTTLValue.text = SFM(@"%d", TTL_MIN);
    tfTTLValue.returnKeyType = UIReturnKeyDone;
    tfTTLValue.delegate = self;
    [tfTTLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTTLValue.mas_bottom);
        make.left.right.equalTo(lbTTLValue);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  footer
    btnReset.layer.cornerRadius = 8.0;
    [btnReset setTitleColor:GRAY_50 forState:UIControlStateNormal];
    btnReset.layer.borderColor = GRAY_50.CGColor;
    btnReset.layer.borderWidth = 1.0;
    [btnReset setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Reset"] forState:UIControlStateNormal];
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfTTLValue.mas_bottom).offset(2*paddingY);
        make.left.equalTo(tfTTLValue);
        make.right.equalTo(viewTop.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hTextfield + 5.0);
    }];
    
    btnSaveRecords.layer.cornerRadius = 8.0;
    [btnSaveRecords setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSaveRecords.backgroundColor = BLUE_COLOR;
    [btnSaveRecords setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Save Record"] forState:UIControlStateNormal];
    [btnSaveRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnReset);
        make.left.equalTo(viewTop.mas_centerX).offset(padding/2);
        make.right.equalTo(tfTTLValue);
    }];
    
    lbDesc.textColor = UIColor.redColor;
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    lbDesc.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"If it is A record, after creating, wait 1 minute later to access to avoid DNS cache."];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnSaveRecords.mas_bottom).offset(2*padding);
        make.left.right.equalTo(tfTTLValue);
        make.height.mas_equalTo(70.0);
    }];
    
    float hContent = 70.0 + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (2*paddingY + hTextfield + 5.0 + 2*paddingY) + (2*padding + 70.0);
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
    
    lbRecordName.textColor = lbRecordType.textColor = lbRecordValue.textColor = lbMX.textColor = lbTTLValue.textColor = GRAY_150;
    tfRecordName.textColor = tfRecordType.textColor = tfRecordValue.textColor = tfMX.textColor = tfTTLValue.textColor = GRAY_80;
    
    lbRecordName.font = lbRecordType.font = lbRecordValue.font = lbMX.font = lbTTLValue.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    tfRecordName.font = tfRecordType.font = tfRecordValue.font = tfMX.font = tfTTLValue.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    
    btnReset.titleLabel.font = btnSaveRecords.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    
    //  register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
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
            make.left.right.equalTo(tfRecordType);
            make.top.equalTo(tfRecordType.mas_bottom).offset(2.0);
            make.height.mas_equalTo(0);
        }];
    }
    
    [self showMXField: FALSE];
}

- (void)showMXField: (BOOL)show {
    if (show) {
        [lbMX mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnRecordType.mas_bottom).offset(paddingY);
            make.height.mas_equalTo(hTextfield);
        }];
        
        [tfMX mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hTextfield);
        }];
        
        float hContent = 70.0 + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (2*paddingY + hTextfield + 5.0 + 2*paddingY) + (2*padding + 70.0);
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
        
    }else{
        [lbMX mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnRecordType.mas_bottom);
            make.height.mas_equalTo(0.0);
        }];
        
        [tfMX mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        float hContent = 70.0 + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (paddingY + hLabel + hTextfield) + (2*paddingY + hTextfield + 5.0 + 2*paddingY) + (2*padding + 70.0);
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
    }
}

- (void)closeKeyboard {
    [self endEditing: TRUE];
    [self showListTypeRecord:FALSE withSender:nil];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-keyboardHeight);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
    }];
}

- (IBAction)icCloseClick:(UIButton *)sender {
    [self endEditing: TRUE];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([delegate respondsToSelector:@selector(closeAddDNSRecordView)]) {
        [delegate closeAddDNSRecordView];
    }
}

- (IBAction)btnRecordTypePress:(UIButton *)sender {
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

- (IBAction)btnResetPress:(UIButton *)sender {
    if (typeView == eDNSRecordAddNew) {
        tfRecordName.text = tfRecordType.text = tfMX.text = tfRecordValue.text = @"";
        tfTTLValue.text = SFM(@"%d", TTL_MIN);
        [self showMXField: FALSE];
    }else{
        [self displayContentWithDNSInfo: editInfo];
    }
}

- (IBAction)btnSaveRecordsPress:(UIButton *)sender
{
    [self endEditing: TRUE];
    [self showListTypeRecord: FALSE withSender: nil];
    
    if ([AppUtils isNullOrEmpty: tfRecordName.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter Record name"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfRecordType.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter Record type"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfRecordType.text isEqualToString: type_MX]) {
        if ([AppUtils isNullOrEmpty: tfMX.text]) {
            [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter MX value"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
        
        if (![AppUtils stringContainsOnlyNumber: tfMX.text]) {
            [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"MX's value is only number"] duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
        
        if ([tfMX.text intValue] < MX_MIN || [tfMX.text intValue] > MX_MAX) {
            [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"MX's is invalid"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
    }else{
        tfMX.text = @"";
    }
    
    if ([AppUtils isNullOrEmpty: tfRecordValue.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter Record value"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tfTTLValue.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter TTL value"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if (![AppUtils stringContainsOnlyNumber: tfTTLValue.text]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"TTL's value is only number"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([tfTTLValue.text intValue] < TTL_MIN || [tfTTLValue.text intValue] > TTL_MAX) {
        NSString *content = SFM(@"%@ (%@ %d %@ %d)", [[AppDelegate sharedInstance].localization localizedStringForKey:@"TTL's value is invalid"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"From"], TTL_MIN, [[AppDelegate sharedInstance].localization localizedStringForKey:@"To"], TTL_MAX);
        
        [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        
        return;
    }
    
    if (typeView == eDNSRecordAddNew) {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Adding..."] Interaction:NO];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] addDNSRecordForDomain:domain name:tfRecordName.text value:tfRecordValue.text type:tfRecordType.text ttl:tfTTLValue.text mx:tfMX.text];
        
    }else{
        NSString *recordId = [editInfo objectForKey:@"record_id"];
        if ([AppUtils isNullOrEmpty: recordId]) {
            [self makeToast:@"Không tìm thấy giá trị recordId, vui lòng thực hiện lại!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            return;
        }
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Updating..."] Interaction:NO];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] updateDNSRecordForDomain:domain name:tfRecordName.text value:tfRecordValue.text type:tfRecordType.text ttl:tfTTLValue.text mx:tfMX.text record_id:recordId];
    }
}

- (void)showListTypeRecord: (BOOL)show withSender: (UIButton *)sender {
    float newHeight;
    if (show) {
        imgRecordType.image = [UIImage imageNamed:@"arrow_up"];
        newHeight = listType.count * [AppDelegate sharedInstance].hTextfield;
    }else{
        imgRecordType.image = [UIImage imageNamed:@"arrow_down"];
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

- (void)displayContentWithDNSInfo: (NSDictionary *)info {
    if (info != nil && [info isKindOfClass:[NSDictionary class]])
    {
        editInfo = info;
        
        NSString *record_name = [info objectForKey:@"record_name"];
        tfRecordName.text = (![AppUtils isNullOrEmpty: record_name]) ? record_name : @"";
        
        NSString *record_type = [info objectForKey:@"record_type"];
        tfRecordType.text = (![AppUtils isNullOrEmpty: record_type]) ? record_type : @"";
        
        NSString *record_value = [info objectForKey:@"record_value"];
        tfRecordValue.text = (![AppUtils isNullOrEmpty: record_value]) ? record_value : @"";
        
        NSString *record_mx = [info objectForKey:@"record_mx"];
        tfMX.text = (![AppUtils isNullOrEmpty: record_mx]) ? record_mx : @"";
        
        NSString *record_ttl = [info objectForKey:@"record_ttl"];
        tfTTLValue.text = (![AppUtils isNullOrEmpty: record_ttl]) ? record_ttl : @"";
        
        if ([record_type isEqualToString: type_MX]) {
            [self showMXField: TRUE];
        }else{
            [self showMXField: FALSE];
        }
    }else{
        tfRecordName.text = tfRecordType.text = tfRecordValue.text = tfMX.text = tfTTLValue.text = @"";
    }
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfRecordName || textField == tfMX) {
        [tfRecordValue becomeFirstResponder];
        
    }else if (textField == tfRecordValue){
        [tfTTLValue becomeFirstResponder];
        
    }else if (textField == tfTTLValue){
        [self endEditing: TRUE];
    }
    return TRUE;
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
    tfRecordType.text = type;

    if ([type isEqualToString: type_MX]) {
        [self showMXField: TRUE];
    }else{
        [self showMXField: FALSE];
//        if (curType == DNSRecordAddNew) {
//            tfMX.text = @"";
//        }
    }

    [self showListTypeRecord: FALSE withSender: nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [AppDelegate sharedInstance].hTextfield;
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
-(void)failedToUpdateDNSRecord:(id)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)updateDNSRecordsSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *message = [data objectForKey:@"message"];
        if (![AppUtils isNullOrEmpty: message]) {
            [self makeToast:message duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }else{
            [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your Record has been updated"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }
    }else{
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your Record has been updated"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
    
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)failedToAddDNSRecord:(id)error {
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self makeToast:content duration:4.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)addDNSRecordsSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSString *message = [data objectForKey:@"message"];
        if (![AppUtils isNullOrEmpty: message]) {
            [self makeToast:message duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }else{
            [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your Record has been added"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
        }
    }else{
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Your Record has been added"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    }
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)dismissView{
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    
    if ([delegate respondsToSelector:@selector(closeAddDNSRecordView)]) {
        [delegate closeAddDNSRecordView];
    }
    
    if ([delegate respondsToSelector:@selector(addNewDNSRecordSuccessful)]) {
        [delegate addNewDNSRecordSuccessful];
    }
}

@end
