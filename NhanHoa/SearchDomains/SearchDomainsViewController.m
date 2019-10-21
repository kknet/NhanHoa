//
//  SearchDomainsViewController.m
//  NhanHoa
//
//  Created by OS on 10/16/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchDomainsViewController.h"

@interface SearchDomainsViewController (){
    AppDelegate *appDelegate;
}
@end

@implementation SearchDomainsViewController
@synthesize viewHeader, icClose, lbHeader, icCart, bgHeader;
@synthesize scvContent, bgTop, viewTop, tfSearch, icSearch, viewCheckMultiDomains, imgCheckMultiDomains, lbCheckMultiDomains, viewRenewDomain, imgRenewDomain, lbRenewDomain, viewTransferDomains, imgTransferDomain, lbTransferDomain, clvSlider, clvPosts, tbDomainsType;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    
}

- (IBAction)icCloseClick:(UIButton *)sender {
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)icSearchClick:(UIButton *)sender {
}

- (void)setupUIForView
{
    float padding = 15.0;
    float hTextfield = 45.0;
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hNav = self.navigationController.navigationBar.frame.size.height;
    
    UIImage *topHeader = [UIImage imageNamed:@"top_header"];
    float hHeader = SCREEN_WIDTH * topHeader.size.height / topHeader.size.width;
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    [bgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewHeader);
    }];
    
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(padding);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40);
    }];
    
    //  content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.backgroundColor = ORANGE_COLOR;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        //  make.top.equalTo(viewHeader.mas_bottom);
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    UIImage *imgTop = [UIImage imageNamed:@"bottom_header"];
    float hTop = SCREEN_WIDTH * imgTop.size.height / imgTop.size.width;
    [bgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTop);
    }];
    
    
    float sizeBlock = (SCREEN_WIDTH - 4*padding)/3;
    
//    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.equalTo(scvContent);
//        make.width.mas_equalTo(SCREEN_WIDTH);
//        make.height.mas_equalTo(hTop);
//    }];
    viewTop.hidden = TRUE;
    viewCheckMultiDomains.hidden = viewRenewDomain.hidden = viewTransferDomains.hidden = TRUE;
    tfSearch.hidden = TRUE;
    tbDomainsType.hidden = TRUE;
    clvPosts.hidden = clvSlider.hidden = TRUE;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
}

@end
