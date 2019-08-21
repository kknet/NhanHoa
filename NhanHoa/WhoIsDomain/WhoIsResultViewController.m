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
#import "CartModel.h"

@interface WhoIsResultViewController ()<UIScrollViewDelegate, WebServiceUtilsDelegate> {
    NSMutableArray *listResults;
    float padding;
}
@end

@implementation WhoIsResultViewController
@synthesize scvContent, listSearch, whoisView, noResultView, btnContinue, lbTop;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
    self.title = text_search_results;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen: @"WhoIsResultViewController"];
    
    [listSearch removeObject:@""];
    
    //  prepare result array
    if (listResults == nil) {
        listResults = [[NSMutableArray alloc] init];
    }
    [listResults removeAllObjects];
    
    [self registerObservers];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_checking Interaction:FALSE];
    
    [self checkWhoIsForListDomains];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView)
                                                 name:@"afterAddOrderSuccessfully" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUIWhenSelectOrRemoveDomainFormCart)
                                                 name:@"selectedOrRemoveDomainFromCart" object:nil];
    
    if (!IS_IPHONE && !IS_IPOD) {
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged)
                                                     name:UIDeviceOrientationDidChangeNotification object:nil];
    }
}

- (void)popToRootView {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [self.navigationController popToRootViewControllerAnimated: TRUE];
}

- (void)setupUIForView {
    float hBTN = 45.0;
    padding = 15.0;
    if ([DeviceUtils isScreen320]) {
        padding = 5.0;
    }
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hBTN = 55.0;
    }
    
    [self checkToEnableContinueButton];
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnContinue.layer.cornerRadius = hBTN/2;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue setTitle:text_continue forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    self.view.backgroundColor = GRAY_235;
    scvContent.showsVerticalScrollIndicator = FALSE;
    scvContent.backgroundColor = UIColor.clearColor;
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(btnContinue.mas_top).offset(-padding);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
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

- (void) orientationChanged
{
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationUnknown || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceUp || [UIDevice currentDevice].orientation == UIDeviceOrientationFaceDown) {
        return;
    }
    
    float screenWidth = [DeviceUtils getWidthOfScreen];
    [lbTop mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(screenWidth);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)addAvailableForViewWithInfo: (NSDictionary *)info withIndex: (int)index {
    float mTop = 0;
    if (index > 0) {
        if (!IS_IPHONE && !IS_IPOD) {
            mTop = 20.0;
        }else{
            mTop = 10.0;
        }
    }
    
    WhoIsNoResult *whoisView;
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsNoResult" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsNoResult class]]) {
            whoisView = (WhoIsNoResult *) currentObject;
            break;
        }
    }
    [scvContent addSubview: whoisView];
    [whoisView setupUIForView];
    float hView = [whoisView showContentOfDomainWithInfo: info];
    
    [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbTop);
        make.top.equalTo(scvContent).offset(scvContent.contentSize.height+mTop);
        make.height.mas_equalTo(hView);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH,  scvContent.contentSize.height + hView + mTop);
}

- (void)addWhoIsResultViewWithInfo: (NSDictionary *)info withIndex:(int)index {
    float mTop = 0;
    if (index > 0) {
        if (!IS_IPHONE && !IS_IPOD) {
            mTop = 20.0;
        }else{
            mTop = 10.0;
        }
    }
    
    WhoIsDomainView *whoisView;
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsDomainView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsDomainView class]]) {
            whoisView = (WhoIsDomainView *) currentObject;
            break;
        }
    }
    [whoisView resetAllValueForView];
    [scvContent addSubview:whoisView];
    [whoisView setupUIForView];
    float hView = [whoisView showContentOfDomainWithInfo: info];
    
    [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbTop);
        make.top.equalTo(scvContent).offset(scvContent.contentSize.height + mTop);
        make.height.mas_equalTo(hView);
    }];
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH,  scvContent.contentSize.height + hView + mTop);
}

- (void)showDomainList {
    for (int index=0; index<listResults.count; index++) {
        NSDictionary *info = [listResults objectAtIndex: index];
        id available = [info objectForKey:@"available"];
        if (available != nil) {
            [self addAvailableForViewWithInfo: info withIndex: index];
        }else{
            [self addWhoIsResultViewWithInfo: info withIndex: index];
        }
    }
}

- (void)checkWhoIsForListDomains {
    if (listSearch.count > 0) {
        NSString *domain = [listSearch firstObject];
        [listSearch removeObjectAtIndex: 0];
        
        [WebServiceUtils getInstance].delegate = self;
        [[WebServiceUtils getInstance] searchDomainWithName:domain type:1];
        
        [WriteLogsUtils writeLogContent:SFM(@"[%s] domain = %@", __FUNCTION__, domain)];
    }else{
        [ProgressHUD dismiss];
        [self showDomainList];
    }
}

- (void)changeUIWhenSelectOrRemoveDomainFormCart {
    [self checkToEnableContinueButton];
}

#pragma mark - Webserice

- (void)failedToSearchDomainWithError:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@", __FUNCTION__, @[error])];
    
    if ([error isKindOfClass:[NSDictionary class]]) {
        [listResults addObject: error];
    }
    [self checkWhoIsForListDomains];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] Function = %@", __FUNCTION__, @[data])];
    
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [listResults addObject: data];
    }
    [self checkWhoIsForListDomains];
}

- (IBAction)btnContinuePress:(UIButton *)sender {
    [[AppDelegate sharedInstance] showCartScreenContent];
}
@end
