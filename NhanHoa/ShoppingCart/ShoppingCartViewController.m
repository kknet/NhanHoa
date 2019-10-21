//
//  ShoppingCartViewController.m
//  NhanHoa
//
//  Created by OS on 10/21/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "AddOrderViewController.h"
#import "TopupViewController.h"
#import "CartDomainTbvCell.h"
#import "CartModel.h"
#import "SelectYearsCell.h"
#import "CartMoreInfoView.h"

@interface ShoppingCartViewController ()<UITableViewDelegate, UITableViewDataSource>{
    AppDelegate *appDelegate;
    UIFont *textFont;
    
    float hCell;
    float hProtectCell;
    float padding;
    float hSection;
    float hFooterView;
    
    int selectedIndex;
    UITableView *tbSelectYear;
    CartMoreInfoView *viewMoreInfo;
}
@end

@implementation ShoppingCartViewController
@synthesize viewHeader, icBack, lbHeader, viewEmpty, imgEmpty;
@synthesize scvContent, viewTop, icViewTopBack, lbTopTitle, tbContent, viewPrices, lbTotal, lbTotalMoney, lbVAT, lbVATMoney;
@synthesize viewFooter, lbTotalPayment, lbTotalPaymentMoney, btnProceedToRegister;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
    [self addTableViewForSelectYears];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [self updateAllPriceForView];
    
    [self showContentWithCurrentLanguage];
    
    if ([[CartModel getInstance] countItemInCart] == 0) {
        viewEmpty.hidden = FALSE;
        scvContent.hidden = viewFooter.hidden = TRUE;
    }else{
        if ([[CartModel getInstance] countItemInCart] == 1) {
            lbTopTitle.text = SFM(@"%@: %d %@", [appDelegate.localization localizedStringForKey:@"Cart"], [[CartModel getInstance] countItemInCart], [appDelegate.localization localizedStringForKey:@"item"]);
        }else{
            lbTopTitle.text = SFM(@"%@: %d %@", [appDelegate.localization localizedStringForKey:@"Cart"], [[CartModel getInstance] countItemInCart], [appDelegate.localization localizedStringForKey:@"items"]);
        }
        
        viewEmpty.hidden = TRUE;
        scvContent.hidden = viewFooter.hidden = FALSE;
    }
}

