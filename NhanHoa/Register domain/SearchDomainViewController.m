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
}

@end

@implementation SearchDomainViewController

@synthesize viewHeader, icBack, lbTitle;
@synthesize scvContent, lbTop, lbWWW, tfSearch, icSearch, viewResult, imgEmoji, lbSearchContent, viewDomain, lbDomainName, lbPrice, lbOldPrice, lbSepa, btnChoose, btnContinue;
@synthesize lbSepaView, lbRelationDomain, tbDomains;
@synthesize padding, strSearch, listDomains, hTableView, hSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: TRUE];
    
    [WriteLogsUtils writeForGoToScreen: @"SearchDomainViewController"];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang kiểm tra. Vui lòng chờ trong giây lát..." Interaction:NO];
    
    tfSearch.text = strSearch;
    [self hideUIForSearch: TRUE];
    
    [self registerObservers];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] searchDomainWithName:strSearch type:0];
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
        [self.view makeToast:@"Vui lòng nhập tên miền muốn kiểm tra!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    firstDomainInfo = nil;
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang kiểm tra. Vui lòng chờ trong giây lát..." Interaction:NO];
    
    strSearch = tfSearch.text;
    [self hideUIForSearch: TRUE];
    
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
            [sender setTitle:@"Chọn" forState:UIControlStateNormal];
            sender.backgroundColor = BLUE_COLOR;
            
        }else{
            //  add domain to cart
            [[CartModel getInstance] addDomainToCart: firstDomainInfo];
            
            //  change button title
            [sender setTitle:@"Bỏ chọn" forState:UIControlStateNormal];
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
    float sizeText = [AppUtils getSizeWithText:sender.currentTitle withFont:sender.titleLabel.font].width + 15;
    if (sizeText < 60.0) {
        sizeText = 60.0;
    }
    [btnChoose mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewDomain).offset(-self.padding);
        make.centerY.equalTo(self.viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(sizeText);
    }];
}

- (void)hideUIForSearch: (BOOL)hide {
    viewResult.hidden = lbSepaView.hidden = lbRelationDomain.hidden = tbDomains.hidden = hide;
}

- (void)reUpdateLayoutForView {
    float hResult;
    if (firstDomainInfo == nil) {
        hResult = 100.0;
    }else{
        hResult = 220.0;
    }
    
    [viewResult mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.tfSearch.mas_bottom).offset(30.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hResult);
    }];
    
    //  layout for choose button
    [self updateLayoutForChooseMainDomain: btnChoose];
    
    //  get height of tableview
    hTableView = [self getHeightTableView];
    [tbDomains mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepaView.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hTableView);
    }];
    
    float contentHeight = hSearch + 30.0 + hResult + padding + 1.0 + padding + hTableView + padding;
    self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hSearch + contentHeight);
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView)
                                                 name:@"afterAddOrderSuccessfully" object:nil];
}

- (void)popToRootView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [self.navigationController popToRootViewControllerAnimated: TRUE];
}

