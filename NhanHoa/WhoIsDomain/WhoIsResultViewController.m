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

@interface WhoIsResultViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate> {
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
@synthesize webService;

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
    
    [listSearch removeObject:@""];
    padding = 15.0;
    hCell = 90.0;
    
    listTagView = [[NSMutableArray alloc] init];
    tag = 100;
    
    sizeLargeText = [AppUtils getSizeWithText:@"Xem thông tin" withFont:[UIFont fontWithName:RobotoRegular size:15.0]].width + 10.0;
    
    //  prepare webservice
    if (webService == nil) {
        webService = [[WebServices alloc] init];
    }
    webService.delegate = self;
    
    //  prepare result array
    if (listResults == nil) {
        listResults = [[NSMutableArray alloc] init];
    }
    [listResults removeAllObjects];
    
    [ProgressHUD backgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]];
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
                
                float textSize = [AppUtils getSizeWithText:view.lbContent.text withFont:[UIFont fontWithName:RobotoRegular size:16.0] andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
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
                float heightView = view.lbDNSSECValue.frame.origin.y + view.lbDNSSECValue.frame.size
                .height + 15.0 + view.lbTitle.frame.size.height + view.lbTitle.frame.origin.y;
                
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
    
    NSString *oldPrice = [AppUtils convertStringToCurrencyFormat:domain.oldPrice];
    cell.lbOldPrice.text = [NSString stringWithFormat:@"%@đ", oldPrice];
    
    if (domain.warning) {
        cell.btnWarning.hidden = FALSE;
    }else{
        cell.btnWarning.hidden = TRUE;
    }
    
    if (domain.isRegistered) {
        [cell.btnChoose setTitle:@"Xem thông tin" forState:UIControlStateNormal];
        [cell updateSizeButtonForSize: sizeLargeText];
        cell.btnChoose.backgroundColor = ORANGE_COLOR;
    }else{
        [cell.btnChoose setTitle:@"Chọn" forState:UIControlStateNormal];
        [cell updateSizeButtonForSize: 60.0];
        cell.btnChoose.backgroundColor = BLUE_COLOR;
    }
    
    cell.btnSpecial.hidden = TRUE;
    [cell addBoxShadowForView:cell.parentView withColor:UIColor.blackColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (void)createDemoData {
    listData = [[NSMutableArray alloc] init];
    
    DomainObject *domain = [[DomainObject alloc] init];
    domain.domain = @"lanhquadi.org";
    domain.price = @"29000";
    domain.oldPrice = @"180000";
    domain.special = FALSE;
    domain.warning = FALSE;
    domain.warningContent = @"";
    domain.isRegistered = TRUE;
    [listData addObject: domain];
    
    DomainObject *domain1 = [[DomainObject alloc] init];
    domain1.domain = @"lanhquadi.top";
    domain1.price = @"100000";
    domain1.oldPrice = @"150000";
    domain1.special = TRUE;
    domain1.warning = FALSE;
    domain1.warningContent = @"";
    domain1.isRegistered = TRUE;
    [listData addObject: domain1];
    
    DomainObject *domain2 = [[DomainObject alloc] init];
    domain2.domain = @"lanhquadi.org.vn";
    domain2.price = @"350000";
    domain2.oldPrice = @"";
    domain2.special = NO;
    domain2.warning = TRUE;
    domain2.isRegistered = FALSE;
    domain2.warningContent = @"Tên miền giành cho các tổ chức hoạt động trong lĩnh vực chính trị, văn hoá, xã hội. Cá nhân không thể đăng ký tên miền này!";
    [listData addObject: domain2];
    
    DomainObject *domain3 = [[DomainObject alloc] init];
    domain3.domain = @"lanhquadi.vn";
    domain3.price = @"85000";
    domain3.oldPrice = @"170000";
    domain3.special = FALSE;
    domain3.warning = FALSE;
    domain3.warningContent = @"";
    domain3.isRegistered = FALSE;
    [listData addObject: domain3];
    
    DomainObject *domain4 = [[DomainObject alloc] init];
    domain4.domain = @"lanhquadi.net.vn";
    domain4.price = @"630000";
    domain4.oldPrice = @"";
    domain4.special = FALSE;
    domain4.warning = FALSE;
    domain4.warningContent = @"";
    domain4.isRegistered = TRUE;
    [listData addObject: domain4];
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
        [self createDemoData];
        
        NSDictionary *info = [listResults firstObject];
        NSString *errorCode = [info objectForKey:@"errorCode"];
        
        if ([AppUtils isNullOrEmpty: errorCode]) {
            [self addWhoIsResultViewForOneItem: info];
            
        }else{
            [self addWhoIsNoResultViewForOneItem: info];
        }
        
    }else{
        [self createDemoData];
        
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
            [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:16.0], NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
            [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoMedium size:16.0], NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
            noResultView.lbContent.attributedText = attr;
        }else{
            noResultView.lbContent.text = content;
        }
        float textSize = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:16.0] andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
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
        lbHeader.font = [UIFont fontWithName:RobotoMedium size:16.0];
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
    
    float hView = 380.0;
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
    lbHeader.font = [UIFont fontWithName:RobotoMedium size:16.0];
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
    
    float hView = 430.0;
    float originY;
    if (index == 0) {
        originY = 0;
        contentSize = hView;
    }else{
        originY = contentSize + 10.0;
        contentSize = contentSize + 10.0 + hView;
    }
    [scvContent addSubview:whoIsView];
    [whoIsView setupUIForView];
    [whoIsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
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
    
    float textSize = [AppUtils getSizeWithText:noResultView.lbContent.text withFont:[UIFont fontWithName:RobotoRegular size:16.0] andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
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
    lbHeader.font = [UIFont fontWithName:RobotoMedium size:16.0];
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
    
    float textSize = [AppUtils getSizeWithText:noView.lbContent.text withFont:[UIFont fontWithName:RobotoRegular size:16.0] andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
    
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

#pragma mark - Webserice
- (void)checkWhoIsForListDomains {
    if (listSearch.count > 0) {
        NSString *domain = [listSearch firstObject];
        [listSearch removeObjectAtIndex: 0];
        
        NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] init];
        [jsonDict setObject:whois_mod forKey:@"mod"];
        [jsonDict setObject:domain forKey:@"domain"];
        [jsonDict setObject:[AccountModel getCusIdOfUser] forKey:@"cus_id"];
        [jsonDict setObject:[NSNumber numberWithInt: 1] forKey:@"type"];
        [webService callWebServiceWithLink:whois_func withParams:jsonDict];
        
        [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] jSonDict = %@", __FUNCTION__, @[jsonDict]] toFilePath:[AppDelegate sharedInstance].logFilePath];
    }else{
        [ProgressHUD dismiss];
        [self showDomainList];
    }
}

-(void)failedToCallWebService:(NSString *)link andError:(id)error {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] link: %@.\n error: %@", __FUNCTION__, link, error] toFilePath:[AppDelegate sharedInstance].logFilePath];
    if ([link isEqualToString: whois_func]) {
        if ([error isKindOfClass:[NSDictionary class]]) {
            [listResults addObject: error];
        }
        [self checkWhoIsForListDomains];
    }
}

-(void)successfulToCallWebService:(NSString *)link withData:(NSDictionary *)data {
    if ([link isEqualToString: whois_func]) {
        if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
            [listResults addObject: data];
        }
        [self checkWhoIsForListDomains];
    }
}

-(void)receivedResponeCode:(NSString *)link withCode:(int)responeCode {
    [WriteLogsUtils writeLogContent:[NSString stringWithFormat:@"[%s] -----> responeCode = %d for function: %@", __FUNCTION__, responeCode, link] toFilePath:[AppDelegate sharedInstance].logFilePath];
}

@end