- (void)addMoreViewInfoIfNeed {
    if (viewMoreInfo == nil) {
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"CartMoreInfoView" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[CartMoreInfoView class]]) {
                viewMoreInfo = (CartMoreInfoView *) currentObject;
                break;
            }
        }
        [scvContent addSubview: viewMoreInfo];
    }
    [viewMoreInfo setupUIForView];
    
    [viewMoreInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tbContent.mas_bottom);
        make.left.right.equalTo(tbContent);
        make.height.mas_equalTo(viewMoreInfo.hContentView);
    }];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Shopping cart"];
    
    NSString *imgName = SFM(@"photo_empty_cart_%@", [appDelegate.localization activeLanguage]);
    imgEmpty.image = [UIImage imageNamed: imgName];
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
        [scvContent addSubview: tbSelectYear];
    }
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hNav = self.navigationController.navigationBar.frame.size.height;
    
    hSection = 50.0;
    padding = 15.0;
    float hBTN = 55.0;
    
    float hCellLabel = 25.0;
    float hCellBTN = 40.0;
    
    textFont = [UIFont fontWithName:RobotoRegular size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoRegular size:18.0];
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoRegular size:20.0];
        hBTN = 48.0;
        padding = 15.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        hBTN = 50.0;
    }
    
    hCell = 10 + hCellLabel + hCellLabel + 7.5 + hCellBTN + 10.0;
    hProtectCell = 10 + hCellLabel + hCellLabel + 7.5 + hCellBTN + 10.0 + 1.0 + (hCellBTN + 10.0) + 5.0;
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.left.equalTo(viewHeader);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  empty view
    [viewEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [imgEmpty mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewEmpty.mas_centerX);
        make.centerY.equalTo(viewEmpty.mas_centerY);
        make.width.height.mas_equalTo(SCREEN_WIDTH*2/3);
    }];
    
    //  footer view
    hFooterView = 50.0 + hBTN + padding;
    viewFooter.backgroundColor = UIColor.whiteColor;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hFooterView);
    }];
    
    lbTotalPayment.textColor = GRAY_80;
    lbTotalPayment.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbTotalPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.top.equalTo(viewFooter);
        make.height.mas_equalTo(50.0);
    }];
    
    lbTotalPaymentMoney.textColor = NEW_PRICE_COLOR;
    lbTotalPaymentMoney.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbTotalPaymentMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewFooter).offset(-padding);
        make.top.bottom.equalTo(lbTotalPayment);
    }];
    
    btnProceedToRegister.titleLabel.font = [UIFont fontWithName:RobotoMedium size:lbTotalPaymentMoney.font.pointSize];
    btnProceedToRegister.layer.cornerRadius = 10.0;
    [btnProceedToRegister setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnProceedToRegister.backgroundColor = BLUE_COLOR;
    [btnProceedToRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.bottom.equalTo(viewFooter).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  cart content view
    scvContent.backgroundColor = GRAY_240;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top);
    }];
    
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hStatus + hNav);
    }];
    
    lbTopTitle.textColor = GRAY_80;
    lbTopTitle.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop).offset(hStatus);
        make.left.equalTo(viewTop).offset(40.0 + 10.0);
        make.right.equalTo(viewTop).offset(-padding);
        make.bottom.equalTo(viewTop);
    }];
    
    icViewTopBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icViewTopBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lbTopTitle.mas_centerY);
        make.left.equalTo(viewTop);
        make.width.height.mas_equalTo(40.0);
    }];
    [AppUtils addBoxShadowForView:viewTop color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  setup for tableview
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent registerNib:[UINib nibWithNibName:@"CartDomainTbvCell" bundle:nil] forCellReuseIdentifier:@"CartDomainTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.scrollEnabled = FALSE;
    
    float hTableView = [self getHeightForTableView] + hSection;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom).offset(2.0);
        make.left.right.equalTo(viewTop);
        make.height.mas_equalTo(hTableView);
    }];
    
    [self addMoreViewInfoIfNeed];
    
    //  view prices
    float curHeight = hStatus + hNav + hTableView + viewMoreInfo.hContentView;
    float hPriceView = 70.0;
    
    viewPrices.backgroundColor = viewFooter.backgroundColor;
    if (curHeight + hPriceView > SCREEN_HEIGHT - hFooterView) {
        [viewPrices mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewMoreInfo.mas_bottom);
            make.left.right.equalTo(viewTop);
            make.height.mas_equalTo(hPriceView);
        }];
    }else{
        [viewPrices mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewMoreInfo.mas_bottom).offset(SCREEN_HEIGHT - (hFooterView + curHeight + hPriceView));
            make.left.right.equalTo(viewTop);
            make.height.mas_equalTo(hPriceView);
        }];
    }
    
    [lbTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewPrices).offset(15.0);
        make.left.equalTo(viewPrices).offset(padding);
        make.height.mas_equalTo(25.0);
    }];
    
    [lbTotalMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbTotal);
        make.right.equalTo(viewPrices).offset(-padding);
        make.left.equalTo(lbTotal.mas_right);
    }];
    
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTotal.mas_bottom);
        make.left.equalTo(lbTotal);
        make.height.mas_equalTo(25.0);
    }];
    
    [lbVATMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbVAT);
        make.right.equalTo(lbTotalMoney);
        make.left.equalTo(lbVAT.mas_right);
    }];
    
    lbTotal.textColor = lbTotalMoney.textColor = lbVAT.textColor = lbVATMoney.textColor = GRAY_80;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hStatus + hNav + hTableView + viewMoreInfo.hCollectionView + hPriceView);
}

