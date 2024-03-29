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
    long vatPrice;
    float hSmallCell;
}

@end

@implementation RenewDomainCartViewController
@synthesize tbDomain, lbSepa, viewFooter, lbDomainPrice, lbDomainPriceValue, lbVAT, lbVATValue, lbTotalPrice, lbTotalPriceValue, btnContinue, tbSelectYear;
@synthesize hCell, domain, cus_id, ord_id, yearsForRenew;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_renew_domains;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"RenewDomainCartViewController"];
    
    yearsForRenew = 1;
    priceForRenew = 0;
    
    [self addTableViewForSelectYears];
    
    [self updateAllPriceForView];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy thông tin..." Interaction:NO];
    [tbDomain reloadData];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getRenewInfoForDomain: domain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    //  close table view
    [UIView animateWithDuration:0.15 animations:^{
        tbSelectYear.frame = CGRectMake(tbSelectYear.frame.origin.x, tbSelectYear.frame.origin.y, tbSelectYear.frame.size.width, 0);
    }];
    
    long totalPrice = [self getTotalPriceForPayment];
    if (totalPrice > 0) {
        NSString *strBalance = [AccountModel getCusBalance];
        if ([strBalance longLongValue] >= totalPrice) {
            if (![AppUtils isNullOrEmpty: domain] && ![AppUtils isNullOrEmpty: cus_id] && ![AppUtils isNullOrEmpty: ord_id])
            {
                [self confirmRenewOrderView];
            }else{
                [self.view makeToast:text_data_is_invalid duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            }
        }else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:text_not_enough_money_to_renewals];
            [attrTitle addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:NSMakeRange(0, attrTitle.string.length)];
            [alertVC setValue:attrTitle forKey:@"attributedTitle"];
            
            UIAlertAction *btnLater = [UIAlertAction actionWithTitle:text_later style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action){}];
            [btnLater setValue:BLUE_COLOR forKey:@"titleTextColor"];
            
            UIAlertAction *btnTopup = [UIAlertAction actionWithTitle:topup_now style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction *action){
                                                                   TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
                                                                   [self.navigationController pushViewController: topupVC animated:YES];
                                                               }];
            [btnTopup setValue:UIColor.redColor forKey:@"titleTextColor"];
            [alertVC addAction:btnLater];
            [alertVC addAction:btnTopup];
            [self presentViewController:alertVC animated:YES completion:nil];
        }
    }else{
        [self.view makeToast:text_data_is_invalid duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

- (void)confirmRenewOrderView {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:text_do_you_want_to_renewals_this_domain];
    [attrTitle addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         
                                                     }];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnRenew = [UIAlertAction actionWithTitle:text_renewals style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action){
                                                         [ProgressHUD backgroundColor: ProgressHUD_BG];
                                                         [ProgressHUD show:text_processing Interaction:FALSE];
                                                         
                                                         [WebServiceUtils getInstance].delegate = self;
                                                         [[WebServiceUtils getInstance] renewOrderForDomain:self.domain contactId:self.cus_id ord_id:self.ord_id years:self.yearsForRenew];
                                                     }];
    [btnRenew setValue:BLUE_COLOR forKey:@"titleTextColor"];
    
    [alertVC addAction:btnClose];
    [alertVC addAction:btnRenew];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hLabel = 30.0;
    float hIcon = 38.0;
    float hBTN = 45.0;
    hSmallCell = 38.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hLabel = 40.0;
        hIcon = 45.0;
        hBTN = 55.0;
        hSmallCell = 50.0;
    }
    hCell = (hLabel + hLabel + hIcon + 10.0);
    
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
        make.top.equalTo(tbDomain.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(1.0);
    }];
    
    //  continue button
    btnContinue.layer.cornerRadius = hBTN/2;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnContinue setTitle:text_proceed_renewals forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.bottom.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  footer view
    float hFooter = padding + 3*hLabel + padding;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(lbSepa.mas_bottom);
        make.height.mas_equalTo(hFooter);
    }];
    
    //  price
    lbDomainPrice.textColor = lbDomainPriceValue.textColor = lbVAT.textColor = lbVATValue.textColor = lbTotalPrice.textColor = TITLE_COLOR;
    lbTotalPriceValue.textColor = NEW_PRICE_COLOR;
    lbDomainPrice.font = lbDomainPriceValue.font = lbVAT.font = lbVATValue.font = [AppDelegate sharedInstance].fontRegular;
    lbTotalPrice.font = lbTotalPriceValue.font = [AppDelegate sharedInstance].fontMedium;
    
    lbDomainPrice.text = text_total;
    [lbDomainPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hLabel);
    }];
    
    [lbDomainPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(lbDomainPrice);
        make.right.equalTo(viewFooter).offset(-padding);
    }];
    
    //  VAT
    lbVAT.text = text_VAT;
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomainPrice.mas_bottom);
        make.left.right.equalTo(lbDomainPrice);
        make.height.equalTo(lbDomainPrice.mas_height);
    }];
    
    [lbVATValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainPriceValue);
        make.top.bottom.equalTo(lbVAT);
    }];
    
    //  Total price
    lbTotalPrice.text = text_total_payment;
    [lbTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVAT.mas_bottom);
        make.left.right.equalTo(lbVAT);
        make.height.equalTo(lbVAT.mas_height);
    }];
    
    [lbTotalPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbVATValue);
        make.top.bottom.equalTo(lbTotalPrice);
    }];
}

