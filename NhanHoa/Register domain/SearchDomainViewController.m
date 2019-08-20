//
//  SearchDomainViewController.m
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchDomainViewController.h"
#import "CartViewController.h"
#import "DomainCell.h"
#import "AccountModel.h"
#import "DomainModel.h"
#import "DomainDescriptionPoupView.h"
#import "WhoisDomainPopupView.h"
#import "CartModel.h"

@interface SearchDomainViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, WebServiceUtilsDelegate, UITextFieldDelegate>{
    NSDictionary *firstDomainInfo;
    float hCell;
    float hSmallCell;
    
    float padding;
    float hTableView;
    float hSearch;
    float hResultView;
    float hContent;
    float hTitle;
    float marginX;
}

@end

@implementation SearchDomainViewController

@synthesize viewHeader, icBack, lbTitle;
@synthesize scvContent, lbTop, lbWWW, tfSearch, icSearch, viewResult, imgEmoji, lbSearchContent, viewDomain, lbDomainName, lbPrice, btnChoose, btnContinue;
@synthesize lbSepaView, lbRelationDomain, tbDomains, lbTopTitle, lbBottomTitle;
@synthesize strSearch, listDomains;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
    [WriteLogsUtils writeForGoToScreen: @"SearchDomainViewController"];
    [self registerObservers];
    tfSearch.text = strSearch;
    
    [self startSearchDomainValue];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden: NO];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    firstDomainInfo = nil;
}

- (IBAction)icCartClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [[AppDelegate sharedInstance] showCartScreenContent];
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icSearchClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    [self.view endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfSearch.text]) {
        [self.view makeToast:text_enter_domains_to_check duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    strSearch = tfSearch.text;
    [self startSearchDomainValue];
}

- (void)startSearchDomainValue {
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_checking_please_wait Interaction:NO];
    [self hideUIForSearch: TRUE];
    
    firstDomainInfo = nil;
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] searchDomainWithName:strSearch type:0];
}

- (IBAction)btnChoosePress:(UIButton *)sender {
    if (firstDomainInfo != nil) {
        BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: firstDomainInfo];
        if (exists) {
            //  remove domain from cart
            [[CartModel getInstance] removeDomainFromCart: firstDomainInfo];
            
            //  change button title
            [sender setTitle:text_select forState:UIControlStateNormal];
            sender.backgroundColor = BLUE_COLOR;
            
        }else{
            //  add domain to cart
            [[CartModel getInstance] addDomainToCart: firstDomainInfo];
            
            //  change button title
            [sender setTitle:text_unselect forState:UIControlStateNormal];
            sender.backgroundColor = NEW_PRICE_COLOR;
        }
        [[AppDelegate sharedInstance] updateShoppingCartCount];
        [self updateLayoutForChooseMainDomain: sender];
    }
    
    [self checkToEnableContinueButton];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [[AppDelegate sharedInstance] showCartScreenContent];
}

- (void)updateLayoutForChooseMainDomain: (UIButton *)sender {
    float sizeText = [AppUtils getSizeWithText:sender.currentTitle withFont:sender.titleLabel.font].width + 20.0;
    if (sizeText < 60.0) {
        sizeText = 60.0;
    }
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewDomain).offset(-marginX);
        make.centerY.equalTo(viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(sizeText);
    }];
}

- (void)hideUIForSearch: (BOOL)hide {
    viewResult.hidden = lbSepaView.hidden = lbRelationDomain.hidden = tbDomains.hidden = hide;
}

- (void)reUpdateLayoutForView {
    float hResult = hResultView;
    if (firstDomainInfo == nil) {
        hResult = hResultView - (hContent + hTitle + 15.0 + 15.0);
    }
    [viewResult mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvContent);
        make.top.equalTo(tfSearch.mas_bottom).offset(15.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hResult);
    }];
    
    [lbSepaView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewResult.mas_bottom).offset(5.0);
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(1.0);
    }];
    
    //  layout for choose button
    [self updateLayoutForChooseMainDomain: btnChoose];
    
    //  get height of tableview
    hTableView = [self getHeightTableView];
    [tbDomains mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRelationDomain.mas_bottom);
        make.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    float contentHeight = hSearch + 15.0 + hResult + padding + 1.0 + padding + hTableView + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hSearch + contentHeight);
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView)
                                                 name:@"afterAddOrderSuccessfully" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadChoosedDomainList)
                                                 name:@"reloadChoosedDomainList" object:nil];
}

