//
//  WhoIsResultViewController.m
//  NhanHoa
//
//  Created by admin on 4/30/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsResultViewController.h"
#import "DomainCell.h"
#import "DomainObject.h"
#import "AccountModel.h"

@interface WhoIsResultViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, WebServiceUtilsDelegate>
{
    NSMutableArray *listResults;
    
    NSMutableArray *listTagView;
    int tag;
    
    UITableView *tbRelatedDomain;
    NSMutableArray *listData;
    float hCell;
    float sizeLargeText;
}
@end

@implementation WhoIsResultViewController
@synthesize scvContent, listSearch, padding, whoisView, noResultView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    self.title = @"Kết quả tra cứu";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"WhoIsResultViewController"];
    [WebServiceUtils getInstance].delegate = self;
    
    [listSearch removeObject:@""];
    padding = 15.0;
    hCell = 90.0;
    
    listTagView = [[NSMutableArray alloc] init];
    tag = 100;
    
    sizeLargeText = [AppUtils getSizeWithText:@"Xem thông tin" withFont:[AppDelegate sharedInstance].fontRegular].width + 10.0;
    
    //  prepare result array
    if (listResults == nil) {
        listResults = [[NSMutableArray alloc] init];
    }
    [listResults removeAllObjects];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang tìm kiếm..." Interaction:NO];
    
    [self checkWhoIsForListDomains];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (listResults.count > 1) {
        float contentSize = 0;
        for (int i=0; i<listTagView.count; i++) {
            int tag = [[listTagView objectAtIndex: i] intValue];
            id view = [scvContent viewWithTag: tag];
            if ([view isKindOfClass:[WhoIsNoResult class]])
            {
                WhoIsNoResult *view = [scvContent viewWithTag: tag];
                
                float textSize = [AppUtils getSizeWithText:view.lbContent.text withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
                float heightView = 60 + 35.0 + 10.0 + textSize + 10.0 + 65.0 + padding;
                
                float originY = 0;
                if (i == 0) {
                    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, heightView);
                    contentSize = heightView;
                }else{
                    originY = contentSize + 10.0;
                    contentSize = contentSize + 10.0 + heightView;
                }
                
                [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.scvContent);
                    make.top.equalTo(self.scvContent).offset(originY);
                    make.width.mas_equalTo(SCREEN_WIDTH);
                    make.height.mas_equalTo(heightView);
                }];
                
            }else if ([view isKindOfClass:[WhoIsDomainView class]])
            {
                WhoIsDomainView *view = [scvContent viewWithTag: tag];
                float maxSize = (SCREEN_WIDTH - 4*padding)/2 + 35.0;
                float heightView = [AppUtils getHeightOfWhoIsDomainViewWithContent:view.lbDNSValue.text font:[UIFont fontWithName:RobotoRegular size:14.0] heightItem:view.hLabel maxSize:maxSize];
                
                //float heightView = view.lbDNSSECValue.frame.origin.y + view.lbDNSSECValue.frame.size.height + 15.0 + view.lbTitle.frame.size.height/2 + view.lbTitle.frame.origin.y;
                
                float originY = 0;
                if (i == 0) {
                    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, heightView);
                    contentSize = heightView;
                }else{
                    originY = contentSize + 10.0;
                    contentSize = contentSize + 10.0 + heightView;
                }
                
                [view mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.scvContent);
                    make.top.equalTo(self.scvContent).offset(originY);
                    make.width.mas_equalTo(SCREEN_WIDTH);
                    make.height.mas_equalTo(heightView);
                }];
                [view layoutIfNeeded];
                
            }
        }
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, contentSize);
        
    }else if (listResults.count == 1){
        if (whoisView != nil) {
            float heightView = whoisView.lbDNSSECValue.frame.origin.y + whoisView.lbDNSSECValue.frame.size
            .height + 15.0 + whoisView.lbTitle.frame.size.height + whoisView.lbTitle.frame.origin.y;
            [whoisView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.scvContent);
                make.top.equalTo(self.scvContent);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(heightView);
            }];
            
            float hTableView = 50.0 + listData.count * hCell;
            [tbRelatedDomain mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.scvContent);
                make.top.equalTo(self.whoisView.mas_bottom).offset(10.0);
                make.width.mas_equalTo(SCREEN_WIDTH);
                make.height.mas_equalTo(hTableView);
            }];
            
            float contentSize = heightView + 10 + hTableView + padding;
            scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, contentSize);
        }
    }
    
}