- (void)updateAllPriceForView {
    if (priceForRenew > 0 && yearsForRenew > 0) {
        long domainPrice = priceForRenew * yearsForRenew;
        NSString *strDomainPrice = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", domainPrice]];
        lbDomainPriceValue.text = [NSString stringWithFormat:@"%@VNĐ", strDomainPrice];
        
        long totalVAT = vatPrice * yearsForRenew;
        NSString *strVAT = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", totalVAT]];
        lbVATValue.text = [NSString stringWithFormat:@"%@VNĐ", strVAT];
        
        long total = domainPrice + totalVAT;
        NSString *strTotal = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", total]];
        lbTotalPriceValue.text = [NSString stringWithFormat:@"%@VNĐ", strTotal];
        
    }else {
        lbVATValue.text = lbDomainPriceValue.text = lbTotalPriceValue.text = @"N/A";
    }
}

- (long)getTotalPriceForPayment {
    if (priceForRenew > 0 && yearsForRenew > 0) {
        long domainPrice = priceForRenew * yearsForRenew;
        long vatValue = vatPrice*yearsForRenew;
        
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
        cell.lbContent.text = SFM(@"%d %@", (int)indexPath.row + 1, text_year);
        return cell;
        
    }else{
        CartDomainItemCell *cell = (CartDomainItemCell *)[tableView dequeueReusableCellWithIdentifier:@"CartDomainItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.protectView.hidden = TRUE;
        
        NSString *domainName = domain;
        
        cell.lbNum.text = SFM(@"%d.", (int)indexPath.row + 1);
        cell.lbName.text = domainName;
        cell.tfYears.text = SFM(@"%d %@", yearsForRenew, text_year);
        
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
            tbSelectYear.frame = CGRectMake(tbSelectYear.frame.origin.x, tbSelectYear.frame.origin.y, tbSelectYear.frame.size.width, 0);
        }];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbSelectYear) {
        return hSmallCell;
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
            if (IS_IPHONE || IS_IPOD) {
                hTbView = 6*hSmallCell;
            }else{
                hTbView = MAX_YEAR_FOR_RENEW*hSmallCell;
            }
        }
        tbSelectYear.hidden = TRUE;
        tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, 0);
        
        tbSelectYear.hidden = FALSE;
        [UIView animateWithDuration:0.15 animations:^{
            tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, hTbView);
        }];
    }else{
        tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, 0);
        
        float hTbView;
        if (IS_IPHONE || IS_IPOD) {
            hTbView = 6*hSmallCell;
        }else{
            hTbView = MAX_YEAR_FOR_RENEW*hSmallCell;
        }
        
        [UIView animateWithDuration:0.15 animations:^{
            tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, hTbView);
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
    [ProgressHUD dismiss];
    [self.view makeToast:text_your_domain_was_renewed_successfully duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.0];
}

-(void)failedToLoginWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:text_your_domain_was_renewed_successfully duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].successStyle];
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
        [self.view makeToast:text_can_not_get_renewal_informations duration:2.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.5];
    }
    //  get price for renew domain
    priceForRenew = [self getPriceForRenewDomainWithInfo: domainInfo];
    vatPrice = [self getVATForRenewDomainWithInfo: domainInfo];
    
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
    id vat = [info objectForKey:@"price_vat"];
    float vatValue = 0;
    if (vat != nil && ([vat isKindOfClass:[NSString class]] || [vat isKindOfClass:[NSNumber class]])) {
        vatValue = [vat floatValue];
    }
    return vatValue;
}

@end
