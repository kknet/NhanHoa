//
//  SearchResultViewController.m
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchResultViewController.h"
#import "DomainAvailableTbvCell.h"
#import "DomainUnavailableTbvCell.h"

@interface SearchResultViewController ()<UITableViewDelegate, UITableViewDataSource, WebServiceUtilsDelegate>{
    AppDelegate *appDelegate;
    float padding;
    float hBTN;
    UIFont *textFont;
    float hCell;
    float hLargeCell;
    
    NSMutableArray *listDomains;
}

@end

@implementation SearchResultViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, tbResult, viewFooter, btnContinue;
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
    
    [self startSearchDomainValue];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Search domains"];
    [btnContinue setTitle:[appDelegate.localization localizedStringForKey:@"Continue"]
                 forState:UIControlStateNormal];
}

- (void)setupUIForView
{
    self.view.backgroundColor = GRAY_235;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 45.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    lbHeader.textColor = GRAY_80;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = 18.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(18.0);
    }];
    
    //  footer view
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(hBTN + padding);
    }];
    
    btnContinue.backgroundColor = BLUE_COLOR;
    btnContinue.layer.cornerRadius = 8.0;
    btnContinue.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    btnContinue.clipsToBounds = TRUE;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(padding);
        make.right.equalTo(viewFooter).offset(-padding);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  tableview result
    [tbResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(viewFooter.mas_top);
    }];
    
    //  table
    UIImage *bg = [UIImage imageNamed:@"domain-search-availabel"];
    float hBG = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    
    hCell = hBG + 30.0 + 30.0 + 15.0;
    
    bg = [UIImage imageNamed:@"domain-search-unavailabel"];
    hBG = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    hLargeCell = hBG + 120.0;
    
    [tbResult registerNib:[UINib nibWithNibName:@"DomainAvailableTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainAvailableTbvCell"];
    [tbResult registerNib:[UINib nibWithNibName:@"DomainUnavailableTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainUnavailableTbvCell"];
    tbResult.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbResult.backgroundColor = UIColor.clearColor;
    tbResult.delegate = self;
    tbResult.dataSource = self;
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [appDelegate showCartScreenContent];
}

- (void)startSearchDomainValue {
    if (![AppUtils isNullOrEmpty: strSearch])
    {
        [ProgressHUD backgroundColor: ProgressHUD_BG];
        [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Seaching..."] Interaction:NO];
        //  [self hideUIForSearch: TRUE];
        
        //  firstDomainInfo = nil;
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] searchDomainWithName:strSearch type:0];
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
    
    //  check available domain
    NSDictionary *info = [listDomains objectAtIndex: indexPath.row];
    id available = [info objectForKey:@"available"];
    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
    {
        DomainAvailableTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainAvailableTbvCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell displayContentWithInfo: info];
        
        return cell;
        
    }else if (available != nil && [available isKindOfClass:[NSString class]] && [available isEqualToString:@"not support"]){
//        cell.btnWarning.hidden = TRUE;
//        [cell.btnChoose setTitle:not_support_yet forState:UIControlStateNormal];
//        cell.btnChoose.backgroundColor = OLD_PRICE_COLOR;
//        cell.btnChoose.enabled = FALSE;
//
//        [cell showPriceForDomainCell: FALSE];
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
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  hCell;
    
//    NSDictionary *info = [listDomains objectAtIndex: indexPath.row];
//    id available = [info objectForKey:@"available"];
//    if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == 1)
//    {
//        return hResult + padding;
//    }else{
//        return hSmallCell;
//    }
}


#pragma mark - WebServicesUtilDelegate
-(void)failedToSearchDomainWithError:(NSString *)error {
    [ProgressHUD dismiss];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    [ProgressHUD dismiss];
    
    if (data != nil && [data isKindOfClass:[NSArray class]]) {
        [listDomains addObjectsFromArray: (NSArray *)data];
        [self prepareDataToDisplay];
    }
}

- (void)prepareDataToDisplay {
    if (listDomains.count > 0) {
//        //  Lưu domain available khác nếu không tìm thấy domain hiện tại
//        NSDictionary *tmpAvailable;
//        for (int index=0; index<listDomains.count; index++)
//        {
//            NSDictionary *info = [listDomains objectAtIndex: index];
//            id available = [info objectForKey:@"available"];
//
//            if (([available isKindOfClass:[NSNumber class]] && [available intValue] == 1) || [available boolValue] == TRUE || [available boolValue] == 1)
//            {
//                NSString *domain = [info objectForKey:@"domain"];
//                if ([strSearch isEqualToString: domain]) {
//                    firstDomainInfo = [[NSDictionary alloc] initWithDictionary: info];
//                    break;
//                }
//                if (tmpAvailable == nil) {
//                    tmpAvailable = info;
//                }
//            }else if ([available isKindOfClass:[NSString class]] && [available isEqualToString:@"1"])
//            {
//                NSString *domain = [info objectForKey:@"domain"];
//                if ([strSearch isEqualToString: domain]) {
//                    firstDomainInfo = [[NSDictionary alloc] initWithDictionary: info];
//                    break;
//                }
//                if (tmpAvailable == nil) {
//                    tmpAvailable = info;
//                }
//                break;
//            }
//        }
//
//        [self hideUIForSearch: FALSE];
//
//        if (firstDomainInfo == nil && tmpAvailable != nil) {
//            firstDomainInfo = [[NSDictionary alloc] initWithDictionary: tmpAvailable];
//        }
//
//        if (firstDomainInfo != nil) {
//            [listDomains removeObject: firstDomainInfo];
//
//            NSString *firstDomain = [firstDomainInfo objectForKey:@"domain"];
//
//            NSString *content = SFM(@"%@!\n%@:\n%@", [appDelegate.localization localizedStringForKey:@"Congratulations"], [appDelegate.localization localizedStringForKey:@"You can use this domain"], firstDomain);
//            NSRange range = [content rangeOfString: firstDomain];
//
//            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:content];
//            [attr addAttribute:NSForegroundColorAttributeName value:GRAY_80 range:NSMakeRange(0, content.length)];
//            [attr addAttribute:NSForegroundColorAttributeName value:BLUE_COLOR range:range];
//            [attr addAttribute:NSFontAttributeName value:textFont range:NSMakeRange(0, content.length)];
//            [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoBold size:textFont.pointSize] range:range];
//            lbContent.attributedText = attr;
//
//            lbFirstDomain.text = firstDomain;
//
//            NSString *price = [DomainModel getPriceFromDomainInfo: firstDomainInfo];
//            if (![AppUtils isNullOrEmpty: price]) {
//                NSString *strPrice = [AppUtils convertStringToCurrencyFormat: price];
//                lbFirstPrice.text = SFM(@"%@VNĐ/%@", strPrice, [appDelegate.localization localizedStringForKey:@"first year"]);
//            }else{
//                lbFirstPrice.text = [appDelegate.localization localizedStringForKey:@"Contact price"];
//            }
//
//            if ([[CartModel getInstance] checkCurrentDomainExistsInCart: firstDomainInfo]) {
//                btnChoose.backgroundColor = NEW_PRICE_COLOR;
//                [btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"Unselect"]
//                           forState:UIControlStateNormal];
//            }else{
//                btnChoose.backgroundColor = BLUE_COLOR;
//                [btnChoose setTitle:[appDelegate.localization localizedStringForKey:@"Select"]
//                           forState:UIControlStateNormal];
//            }
//            imgResult.hidden = FALSE;
//            imgResult.image = [UIImage imageNamed:@"search_domain_ok"];
//
//        }else{
//            [self hideUIForSearch: TRUE];
//
//            imgResult.hidden = FALSE;
//            imgResult.image = [UIImage imageNamed:@"search_domain_notfound"];
//        }
//
//        [self reUpdateLayoutForView];
        [tbResult reloadData];
    }
}

@end