- (void)setupUIForView {
    scvContent.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DomainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    DomainObject *domain = [listData objectAtIndex: indexPath.row];
    cell.lbDomain.text = domain.domain;
    
    NSString *price = [AppUtils convertStringToCurrencyFormat:domain.price];
    cell.lbPrice.text = [NSString stringWithFormat:@"%@đ", price];
    
    if (domain.warning) {
        cell.btnWarning.hidden = FALSE;
    }else{
        cell.btnWarning.hidden = TRUE;
    }
    
    if (domain.isRegistered) {
        [cell.btnChoose setTitle:@"Xem thông tin" forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = ORANGE_COLOR;
    }else{
        [cell.btnChoose setTitle:text_choose forState:UIControlStateNormal];
        cell.btnChoose.backgroundColor = BLUE_COLOR;
    }
    [cell updateSizeButtonWithContent:cell.btnChoose.currentTitle];
    
    [cell addBoxShadowForView:cell.parentView withColor:UIColor.blackColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)showDomainList {
    float contentSize = 0;
    if (listResults.count > 1) {
        for (int index=0; index<listResults.count; index++) {
            tag = tag + 5;
            
            NSDictionary *info = [listResults objectAtIndex: index];
            NSString *errorCode = [info objectForKey:@"errorCode"];
            
            if ([AppUtils isNullOrEmpty: errorCode]) {
                [self addWhoIsResultViewWithInfo:info index:index contentSize:contentSize];
                
            }else{
                [self addWhoIsNoResultViewWithInfo:info index:index contentSize:contentSize];
                
                //[self addWhoIsNoResultViewForOneItem: info];
            }
        }
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, contentSize);
    }else if (listResults.count == 1) {
        NSDictionary *info = [listResults firstObject];
        NSString *errorCode = [info objectForKey:@"errorCode"];
        
        if ([AppUtils isNullOrEmpty: errorCode]) {
            [self addWhoIsResultViewForOneItem: info];
            
        }else{
            [self addWhoIsNoResultViewForOneItem: info];
        }
        
    }else{
        NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsNoResult" owner:nil options:nil];
        for(id currentObject in toplevelObject){
            if ([currentObject isKindOfClass:[WhoIsNoResult class]]) {
                noResultView = (WhoIsNoResult *) currentObject;
                break;
            }
        }
        
        NSString *content = [NSString stringWithFormat:@"Hiện tại tên miền %@ chưa được đăng ký!\nBạn có muốn đăng ký tên miền này không?", @"lanhquadi.com"];
        NSRange range = [content rangeOfString: @"lanhquadi.com"];
        if (range.location != NSNotFound) {
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
            [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontRegular, NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
            [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[AppDelegate sharedInstance].fontMedium, NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
            noResultView.lbContent.attributedText = attr;
        }else{
            noResultView.lbContent.text = content;
        }
        float textSize = [AppUtils getSizeWithText:content withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
        float hView = 60 + 35.0 + 10.0 + textSize + 10.0 + 65.0 + padding;
        [scvContent addSubview: noResultView];
        [noResultView setupUIForView];
        [noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent);
            make.top.equalTo(self.scvContent);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(hView);
        }];
        
        float hTableView = listData.count * hCell + 40.0;
        tbRelatedDomain = [[UITableView alloc] init];
        tbRelatedDomain.backgroundColor = UIColor.clearColor;
        [tbRelatedDomain registerNib:[UINib nibWithNibName:@"DomainCell" bundle:nil] forCellReuseIdentifier:@"DomainCell"];
        tbRelatedDomain.separatorStyle = UITableViewCellSelectionStyleNone;
        tbRelatedDomain.delegate = self;
        tbRelatedDomain.dataSource = self;
        [self.scvContent addSubview: tbRelatedDomain];
        
        [tbRelatedDomain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent);
            make.top.equalTo(self.noResultView.mas_bottom).offset(10.0);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(hTableView);
        }];
        
        UIView *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0)];
        
        UILabel *lbHeader = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, viewHeader.frame.size.width-2*padding, viewHeader.frame.size.height)];
        lbHeader.text = @"Các tên miền liên quan";
        lbHeader.font = [AppDelegate sharedInstance].fontMedium;
        lbHeader.textColor = TITLE_COLOR;
        [viewHeader addSubview: lbHeader];
        tbRelatedDomain.tableHeaderView = viewHeader;
        
        scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hView + 10.0 + hTableView);
    }
}

