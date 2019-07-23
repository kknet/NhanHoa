//
//  CartViewController.m
//  NhanHoa
//
//  Created by admin on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "CartViewController.h"
#import "AddOrderViewController.h"
#import "TopupViewController.h"
#import "CartDomainItemCell.h"
#import "SelectYearsCell.h"
#import "CartModel.h"
#import "AccountModel.h"

@interface CartViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, WebServiceUtilsDelegate>{
    float hCell;
    float hProtectCell;
    int selectedIndex;
}

@end

@implementation CartViewController

@synthesize scvContent, viewInfo, lbInfo, lbCount, tbDomains, viewFooter, lbPrice, lbPriceValue, lbVAT, lbVATValue, lbTotal, lbTotalValue, btnContinue, btnGoShop, viewEmpty, imgCartEmpty, lbEmpty, tbSelectYear;
@synthesize hInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Giỏ hàng";
    [self.navigationController setNavigationBarHidden: FALSE];
    
    [self addBackBarButtonForNavigationBar];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] loginWithUsername:USERNAME password:PASSWORD];
    
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
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startContinuePress) withObject:nil afterDelay:0.05];
}

- (void)startContinuePress {
    btnContinue.backgroundColor = BLUE_COLOR;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    NSString *strBalance = [AccountModel getCusBalance];
    long totalPrice = [[CartModel getInstance] getTotalPriceForCart];
    
    if ([strBalance longLongValue] >= totalPrice) {
        AddOrderViewController *addOrderVC = [[AddOrderViewController alloc] initWithNibName:@"AddOrderViewController" bundle:nil];
        [self.navigationController pushViewController:addOrderVC animated:TRUE];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Số tiền hiện tại trong ví của bạn không đủ để thanh toán.\nBạn có muốn nạp tiền ngay?" delegate:self cancelButtonTitle:@"Để sau" otherButtonTitles:topup_now, nil];
        [alert show];
    }
}


- (IBAction)btnGoShopPress:(UIButton *)sender {
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:[UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0] forState:UIControlStateNormal];
    [self performSelector:@selector(startContinueShop) withObject:nil afterDelay:0.05];
}

- (void)startContinueShop {
    btnGoShop.backgroundColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0];
    [btnGoShop setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [[AppDelegate sharedInstance] hideCartView];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [[AppDelegate sharedInstance] hideCartView];
}

- (float)getHeightForTableView {
    float hTableView = 0;
    for (int i=0; i<[[CartModel getInstance] countItemInCart]; i++) {
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: i];
        NSString *domainName = [domainInfo objectForKey:@"domain"];
        BOOL isNationalDomain = [AppUtils checkDomainIsNationalDomain: domainName];
        if (isNationalDomain) {
            hTableView += hCell;
        }else{
            hTableView += hProtectCell;
        }
    }
    return hTableView;
}

- (void)rechangeLayoutForView {
    float padding = 15.0;
    
    float hTableView =  [self getHeightForTableView];
    [tbDomains mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    //  footer view
    float hFooter = padding + 3*30 + 2*padding + 45.0 + padding + 45.0 + padding;
    float maxHeightScroll = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    if (self.hInfo + hTableView + hFooter > maxHeightScroll) {
        [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent);
            //  make.top.equalTo(self.tbDomains.mas_bottom);
            make.top.equalTo(self.scvContent).offset(self.hInfo+hTableView);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(hFooter);
        }];
        self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, self.hInfo + hTableView + hFooter);
    }else{
        [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent);
            make.top.equalTo(self.scvContent).offset(maxHeightScroll - hFooter);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(hFooter);
        }];
        self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, maxHeightScroll);
    }
}

- (void)updateAllPriceForView {
    [self rechangeLayoutForView];
    
    //  show price for cart
    NSDictionary *priceCartInfo = [[CartModel getInstance] getCartPriceInfo];
    NSNumber *VAT = [priceCartInfo objectForKey:@"VAT"];
    NSNumber *domainPrice = [priceCartInfo objectForKey:@"domain_price"];
    NSNumber *totalPrice = [priceCartInfo objectForKey:@"total_price"];
    
    NSString *feeVAT = [NSString stringWithFormat:@"%ld", [VAT longValue]];
    lbVATValue.text = [NSString stringWithFormat:@"%@VNĐ", [AppUtils convertStringToCurrencyFormat:feeVAT]];
    
    NSString *strDomainPrice = [NSString stringWithFormat:@"%ld", [domainPrice longValue]];
    lbPriceValue.text = [NSString stringWithFormat:@"%@VNĐ", [AppUtils convertStringToCurrencyFormat:strDomainPrice]];
    
    NSString *strTotalPrice = [NSString stringWithFormat:@"%ld", [totalPrice longValue]];
    lbTotalValue.text = [NSString stringWithFormat:@"%@VNĐ", [AppUtils convertStringToCurrencyFormat:strTotalPrice]];
}

- (void)addBackBarButtonForNavigationBar {
    UIView *viewBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    viewBack.backgroundColor = UIColor.clearColor;
    
    UIButton *btnBack =  [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    btnBack.frame = CGRectMake(-20, 0, 40, 40);
    btnBack.backgroundColor = UIColor.clearColor;
    [btnBack setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(closeCartView) forControlEvents:UIControlEventTouchUpInside];
    [viewBack addSubview: btnBack];
    
    UIBarButtonItem *btnBackBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: viewBack];
    
    self.navigationItem.leftBarButtonItem =  btnBackBarButtonItem;
}

