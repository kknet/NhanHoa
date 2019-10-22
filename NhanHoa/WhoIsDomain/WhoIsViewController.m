//
//  WhoIsViewController.m
//  NhanHoa
//
//  Created by admin on 4/29/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WhoIsViewController.h"
#import "WhoIsResultViewController.h"
#import "WhoIsCell.h"

@interface WhoIsViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    NSMutableArray *listDomain;
    float padding;
    float hCell;
}

@end

@implementation WhoIsViewController
@synthesize tbContent, btnSearch;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = text_search_domains;
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"WhoIsViewController"];
    self.navigationController.navigationBarHidden = FALSE;
    
    if (listDomain == nil) {
        listDomain = [[NSMutableArray alloc] init];
    }else{
        [listDomain removeAllObjects];
    }
    
    NSArray *arr = [tbContent visibleCells];
    for (int i=0; i<arr.count; i++) {
        WhoIsCell *cell = [arr objectAtIndex: i];
        NSString *domain = cell.tfDomain.text;
        if ([domain isEqualToString:@""] || (![AppUtils isNullOrEmpty: domain] && ![listDomain containsObject: domain])) {
            [listDomain addObject: domain];
        }
    }
    
    if (listDomain.count == 0) {
        [listDomain addObject:@""];
        [listDomain addObject:@""];
        [listDomain addObject:@""];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

- (IBAction)btnSearchPress:(UIButton *)sender
{
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    sender.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:BLUE_COLOR forState:UIControlStateNormal];
    [self performSelector:@selector(startSearchDomain) withObject:nil afterDelay:0.05];
}

- (void)startSearchDomain {
    btnSearch.backgroundColor = BLUE_COLOR;
    [btnSearch setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray: listDomain];
    [result removeObject:@""];
    if (result.count == 0) {
        [self.view makeToast:text_enter_domains_to_check duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    [WriteLogsUtils writeLogContent:SFM(@"[%s] list search = %@", __FUNCTION__, @[result])];
    
    WhoIsResultViewController *whoIsResultVC = [[WhoIsResultViewController alloc] init];
    whoIsResultVC.listSearch = result;
    [self.navigationController pushViewController:whoIsResultVC animated:YES];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardHeight);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(btnSearch).offset(-padding);
    }];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [self.view addGestureRecognizer: tapOnScreen];
    
    float hBTN = 45.0;
    float hHeader = 50.0;
    float hFooter = 55.0;
    padding = 15.0;
    hCell = 48.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        hBTN = 55.0;
        padding = 30.0;
        hHeader = 80.0;
        hFooter = 80.0;
        hCell = 65.0;
    }
    
    btnSearch.layer.cornerRadius = hBTN/2;
    btnSearch.backgroundColor = BLUE_COLOR;
    btnSearch.layer.borderColor = BLUE_COLOR.CGColor;
    btnSearch.layer.borderWidth = 1.0;
    btnSearch.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnSearch setTitle:text_check forState:UIControlStateNormal];
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.bottom.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"WhoIsCell" bundle:nil] forCellReuseIdentifier:@"WhoIsCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(btnSearch.mas_top).offset(-padding);
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hHeader)];
    UILabel *lbTbHeader = [[UILabel alloc] init];
    lbTbHeader.numberOfLines = 5;
    lbTbHeader.textAlignment = NSTextAlignmentCenter;
    lbTbHeader.text = enter_one_or_more_domains_you_want_to_check;
    lbTbHeader.font = [AppDelegate sharedInstance].fontRegular;
    lbTbHeader.textColor = TITLE_COLOR;
    [headerView addSubview: lbTbHeader];
    [lbTbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(padding);
        make.right.equalTo(headerView).offset(-padding);
        make.top.bottom.equalTo(headerView);
    }];
    tbContent.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, hFooter)];
    
    UIButton *btnTbFooter = [UIButton buttonWithType: UIButtonTypeCustom];
    btnTbFooter.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnTbFooter.backgroundColor = [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(202/255.0) alpha:1.0];
    btnTbFooter.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnTbFooter setTitle:text_add_more_domains forState:UIControlStateNormal];
    [btnTbFooter addTarget:self
                    action:@selector(addNewRowForDomain)
          forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview: btnTbFooter];
    [btnTbFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).offset(padding);
        make.right.equalTo(footerView).offset(-padding);
        make.centerY.equalTo(footerView.mas_centerY);
        make.height.mas_equalTo(hBTN);
    }];
    
    tbContent.tableFooterView = footerView;
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)addNewRowForDomain {
    if (listDomain.count == 5 || listDomain.count > 5) {
        self.view.clipsToBounds = NO;
        [self.view makeToast:SFM(you_can_check_x_domains_at_time, 5) duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
    }else{
        [listDomain addObject:@""];
        [tbContent reloadData];
        [tbContent scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:listDomain.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

- (void)whenTextfieldDomainChanged: (UITextField *)textfield {
    int index = (int)textfield.tag;
    if (index < listDomain.count) {
        listDomain[index] = textfield.text;
    }
}

- (void)removeDomain: (UIButton *)sender {
    int index = (int)sender.tag;
    if (index < listDomain.count) {
        [listDomain removeObjectAtIndex: index];
        [tbContent reloadData];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    [self.view endEditing: YES];
//    CGPoint scrollViewOffset = scrollView.contentOffset;
//    if (scrollViewOffset.y < 0) {
//        [scrollView setContentOffset:CGPointMake(0, 0)];
//    }
}

#pragma mark - UITextfield delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing: TRUE];
    return TRUE;
}

@end
