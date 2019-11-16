//
//  SearchResultsViewController.m
//  NhanHoa
//
//  Created by OS on 10/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "DomainCell.h"
#import "CartModel.h"
#import "DomainModel.h"
#import "DomainDescriptionPoupView.h"
#import "DomainInfoPopupView.h"

@interface SearchResultsViewController ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate, UITextFieldDelegate>
{
    AppDelegate *appDelegate;
    float hBGBottom;
    
    UIFont *textFont;
    float padding;
    float hTextfield;
    float hResult;
    float hSection;
    float hSmallCell;
    float hImgResult;
    float hFooter;
    
    NSMutableArray *listDomains;
    NSDictionary *firstDomainInfo;
    
    UIColor *unselectColor;
}
@end

@implementation SearchResultsViewController

@synthesize viewHeader, imgBGTop, icBack, lbHeader, lbCount, icCart, scvContent, imgBGBottom, tfSearch, imgSearch, icClear, imgResult, lbContent, viewResult, lbFirstDomain, lbFirstPrice, btnChoose, tbRelated, viewFooter, btnContinue;
@synthesize strSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    self.navigationController.navigationBarHidden = TRUE;
    
    [self showContentWithCurrentLanguage];
    
    if (listDomains == nil) {
        listDomains = [[NSMutableArray alloc] init];
    }else{
        [listDomains removeAllObjects];
    }
    
    tfSearch.text = strSearch;
    lbContent.text = @"";
    imgResult.hidden = TRUE;
    
    [self startSearchDomainValue];

    
    [self updateCartItemCount];
    [self checkToEnableContinueButton];
    [self registerObservers];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    firstDomainInfo = nil;
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
    [[AppDelegate sharedInstance] showCartScreenContent];
}

- (IBAction)icClearClick:(UIButton *)sender {
    [self.view endEditing: TRUE];
    tfSearch.text = @"";
}

- (IBAction)btnChoosePress:(UIButton *)sender {
    if (firstDomainInfo != nil) {
        BOOL exists = [[CartModel getInstance] checkCurrentDomainExistsInCart: firstDomainInfo];
        if (exists) {
            //  remove domain from cart
            [[CartModel getInstance] removeDomainFromCart: firstDomainInfo];
            
            //  change button title
            [sender setTitle:[appDelegate.localization localizedStringForKey:@"Select"] forState:UIControlStateNormal];
            sender.backgroundColor = UIColor.whiteColor;
            [sender setTitleColor:unselectColor forState:UIControlStateNormal];
            
        }else{
            //  add domain to cart
            [[CartModel getInstance] addDomainToCart: firstDomainInfo];
            
            //  change button title
            [sender setTitle:[appDelegate.localization localizedStringForKey:@"Unselect"] forState:UIControlStateNormal];
            sender.backgroundColor = unselectColor;
            [sender setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        }
        [[AppDelegate sharedInstance] updateShoppingCartCount];
        [self updateLayoutForChooseMainDomain];
        
        [self updateCartItemCount];
    }
    
    [self checkToEnableContinueButton];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView)
                                                 name:@"afterAddOrderSuccessfully" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadChoosedDomainList)
                                                 name:@"reloadChoosedDomainList" object:nil];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Search domains"];
    [btnContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"]
                 forState:UIControlStateNormal];
}


- (void)reloadChoosedDomainList {
    [self prepareDataToDisplay];
}

