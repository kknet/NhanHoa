//
//  RenewDomainCartViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RenewDomainCartViewController.h"
#import "TopupViewController.h"
#import "CartDomainItemCell.h"
#import "SelectYearsCell.h"
#import "PaymentMethodCell.h"
#import "AccountModel.h"

@interface RenewDomainCartViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, WebServiceUtilsDelegate> {
    NSDictionary *domainInfo;
    
    long priceForRenew;
    float vat;
}

@end

@implementation RenewDomainCartViewController
@synthesize tbDomain, lbSepa, viewFooter, lbDomainPrice, lbDomainPriceValue, lbVAT, lbVATValue, lbTotalPrice, lbTotalPriceValue, btnContinue, tbSelectYear;
@synthesize hCell, domain, cus_id, ord_id, yearsForRenew;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Gia hạn tên miền";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"RenewDomainCartViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
    yearsForRenew = 1;
    priceForRenew = 0;
    vat = 0;
    
    [self addTableViewForSelectYears];
    
    [self updateAllPriceForView];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy thông tin..." Interaction:NO];
    [tbDomain reloadData];
    
    [[WebServiceUtils getInstance] getRenewInfoForDomain: domain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    //  close table view
    [UIView animateWithDuration:0.15 animations:^{
        self.tbSelectYear.frame = CGRectMake(self.tbSelectYear.frame.origin.x, self.tbSelectYear.frame.origin.y, self.tbSelectYear.frame.size.width, 0);
    }];
    
    long totalPrice = [self getTotalPriceForPayment];
    if (totalPrice > 0) {
        NSString *strBalance = [AccountModel getCusBalance];
        if ([strBalance longLongValue] >= totalPrice) {
            if (![AppUtils isNullOrEmpty: domain] && ![AppUtils isNullOrEmpty: cus_id] && ![AppUtils isNullOrEmpty: ord_id])
            {
                [self confirmRenewOrderView];
            }else{
                [self.view makeToast:@"Dữ liệu không hợp lệ. Vui lòng thử lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Số tiền hiện tại trong ví của bạn không đủ để thanh toán.\nBạn có muốn nạp tiền ngay?" delegate:self cancelButtonTitle:@"Để sau" otherButtonTitles:topup_now, nil];
            alert.tag = 2;
            [alert show];
        }
    }else{
        [self.view makeToast:@"Dữ liệu không hợp lệ. Vui lòng kiểm tra lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (void)confirmRenewOrderView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:@"Bạn chắc chắn muốn gia hạn tên miền này?"];
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:16.0] range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:@"Đóng" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         NSLog(@"Đóng");
                                                     }];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnRenew = [UIAlertAction actionWithTitle:@"Gia hạn" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         [ProgressHUD backgroundColor: ProgressHUD_BG];
                                                         [ProgressHUD show:@"Đang xử lý..." Interaction:NO];
                                                         
                                                         [[WebServiceUtils getInstance] renewOrderForDomain:self.domain contactId:self.cus_id ord_id:self.ord_id years:self.yearsForRenew];
                                                     }];
    [btnRenew setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnClose];
    [alertVC addAction:btnRenew];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupUIForView {
    float padding = 15.0;
    hCell = 106.0;
    
    [tbDomain registerNib:[UINib nibWithNibName:@"CartDomainItemCell" bundle:nil] forCellReuseIdentifier:@"CartDomainItemCell"];
    tbDomain.scrollEnabled = FALSE;
    tbDomain.delegate = self;
    tbDomain.dataSource = self;
    tbDomain.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(self.hCell);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tbDomain.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1.0);
    }];
    
    //  continue button
    btnContinue.layer.cornerRadius = 45.0/2;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.bottom.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    //  footer view
    float hFooter = padding + 4*30 + padding;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.lbSepa.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hFooter);
    }];
    
    //  price
    lbDomainPrice.textColor = TITLE_COLOR;
    lbDomainPrice.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbDomainPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(30.0);
    }];
    
    lbDomainPriceValue.textColor = lbDomainPrice.textColor;
    lbDomainPriceValue.font = lbDomainPrice.font;
    [lbDomainPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewFooter.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(self.lbDomainPrice);
        make.right.equalTo(self.viewFooter).offset(-padding);
    }];
    
    //  VAT
    lbVAT.textColor = TITLE_COLOR;
    lbVAT.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomainPrice.mas_bottom);
        make.left.right.equalTo(self.lbDomainPrice);
        make.height.equalTo(self.lbDomainPrice.mas_height);
    }];
    
    lbVATValue.textColor = lbDomainPrice.textColor;
    lbVATValue.font = lbDomainPrice.font;
    [lbVATValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomainPriceValue);
        make.top.bottom.equalTo(self.lbVAT);
    }];
    
    
    //  Total price
    lbTotalPrice.textColor = TITLE_COLOR;
    lbTotalPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVAT.mas_bottom);
        make.left.right.equalTo(self.lbVAT);
        make.height.equalTo(self.lbVAT.mas_height);
    }];
    
    lbTotalPriceValue.textColor = NEW_PRICE_COLOR;
    lbTotalPriceValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbVATValue);
        make.top.bottom.equalTo(self.lbTotalPrice);
    }];
}

