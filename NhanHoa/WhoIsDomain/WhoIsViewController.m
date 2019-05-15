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

@interface WhoIsViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listDomain;
}

@end

@implementation WhoIsViewController
@synthesize tbContent, btnSearch, padding;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tra cứu tên miền";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    if (listDomain == nil) {
        listDomain = [[NSMutableArray alloc] init];
    }else{
        [listDomain removeAllObjects];
    }
    //  [listDomain addObject:@"nongquadi.vn"];
    [listDomain addObject:@""];
    [listDomain addObject:@""];
    [listDomain addObject:@""];
    
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification object:nil];
    */
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}
- (IBAction)btnSearchPress:(UIButton *)sender {
    NSMutableArray *result = [[NSMutableArray alloc] initWithArray: listDomain];
    [result removeObject:@""];
    if (result.count == 0) {
        [self.view makeToast:@"Vui lòng nhập tên miền muốn kiểm tra!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].warningStyle];
        return;
    }
    
    WhoIsResultViewController *whoIsResultVC = [[WhoIsResultViewController alloc] init];
    whoIsResultVC.listSearch = result;
    [self.navigationController pushViewController:whoIsResultVC animated:YES];
}

//  Hiển thị bàn phím
- (void)keyboardWillShow:(NSNotification *)notif {
    CGSize keyboardSize = [[[notif userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-keyboardSize.height);
    }];
}

//  Ẩn bàn phím
- (void)keyboardDidHide: (NSNotification *) notif{
    [tbContent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnSearch).offset(-self.padding);
    }];
}

- (void)setupUIForView {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    padding = 15.0;
    btnSearch.layer.cornerRadius = 40.0/2;
    btnSearch.backgroundColor = BLUE_COLOR;
    btnSearch.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(self.padding);
        make.bottom.right.equalTo(self.view).offset(-self.padding);
        make.height.mas_equalTo(40.0);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"WhoIsCell" bundle:nil] forCellReuseIdentifier:@"WhoIsCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnSearch.mas_top).offset(-self.padding);
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
    
    UILabel *lbTbHeader = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, headerView.frame.size.width-2*padding, headerView.frame.size.height)];
    lbTbHeader.textAlignment = NSTextAlignmentCenter;
    lbTbHeader.text = @"Nhập một hay nhiều tên miền bạn muốn tra cứu";
    lbTbHeader.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbTbHeader.textColor = TITLE_COLOR;
    [headerView addSubview: lbTbHeader];
    tbContent.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
    UIButton *btnTbFooter = [UIButton buttonWithType: UIButtonTypeCustom];
    btnTbFooter.frame = CGRectMake(padding, footerView.frame.size.height-40.0, footerView.frame.size.width-2*padding, 40.0);
    btnTbFooter.layer.cornerRadius = 5.0;
    btnTbFooter.backgroundColor = [UIColor colorWithRed:(172/255.0) green:(185/255.0) blue:(202/255.0) alpha:1.0];
    NSAttributedString *content = [AppUtils generateTextWithContent:@"Thêm tên miền" font:[UIFont fontWithName:RobotoRegular size:16.0] color:UIColor.whiteColor image:[UIImage imageNamed:@"add"] size:20.0 imageFirst:YES];
    [btnTbFooter setAttributedTitle:content forState:UIControlStateNormal];
    [btnTbFooter addTarget:self
                    action:@selector(addNewRowForDomain)
          forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview: btnTbFooter];
    
    tbContent.tableFooterView = footerView;
}

- (void)addNewRowForDomain {
    if (listDomain.count == 5 || listDomain.count > 5) {
        self.view.clipsToBounds = NO;
        [self.view makeToast:@"Vượt quá số lượng tìm kiếm" duration:2.0 position:CSToastPositionTop style:[AppDelegate sharedInstance].warningStyle];
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
    return 48.0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing: YES];
    CGPoint scrollViewOffset = scrollView.contentOffset;
    if (scrollViewOffset.y < 0) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
}

@end
