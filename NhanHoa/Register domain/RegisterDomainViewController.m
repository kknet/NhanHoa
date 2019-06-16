//
//  RegisterDomainViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 4/23/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterDomainViewController.h"
#import "SearchDomainViewController.h"
#import "RenewedDomainViewController.h"
#import "WhoIsViewController.h"
#import "SuggestDomainCell.h"

@interface RegisterDomainViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, UITextFieldDelegate>{
    NSMutableArray *listData;
}

@end

@implementation RegisterDomainViewController
@synthesize scvContent, tfSearch, lbWWW, icSearch, viewInfo, lbTitle, viewSearch, imgSearch, lbSearch, viewRenew, imgRenew, lbRenew, viewTransferDomain, imgTransferDomain, lbTransferDomain, lbSepa, lbManyOptions, tbContent;
@synthesize hCell, padding, hBanner, viewBanner;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký tên miền";
    
    [self createListDomainPrice];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"RegisterDomainViewController"];
    
    [self reUpdateLayoutForView];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createListDomainPrice {
    listData = [[NSMutableArray alloc] init];
    id listPrice = [[AppDelegate sharedInstance].userInfo objectForKey:@"list_price"];
    if (listPrice != nil && [listPrice isKindOfClass:[NSArray class]]) {
        listData = [[NSMutableArray alloc] initWithArray:listPrice];
    }
}

- (void)reUpdateLayoutForView {
    float hTableView = listData.count * hCell;
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbManyOptions.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
}

- (void)viewDidLayoutSubviews {
    float contentSize = tbContent.frame.origin.y + listData.count * hCell + self.padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, contentSize);
}

- (void)addBannerImageForView
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if ([AppDelegate sharedInstance].userInfo != nil)
    {
        if (viewBanner == nil) {
            NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"BannerSliderView" owner:nil options:nil];
            for(id currentObject in toplevelObject){
                if ([currentObject isKindOfClass:[BannerSliderView class]]) {
                    viewBanner = (BannerSliderView *) currentObject;
                    break;
                }
            }
            [self.scvContent addSubview: viewBanner];
        }
        [viewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.scvContent);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(self.hBanner);
        }];
        
        viewBanner.hBanner = hBanner;
        [viewBanner setupUIForView];
        [viewBanner showBannersForSliderView];
        
        [self.scvContent bringSubviewToFront: tfSearch];
        [self.scvContent bringSubviewToFront: lbWWW];
        [self.scvContent bringSubviewToFront: icSearch];
    }
}