- (void)popToRootView {
    [self.navigationController popToRootViewControllerAnimated: TRUE];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewFooter.mas_top).offset(-keyboardHeight+hFooter);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewFooter.mas_top);
    }];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)setupUIForView
{
    UITapGestureRecognizer *tapScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [scvContent addGestureRecognizer: tapScreen];
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hTextfield = 50.0;
    hSmallCell = 80.0;
    hSection = 50.0;
    
    unselectColor = [UIColor colorWithRed:(176/255.0) green:(181/255.0)
                                     blue:(193/255.0) alpha:1.0];
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    hResult = 5.0 + 35.0 + 35.0 + 5.0;
    hImgResult = 120.0;
    float hBTN = 53.0;
    float hSmallBTN = 46.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hTextfield = 45.0;
        hResult = 5.0 + 30.0 + 30.0 + 5.0;
        hImgResult = 80.0;
        hSmallCell = 70.0;
        hBTN = 45.0;
        hSmallBTN = 42.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hTextfield = 48.0;
        hResult = 5.0 + 30.0 + 30.0 + 5.0;
        hImgResult = 90.0;
        hSmallCell = 75.0;
        hBTN = 48.0;
        hSmallBTN = 44.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hTextfield = 50.0;
        hResult = 5.0 + 35.0 + 35.0 + 5.0;
        hImgResult = 100.0;
        hSmallCell = 80.0;
        hBTN = 53.0;
        hSmallBTN = 46.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    if (appDelegate.safeAreaBottomPadding > 0) {
        hFooter = hBTN + padding + appDelegate.safeAreaBottomPadding;
    }else{
        hFooter = hBTN + 2*padding;
    }
    
    UIImage *imgTop = [UIImage imageNamed:@"bg_search_result_top"];
    float hHeader = SCREEN_WIDTH * imgTop.size.height / imgTop.size.width;
    
    viewHeader.backgroundColor = UIColor.clearColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    [imgBGTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewHeader);
    }];
    
    lbHeader.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(3.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.clipsToBounds = TRUE;
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    //  footer view
    viewFooter.backgroundColor = GRAY_240;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hFooter);
    }];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnContinue.layer.cornerRadius = 8.0;
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.top.equalTo(viewFooter).offset(padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  content
    scvContent.backgroundColor = [UIColor colorWithRed:(243/255.0) green:(244/255.0)
                                                  blue:(246/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top);
    }];
    
    UIImage *imgBottom = [UIImage imageNamed:@"bg_search_result_bottom"];
    hBGBottom = SCREEN_WIDTH * imgBottom.size.height / imgBottom.size.width;
    [imgBGBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hBGBottom);
    }];
    
    tfSearch.delegate = self;
    tfSearch.returnKeyType = UIReturnKeySearch;
    tfSearch.textColor = GRAY_80;
    tfSearch.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    tfSearch.layer.cornerRadius = 12.0;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imgBGBottom.mas_bottom).offset(-hTextfield/4);
        make.left.equalTo(imgBGBottom).offset(padding);
        make.right.equalTo(imgBGBottom).offset(-padding);
        make.height.mas_equalTo(hTextfield);
    }];
    [AppUtils addBoxShadowForView:tfSearch color:GRAY_200 opacity:0.8 offsetX:1.5 offsetY:1.5];
    
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10+22+5, hTextfield)];
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(tfSearch).offset(10.0);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(22.0);
    }];
    
    icClear.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
    [icClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfSearch);
        make.centerY.equalTo(tfSearch.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [imgResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfSearch.mas_bottom).offset(2*padding);
        make.centerX.equalTo(imgBGBottom.mas_centerX);
        make.height.mas_equalTo(hImgResult);
        make.width.mas_equalTo(0);
    }];
    
    [lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgResult.mas_bottom).offset(padding);
        make.left.equalTo(imgBGBottom).offset(padding);
        make.right.equalTo(imgBGBottom).offset(-padding);
    }];
    
    //  view result
    viewResult.clipsToBounds = TRUE;
    viewResult.layer.cornerRadius = 7.0;
    [viewResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbContent.mas_bottom).offset(padding);
        make.left.equalTo(imgBGBottom).offset(padding);
        make.right.equalTo(imgBGBottom).offset(-padding);
        make.height.mas_equalTo(0);
    }];
    [AppUtils addBoxShadowForView:viewResult color:GRAY_200 opacity:0.8 offsetX:1.5 offsetY:1.5];
    
    btnChoose.layer.borderColor = unselectColor.CGColor;
    btnChoose.layer.borderWidth = 1.0;
    btnChoose.layer.cornerRadius = 8.0;
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewResult).offset(-padding);
        make.centerY.equalTo(viewResult.mas_centerY);
        make.height.mas_equalTo(hSmallBTN);
        make.width.mas_equalTo(0);
    }];
    
    lbFirstDomain.textColor = BLUE_COLOR;
    lbFirstDomain.font = [UIFont fontWithName:RobotoBold size:textFont.pointSize];
    [lbFirstDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewResult).offset(padding);
        make.bottom.equalTo(viewResult.mas_centerY);
        make.right.equalTo(btnChoose.mas_left).offset(-5.0);
    }];
    
    lbFirstPrice.textColor = ORANGE_COLOR;
    lbFirstPrice.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    [lbFirstPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewResult.mas_centerY);
        make.left.right.equalTo(lbFirstDomain);
    }];
    
    //  tb content
    tbRelated.scrollEnabled = FALSE;
    tbRelated.backgroundColor = UIColor.clearColor;
    tbRelated.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbRelated registerNib:[UINib nibWithNibName:@"DomainCell" bundle:nil] forCellReuseIdentifier:@"DomainCell"];
    tbRelated.delegate = self;
    tbRelated.dataSource = self;
    [tbRelated mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewResult.mas_bottom).offset(padding);
        make.left.right.equalTo(viewResult);
        make.height.mas_equalTo(0);
    }];
}