- (IBAction)icBackClick:(UIButton *)sender {
    [appDelegate hideCartView];
}

- (IBAction)icViewTopBackClick:(UIButton *)sender {
    [appDelegate hideCartView];
}

- (IBAction)btnProceedToRegisterPress:(UIButton *)sender {
    NSString *strBalance = [AccountModel getCusBalance];
    long totalPrice = [[CartModel getInstance] getTotalPriceForCart];
    
    if ([strBalance longLongValue] >= totalPrice) {
        AddOrderViewController *addOrderVC = [[AddOrderViewController alloc] initWithNibName:@"AddOrderViewController" bundle:nil];
        [self.navigationController pushViewController:addOrderVC animated:TRUE];
        
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[appDelegate.localization localizedStringForKey:@"Not enough money to payment"]];
        [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize-2] range:NSMakeRange(0, attrTitle.string.length)];
        [alertVC setValue:attrTitle forKey:@"attributedTitle"];
        
        UIAlertAction *btnLater = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Later"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
        [btnLater setValue:BLUE_COLOR forKey:@"titleTextColor"];
        
        UIAlertAction *btnTopup = [UIAlertAction actionWithTitle:[appDelegate.localization localizedStringForKey:@"Topup now"] style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action){
                                                             TopupViewController *topupVC = [[TopupViewController alloc] initWithNibName:@"TopupViewController" bundle:nil];
                                                             [self.navigationController pushViewController: topupVC animated:YES];
                                                         }];
        [btnTopup setValue:BLUE_COLOR forKey:@"titleTextColor"];
        [alertVC addAction:btnLater];
        [alertVC addAction:btnTopup];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hSection)];
    viewSection.backgroundColor = [UIColor colorWithRed:(238/255.0) green:(238/255.0)
                                                   blue:(238/255.0) alpha:1.0];
    UILabel *lbSection = [[UILabel alloc] init];
    lbSection.text = [appDelegate.localization localizedStringForKey:@"Order's informations"];
    lbSection.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize-1];
    lbSection.textColor = GRAY_80;
    [viewSection addSubview: lbSection];
    [lbSection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewSection).offset(padding);
        make.top.bottom.equalTo(viewSection);
    }];
    
    UIButton *btnBuyMore = [[UIButton alloc] init];
    btnBuyMore.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-1];
    [btnBuyMore setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [btnBuyMore setTitle:[appDelegate.localization localizedStringForKey:@"Buy more"]
                forState:UIControlStateNormal];
    btnBuyMore.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnBuyMore addTarget:self
                   action:@selector(onButtonBuyMorePress)
         forControlEvents:UIControlEventTouchUpInside];
    [viewSection addSubview: btnBuyMore];
    [btnBuyMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewSection).offset(-padding);
        make.top.bottom.equalTo(viewSection);
    }];
    
    return viewSection;
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
        CartDomainTbvCell *cell = (CartDomainTbvCell *)[tableView dequeueReusableCellWithIdentifier:@"CartDomainTbvCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.swWhoIsProtect.tag = indexPath.row;
        
        NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
        [cell displayDomainInfoForCart: domainInfo];
        cell.lbNo.text = SFM(@"%d.", (int)indexPath.row + 1);
        
        cell.btnSelectYear.tag = indexPath.row;
        [cell.btnSelectYear addTarget:self
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
//    if (tableView == tbSelectYear) {
//        if (selectedIndex < [[CartModel getInstance] countItemInCart]) {
//            NSMutableDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: selectedIndex];
//            [domainInfo setObject:[NSString stringWithFormat:@"%d", (int)(indexPath.row+1)] forKey:year_for_domain];
//            [tbDomains reloadData];
//            [self updateAllPriceForView];
//
//            [UIView animateWithDuration:0.15 animations:^{
//                self.tbSelectYear.frame = CGRectMake(self.tbSelectYear.frame.origin.x, self.tbSelectYear.frame.origin.y, self.tbSelectYear.frame.size.width, 0);
//            }];
//        }
//    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (tableView == tbSelectYear) {
//        return 38.0;
//    }
//
    NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
    NSString *domainName = [domainInfo objectForKey:@"domain"];
    BOOL nationDomain = [AppUtils checkDomainIsNationalDomain: domainName];
    if (nationDomain) {
        return hCell;
    }else{
        return hProtectCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hSection;
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
            scvContent.hidden = viewFooter.hidden = FALSE;
            
            [tbContent reloadData];
            [self updateAllPriceForView];
        }else{
            viewEmpty.hidden = FALSE;
            scvContent.hidden = viewFooter.hidden = TRUE;
        }
        
        //  show num items of cart
        if ([[CartModel getInstance] countItemInCart] <= 1) {
            lbTopTitle.text = SFM(@"%@: %d %@", [appDelegate.localization localizedStringForKey:@"Cart"], [[CartModel getInstance] countItemInCart], [appDelegate.localization localizedStringForKey:@"item"]);
        }else{
            lbTopTitle.text = SFM(@"%@: %d %@", [appDelegate.localization localizedStringForKey:@"Cart"], [[CartModel getInstance] countItemInCart], [appDelegate.localization localizedStringForKey:@"items"]);
        }
    }
}