- (void)setupUIForView {
    padding = 15.0;
    hCell = 80.0;
    hSmallCell = 65.0;
    
    //  header view
    float hHeader = [UIApplication sharedApplication].statusBarFrame.size.height + 50.0;
    viewHeader.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0];
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    lbTitle.font = [AppDelegate sharedInstance].fontBTN;
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
    btnContinue.layer.cornerRadius = 45.0/2;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(self.padding);
        make.right.bottom.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(45.0);
    }];
    
    scvContent.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.btnContinue.mas_top).offset(-self.padding);
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    hSearch = 38.0;
    
    lbTop.backgroundColor = viewHeader.backgroundColor;
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hSearch/2);
    }];
    
    tfSearch.font = [AppDelegate sharedInstance].fontMedium;
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.layer.cornerRadius = self.hSearch/2;
    tfSearch.layer.borderColor = [UIColor colorWithRed:(86/255.0) green:(149/255.0) blue:(228/255.0) alpha:1.0].CGColor;
    tfSearch.layer.borderWidth = 1.5;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.top.equalTo(self.scvContent);
        make.height.mas_equalTo(self.hSearch);
    }];
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    
    tfSearch.leftView = lbWWW;
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(self.hSearch);
    }];
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(self.hSearch);
    }];
    
    lbWWW.backgroundColor = UIColor.clearColor;
    lbWWW.text = @"WWW.";
    lbWWW.textColor = [UIColor colorWithRed:(41/255.0) green:(121/255.0) blue:(216/255.0) alpha:1.0];
    float fontSize = [AppDelegate sharedInstance].fontMedium.pointSize;
    lbWWW.font = [UIFont fontWithName:RobotoMedium size:fontSize-3];
    [lbWWW mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(50);
    }];
    
    //  search result view
    viewResult.backgroundColor = UIColor.clearColor;
    [viewResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.tfSearch.mas_bottom).offset(30.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(200.0);
    }];
    
    [imgEmoji mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewResult);
        make.centerX.equalTo(self.viewResult.mas_centerX);
        make.width.height.mas_equalTo(45.0);
    }];
    
    lbSearchContent.numberOfLines = 10;
    lbSearchContent.font = [AppDelegate sharedInstance].fontRegular;
    lbSearchContent.textColor = TITLE_COLOR;
    [lbSearchContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewResult).offset(self.padding);
        make.top.equalTo(self.imgEmoji.mas_bottom).offset(5.0);
        make.width.mas_equalTo(SCREEN_WIDTH - 2*self.padding);
    }];
    
    viewDomain.layer.cornerRadius = 7.0;
    viewDomain.layer.borderWidth = 2.0;
    viewDomain.layer.borderColor = [UIColor colorWithRed:(250/255.0) green:(157/255.0) blue:(26/255.0) alpha:1.0].CGColor;
    [viewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSearchContent.mas_bottom).offset(self.padding);
        make.left.equalTo(self.viewResult).offset(self.padding);
        make.right.equalTo(self.viewResult).offset(-self.padding);
        make.height.mas_equalTo(65.0);
    }];
    
    btnChoose.titleLabel.font = [AppDelegate sharedInstance].fontRegular;
    btnChoose.backgroundColor = BLUE_COLOR;
    btnChoose.layer.cornerRadius = 36.0/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewDomain).offset(-self.padding);
        make.centerY.equalTo(self.viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(60.0);
    }];
    
    lbDomainName.text = @"";
    lbDomainName.font = [AppDelegate sharedInstance].fontBold;
    lbDomainName.textColor = BLUE_COLOR;
    [lbDomainName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewDomain).offset(self.padding);
        make.bottom.equalTo(self.viewDomain.mas_centerY).offset(-2.0);
        make.right.equalTo(self.btnChoose.mas_left).offset(-self.padding);
    }];
    
    lbPrice.text = @"";
    lbPrice.font = [AppDelegate sharedInstance].fontMedium;
    lbPrice.textColor = NEW_PRICE_COLOR;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbDomainName);
        make.top.equalTo(self.viewDomain.mas_centerY).offset(2.0);
    }];
    
    lbOldPrice.text = @"";
    lbOldPrice.font = [AppDelegate sharedInstance].fontMedium;
    lbOldPrice.textColor = OLD_PRICE_COLOR;
    [lbOldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbPrice.mas_right).offset(5.0);
        make.top.equalTo(self.lbPrice);
    }];
    
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbOldPrice);
        make.centerY.equalTo(self.lbOldPrice.mas_centerY);
        make.height.mas_equalTo(1.0);
    }];
    
    lbSepaView.backgroundColor = BORDER_COLOR;
    [lbSepaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewResult.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(1.0);
    }];
    
    lbRelationDomain.font = [UIFont fontWithName:RobotoMedium size:17.0];
    [lbRelationDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepaView.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(40.0);
    }];
    
    tbDomains.scrollEnabled = FALSE;
    tbDomains.backgroundColor = UIColor.clearColor;
    tbDomains.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbDomains registerNib:[UINib nibWithNibName:@"DomainCell" bundle:nil] forCellReuseIdentifier:@"DomainCell"];
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepaView.mas_bottom).offset(self.padding);
        make.left.bottom.equalTo(self.scvContent);
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
            NSString *content = [NSString stringWithFormat:@"Chúc mừng!\nBạn có thế sử dụng tên miền:\n %@\nĐăng ký ngay để bảo vệ thương hiệu của bạn.", firstDomain];
            NSRange range = [content rangeOfString: firstDomain];
            if (range.location != NSNotFound) {
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
                [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontRegular, NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
                [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontMedium, NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
                lbSearchContent.attributedText = attr;
            }else{
                lbSearchContent.text = content;
            }
            
            lbDomainName.text = firstDomain;
            NSString *price = [DomainModel getPriceFromDomainInfo: firstDomainInfo];
            if (![AppUtils isNullOrEmpty: price]) {
                NSString *strPrice = [AppUtils convertStringToCurrencyFormat: price];
                lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", strPrice];
            }
            lbOldPrice.hidden = lbSepa.hidden = TRUE;
            
            if ([[CartModel getInstance] checkCurrentDomainExistsInCart: firstDomainInfo]) {
                btnChoose.backgroundColor = NEW_PRICE_COLOR;
                [btnChoose setTitle:@"Bỏ chọn" forState:UIControlStateNormal];
                
            }else{
                btnChoose.backgroundColor = BLUE_COLOR;
                [btnChoose setTitle:@"Chọn" forState:UIControlStateNormal];
            }
            viewDomain.hidden = FALSE;
            imgEmoji.image = [UIImage imageNamed:@"search_smile"];
            
        }else{
            NSString *content = [NSString stringWithFormat:@"Xin lỗi!\nBạn không thể sử dụng tên miền\n%@", strSearch];
            NSRange range = [content rangeOfString: strSearch];
            if (range.location != NSNotFound) {
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
                [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontRegular, NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
                [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontMedium, NSFontAttributeName, NEW_PRICE_COLOR, NSForegroundColorAttributeName, nil] range: range];
                lbSearchContent.attributedText = attr;
            }else{
                lbSearchContent.text = content;
            }
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
            [cell.btnChoose setTitle:@"Bỏ chọn" forState:UIControlStateNormal];
            cell.btnChoose.backgroundColor = NEW_PRICE_COLOR;
        }else{
            [cell.btnChoose setTitle:@"Chọn" forState:UIControlStateNormal];
            cell.btnChoose.backgroundColor = BLUE_COLOR;
        }
        
        NSString *price = [DomainModel getPriceFromDomainInfo: info];
        if (![AppUtils isNullOrEmpty: price]) {
            price = [AppUtils convertStringToCurrencyFormat: price];
            cell.lbPrice.text = [NSString stringWithFormat:@"%@VNĐ", price];
        }else{
            cell.lbPrice.text = @"Liên hệ";
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
        [cell.btnChoose setTitle:@"Xem thông tin" forState:UIControlStateNormal];
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