- (void)startSearchDomainValue {
    if (![AppUtils isNullOrEmpty: strSearch])
    {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Seaching..."] Interaction:NO];
        [self hideUIForSearch: TRUE];
        
        firstDomainInfo = nil;
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] searchDomainWithName:strSearch type:0];
    }
}

- (void)hideUIForSearch: (BOOL)hide {
    lbFirstDomain.hidden = lbFirstPrice.hidden = btnChoose.hidden = hide;
    
    if (hide) {
        [viewResult mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }else{
        [viewResult mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hResult);
        }];
    }
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
            
            NSString *content = SFM(@"%@!\n%@:\n%@", [appDelegate.localization localizedStringForKey:@"Congratulations"], [appDelegate.localization localizedStringForKey:@"You can use this domain"], firstDomain);
            NSRange range = [content rangeOfString: firstDomain];
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
            [attr addAttribute:NSForegroundColorAttributeName value:GRAY_80 range:NSMakeRange(0, content.length)];
            [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
            [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize-2] range:NSMakeRange(0, content.length)];
            [attr addAttribute:NSFontAttributeName value:textFont range:range];
            lbContent.attributedText = attr;
            
            lbFirstDomain.text = firstDomain;
            
            NSString *price = [DomainModel getPriceFromDomainInfo: firstDomainInfo];
            if (![AppUtils isNullOrEmpty: price]) {
                NSString *strPrice = [AppUtils convertStringToCurrencyFormat: price];
                lbFirstPrice.text = SFM(@"%@VNĐ/%@", strPrice, [appDelegate.localization localizedStringForKey:@"first year"]);
            }else{
                lbFirstPrice.text = [appDelegate.localization localizedStringForKey:@"Contact price"];
            }
            
            if ([[CartModel getInstance] checkCurrentDomainExistsInCart: firstDomainInfo]) {
                [btnChoose setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
                btnChoose.backgroundColor = unselectColor;
                [btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"Unselect"]
                           forState:UIControlStateNormal];
            }else{
                [btnChoose setTitleColor:unselectColor forState:UIControlStateNormal];
                btnChoose.backgroundColor = UIColor.whiteColor;
                [btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"Select"]
                           forState:UIControlStateNormal];
            }
            imgResult.hidden = FALSE;
            
            UIImage *resultIMG = [UIImage imageNamed:@"search_domain_ok"];
            imgResult.image = resultIMG;
            float width = hImgResult * resultIMG.size.width / resultIMG.size.height;
            [imgResult mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(width);
            }];
        }else{
            if (listDomains.count > 0) {
                NSDictionary *info = [listDomains objectAtIndex: 0];
                NSString *domainName = [info objectForKey:@"domain"];
                
                NSString *content = SFM(@"%@!\n%@:\n%@", [appDelegate.localization localizedStringForKey:@"Sorry"], [appDelegate.localization localizedStringForKey:@"You can not use this domain"], domainName);
                NSRange range = [content rangeOfString: domainName];
                
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
                [attr addAttribute:NSForegroundColorAttributeName value:GRAY_80 range:NSMakeRange(0, content.length)];
                [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
                [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize-2] range:NSMakeRange(0, content.length)];
                [attr addAttribute:NSFontAttributeName value:textFont range:range];
                lbContent.attributedText = attr;
                
                lbFirstDomain.text = domainName;
                
                
                [self hideUIForSearch: TRUE];
                
                imgResult.hidden = FALSE;
                UIImage *resultIMG = [UIImage imageNamed:@"search_domain_notfound"];
                imgResult.image = resultIMG;
                float width = hImgResult * resultIMG.size.width / resultIMG.size.height;
                [imgResult mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.width.mas_equalTo(width);
                }];
            }
        }
        
        [self reUpdateLayoutForView];
        [tbRelated reloadData];
    }
}