- (void)popToRootView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [self.navigationController popToRootViewControllerAnimated: TRUE];
}

- (void)setupUIForView {
    self.view.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    
    padding = 15.0;
    hCell = 80.0;
    hSmallCell = 65.0;
    hSearch = 38.0;
    float paddingSearch = 1.0;
    float hEmoji = 45.0;
    hTitle = 20.0;
    marginX = 15.0;
    float hBTN = 45.0;
    hContent = 65.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hSearch = 50.0;
        paddingSearch = 2.0;
        hEmoji = 70.0;
        hTitle = 30.0;
        hCell = 100;
        hContent = 80.0;
        hBTN = 55.0;
    }
    
    //  header view
    float hHeader = [AppDelegate sharedInstance].hStatusBar + 50.0;
    viewHeader.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0];
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontBTN;
    lbTitle.text = text_search_domains;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.top.equalTo(self.viewHeader).offset([UIApplication sharedApplication].statusBarFrame.size.height);
        make.bottom.equalTo(self.viewHeader);
        make.width.mas_equalTo(200.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewHeader).offset(-5.0);
        make.centerY.equalTo(self.lbTitle.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [self checkToEnableContinueButton];
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnContinue.layer.cornerRadius = hBTN/2;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue setTitle:text_continue forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.bottom.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    scvContent.backgroundColor = UIColor.clearColor;
    scvContent.delegate = self;
    scvContent.showsVerticalScrollIndicator = FALSE;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(btnContinue.mas_top).offset(-padding);
        make.top.equalTo(viewHeader.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    lbTop.backgroundColor = viewHeader.backgroundColor;
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hSearch/2);
    }];
    
    float sizeText = [AppUtils getSizeWithText:lbWWW.text withFont:[AppDelegate sharedInstance].fontMedium].width + 5.0;
    
    tfSearch.font = [AppDelegate sharedInstance].fontMedium;
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.layer.cornerRadius = hSearch/2;
    tfSearch.layer.borderColor = [UIColor colorWithRed:(86/255.0) green:(149/255.0) blue:(228/255.0) alpha:1.0].CGColor;
    tfSearch.layer.borderWidth = 1.5;
    tfSearch.placeholder = text_enter_domain_name;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.top.equalTo(scvContent);
        make.height.mas_equalTo(hSearch);
    }];
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sizeText + 5.0, hSearch)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    icSearch.layer.cornerRadius = (hSearch-2*paddingSearch)/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfSearch).offset(paddingSearch);
        make.right.bottom.equalTo(tfSearch).offset(-paddingSearch);
        make.width.mas_equalTo(hSearch-2*paddingSearch);
    }];
    
    lbWWW.textColor = BLUE_COLOR;
    lbWWW.font = [AppDelegate sharedInstance].fontMedium;
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(5.0);
        make.top.bottom.equalTo(tfSearch);
        make.width.mas_equalTo(sizeText);
    }];
    
    //  search result view
    hResultView = hEmoji + 5.0 + hTitle + (hTitle + 10.0) + hTitle + 15.0 + hContent + 15.0;
    
    [viewResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvContent);
        make.top.equalTo(tfSearch.mas_bottom).offset(15.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hResultView);
    }];
    
    [imgEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewResult);
        make.centerX.equalTo(viewResult.mas_centerX);
        make.width.height.mas_equalTo(hEmoji);
    }];
    
    lbTopTitle.textColor = lbBottomTitle.textColor = TITLE_COLOR;
    lbTopTitle.font = lbBottomTitle.font = [AppDelegate sharedInstance].fontRegular;
    
    lbTopTitle.text = text_can_use_domains;
    [lbTopTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgEmoji.mas_bottom).offset(5.0);
        make.left.equalTo(viewResult).offset(5.0);
        make.right.equalTo(viewResult).offset(-5.0);
        make.height.mas_equalTo(hTitle);
    }];
    
    lbSearchContent.font = [AppDelegate sharedInstance].fontMedium;
    lbSearchContent.textColor = BLUE_COLOR;
    [lbSearchContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTopTitle.mas_bottom);
        make.left.right.equalTo(lbTopTitle);
        make.height.mas_equalTo(hTitle+10.0);
    }];
    
    lbBottomTitle.text = text_register_to_protect_brand;
    [lbBottomTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSearchContent.mas_bottom);
        make.left.right.equalTo(lbTopTitle);
        make.height.mas_equalTo(hTitle);
    }];
    
    viewDomain.layer.cornerRadius = 7.0;
    viewDomain.layer.borderWidth = 1.0;
    viewDomain.layer.borderColor = [UIColor colorWithRed:(250/255.0) green:(157/255.0) blue:(26/255.0) alpha:1.0].CGColor;
    [viewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBottomTitle.mas_bottom).offset(15.0);
        make.left.equalTo(self.viewResult).offset(padding);
        make.right.equalTo(self.viewResult).offset(-padding);
        make.height.mas_equalTo(hContent);
    }];
    
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    btnChoose.backgroundColor = BLUE_COLOR;
    btnChoose.layer.cornerRadius = 36.0/2;
    float sizeBTN = [AppUtils getSizeWithText:btnChoose.currentTitle withFont:btnChoose.titleLabel.font].width + 20.0;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewDomain).offset(-marginX);
        make.centerY.equalTo(viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(sizeBTN);
    }];
    
    lbDomainName.text = @"";
    lbDomainName.font = [AppDelegate sharedInstance].fontBold;
    lbDomainName.textColor = BLUE_COLOR;
    [lbDomainName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewDomain).offset(marginX);
        make.bottom.equalTo(viewDomain.mas_centerY).offset(-2.0);
        make.right.equalTo(btnChoose.mas_left).offset(-marginX);
    }];
    
    lbPrice.text = @"";
    lbPrice.font = [AppDelegate sharedInstance].fontMedium;
    lbPrice.textColor = NEW_PRICE_COLOR;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbDomainName);
        make.top.equalTo(viewDomain.mas_centerY).offset(2.0);
    }];
    
    lbSepaView.backgroundColor = GRAY_220;
    [lbSepaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewResult.mas_bottom).offset(5.0);
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(1.0);
    }];
    
    lbRelationDomain.font = [AppDelegate sharedInstance].fontMedium;
    lbRelationDomain.text = text_related_domains;
    [lbRelationDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepaView.mas_bottom).offset(10.0);
        make.left.equalTo(scvContent).offset(padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*padding);
        make.height.mas_equalTo(40.0);
    }];
    
    tbDomains.scrollEnabled = FALSE;
    tbDomains.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbDomains registerNib:[UINib nibWithNibName:@"DomainCell" bundle:nil] forCellReuseIdentifier:@"DomainCell"];
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRelationDomain.mas_bottom);
        make.left.bottom.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)prepareDataToDisplay {
    if (listDomains.count > 0) {
        //  Lưu domain available khác nếu không tìm thấy domain hiện tại
        NSDictionary *tmpAvailable;
        
        for (int index=0; index<listDomains.count; index++)
        {
            NSDictionary *info = [listDomains objectAtIndex: index];
            id available = [info objectForKey:@"available"];
            
            if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == TRUE || [available boolValue] == 1)
            {
                NSString *domain = [info objectForKey:@"domain"];
                if ([strSearch isEqualToString: domain]) {
                    firstDomainInfo = [[NSDictionary alloc] initWithDictionary: info];
                    break;
                }
                if (tmpAvailable == nil) {
                    tmpAvailable = info;
                }
            }else if ([available isKindOfClass:[NSString class]] && [available isEqualToString:@"1"])
            {
                NSString *domain = [info objectForKey:@"domain"];
                if ([strSearch isEqualToString: domain]) {
                    firstDomainInfo = [[NSDictionary alloc] initWithDictionary: info];
                    break;
                }
                if (tmpAvailable == nil) {
                    tmpAvailable = info;
                }
                break;
            }
        }
        
        [self hideUIForSearch: FALSE];
        
        if (firstDomainInfo == nil && tmpAvailable != nil) {
            firstDomainInfo = [[NSDictionary alloc] initWithDictionary: tmpAvailable];
        }
        
        if (firstDomainInfo != nil) {
            [listDomains removeObject: firstDomainInfo];
            
            NSString *firstDomain = [firstDomainInfo objectForKey:@"domain"];
            
            lbTopTitle.text = text_can_use_domains;
            lbSearchContent.text = firstDomain;
            lbBottomTitle.text = text_register_to_protect_brand;
            
            lbDomainName.text = firstDomain;
            NSString *price = [DomainModel getPriceFromDomainInfo: firstDomainInfo];
            if (![AppUtils isNullOrEmpty: price]) {
                NSString *strPrice = [AppUtils convertStringToCurrencyFormat: price];
                lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", strPrice];
            }
            
            if ([[CartModel getInstance] checkCurrentDomainExistsInCart: firstDomainInfo]) {
                btnChoose.backgroundColor = NEW_PRICE_COLOR;
                [btnChoose setTitle:text_unselect forState:UIControlStateNormal];
                
            }else{
                btnChoose.backgroundColor = BLUE_COLOR;
                [btnChoose setTitle:text_select forState:UIControlStateNormal];
            }
            viewDomain.hidden = FALSE;
            imgEmoji.image = [UIImage imageNamed:@"search_smile"];
            
        }else{
            lbTopTitle.text = text_cannot_use_domains;
            lbSearchContent.text = strSearch;
            lbBottomTitle.text = @"";
            
            viewDomain.hidden = TRUE;
            imgEmoji.image = [UIImage imageNamed:@"search_sad"];
        }
        
        [self reUpdateLayoutForView];
        [tbDomains reloadData];
    }
}