- (void)setupUIForView {
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    hCell = 90.0;
    
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    padding = 15.0;
    hBanner = 150.0;
    
    [self addBannerImageForView];
    
    viewBanner.clipsToBounds = YES;
    [viewBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hBanner);
    }];
    
    
    //  search UI
    float hSearch = 38.0;
    tfSearch.text = @"";
    tfSearch.backgroundColor = UIColor.whiteColor;
    tfSearch.layer.cornerRadius = hSearch/2;
    tfSearch.layer.borderColor = [UIColor colorWithRed:(86/255.0) green:(149/255.0) blue:(228/255.0) alpha:1.0].CGColor;
    tfSearch.layer.borderWidth = 2;
    tfSearch.font = [UIFont fontWithName:RobotoMedium size:16.0];
    tfSearch.textColor = TITLE_COLOR;
    tfSearch.returnKeyType = UIReturnKeyDone;
    tfSearch.delegate = self;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
        make.centerY.equalTo(self.viewBanner.mas_bottom);
        make.height.mas_equalTo(hSearch);
    }];
    tfSearch.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, hSearch)];
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
        make.width.mas_equalTo(60);
    }];
    
    //  info view
    float hItemView = 80.0;
    float hInfo = hSearch/2 + 10.0 + 40.0 + hItemView + 20.0;
    viewInfo.backgroundColor = UIColor.clearColor;
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewBanner.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hInfo);
    }];
    
    NSAttributedString *contentStr = [AppUtils generateTextWithContent:@"Nên đặt tên miền như thế nào?" font:[AppDelegate sharedInstance].fontRegular color:NEW_PRICE_COLOR image:[UIImage imageNamed:@"info_red"] size:20.0 imageFirst:TRUE];
    lbTitle.attributedText = contentStr;
    lbTitle.textAlignment = NSTextAlignmentCenter;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(hSearch/2 + 10.0);
        make.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(40.0);
    }];
    
    float sizeItem = (SCREEN_WIDTH - 2*padding - 2*5)/3;
    
    //  view re-order domain
    UIImage *itemImg = [UIImage imageNamed:@"search_multi_domain"];
    float wItemImg = 50.0;
    float hItemImg = wItemImg * itemImg.size.height / itemImg.size.width;
    float smallPadding = 4.0;
    viewRenew.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [viewRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.mas_equalTo(sizeItem);
        make.height.mas_equalTo(hItemView);
    }];
    UITapGestureRecognizer *tapRenew = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSearchDomains)];
    viewRenew.userInteractionEnabled = TRUE;
    [viewRenew addGestureRecognizer: tapRenew];
    
    lbRenew.textColor = UIColor.whiteColor;
    lbRenew.font = [UIFont fontWithName:RobotoRegular size:13];
    lbRenew.text = @"Kiểm tra nhiều tên miền";
    lbRenew.numberOfLines = 5.0;
    [lbRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewRenew.mas_centerY);
        make.left.equalTo(self.viewRenew).offset(3.0);
        make.right.equalTo(self.viewRenew).offset(-3.0);
    }];
    
    imgRenew.image = itemImg;
    [imgRenew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbRenew.mas_top).offset(-smallPadding);
        make.centerX.equalTo(self.viewRenew.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    //  view check multi domain
    viewSearch.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [viewSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewRenew);
        make.right.equalTo(self.viewRenew.mas_left).offset(-5.0);
        make.width.mas_equalTo(sizeItem);
    }];
    UITapGestureRecognizer *tapSearchDomain = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToRenewDomains)];
    viewSearch.userInteractionEnabled = TRUE;
    [viewSearch addGestureRecognizer: tapSearchDomain];
    
    lbSearch.textColor = lbRenew.textColor;
    lbSearch.font = lbRenew.font;
    lbSearch.text = @"Gia hạn tên miền";
    lbSearch.numberOfLines = 5.0;
    [lbSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewSearch.mas_centerY);
        make.left.equalTo(self.viewSearch).offset(3.0);
        make.right.equalTo(self.viewSearch).offset(-3.0);
    }];
    
    imgSearch.image = itemImg;
    [imgSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbSearch.mas_top).offset(-smallPadding);
        make.centerX.equalTo(self.viewSearch.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    //  view transfer domain
    viewTransferDomain.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    [viewTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.viewRenew);
        make.left.equalTo(self.viewRenew.mas_right).offset(5.0);
        make.width.mas_equalTo(sizeItem);
    }];
    
    lbTransferDomain.textColor = lbRenew.textColor;
    lbTransferDomain.font = lbRenew.font;
    lbTransferDomain.text = @"Chuyển tên miền về Nhân Hoà";
    lbTransferDomain.numberOfLines = 5.0;
    [lbTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewTransferDomain.mas_centerY);
        make.left.equalTo(self.viewTransferDomain).offset(3.0);
        make.right.equalTo(self.viewTransferDomain).offset(-3.0);
    }];
    
    imgTransferDomain.image = itemImg;
    [imgTransferDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lbTransferDomain.mas_top).offset(-smallPadding);
        make.centerX.equalTo(self.viewTransferDomain.mas_centerX);
        make.width.mas_equalTo(wItemImg);
        make.height.mas_equalTo(hItemImg);
    }];
    
    //  sepa
    lbSepa.backgroundColor = BORDER_COLOR;
    lbSepa.adjustsFontSizeToFitWidth = NO;
    lbSepa.lineBreakMode = NSLineBreakByTruncatingTail;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(1.0);
    }];
    
    //  many options
    lbManyOptions.text = @"Nhiều lựa chọn với ưu đãi hấp dẫn";
    lbManyOptions.font = [UIFont fontWithName:RobotoBold size:16.0];
    lbManyOptions.textColor = [UIColor colorWithRed:(57/255.0) green:(65/255.0) blue:(86/255.0) alpha:1.0];
    [lbManyOptions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbSepa.mas_bottom).offset(20.0);
        make.left.equalTo(self.scvContent).offset(self.padding);
        make.width.mas_equalTo(SCREEN_WIDTH-2*self.padding);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"SuggestDomainCell" bundle:nil] forCellReuseIdentifier:@"SuggestDomainCell"];
    tbContent.backgroundColor = UIColor.clearColor;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.scrollEnabled = NO;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbManyOptions.mas_bottom).offset(self.padding);
        make.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.scvContent).offset(-5.0);
    }];
}

- (IBAction)icSearchClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] search text = %@", __FUNCTION__, tfSearch.text)];
    
    [self.view endEditing: TRUE];
    
    if ([AppUtils isNullOrEmpty: tfSearch.text]) {
        [self.view makeToast:@"Vui lòng nhập tên miền muốn kiểm tra!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    SearchDomainViewController *searchDomainVC = [[SearchDomainViewController alloc] init];
    searchDomainVC.strSearch = tfSearch.text;
    [self.navigationController pushViewController:searchDomainVC animated:YES];
}

- (void)tapToSearchDomains {
    WhoIsViewController *whoisVC = [[WhoIsViewController alloc] initWithNibName:@"WhoIsViewController" bundle:nil];
    [self.navigationController pushViewController: whoisVC animated:TRUE];
}

- (void)tapToRenewDomains {
    RenewedDomainViewController *renewedVC = [[RenewedDomainViewController alloc] initWithNibName:@"RenewedDomainViewController" bundle:nil];
    [self.navigationController pushViewController: renewedVC animated:TRUE];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SuggestDomainCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SuggestDomainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listData objectAtIndex: indexPath.row];
    NSString *name = [info objectForKey:@"name"];
    id price = [info objectForKey:@"price"];
    
    if ([price isKindOfClass:[NSNumber class]]) {
        NSString *strPrice = [NSString stringWithFormat:@"%d", [price intValue]];
        cell.lbPrice.text = [NSString stringWithFormat:@"%@đ/năm", [AppUtils convertStringToCurrencyFormat: strPrice]];
        
    }else if ([price isKindOfClass:[NSString class]]) {
        cell.lbPrice.text = [NSString stringWithFormat:@"%@đ/năm", [AppUtils convertStringToCurrencyFormat: (NSString *)price]];
    }
    
    NSString *image = name;
    if ([image hasPrefix:@"."]) {
        image = [image substringFromIndex: 1];
    }
    cell.imgType.image = [UIImage imageNamed: image];
    
    cell.lbDomain.text = @"Không yêu cầu điều kiện đi kèm";
    
    cell.padding = padding;
    cell.hItem = hCell;
    [cell addBoxShadowForView:cell.viewParent withColor:UIColor.blackColor];
    [cell showOldPriceForCell: FALSE];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
    [self.view endEditing: TRUE];
    
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == tfSearch) {
        [tfSearch resignFirstResponder];
    }
    return TRUE;
}

@end