- (void)reUpdateLayoutForView {
    //  layout for choose button
    float hContent = hBGBottom + (hTextfield - hTextfield/4) + 2*padding + hImgResult;
    
    float hText = [AppUtils getSizeWithText:lbContent.text withFont:lbContent.font andMaxWidth:SCREEN_WIDTH].height;
    hContent += padding + hText;
    
    if (firstDomainInfo != nil) {
        hContent += padding + hResult;
        
        [viewResult mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(hResult);
        }];
    }else{
        [viewResult mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    [self updateLayoutForChooseMainDomain];
    
    //  get height of tableview
    float hTableView = [self getHeightTableView];
    [tbRelated mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hSection + hTableView);
    }];
    hContent += hSection + hTableView + padding;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (void)updateLayoutForChooseMainDomain {
    float sizeText = [AppUtils getSizeWithText:btnContinue.currentTitle withFont:btnContinue.titleLabel.font].width + 20.0;
    if (sizeText < 60.0) {
        sizeText = 60.0;
    }
    [btnChoose mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(sizeText);
    }];
}

- (float)getHeightTableView {
    float hTableView = 0;
    
    for (int index=0; index<listDomains.count; index++) {
        NSDictionary *info = [listDomains objectAtIndex: index];
        id available = [info objectForKey:@"available"];
        if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
        {
            hTableView += (hResult + padding);
        }else{
            hTableView+= hSmallCell;
        }
    }
    return hTableView;
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


#pragma mark - UITableview Delegate
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
        cell.btnChoose.hidden = FALSE;
        cell.btnViewInfo.hidden = TRUE;
        
        if ([[CartModel getInstance] checkCurrentDomainExistsInCart: info]) {
            [cell.btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"Unselect"]
                            forState:UIControlStateNormal];
            [cell.btnChoose setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
            cell.btnChoose.backgroundColor = unselectColor;
        }else{
            [cell.btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"Select"]
                            forState:UIControlStateNormal];
            [cell.btnChoose setTitleColor:unselectColor forState:UIControlStateNormal];
            cell.btnChoose.backgroundColor = UIColor.whiteColor;
        }
        
        NSString *price = [DomainModel getPriceFromDomainInfo: info];
        if (![AppUtils isNullOrEmpty: price]) {
            price = [AppUtils convertStringToCurrencyFormat: price];
            cell.lbPrice.text = SFM(@"%@VNĐ", price);
        }else{
            cell.lbPrice.text = [appDelegate.localization localizedStringForKey:@"Contact price"];
        }
        [cell showPriceForDomainCell: TRUE];
        
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
        [cell.btnChoose addTarget:self
                           action:@selector(chooseThisDomain:)
                 forControlEvents:UIControlEventTouchUpInside];
        
    }else if (available != nil && [available isKindOfClass:[NSString class]] && [available isEqualToString:@"not support"]){
        [cell setStateForNotSupportDomain];
        
    }else{
        cell.btnWarning.hidden = TRUE;
        cell.btnChoose.hidden = TRUE;
        cell.btnViewInfo.hidden = FALSE;
        
        [cell.btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"View info"] forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = ORANGE_COLOR;
        cell.lbPrice.text = @"";
        
        [cell showPriceForDomainCell: FALSE];
        
        cell.btnViewInfo.tag = indexPath.row;
        [cell.btnViewInfo addTarget:self
                             action:@selector(viewInfoOfDomain:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *viewSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*padding, hSection)];
    
    UILabel *lbTitle = [[UILabel alloc] init];
    lbTitle.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    lbTitle.textColor = GRAY_50;
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Related domains"];
    [viewSection addSubview: lbTitle];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(viewSection);
    }];
    
    return viewSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info = [listDomains objectAtIndex: indexPath.row];
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        return hResult + padding;
    }else{
        return hSmallCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return hSection;
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
            [self updateCartItemCount];
            [tbRelated reloadData];
        }
    }
    
    [self checkToEnableContinueButton];
}