- (float)getHeightTableView {
    float hTableView = 0;
    
    for (int index=0; index<listDomains.count; index++) {
        NSDictionary *info = [listDomains objectAtIndex: index];
        id available = [info objectForKey:@"available"];
        if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
        {
            hTableView+= hCell;
        }else{
            hTableView+= hSmallCell;
        }
    }
    return hTableView;
}

- (void)reloadChoosedDomainList {
    [self prepareDataToDisplay];
}

#pragma mark - WebServicesUtilDelegate
-(void)failedToSearchDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSArray class]]) {
        listDomains = [[NSMutableArray alloc] initWithArray: (NSArray *)data];
        [self prepareDataToDisplay];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listDomains.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DomainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listDomains objectAtIndex: indexPath.row];
    NSString *domain = [info objectForKey: @"domain"];
    
    cell.lbDomain.text = domain;
    //  check available domain
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        if ([[CartModel getInstance] checkCurrentDomainExistsInCart: info]) {
            [cell.btnChoose setTitle:text_unselect forState:UIControlStateNormal];
            cell.btnChoose.backgroundColor = NEW_PRICE_COLOR;
        }else{
            [cell.btnChoose setTitle:text_select forState:UIControlStateNormal];
            cell.btnChoose.backgroundColor = BLUE_COLOR;
        }
        
        NSString *price = [DomainModel getPriceFromDomainInfo: info];
        if (![AppUtils isNullOrEmpty: price]) {
            price = [AppUtils convertStringToCurrencyFormat: price];
            cell.lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", price];
        }else{
            cell.lbPrice.text = text_contact_price;
        }
        [cell showPriceForDomainCell: TRUE];
        cell.btnChoose.enabled = TRUE;
        
        //  check flag
        id flag = [info objectForKey:@"flag"];
        if (([flag isKindOfClass:[NSNumber class]] && [flag intValue] == 1) || [flag boolValue] == 1)
        {
            cell.btnWarning.hidden = FALSE;
            [cell.btnWarning addTarget:self
                                action:@selector(showDescriptionForCurrentDomain)
                      forControlEvents:UIControlEventTouchUpInside];
            
        }else{
            cell.btnWarning.hidden = TRUE;
        }
        
        cell.btnChoose.tag = indexPath.row;
        
        [cell.btnChoose removeTarget:self
                           action:@selector(viewInfoOfDomain:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnChoose addTarget:self
                           action:@selector(chooseThisDomain:)
                 forControlEvents:UIControlEventTouchUpInside];
        
    }else if (available != nil && [available isKindOfClass:[NSString class]] && [available isEqualToString:@"not support"]){
        cell.btnWarning.hidden = TRUE;
        [cell.btnChoose setTitle:not_support_yet forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = OLD_PRICE_COLOR;
        cell.btnChoose.enabled = FALSE;
        
        [cell showPriceForDomainCell: FALSE];
    }else{
        cell.btnChoose.enabled = TRUE;
        [cell.btnChoose setTitle:text_view_info forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = ORANGE_COLOR;
        cell.lbPrice.text = @"";
        
        
        [cell showPriceForDomainCell: FALSE];
        
        cell.btnWarning.hidden = TRUE;
        
        cell.btnChoose.tag = indexPath.row;
        
        [cell.btnChoose removeTarget:self
                              action:@selector(chooseThisDomain:)
                    forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btnChoose addTarget:self
                           action:@selector(viewInfoOfDomain:)
                 forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    //[cell addBoxShadowForView:cell.parentView withColor:UIColor.blackColor];
    
    return cell;
}

- (void)chooseThisDomain: (UIButton *)sender {
    int index = (int)sender.tag;
    if (index < listDomains.count) {
        NSDictionary *infoDomain = [listDomains objectAtIndex: index];
        if (infoDomain != nil) {
            id available = [infoDomain objectForKey:@"available"];
            if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 0) || [available boolValue] == 0)
            {
                return;
            }
            
            BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: infoDomain];
            if (exists) {
                [[CartModel getInstance] removeDomainFromCart: infoDomain];
                
            }else{
                [[CartModel getInstance] addDomainToCart: infoDomain];
            }
            [[AppDelegate sharedInstance] updateShoppingCartCount];
            [tbDomains reloadData];
        }
    }
    
    [self checkToEnableContinueButton];
}

