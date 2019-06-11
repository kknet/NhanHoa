//
//  RenewDomainCartViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RenewDomainCartViewController.h"
#import "CartDomainItemCell.h"
#import "SelectYearsCell.h"
#import "PaymentMethodCell.h"

@interface RenewDomainCartViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate> {
    NSDictionary *domainInfo;
    int yearsForRenew;
    long priceForRenew;
}

@end

@implementation RenewDomainCartViewController
@synthesize tbDomain, lbSepa, viewFooter, lbDomainPrice, lbDomainPriceValue, lbVAT, lbVATValue, lbTotalPrice, lbTotalPriceValue, btnContinue, tbSelectYear;
@synthesize hCell, domain;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Gia hạn tên miền";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"RenewDomainCartViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
    yearsForRenew = 1;
    priceForRenew = 0;
    
    [self setupUIForView];
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
    
}

- (void)confirmPaymentPress {
    
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
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
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
        long total = priceForRenew * yearsForRenew;
        NSString *strTotal = [AppUtils convertStringToCurrencyFormat:[NSString stringWithFormat:@"%ld", total]];
        lbTotalPriceValue.text = [NSString stringWithFormat:@"%@ vnđ", strTotal];
        
        lbVATValue.text = @"0 vnđ";
        
    }else {
        lbVATValue.text = lbDomainPriceValue.text = lbTotalPriceValue.text = @"N/A";
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, error) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    [self.view makeToast:@"Lấy thông tin gia hạn thất bại. Vui lòng thử lại sau." duration:2.5 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self performSelector:@selector(dismissView) withObject:nil afterDelay:2.5];
}

-(void)getRenewInfoForDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, data) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    [self prepareDataWithInfo: data];
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

@end
