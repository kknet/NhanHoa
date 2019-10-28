//
//  TopUpMoneyView.m
//  NhanHoa
//
//  Created by Khai Leo on 10/26/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "TopUpMoneyView.h"
#import "ChooseMoneyTbvCell.h"

#define NUM_OF_ROWS     3

@implementation TopUpMoneyView
@synthesize viewBg, viewContent, icClose, tbMoney, tfMoney, btnConfirm;
@synthesize hCell, hBTN, textFont, hContent, padding, popupType, selectedRow;

- (void)setupUIForView
{
    self.backgroundColor = UIColor.clearColor;
    hCell = 60.0;
    hBTN = 50.0;
    padding = 15.0;
    selectedRow = 0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    }
    
    viewBg.hidden = TRUE;
    viewBg.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:0.3];
    [viewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    hContent = (40.0 + hCell) + NUM_OF_ROWS*hCell + hBTN + 2*padding + hBTN + padding + padding;
    viewContent.layer.cornerRadius = 15.0;
    viewContent.backgroundColor = UIColor.whiteColor;
    viewContent.clipsToBounds = TRUE;
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(hContent);
    }];
    
    [tbMoney registerNib:[UINib nibWithNibName:@"ChooseMoneyTbvCell" bundle:nil] forCellReuseIdentifier:@"ChooseMoneyTbvCell"];
    tbMoney.scrollEnabled = FALSE;
    tbMoney.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbMoney.delegate = self;
    tbMoney.dataSource = self;
    [tbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewContent);
        make.height.mas_equalTo(40.0 + hCell + NUM_OF_ROWS*hCell);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewContent).offset(5.0);
        make.top.equalTo(viewContent);
        make.width.height.mas_equalTo(40.0);
    }];
    
    tfMoney.placeholder = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Enter another amount"];
    tfMoney.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    tfMoney.layer.cornerRadius = 5.0;
    tfMoney.backgroundColor = GRAY_240;
    [tfMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tbMoney.mas_bottom);
        make.left.equalTo(viewContent).offset(padding);
        make.right.equalTo(viewContent).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    [tfMoney addTarget:self
                action:@selector(textfieldMoneyChanged:)
      forControlEvents:UIControlEventEditingChanged];
    
    btnConfirm.titleLabel.font = textFont;
    btnConfirm.clipsToBounds = TRUE;
    btnConfirm.layer.cornerRadius = 8.0;
    btnConfirm.backgroundColor = BLUE_COLOR;
    [btnConfirm setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnConfirm setTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Confirm"] forState:UIControlStateNormal];
    [btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfMoney.mas_bottom).offset(2*padding);
        make.left.right.equalTo(tfMoney);
        make.height.mas_equalTo(hBTN);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)textfieldMoneyChanged:(UITextField *)textField
{
    if (selectedRow != -1) {
        selectedRow = -1;
        [tbMoney reloadData];
    }
    
    NSString *cleanValue = [[textField.text componentsSeparatedByCharactersInSet: [[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    NSString *result = [AppUtils convertStringToCurrencyFormat: cleanValue];
    textField.text = result;
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;

    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT-hContent+padding - keyboardHeight);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT-hContent+padding);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

- (IBAction)btnConfirmPress:(UIButton *)sender
{
    if (![AppUtils checkNetworkAvailable]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"No network connection. Please check again!"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    //  check topup money
    NSString *strMoney = tfMoney.text;
    strMoney = [strMoney stringByReplacingOccurrencesOfString:@"." withString:@""];
    strMoney = [strMoney stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    if (![AppUtils checkValidCurrency: strMoney]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"The amount you want to top up is not in the correct format. Please check again!"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: strMoney] || [strMoney isEqualToString:@"0"]) {
        [self makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Please enter the amount you want to top up"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    long topupMoney = (long)[strMoney longLongValue];
    if (topupMoney < MIN_MONEY_TOPUP) {
        NSString *strMinTopup = [AppUtils convertStringToCurrencyFormat:SFM(@"%d", MIN_MONEY_TOPUP)];
        NSString *content = SFM(@"%@ %@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"The amount to top up must be at least"], strMinTopup);
        [self makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    [self endEditing: TRUE];
    
    int curUnixTime = (int)[[NSDate date] timeIntervalSince1970];
    NSString *total = [NSString stringWithFormat:@"%@%d", PASSWORD, curUnixTime];
    [AppDelegate sharedInstance].hashKey = [AppUtils getMD5StringOfString: total];
    
    //  [self goToPaymentView];
    
}

- (IBAction)icCloseClick:(UIButton *)sender {
    
}

- (void)showMoneyListToTopUp {
    viewBg.hidden = FALSE;
    [viewContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(SCREEN_HEIGHT-hContent+padding);
    }];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}


#pragma mark - UItableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChooseMoneyTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChooseMoneyTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lbMoney.font = textFont;
    switch (indexPath.row) {
        case 0:{
            cell.lbMoney.text = @"500.000VNĐ";
            break;
        }
        case 1:{
            cell.lbMoney.text = @"1.000.000VNĐ";
            break;
        }
        case 2:{
            cell.lbMoney.text = @"1.500.000VNĐ";
            cell.lbSepa.hidden = TRUE;
            break;
        }
        default:
            break;
    }
    
    cell.lbMoney.textColor = (selectedRow == indexPath.row) ? BLUE_COLOR : GRAY_100;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row != selectedRow) {
        selectedRow = (int)indexPath.row;
    }
    [tbMoney reloadData];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hCell + 40.0)];
    
    UILabel *lbSection = [[UILabel alloc] init];
        lbSection.textAlignment = NSTextAlignmentCenter;
    lbSection.textColor = GRAY_100;
    lbSection.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize-2];
    [viewSection addSubview: lbSection];
    [lbSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewSection);
        make.left.equalTo(viewSection).offset(padding);
        make.right.equalTo(viewSection).offset(-padding);
        make.height.mas_equalTo(40.0);
    }];
    
    UILabel *lbContent = [[UILabel alloc] init];
    lbContent.textAlignment = NSTextAlignmentCenter;
    lbContent.numberOfLines = 5;
    lbContent.textColor = GRAY_100;
    lbContent.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [viewSection addSubview: lbContent];
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSection.mas_bottom);
        make.left.right.equalTo(lbSection);
        make.height.mas_equalTo(hCell);
    }];
    
    if (popupType == ePopupTopup) {
        lbSection.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Choose amount want to top up"];
        
        NSString *minMoneyTopup = [AppUtils convertStringToCurrencyFormat:SFM(@"%d", MIN_MONEY_TOPUP)];
        
        lbContent.text = SFM(@"%@: %@ %@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Note"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"The amount to top up must be at least"], minMoneyTopup);
    }else{
        lbSection.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Choose amount want to withdraw"];
        lbContent.text = SFM(@"%@: %@", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Note"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"The amount you want to withdraw must be less than the bonus balance"]);
    }
    
    return viewSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hCell + 40.0;
}

@end