- (void)updateAllPriceForView {
    if (priceForRenew > 0 && yearsForRenew > 0) {
        long domainPrice = priceForRenew * yearsForRenew;
        NSString *strDomainPrice = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", domainPrice]];
        lbDomainPriceValue.text = [NSString stringWithFormat:@"%@VNĐ", strDomainPrice];
        
        long vatValue = vat*domainPrice/100;
        NSString *strVAT = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", vatValue]];
        lbVATValue.text = [NSString stringWithFormat:@"%@VNĐ", strVAT];
        
        long total = domainPrice + vatValue;
        NSString *strTotal = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", total]];
        lbTotalPriceValue.text = [NSString stringWithFormat:@"%@VNĐ", strTotal];
        
    }else {
        lbVATValue.text = lbDomainPriceValue.text = lbTotalPriceValue.text = @"N/A";
    }
}

- (long)getTotalPriceForPayment {
    if (priceForRenew > 0 && yearsForRenew > 0) {
        long domainPrice = priceForRenew * yearsForRenew;
        long vatValue = vat*domainPrice/100;
        
        return domainPrice + vatValue;
    }else {
        return 0;
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbSelectYear) {
        return MAX_YEAR_FOR_RENEW;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbSelectYear) {
        SelectYearsCell *cell = (SelectYearsCell *)[tableView dequeueReusableCellWithIdentifier:@"SelectYearsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lbContent.text = [NSString stringWithFormat:@"%d năm", (int)indexPath.row + 1];
        return cell;
        
    }else{
        CartDomainItemCell *cell = (CartDomainItemCell *)[tableView dequeueReusableCellWithIdentifier:@"CartDomainItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSString *domainName = domain;
        
        cell.lbNum.text = [NSString stringWithFormat:@"%d.", (int)indexPath.row + 1];
        cell.lbName.text = domainName;
        cell.tfYears.text = [NSString stringWithFormat:@"%d năm", yearsForRenew];
        
        [cell displayDataWithInfo: domainInfo forYear: yearsForRenew];
        
        cell.lbSepa.hidden = TRUE;
        cell.lbDescription.hidden = TRUE;
        cell.btnYears.tag = indexPath.row;
        [cell.btnYears addTarget:self
                          action:@selector(selectYearsForDomain:)
                forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbSelectYear) {
        yearsForRenew = (int)indexPath.row + 1;
        [self updateAllPriceForView];
        [tbDomain reloadData];
        
        [UIView animateWithDuration:0.15 animations:^{
            self.tbSelectYear.frame = CGRectMake(self.tbSelectYear.frame.origin.x, self.tbSelectYear.frame.origin.y, self.tbSelectYear.frame.size.width, 0);
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbSelectYear) {
        return 38.0;
    }
    return hCell;
}

- (void)selectYearsForDomain: (UIButton *)sender {
    CartDomainItemCell *cell = (CartDomainItemCell *)[tbDomain cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    CGRect frame = [tbDomain convertRect:cell.frame toView:self.view];
    
    float newYFrame = frame.origin.y + cell.btnYears.frame.origin.y + cell.btnYears.frame.size.height + 2;
    
    if (tbSelectYear.frame.origin.y == newYFrame) {
        float hTbView = 0;
        if (tbSelectYear.frame.size.height == 0) {
            hTbView = 6*sender.frame.size.height;
        }
        tbSelectYear.hidden = TRUE;
        tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, 0);
        
        tbSelectYear.hidden = FALSE;
        [UIView animateWithDuration:0.15 animations:^{
            self.tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, hTbView);
        }];
    }else{
        tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, 0);
        
        float hTbView = 6*sender.frame.size.height;
        [UIView animateWithDuration:0.15 animations:^{
            self.tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, hTbView);
        }];
    }
}

- (void)addTableViewForSelectYears {
    if (tbSelectYear == nil) {
        tbSelectYear = [[UITableView alloc] init];
        
        [tbSelectYear registerNib:[UINib nibWithNibName:@"SelectYearsCell" bundle:nil] forCellReuseIdentifier:@"SelectYearsCell"];
        
        tbSelectYear.separatorStyle = UITableViewCellSelectionStyleNone;
        tbSelectYear.backgroundColor = UIColor.whiteColor;
        tbSelectYear.layer.cornerRadius = 5.0;
        tbSelectYear.layer.borderWidth = 1.0;
        tbSelectYear.layer.borderColor = BORDER_COLOR.CGColor;
        tbSelectYear.delegate = self;
        tbSelectYear.dataSource = self;
        [self.view addSubview: tbSelectYear];
    }
}

#pragma mark - WebserviceUtil Delegate
-(void)failedToGetRenewInfoWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, error)];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];

    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.5];
}