- (void)addWhoIsResultViewForOneItem: (NSDictionary *)info {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsDomainView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsDomainView class]]) {
            whoisView = (WhoIsDomainView *) currentObject;
            break;
        }
    }
    [whoisView resetAllValueForView];
    whoisView.hLabel = 25.0;
    
    float hView = 340.0;
    [scvContent addSubview: whoisView];
    [whoisView setupUIForView];
    [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    
    [whoisView showContentOfDomainWithInfo: info];
    
    float hTableView = listData.count * hCell + 50.0;
    tbRelatedDomain = [[UITableView alloc] init];
    tbRelatedDomain.backgroundColor = UIColor.clearColor;
    [tbRelatedDomain registerNib:[UINib nibWithNibName:@"DomainCell" bundle:nil] forCellReuseIdentifier:@"DomainCell"];
    tbRelatedDomain.separatorStyle = UITableViewCellSelectionStyleNone;
    tbRelatedDomain.delegate = self;
    tbRelatedDomain.dataSource = self;
    [self.scvContent addSubview: tbRelatedDomain];
    
    [tbRelatedDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.whoisView.mas_bottom).offset(10.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    UIView *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
    
    UILabel *lbHeader = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, viewHeader.frame.size.width-2*padding, viewHeader.frame.size.height)];
    lbHeader.text = @"Các tên miền liên quan";
    lbHeader.font = [AppDelegate sharedInstance].fontMedium;
    lbHeader.textColor = TITLE_COLOR;
    [viewHeader addSubview: lbHeader];
    tbRelatedDomain.tableHeaderView = viewHeader;
}

- (void)addWhoIsResultViewWithInfo: (NSDictionary *)info index: (int)index contentSize: (float)contentSize {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsDomainView" owner:nil options:nil];
    WhoIsDomainView *whoIsView;
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsDomainView class]]) {
            whoIsView = (WhoIsDomainView *) currentObject;
            break;
        }
    }
    [whoIsView resetAllValueForView];
    whoIsView.hLabel = 25.0;
    
    NSString *dns = [info objectForKey:@"dns"];
    if (![AppUtils isNullOrEmpty: dns]) {
        dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
        dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    }
    
    float maxSize = (SCREEN_WIDTH - 4*padding)/2 + 35.0;
    float hView = [AppUtils getHeightOfWhoIsDomainViewWithContent:dns font:[AppDelegate sharedInstance].fontRegular heightItem:whoIsView.hLabel maxSize:maxSize];
    
    float originY;
    if (index == 0) {
        originY = 0;
        contentSize = hView;
    }else{
        originY = contentSize + 10.0;
        contentSize = contentSize + 10.0 + hView;
    }
    [scvContent addSubview:whoIsView];
    
    [whoIsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [whoIsView setupUIForView];
    
    whoIsView.tag = tag;
    [listTagView addObject:[NSNumber numberWithInt: tag]];
    [whoIsView showContentOfDomainWithInfo: info];
}