- (void)checkToEnableContinueButton {
    if ([[CartModel getInstance] countItemInCart] > 0) {
        btnContinue.enabled = TRUE;
        btnContinue.backgroundColor = BLUE_COLOR;
    }else{
        btnContinue.enabled = FALSE;
        btnContinue.backgroundColor = OLD_PRICE_COLOR;
    }
}

- (void)showDescriptionForCurrentDomain
{
    NSString *content = @"Lưu ý: Trong một số trường hợp, các tên miền gắn liền với tên thương hiệu riêng đã bảo hộ hoặc thương hiệu nổi tiếng hoặc các tên miền đang đấu giá, chính sách giá sẽ được căn cứ theo giá thực tế trong hệ thống tại thời điểm đăng ký (không theo CTKM). Khi đó, bộ phận kinh doanh của chúng tôi sẽ thông báo lại Quý khách.";
    
    float sizeContent = [AppUtils getSizeWithText:content withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(280-30.0)].height;
    float hPopup = 40.0 + sizeContent + 5.0 + 15.0;
    
    DomainDescriptionPoupView *popupView = [[DomainDescriptionPoupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, (SCREEN_HEIGHT - hPopup)/2, 300, hPopup)];
    popupView.lbContent.text = content;
    [popupView showInView:self.view animated:TRUE];
    [AppUtils addBoxShadowForView:popupView withColor:UIColor.whiteColor];
}

- (void)viewInfoOfDomain: (UIButton *)sender {
    NSDictionary *info = [listDomains objectAtIndex: sender.tag];
    NSString *domain = [info objectForKey:@"domain"];
    
    float maxSize = (SCREEN_WIDTH - 4*padding)/2 + 35.0;
    
    float hPopup = [AppUtils getHeightOfWhoIsDomainViewWithContent:@"" font:[AppDelegate sharedInstance].fontRegular heightItem:28.0 maxSize:maxSize];
    float wPopup = (SCREEN_WIDTH-10.0);
    WhoisDomainPopupView *popupView = [[WhoisDomainPopupView alloc] initWithFrame:CGRectMake(5.0, (SCREEN_HEIGHT - hPopup)/2, wPopup, hPopup)];
    popupView.domain = domain;
    [popupView showInView:self.view animated:TRUE];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = [listDomains objectAtIndex: indexPath.row];
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        return hCell;
    }else{
        return hSmallCell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
    }
    return TRUE;
}

@end
