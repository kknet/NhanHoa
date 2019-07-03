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
}
@end

@implementation WhoIsResultViewController
@synthesize scvContent, listSearch, padding, whoisView, noResultView, btnContinue;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    padding = 15.0;
    
    [self setupUIForView];
    self.title = @"Kết quả tra cứu";
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
    [ProgressHUD show:@"Đang kiểm tra..." Interaction:NO];
    
    [self checkWhoIsForListDomains];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUIWhenSelectOrRemoveDomainFormCart)
                                                 name:@"selectedOrRemoveDomainFromCart" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
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
    
    [self checkToEnableContinueButton];
    btnContinue.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    btnContinue.layer.cornerRadius = 45.0/2;
    [btnContinue setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.bottom.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(45.0);
    }];
    
    scvContent.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    scvContent.backgroundColor = LIGHT_GRAY_COLOR;
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.bottom.equalTo(self.btnContinue.mas_top).offset(-self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH);
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

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

- (void)addAvailableForViewWithInfo: (NSDictionary *)info withIndex: (int)index {
    float mTop = (index > 0)? 10.0 : 0.0;
    
    WhoIsNoResult *whoisView;
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"WhoIsNoResult" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[WhoIsNoResult class]]) {
            whoisView = (WhoIsNoResult *) currentObject;
            break;
        }
    }
    
    float textSize = [AppUtils getSizeWithText:whoisView.lbContent.text withFont:[AppDelegate sharedInstance].fontRegular andMaxWidth:(SCREEN_WIDTH-2*padding)].height;
    float hView = 60 + 35.0 + 10.0 + textSize + 10.0 + 65.0 + padding;
    [scvContent addSubview: whoisView];
    [whoisView setupUIForView];
    [whoisView showContentOfDomainWithInfo: info];
    
    [whoisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(self.scvContent.contentSize.height+mTop);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH,  scvContent.contentSize.height + hView + mTop);
}

- (void)addWhoIsResultViewWithInfo: (NSDictionary *)info withIndex:(int)index {
    float mTop = (index > 0)? 10.0 : 0.0;
    
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
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.scvContent).offset(self.scvContent.contentSize.height + mTop);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hView);
    }];
    whoisView.backgroundColor = UIColor.orangeColor;
    
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