- (void)selectYearsForDomain: (UIButton *)sender {
    selectedIndex = (int)sender.tag;
    
    CartDomainTbvCell *cell = (CartDomainTbvCell *)[tbContent cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    CGRect frame = [tbContent convertRect:cell.frame toView:scvContent];
    
    float newYFrame = frame.origin.y + cell.btnSelectYear.frame.origin.y + cell.btnSelectYear.frame.size.height + 2;
    
    if (tbSelectYear.frame.origin.y == newYFrame) {
        float hTbView = 0;
        if (tbSelectYear.frame.size.height == 0) {
            hTbView = 6*sender.frame.size.height;
        }
        tbSelectYear.hidden = TRUE;
        tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, 0);
        
        tbSelectYear.hidden = FALSE;
        [UIView animateWithDuration:0.15 animations:^{
            tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, hTbView);
        }];
    }else{
        tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, 0);
        
        float hTbView = 6*sender.frame.size.height;
        [UIView animateWithDuration:0.15 animations:^{
            tbSelectYear.frame = CGRectMake(sender.frame.origin.x, newYFrame, sender.frame.size.width, hTbView);
        }];
    }
}

- (void)onButtonBuyMorePress {
    [appDelegate hideCartView];
}

- (void)updateAllPriceForView
{
    //  show price for cart
    NSDictionary *priceCartInfo = [[CartModel getInstance] getCartPriceInfo];
    NSNumber *VAT = [priceCartInfo objectForKey:@"VAT"];
    NSNumber *domainPrice = [priceCartInfo objectForKey:@"domain_price"];
    NSNumber *totalPrice = [priceCartInfo objectForKey:@"total_price"];
    
    NSString *feeVAT = SFM(@"%ld", [VAT longValue]);
    lbVATMoney.text = SFM(@"%@VNĐ", [AppUtils convertStringToCurrencyFormat:feeVAT]);
    
    NSString *strDomainPrice = SFM(@"%ld", [domainPrice longValue]);
    lbTotalMoney.text = SFM(@"%@VNĐ", [AppUtils convertStringToCurrencyFormat:strDomainPrice]);
    
    NSString *strTotalPrice = SFM(@"%ld", [totalPrice longValue]);
    lbTotalPaymentMoney.text = SFM(@"%@VNĐ", [AppUtils convertStringToCurrencyFormat:strTotalPrice]);
}

@end
