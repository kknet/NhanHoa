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

@interface WhoIsResultViewController ()<UIScrollViewDelegate, WebServiceUtilsDelegate> {
    NSMutableArray *listResults;
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
    
    //  prepare result array
    if (listResults == nil) {
        listResults = [[NSMutableArray alloc] init];
    }
    [listResults removeAllObjects];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang kiểm tra..." Interaction:NO];
    
    [self checkWhoIsForListDomains];
}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)setupUIForView {
    scvContent.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)addAvailableForViewWithInfo: (NSDictionary *)info {
    WhoIsNoResult *whoisView;
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsNoResult" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsNoResult class]]) {
            whoisView = (WhoIsNoResult *) currentObject;
            break;
        }
    }
    [whoisView showContentOfDomainWithInfo: info];
    
    float textSize = [AppUtils getSizeWithText:whoisView.lbContent.text withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
    float hView = 60 + 35.0 + 10.0 + textSize + 10.0 + 65.0 + padding;
    [scvContent addSubview: whoisView];
    [whoisView setupUIForView];
    [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(self.scvContent.contentSize.height+10.0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH,  scvContent.contentSize.height + hView + 10.0);
}

- (void)addWhoIsResultViewWithInfo: (NSDictionary *)info {
    WhoIsDomainView *whoisView;
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsDomainView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsDomainView class]]) {
            whoisView = (WhoIsDomainView *) currentObject;
            break;
        }
    }
    [whoisView resetAllValueForView];
    whoisView.hLabel = 25.0;
    
    NSString *dns = [info objectForKey:@"dns"];
    if (![AppUtils isNullOrEmpty: dns]) {
        dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
        dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    }
    
    float maxSize = (SCREEN_WIDTH - 4*padding)/2 + 35.0;
    float hView = [AppUtils getHeightOfWhoIsDomainViewWithContent:dns font:[AppDelegate sharedInstance].fontRegular heightItem:whoisView.hLabel maxSize:maxSize];

    [scvContent addSubview:whoisView];
    
    [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(self.scvContent.contentSize.height + self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    [whoisView setupUIForView];
    [whoisView showContentOfDomainWithInfo: info];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH,  scvContent.contentSize.height + hView + 10.0);
}

- (void)showDomainList {
    for (int index=0; index<listResults.count; index++) {
        NSDictionary *info = [listResults objectAtIndex: index];
        id available = [info objectForKey:@"available"];
        if (available != nil) {
            [self addAvailableForViewWithInfo: info];
        }else{
            [self addWhoIsResultViewWithInfo: info];
        }
    }
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
