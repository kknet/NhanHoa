//
//  SearchMultiDomainsViewController.m
//  NhanHoa
//
//  Created by OS on 11/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SearchMultiDomainsViewController.h"
#import "SearchResultViewController.h"
#import "WhoIsCell.h"

@interface SearchMultiDomainsViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    AppDelegate *appDelegate;
    float padding;
    float hBTN;
    UIFont *textFont;
    float hCell;
    
    NSMutableArray *listDomain;
}
@end

@implementation SearchMultiDomainsViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvContent, lbTitle, tbDomains, btnCheck, btnAdd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self showContentWithCurrentLanguage];
    
    if (listDomain == nil) {
        listDomain = [[NSMutableArray alloc] init];
    }else{
        [listDomain removeAllObjects];
    }
    
    NSArray *arr = [tbDomains visibleCells];
    for (int i=0; i<arr.count; i++) {
        WhoIsCell *cell = [arr objectAtIndex: i];
        NSString *domain = cell.tfDomain.text;
        if ([domain isEqualToString:@""] || (![AppUtils isNullOrEmpty: domain] && ![listDomain containsObject: domain])) {
            [listDomain addObject: domain];
        }
    }
    
    if (listDomain.count == 0) {
        [listDomain addObject:@"nhanhoa.com.vn"];
        [listDomain addObject:@"khaile76.com.vn"];
        [listDomain addObject:@"taolaobidao.tele"];
    }
    
    [self reUpdateLayoutForView];
    
    //  register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [scvContent mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
}

- (void)reUpdateLayoutForView {
    float hTableView = listDomain.count * hCell;
    [tbDomains mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(hTableView);
    }];
    
    float hContent = 80.0 + hTableView + padding + hBTN;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Check multi domains"];
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"Enter one or multi domains you want to check"];
    [btnCheck setTitle:[appDelegate.localization localizedStringForKey:@"Check"] forState:UIControlStateNormal];
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 50.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hBTN = 45.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hBTN = 48.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hBTN = 50.0;
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
    
    //  footer button
    btnCheck.layer.cornerRadius = 8.0;
    btnCheck.backgroundColor = BLUE_COLOR;
    [btnCheck setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnCheck.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [btnCheck mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-padding-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(hBTN);
    }];
    
    //  scrollview content
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }

    self.view.backgroundColor = scvContent.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(7.0);
        make.left.right.equalTo(self.view);
        //  make.bottom.equalTo(btnCheck.mas_top).offset(-padding);
        make.bottom.equalTo(self.view).offset(-padding - hBTN - appDelegate.safeAreaBottomPadding);
    }];

    lbTitle.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(80.0);
    }];

    //  table
    hCell = 55.0;

    [tbDomains registerNib:[UINib nibWithNibName:@"WhoIsCell" bundle:nil] forCellReuseIdentifier:@"WhoIsCell"];
    tbDomains.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbDomains.backgroundColor = UIColor.clearColor;
    tbDomains.delegate = self;
    tbDomains.dataSource = self;
    tbDomains.scrollEnabled = FALSE;
    [tbDomains mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.right.equalTo(lbTitle);
        make.height.mas_equalTo(0);
    }];

    NSAttributedString *attr = [AppUtils generateTextWithContent:@"" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"add"] size:25.0 imageFirst:TRUE];
    btnAdd.backgroundColor = GRAY_200;
    [btnAdd setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnAdd setAttributedTitle:attr forState:UIControlStateNormal];
    btnAdd.titleLabel.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    btnAdd.layer.cornerRadius = 10.0;
    [btnAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tbDomains.mas_bottom).offset(padding);
        make.left.equalTo(lbTitle).offset(padding);
        make.right.equalTo(lbTitle).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
}
- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnCheckPress:(UIButton *)sender
{
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray: listDomain];
    [result removeObject:@""];
    if (result.count == 0) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Please enter domains you want to check"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    SearchResultViewController *searchResultVC = [[SearchResultViewController alloc] init];
    searchResultVC.listSearch = result;
    [self.navigationController pushViewController:searchResultVC animated:YES];
}

- (IBAction)btnAddPress:(UIButton *)sender {
    if (listDomain.count == 5 || listDomain.count > 5) {
        [self.view makeToast:SFM(@"Bạn chỉ có thể tìm kiếm %d tên miền cùng lúc", 5) duration:2.0 position:CSToastPositionCenter style:appDelegate.warningStyle];
        
    }else{
        [listDomain addObject:@""];
        [tbDomains reloadData];
        
        [self reUpdateLayoutForView];
    }
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listDomain.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WhoIsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WhoIsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.tfDomain.delegate = self;
    cell.tfDomain.returnKeyType = UIReturnKeyDone;
    
    [cell.tfDomain addTarget:self
                      action:@selector(whenTextfieldDomainChanged:)
            forControlEvents:UIControlEventEditingChanged];
    cell.tfDomain.tag = indexPath.row;
    
    [cell.icRemove addTarget:self
                      action:@selector(removeDomain:)
            forControlEvents:UIControlEventTouchUpInside];
    cell.icRemove.tag = indexPath.row;
    
    NSString *domain = [listDomain objectAtIndex: indexPath.row];
    cell.tfDomain.text = domain;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}


- (void)removeDomain: (UIButton *)sender {
    int index = (int)sender.tag;
    if (index < listDomain.count) {
        [listDomain removeObjectAtIndex: index];
        [tbDomains reloadData];
        
        [self reUpdateLayoutForView];
    }
}

- (void)whenTextfieldDomainChanged: (UITextField *)textfield {
    int index = (int)textfield.tag;
    if (index < listDomain.count) {
        listDomain[index] = textfield.text;
    }
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing: TRUE];
    return TRUE;
}

@end
