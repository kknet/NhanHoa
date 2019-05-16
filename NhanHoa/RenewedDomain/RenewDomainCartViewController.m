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

@interface RenewDomainCartViewController ()<UITableViewDelegate, UITableViewDataSource, OnepayPaymentViewDelegate>

@end

@implementation RenewDomainCartViewController
@synthesize paymentView, tbDomain, lbSepa, viewFooter, lbDomainPrice, lbDomainPriceValue, lbVAT, lbVATValue, lbPromo, lbPromoValue, lbTotalPrice, lbTotalPriceValue, btnContinue, promoView, tbSelectYear;
@synthesize hCell, hPromoView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Gia hạn tên miền";
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self setupUIForView];
    [self addTableViewForSelectYears];
    
    if (paymentView == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"OnepayPaymentView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[OnepayPaymentView class]]) {
                paymentView = (OnepayPaymentView *) currentObject;
                break;
            }
        }
        paymentView.typePayment = renew_domain;
        [self.view addSubview: paymentView];
        paymentView.delegate = self;
        [paymentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(0);
        }];
        [paymentView setupUIForViewWithMenuHeight:0 padding:15.0];
    }
    
    [self updateAllPriceForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [paymentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [paymentView setupUIForViewWithMenuHeight:0 padding:15.0];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)addPromotionView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PromotionCodeView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PromotionCodeView class]]) {
            promoView = (PromotionCodeView *) currentObject;
            break;
        }
    }
    [self.view addSubview: promoView];
    
    hPromoView = 108.0;
    [promoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.lbSepa.mas_bottom).offset(5.0);
        make.height.mas_equalTo(self.hPromoView);
    }];
    [promoView setupUIForView];
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
    
    [self addPromotionView];
    
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
        make.top.equalTo(self.promoView.mas_bottom);
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
    
    //  Promotions
    lbPromo.textColor = TITLE_COLOR;
    lbPromo.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPromo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVAT.mas_bottom);
        make.left.right.equalTo(self.lbVAT);
        make.height.equalTo(self.lbVAT.mas_height);
    }];
    
    lbPromoValue.textColor = lbDomainPrice.textColor;
    lbPromoValue.font = lbDomainPrice.font;
    [lbPromoValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbVATValue);
        make.top.bottom.equalTo(self.lbPromo);
    }];
    
    //  Total price
    lbTotalPrice.textColor = TITLE_COLOR;
    lbTotalPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPromo.mas_bottom);
        make.left.right.equalTo(self.lbPromo);
        make.height.equalTo(self.lbPromo.mas_height);
    }];
    
    lbTotalPriceValue.textColor = NEW_PRICE_COLOR;
    lbTotalPriceValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPromoValue);
        make.top.bottom.equalTo(self.lbTotalPrice);
    }];
}

- (void)updateAllPriceForView {
    //  show price for cart
    lbVATValue.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat:@"28000"]];
    lbDomainPriceValue.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat:@"280000"]];
    lbTotalPriceValue.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat:@"308000"]];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbSelectYear) {
        return 10;
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
        
        NSString *domainName = @"anvatsaigon.com";
        NSString *years = @"1";
        
        cell.lbNum.text = [NSString stringWithFormat:@"%d.", (int)indexPath.row + 1];
        cell.lbName.text = domainName;
        cell.lbPrice.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat: @"280000"]];
        cell.tfYears.text = [NSString stringWithFormat:@"%@ năm", years];
        cell.lbSepa.hidden = TRUE;
        cell.lbDescription.hidden = TRUE;
        cell.btnYears.tag = indexPath.row;
        [cell.btnYears addTarget:self
                          action:@selector(selectYearsForDomain:)
                forControlEvents:UIControlEventTouchUpInside];
        
        //  total price
        cell.lbTotalPrice.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat: @"280000"]];
        
        return cell;
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

- (void)backToPreviousView {
    [self.navigationController popViewControllerAnimated: TRUE];
}

-(void)paymentResultWithInfo:(NSDictionary *)info {
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        if ([vpc_TxnResponseCode isEqualToString: User_cancel_Code]) {
            [self.view makeToast:@"Bạn đã hủy bỏ giao dịch" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            [self performSelector:@selector(backToPreviousView) withObject:nil afterDelay:2.0];
            return;
        }
    }
}

@end
