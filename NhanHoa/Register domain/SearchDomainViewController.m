//
//  SearchDomainViewController.m
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchDomainViewController.h"
#import "DomainObject.h"
#import "DomainCell.h"

@interface SearchDomainViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>{
    NSMutableArray *listData;
    float hCell;
    NSString *strSearch;
}

@end

@implementation SearchDomainViewController

@synthesize viewHeader, icBack, icCart, lbTitle, lbCount;
@synthesize scvContent, lbTop, lbWWW, tfSearch, icSearch, viewResult, imgEmoji, lbSearchContent, viewDomain, lbDomainName, lbPrice, lbOldPrice, lbSepa, btnChoose;
@synthesize lbSepaView, lbRelationDomain, tbDomains;
@synthesize padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createDemoData];
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden: YES];
    strSearch = @"lanhquadi.com";
    
    NSString *content = [NSString stringWithFormat:@"Chúc mừng!\nBạn có thế sử dụng tên miền %@\nĐăng ký ngay để bảo vệ thương hiệu của bạn.", strSearch];
    NSRange range = [content rangeOfString: strSearch];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString: content];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoRegular size:16.0], NSFontAttributeName, TITLE_COLOR, NSForegroundColorAttributeName, nil] range:NSMakeRange(0, content.length)];
        [attr addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:RobotoMedium size:16.0], NSFontAttributeName, BLUE_COLOR, NSForegroundColorAttributeName, nil] range: range];
        lbSearchContent.attributedText = attr;
    }else{
        lbSearchContent.text = content;
    }
    
    tfSearch.text = strSearch;
    
    [self reUpdateLayoutForView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden: NO];
}

-(void)viewDidLayoutSubviews {
    float contentSize = tbDomains.frame.origin.y + listData.count * hCell + self.padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, contentSize);
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icSearchClick:(UIButton *)sender {
}

- (IBAction)btnChoosePress:(UIButton *)sender {
}

- (void)reUpdateLayoutForView {
    float hTableView = listData.count * hCell;
    [tbDomains mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepaView.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
}

- (void)setupUIForView {
    padding = 15.0;
    hCell = 90.0;
    
    //  header view
    float hHeader = [UIApplication sharedApplication].statusBarFrame.size.height + 50.0;
    viewHeader.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:1.0];
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.top.equalTo(self.viewHeader).offset([UIApplication sharedApplication].statusBarFrame.size.height);
        make.bottom.equalTo(self.viewHeader);
        make.width.mas_equalTo(200.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewHeader);
        make.centerY.equalTo(self.lbTitle.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewHeader).offset(-10.0);
        make.centerY.equalTo(self.lbTitle.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.clipsToBounds = TRUE;
    lbCount.layer.cornerRadius = 20.0/2;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:13.5];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.icCart.mas_right);
        make.top.equalTo(self.icCart.mas_top);
        make.width.height.mas_equalTo(20.0);
    }];
    
    scvContent.backgroundColor = [UIColor colorWithRed:(246/255.0) green:(247/255.0) blue:(251/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    float hSearch = 38.0;
    
    lbTop.backgroundColor = viewHeader.backgroundColor;
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hSearch/2);
    }];
    
    tfSearch.font = [UIFont fontWithName:RobotoMedium size:16.0];
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.layer.cornerRadius = hSearch/2;
    tfSearch.layer.borderColor = [UIColor colorWithRed:(86/255.0) green:(149/255.0) blue:(228/255.0) alpha:1.0].CGColor;
    tfSearch.layer.borderWidth = 1.5;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.top.equalTo(self.scvContent);
        make.height.mas_equalTo(hSearch);
    }];
    
    tfSearch.leftView = lbWWW;
    tfSearch.leftViewMode = UITextFieldViewModeAlways;
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hSearch);
    }];
    
    icSearch.layer.cornerRadius = hSearch/2;
    icSearch.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    [icSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.tfSearch);
        make.width.mas_equalTo(hSearch);
    }];
    
    lbWWW.backgroundColor = UIColor.clearColor;
    lbWWW.text = @"WWW.";
    lbWWW.textColor = [UIColor colorWithRed:(41/255.0) green:(121/255.0) blue:(216/255.0) alpha:1.0];
    lbWWW.font = [UIFont fontWithName:RobotoBold size:13.0];
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
    lbSearchContent.font = [UIFont fontWithName:RobotoRegular size:16.0];
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
    
    btnChoose.titleLabel.font = [UIFont fontWithName:RobotoRegular size:15.0];
    btnChoose.backgroundColor = BLUE_COLOR;
    btnChoose.layer.cornerRadius = 36.0/2;
    [btnChoose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.viewDomain).offset(-self.padding);
        make.centerY.equalTo(self.viewDomain.mas_centerY);
        make.height.mas_equalTo(36.0);
        make.width.mas_equalTo(60.0);
    }];
    
    lbDomainName.text = @"lanhquadi.com";
    lbDomainName.font = [UIFont fontWithName:RobotoBold size:16.0];
    lbDomainName.textColor = BLUE_COLOR;
    [lbDomainName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.viewDomain).offset(self.padding);
        make.bottom.equalTo(self.viewDomain.mas_centerY).offset(-2.0);
        make.right.equalTo(self.btnChoose.mas_left).offset(-self.padding);
    }];
    
    lbPrice.text = @"29,000đ";
    lbPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    lbPrice.textColor = NEW_PRICE_COLOR;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbDomainName);
        make.top.equalTo(self.viewDomain.mas_centerY).offset(2.0);
    }];
    
    lbOldPrice.text = @"180,000đ";
    lbOldPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
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
    
    [lbRelationDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepaView.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.height.mas_equalTo(40.0);
    }];
    
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

- (void)createDemoData {
    listData = [[NSMutableArray alloc] init];
    
    DomainObject *domain = [[DomainObject alloc] init];
    domain.domain = @"lanhquadi.org";
    domain.price = @"29000";
    domain.oldPrice = @"180000";
    domain.special = FALSE;
    domain.warning = FALSE;
    domain.warningContent = @"";
    [listData addObject: domain];
    
    DomainObject *domain1 = [[DomainObject alloc] init];
    domain1.domain = @"lanhquadi.top";
    domain1.price = @"100000";
    domain1.oldPrice = @"150000";
    domain1.special = TRUE;
    domain1.warning = FALSE;
    domain1.warningContent = @"";
    [listData addObject: domain1];
    
    DomainObject *domain2 = [[DomainObject alloc] init];
    domain2.domain = @"lanhquadi.org.vn";
    domain2.price = @"350000";
    domain2.oldPrice = @"";
    domain2.special = NO;
    domain2.warning = TRUE;
    domain2.warningContent = @"Tên miền giành cho các tổ chức hoạt động trong lĩnh vực chính trị, văn hoá, xã hội. Cá nhân không thể đăng ký tên miền này!";
    [listData addObject: domain2];
    
    DomainObject *domain3 = [[DomainObject alloc] init];
    domain3.domain = @"lanhquadi.vn";
    domain3.price = @"85000";
    domain3.oldPrice = @"170000";
    domain3.special = FALSE;
    domain3.warning = FALSE;
    domain3.warningContent = @"";
    [listData addObject: domain3];
    
    DomainObject *domain4 = [[DomainObject alloc] init];
    domain4.domain = @"lanhquadi.net.vn";
    domain4.price = @"630000";
    domain4.oldPrice = @"";
    domain4.special = FALSE;
    domain4.warning = FALSE;
    domain4.warningContent = @"";
    [listData addObject: domain4];
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
@end