- (void)closeCartView {
    [[AppDelegate sharedInstance] hideCartView];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    float padding = 15.0;
    hInfo = 40.0;
    hCell = 105.0;
    hProtectCell = 175;
    
    //  empty view
    
    viewEmpty.hidden = TRUE;
    viewEmpty.clipsToBounds = TRUE;
    [viewEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    [imgCartEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewEmpty.mas_centerX);
        make.centerY.equalTo(self.viewEmpty.mas_centerY).offset(-20.0);
        make.width.height.mas_equalTo(120.0);
    }];
    
    lbEmpty.text = @"Giỏ hàng trống";
    lbEmpty.textColor = [UIColor colorWithRed:(180/255.0) green:(180/255.0)
                                         blue:(180/255.0) alpha:1.0];
    lbEmpty.font = [AppDelegate sharedInstance].fontBTN;
    [lbEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgCartEmpty.mas_bottom);
        make.left.equalTo(self.viewEmpty).offset(10.0);
        make.right.equalTo(self.viewEmpty).offset(-10.0);
        make.height.mas_equalTo(40.0);
    }];
    
    //  scroll view content
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    //  view top
    viewInfo.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hInfo);
    }];
    
    lbInfo.font = lbCount.font = [AppDelegate sharedInstance].fontRegular;
    [lbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewInfo).offset(padding);
        make.top.bottom.equalTo(self.viewInfo);
        make.right.equalTo(self.viewInfo.mas_centerX);
    }];
    
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewInfo).offset(-padding);
        make.top.bottom.equalTo(self.viewInfo);
        make.left.equalTo(self.viewInfo.mas_centerX);
    }];
    
    float hTableView = [self getHeightForTableView];
    tbDomains.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbDomains registerNib:[UINib nibWithNibName:@"CartDomainItemCell" bundle:nil] forCellReuseIdentifier:@"CartDomainItemCell"];
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    tbDomains.scrollEnabled = FALSE;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    //  footer view
    float hFooter = padding + 3*30 + 2*padding + 45.0 + padding + 45.0 + padding;
    float maxHeightScroll = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    if (self.hInfo + hTableView + hFooter > maxHeightScroll) {
        [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent);
            make.top.equalTo(self.scvContent).offset(self.hInfo+hTableView);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(hFooter);
        }];
    }else{
        [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent);
            make.top.equalTo(self.scvContent).offset(maxHeightScroll - hFooter);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(hFooter);
        }];
    }
    
    //  price
    lbPrice.textColor = lbVAT.textColor = lbVATValue.textColor = lbTotal.textColor = TITLE_COLOR;
    lbPrice.font = lbPriceValue.font = lbVAT.font = lbVATValue.font = [UIFont fontWithName:RobotoRegular size:16.0];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(30.0);
    }];
    
    [lbPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewFooter.mas_centerX).offset(padding/2);
        make.top.bottom.equalTo(self.lbPrice);
        make.right.equalTo(self.viewFooter).offset(-padding);
    }];
    
    //  VAT
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPrice.mas_bottom);
        make.left.right.equalTo(self.lbPrice);
        make.height.equalTo(self.lbPrice.mas_height);
    }];
    
    [lbVATValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPriceValue);
        make.top.bottom.equalTo(self.lbVAT);
    }];
    
    //  Total price
    lbTotal.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbVAT.mas_bottom);
        make.left.right.equalTo(self.lbVAT);
        make.height.equalTo(self.lbVAT.mas_height);
    }];
    
    lbTotalValue.textColor = NEW_PRICE_COLOR;
    lbTotalValue.font = [UIFont fontWithName:RobotoMedium size:16.0];
    [lbTotalValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbVATValue);
        make.top.bottom.equalTo(self.lbTotal);
    }];
    
    btnContinue.layer.cornerRadius = 45.0/2;
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.borderColor = BLUE_COLOR.CGColor;
    btnContinue.layer.borderWidth = 1.0;
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTotalValue.mas_bottom).offset(2*padding);
        make.left.equalTo(self.viewFooter).offset(padding);
        make.right.equalTo(self.viewFooter).offset(-padding);
        make.height.mas_equalTo(45.0);
    }];
    
    btnGoShop.backgroundColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0];
    btnGoShop.layer.borderColor = [UIColor colorWithRed:(84/255.0) green:(99/255.0) blue:(128/255.0) alpha:1.0].CGColor;
    btnGoShop.layer.borderWidth = 1.0;
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
        
        if ([[CartModel getInstance] countItemInCart] > 0) {
            viewEmpty.hidden = TRUE;
            scvContent.hidden = FALSE;
            
            [tbDomains reloadData];
            [self updateAllPriceForView];
            
            lbCount.text = [NSString stringWithFormat:@"%d tên miền", [[CartModel getInstance] countItemInCart]];
        }else{
            viewEmpty.hidden = FALSE;
            scvContent.hidden = TRUE;
        }
        
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
        cell.swProtect.tag = indexPath.row;
        
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
    
    NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
    NSString *domainName = [domainInfo objectForKey:@"domain"];
    BOOL nationDomain = [AppUtils checkDomainIsNationalDomain: domainName];
    if (nationDomain) {
        return hCell;
    }else{
        return hProtectCell;
    }
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