- (void)addWhoIsNoResultViewForOneItem: (NSDictionary *)info {
    NSString *domain = [info objectForKey:@"domain"];
    if ([AppUtils isNullOrEmpty: domain]) {
        domain = @"Chưa xác định";
    }
    
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsNoResult" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsNoResult class]]) {
            noResultView = (WhoIsNoResult *) currentObject;
            break;
        }
    }
    [noResultView showContentOfDomainWithInfo: info];
    
    float textSize = [AppUtils getSizeWithText:noResultView.lbContent.text withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
    float hView = 60 + 35.0 + 10.0 + textSize + 10.0 + 65.0 + padding;
    [scvContent addSubview: noResultView];
    [noResultView setupUIForView];
    [noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    
    float hTableView = listData.count * hCell + 40.0;
    tbRelatedDomain = [[UITableView alloc] init];
    tbRelatedDomain.backgroundColor = UIColor.clearColor;
    [tbRelatedDomain registerNib:[UINib nibWithNibName:@"DomainCell" bundle:nil] forCellReuseIdentifier:@"DomainCell"];
    tbRelatedDomain.separatorStyle = UITableViewCellSelectionStyleNone;
    tbRelatedDomain.delegate = self;
    tbRelatedDomain.dataSource = self;
    [self.scvContent addSubview: tbRelatedDomain];
    
    [tbRelatedDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.noResultView.mas_bottom).offset(10.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    UIView *viewHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0)];
    
    UILabel *lbHeader = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, viewHeader.frame.size.width-2*padding, viewHeader.frame.size.height)];
    lbHeader.text = @"Các tên miền liên quan";
    lbHeader.font = [AppDelegate sharedInstance].fontMedium;
    lbHeader.textColor = TITLE_COLOR;
    [viewHeader addSubview: lbHeader];
    tbRelatedDomain.tableHeaderView = viewHeader;
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hView + 10.0 + hTableView);
}

- (void)addWhoIsNoResultViewWithInfo: (NSDictionary *)info index: (int)index contentSize: (float)contentSize
{
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsNoResult" owner:nil options:nil];
    WhoIsNoResult *noView;
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsNoResult class]]) {
            noView = (WhoIsNoResult *) currentObject;
            break;
        }
    }
    [noView showContentOfDomainWithInfo: info];
    
    float textSize = [AppUtils getSizeWithText:noView.lbContent.text withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
    
    float hView = 60 + 35.0 + 10.0 + textSize + 10.0 + 65.0 + padding;
    float originY;
    if (index == 0) {
        originY = 0;
        contentSize = hView;
    }else{
        originY = contentSize + 10.0;
        contentSize = contentSize + 10.0 + hView;
    }
    [scvContent addSubview: noView];
    [noView setupUIForView];
    
    [noView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    noView.tag = tag;
    [listTagView addObject:[NSNumber numberWithInt: tag]];
}

- (void)checkWhoIsForListDomains {
    if (listSearch.count > 0) {
        NSString *domain = [listSearch firstObject];
        [listSearch removeObjectAtIndex: 0];
        [[WebServiceUtils getInstance] searchDomainWithName:domain type:1];
        
        [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain) toFilePath:[AppDelegate sharedInstance].logFilePath];
    }else{
        [ProgressHUD dismiss];
        [self showDomainList];
    }
}

#pragma mark - Webserice

- (void)failedToSearchDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@", __FUNCTION__, @[error]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    if ([error isKindOfClass:[NSDictionary class]]) {
        [listResults addObject: error];
    }
    [self checkWhoIsForListDomains];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@", __FUNCTION__, @[data]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [listResults addObject: data];
    }
    [self checkWhoIsForListDomains];
}

@end
