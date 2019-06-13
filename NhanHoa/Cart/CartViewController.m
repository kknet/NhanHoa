//
//  CartViewController.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartViewController.h"
#import "PaymentViewController.h"
#import "TopupViewController.h"
#import "CartDomainItemCell.h"
#import "SelectYearsCell.h"
#import "CartModel.h"
#import "AccountModel.h"

@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>{
    float hCell;
    int selectedIndex;
}

@end

@implementation CartViewController

@synthesize viewHeader, icBack, lbHeader, scvContent, viewInfo, lbInfo, lbCount, tbDomains, viewFooter, lbPrice, lbPriceValue, lbVAT, lbVATValue, lbPromo, lbPromoValue, lbTotal, lbTotalValue, btnContinue, btnGoShop, viewEmpty, imgCartEmpty, lbEmpty, tbSelectYear;
@synthesize hInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.title = @"Giỏ hàng";
    [self setupUIForView];
    [self addTableViewForSelectYears];
    
    if ([[CartModel getInstance] countItemInCart] == 0) {
        viewEmpty.hidden = FALSE;
        scvContent.hidden = TRUE;
    }else{
        lbCount.text = [NSString stringWithFormat:@"%d tên miền", [[CartModel getInstance] countItemInCart]];
        viewEmpty.hidden = TRUE;
        scvContent.hidden = FALSE;
    }

    [self updateAllPriceForView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Số tiền hiện tại trong ví của bạn không đủ để thanh toán.\nBạn có muốn nạp tiền ngay?" delegate:self cancelButtonTitle:@"Để sau" otherButtonTitles:topup_now, nil];
    [alert show];
    return;
    
    NSString *strBalance = [AccountModel getCusBalance];
    long totalPrice = [[CartModel getInstance] getTotalDomainPriceForCart];
    
    if ([strBalance longLongValue] >= totalPrice) {
        PaymentViewController *paymentVC = [[PaymentViewController alloc] initWithNibName:@"PaymentViewController" bundle:nil];
        [self.navigationController pushViewController:paymentVC animated:TRUE];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Số tiền hiện tại trong ví của bạn không đủ để thanh toán.\nBạn có muốn nạp tiền ngay?" delegate:self cancelButtonTitle:@"Để sau" otherButtonTitles:topup_now, nil];
        [alert show];
    }
}

- (IBAction)btnGoShopPress:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [[AppDelegate sharedInstance] hideCartView];
}

- (void)rechangeLayoutForView {
    float padding = 15.0;
    
    float hTableView = [[CartModel getInstance] countItemInCart] * hCell;
    [tbDomains mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    //  footer view
    float hFooter = padding + 4*30 + 2*padding + 50 + padding + 50.0 + padding;
    [viewFooter mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.tbDomains.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hFooter);
    }];
}

- (void)updateAllPriceForView {
    [self rechangeLayoutForView];
    
    //  show price for cart
    NSDictionary *priceCartInfo = [[CartModel getInstance] getCartPriceInfo];
    NSNumber *VAT = [priceCartInfo objectForKey:@"VAT"];
    NSNumber *domainPrice = [priceCartInfo objectForKey:@"domain_price"];
    NSNumber *totalPrice = [priceCartInfo objectForKey:@"total_price"];
    
    NSString *feeVAT = [NSString stringWithFormat:@"%ld", [VAT longValue]];
    lbVATValue.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat:feeVAT]];
    
    NSString *strDomainPrice = [NSString stringWithFormat:@"%ld", [domainPrice longValue]];
    lbPriceValue.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat:strDomainPrice]];
    
    NSString *strTotalPrice = [NSString stringWithFormat:@"%ld", [totalPrice longValue]];
    lbTotalValue.text = [NSString stringWithFormat:@"%@đ", [AppUtils convertStringToCurrencyFormat:strTotalPrice]];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float padding = 15.0;
    hInfo = 40.0;
    hCell = 106.0;
    
    //  header view
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewHeader).offset(-10.0);
        make.top.equalTo(self.viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].hNav);
    }];
    
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.icBack);
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.width.mas_equalTo(200.0);
    }];
    
    //  empty view
    
    viewEmpty.hidden = TRUE;
    viewEmpty.clipsToBounds = TRUE;
    [viewEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    [imgCartEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewEmpty.mas_centerX);
        make.centerY.equalTo(self.viewEmpty.mas_centerY).offset(-20.0);
        make.width.height.mas_equalTo(120.0);
    }];
    
    lbEmpty.text = @"Giỏ hàng trống";
    lbEmpty.textColor = [UIColor colorWithRed:(180/255.0) green:(180/255.0)
                                         blue:(180/255.0) alpha:1.0];
    lbEmpty.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [lbEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgCartEmpty.mas_bottom);
        make.left.equalTo(self.viewEmpty).offset(10.0);
        make.right.equalTo(self.viewEmpty).offset(-10.0);
        make.height.mas_equalTo(40.0);
    }];
    
    //  scroll view content
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  view top
    viewInfo.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hInfo);
    }];
    
    lbInfo.font = [UIFont fontWithName:RobotoRegular size:17.0];
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewInfo).offset(padding);
        make.top.bottom.equalTo(self.viewInfo);
        make.right.equalTo(self.viewInfo.mas_centerX);
    }];
    
    lbCount.font = lbInfo.font;
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewInfo).offset(-padding);
        make.top.bottom.equalTo(self.viewInfo);
        make.left.equalTo(self.viewInfo.mas_centerX);
    }];
    
    float hTableView = [[CartModel getInstance] countItemInCart] * hCell;
    tbDomains.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbDomains registerNib:[UINib nibWithNibName:@"CartDomainItemCell" bundle:nil] forCellReuseIdentifier:@"CartDomainItemCell"];
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    //  footer view
    float hFooter = padding + 4*30 + 2*padding + 50 + padding + 50.0 + padding;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.tbDomains.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hFooter);
    }];
    
    //  price
    lbPrice.textColor = TITLE_COLOR;
    lbPrice.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(30.0);
    }];
    
    lbPriceValue.textColor = lbPrice.textColor;
    lbPriceValue.font = lbPrice.font;
    [lbPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewFooter.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(self.lbPrice);
        make.right.equalTo(self.viewFooter).offset(-padding);
    }];
    
    //  VAT
    lbVAT.textColor = TITLE_COLOR;
    lbVAT.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPrice.mas_bottom);
        make.left.right.equalTo(self.lbPrice);
        make.height.equalTo(self.lbPrice.mas_height);
    }];
    
    lbVATValue.textColor = lbPrice.textColor;
    lbVATValue.font = lbPrice.font;
    [lbVATValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPriceValue);
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
    
    lbPromoValue.textColor = lbPrice.textColor;
    lbPromoValue.font = lbPrice.font;
    [lbPromoValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbVATValue);
        make.top.bottom.equalTo(self.lbPromo);
    }];
    
    //  Total price
    lbTotal.textColor = TITLE_COLOR;
    lbTotal.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPromo.mas_bottom);
        make.left.right.equalTo(self.lbPromo);
        make.height.equalTo(self.lbPromo.mas_height);
    }];
    
    lbTotalValue.textColor = NEW_PRICE_COLOR;
    lbTotalValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPromoValue);
        make.top.bottom.equalTo(self.lbTotal);
    }];
    
    btnContinue.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTotalValue.mas_bottom).offset(2*padding);
        make.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    btnGoShop.backgroundColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0];
    btnGoShop.layer.cornerRadius = btnContinue.layer.cornerRadius;
    btnGoShop.titleLabel.font = btnContinue.titleLabel.font;
    [btnGoShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnContinue.mas_bottom).offset(padding);
        make.left.right.equalTo(self.btnContinue);
        make.height.equalTo(self.btnContinue.mas_height);
    }];
    
    self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hInfo+hTableView+hFooter);
}