-(void)getRenewInfoForDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, data)];
    [ProgressHUD dismiss];
    [self prepareDataWithInfo: data];
}

-(void)failedToReOrderDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];

    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)reOrderDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [self tryToReloginAgainToUpdateBalance];
}

- (void)tryToReloginAgainToUpdateBalance {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
}

-(void)loginSucessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"Tên miền đã được gia hạn thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"Tên miền đã được gia hạn thành công." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

- (void)prepareDataWithInfo: (id)data {
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        domainInfo = [[NSDictionary alloc] initWithDictionary: data];
        [tbDomain reloadData];
    }else if (data != nil && [data isKindOfClass:[NSArray class]]) {
        if ([(NSArray *)data count] > 0) {
            domainInfo = [[NSDictionary alloc] initWithDictionary: [(NSArray *)data firstObject]];
        }
        [tbDomain reloadData];
    }else{
        [self.view makeToast:@"Lấy thông tin gia hạn thất bại. Vui lòng thử lại sau." duration:2.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.5];
    }
    //  get price for renew domain
    priceForRenew = [self getPriceForRenewDomainWithInfo: domainInfo];
    vat = [self getVATForRenewDomainWithInfo: domainInfo];
    
    [self updateAllPriceForView];
}

- (void)dismissView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (long)getPriceForRenewDomainWithInfo: (NSDictionary *)info {
    if (info == nil) {
        return 0;
    }
    id price = [info objectForKey:@"price"];
    long priceValue = 0;
    if (price != nil && ([price isKindOfClass:[NSString class]] || [price isKindOfClass:[NSNumber class]])) {
        priceValue = (long)[price longLongValue];
    }
    return priceValue;
}

- (float)getVATForRenewDomainWithInfo: (NSDictionary *)info {
    if (info == nil) {
        return 0;
    }
    id vat = [info objectForKey:@"vat"];
    float vatValue = 0;
    if (vat != nil && ([vat isKindOfClass:[NSString class]] || [vat isKindOfClass:[NSNumber class]])) {
        vatValue = [vat floatValue];
    }
    return vatValue;
}

#pragma mark - Alerview Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *title = [alertView buttonTitleAtIndex: buttonIndex];
    if ([title isEqualToString:topup_now]) {
        TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
        [self.navigationController pushViewController: topupVC animated:YES];
    }
}

@end