- (void)updateCartItemCount {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)showDescriptionForCurrentDomain
{
    NSString *content = @"Lưu ý: Trong một số trường hợp, các tên miền gắn liền với tên thương hiệu riêng đã bảo hộ hoặc thương hiệu nổi tiếng hoặc các tên miền đang đấu giá, chính sách giá sẽ được căn cứ theo giá thực tế trong hệ thống tại thời điểm đăng ký (không theo CTKM).\n\nKhi đó, bộ phận kinh doanh của chúng tôi sẽ thông báo lại Quý khách.";
    
    float sizeContent = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:textFont.pointSize-2] andMaxWidth:(280-30.0)].height;
    float hPopup = 40.0 + sizeContent + 5.0 + 15.0;
    
    DomainDescriptionPoupView *popupView = [[DomainDescriptionPoupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-300)/2, (SCREEN_HEIGHT - hPopup)/2, 300, hPopup)];
    popupView.lbContent.text = content;
    [popupView showInView:self.view animated:TRUE];
    [AppUtils addBoxShadowForView:popupView withColor:UIColor.whiteColor];
}

- (void)viewInfoOfDomain: (UIButton *)sender
{
    NSDictionary *info = [listDomains objectAtIndex: sender.tag];
    NSString *domain = [info objectForKey:@"domain"];
    
    float maxSize = (SCREEN_WIDTH - 4*padding)/2 + 35.0;
    
    float hPopup = [AppUtils getHeightOfWhoIsDomainViewWithContent:@"" font:[AppDelegate sharedInstance].fontRegular heightItem:28.0 maxSize:maxSize];
    hPopup = 40.0 + 8*40.0;
    
    float marginX = 5.0;
    if (!IS_IPHONE && !IS_IPOD) {
        marginX = 40.0;
    }
    
    DomainInfoPopupView *popupView = [[DomainInfoPopupView alloc] initWithFrame:CGRectMake(marginX, (SCREEN_HEIGHT - hPopup)/2, SCREEN_WIDTH-2*marginX, hPopup)];
    popupView.domain = domain;
    [popupView showInView:self.view animated:TRUE];
}

#pragma mark - UIScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [self.view endEditing: TRUE];
        strSearch = tfSearch.text;
        
        if (![AppUtils isNullOrEmpty: tfSearch.text]) {
            [self startSearchDomainValue];
        }
    }
    return TRUE;
}

#pragma mark - WebServicesUtilDelegate
-(void)failedToSearchDomainWithError:(NSString *)error {
    [ProgressHUD dismiss];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    if (data != nil && [data isKindOfClass:[NSArray class]]) {
        [listDomains removeAllObjects];
        [listDomains addObjectsFromArray: (NSArray *)data];
        [self prepareDataToDisplay];
    }
}

@end