- (void)removeDomainFromCart: (UIButton *)sender {
    int index = (int)sender.tag;
    if (index < [[CartModel getInstance] countItemInCart]) {
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: index];
        //  remove domain from cart
        [[CartModel getInstance] removeDomainFromCart: domainInfo];
        [[AppDelegate sharedInstance] updateShoppingCartCount];
        
        [tbDomains reloadData];
        [self updateAllPriceForView];
    }
}


#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbSelectYear) {
        return 10;
    }
    return [[CartModel getInstance] countItemInCart];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbSelectYear) {
        SelectYearsCell *cell = (SelectYearsCell *)[tableView dequeueReusableCellWithIdentifier:@"SelectYearsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lbContent.text = [NSString stringWithFormat:@"%d năm", (int)indexPath.row + 1];
        return cell;
        
    }else{
        CartDomainItemCell *cell = (CartDomainItemCell *)[tableView dequeueReusableCellWithIdentifier:@"CartDomainItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
        [cell displayDomainInfoForCart: domainInfo];
        cell.lbNum.text = [NSString stringWithFormat:@"%d.", (int)indexPath.row + 1];
        
        
        cell.lbDescription.hidden = TRUE;
        cell.btnYears.tag = indexPath.row;
        [cell.btnYears addTarget:self
                          action:@selector(selectYearsForDomain:)
                forControlEvents:UIControlEventTouchUpInside];
        
        cell.icRemove.tag = indexPath.row;
        [cell.icRemove addTarget:self
                          action:@selector(removeDomainFromCart:)
                forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbSelectYear) {
        if (selectedIndex < [[CartModel getInstance] countItemInCart]) {
            NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: selectedIndex];
            [domainInfo setObject:[NSString stringWithFormat:@"%d", (int)(indexPath.row+1)] forKey:year_for_domain];
            [tbDomains reloadData];
            [self updateAllPriceForView];
            
            [UIView animateWithDuration:0.15 animations:^{
                self.tbSelectYear.frame = CGRectMake(self.tbSelectYear.frame.origin.x, self.tbSelectYear.frame.origin.y, self.tbSelectYear.frame.size.width, 0);
            }];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbSelectYear) {
        return 38.0;
    }
    return hCell;
}

- (void)selectYearsForDomain: (UIButton *)sender {
    selectedIndex = (int)sender.tag;
    
    CartDomainItemCell *cell = (CartDomainItemCell *)[tbDomains cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    CGRect frame = [tbDomains convertRect:cell.frame toView:scvContent];
    
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
        [self.scvContent addSubview: tbSelectYear];
    }
}

#pragma mark - Alertview Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex: buttonIndex];
    if ([title isEqualToString:topup_now]) {
        TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
        [self.navigationController pushViewController: topupVC animated:YES];
    }
}

@end
