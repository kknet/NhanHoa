//
//  OrdersListViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrdersListViewController.h"
#import "OrderDetailViewController.h"
#import "HostingUpgradeViewController.h"
#import "OrderTbvCell.h"

@interface OrdersListViewController ()<UITableViewDelegate, UITableViewDataSource>{
    float padding;
    NSMutableArray *listData;
}

@end

@implementation OrdersListViewController
@synthesize tfSearch, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Danh sách đơn hàng";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self createDemoDatas];
}

- (void)setupUIForView {
    padding = 15.0;
    [tfSearch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"OrderTbvCell" bundle:nil] forCellReuseIdentifier:@"OrderTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.showsVerticalScrollIndicator = FALSE;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(tfSearch.mas_bottom).offset(padding);
    }];
}

- (void)createDemoDatas {
    listData = [[NSMutableArray alloc] init];
    
    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD896893", @"ord_id", @"bsnhakhoa.net", @"domain", @"DT tên miền quốc tế .NET", @"name", @"0", @"price", @"28/06/2020", @"create_date", @"28/06/2021", @"end_date", @"1", @"status", nil];
    [listData addObject: info];
    
    NSDictionary *info1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD896863", @"ord_id", @"lehson.name.vn", @"domain", @"DT tên miền quốc gia .NAME.VN", @"name", @"0", @"price", @"14/07/2019", @"create_date", @"14/07/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info1];
    
    NSDictionary *info2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD886198", @"ord_id", @"sonlh1984.name.vn", @"domain", @"Tài khoản trả trước", @"name", @"0", @"price", @"28/06/2020", @"create_date", @"28/06/2021", @"end_date", @"1", @"status", nil];
    [listData addObject: info2];
    
    NSDictionary *info3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD896893", @"ord_id", @"bsnhakhoa.net", @"domain", @"DT tên miền quốc tế .NET", @"name", @"0", @"price", @"", @"create_date", @"", @"end_date", @"1", @"status", nil];
    [listData addObject: info3];
    
    NSDictionary *info4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD886195", @"ord_id", @"sonlh1984.name.vn", @"domain", @"ĐK tên miền quốc gia .NAME.VN", @"name", @"0", @"price", @"", @"create_date", @"", @"end_date", @"1", @"status", nil];
    [listData addObject: info4];
    
    NSDictionary *info5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD885825", @"ord_id", @"lehoangson.net", @"domain", @"DT tên miền quốc tế .NET", @"name", @"0", @"price", @"16/06/2025", @"create_date", @"16/06/2025", @"end_date", @"1", @"status", nil];
    [listData addObject: info5];
    
    NSDictionary *info6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD885816", @"ord_id", @"vnnic.vn", @"domain", @"Tranfer tên miền quốc gia .VN", @"name", @"0", @"price", @"", @"create_date", @"", @"end_date", @"1", @"status", nil];
    [listData addObject: info6];
    
    NSDictionary *info7 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882872", @"ord_id", @"lehoangson.net", @"domain", @"ĐK Email Hosting – BASIC 1 (Space:20GB;Email:50)", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/01/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info7];
    
    NSDictionary *info8 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882870", @"ord_id", @"nooplinux.com", @"domain", @"ĐK Email - Web4s Enterprise", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/07/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info8];
    
    NSDictionary *info9 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882867", @"ord_id", @"webpro.vn", @"domain", @"ĐK Email Hosting – CLASSIC 2 (Space:10GB;Email:20)", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/07/2020", @"end_date", @"1", @"status", nil];
    [listData addObject: info9];
    
    NSDictionary *info10 = [[NSDictionary alloc] initWithObjectsAndKeys:@"ORD882223", @"ord_id", @"lehoangson.com", @"domain", @"ĐK tên miền quốc tế .COM", @"name", @"0", @"price", @"05/07/2019", @"create_date", @"05/07/2021", @"end_date", @"1", @"status", nil];
    [listData addObject: info10];
}

#pragma mark - UITableview Delegate & Data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listData objectAtIndex: indexPath.row];
    cell.lbService.text = [info objectForKey:@"name"];
    cell.lbOrID.text = [info objectForKey:@"ord_id"];
    cell.lbDomain.text = [info objectForKey:@"domain"];
    
    NSString *price = [AppUtils convertStringToCurrencyFormat:[info objectForKey:@"price"]];
    cell.lbMoney.text = SFM(@"%@ đ", price);
    
    cell.lbTime.text = SFM(@"[%@ - %@]", [info objectForKey:@"create_date"], [info objectForKey:@"end_date"]);
    
    cell.lbStatus.attributedText = [AppUtils generateTextWithContent:@"Đã kích hoạt" font:[AppDelegate sharedInstance].fontRegular color:GREEN_COLOR image:[UIImage imageNamed:@"tick_green"] size:16.0 imageFirst:TRUE];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:text_close style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Xem chi tiết" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc] initWithNibName:@"OrderDetailViewController" bundle:nil];
            [self.navigationController pushViewController:orderDetailVC animated:TRUE];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Gia hạn dịch vụ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }]];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Nâng cấp dịch vụ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            HostingUpgradeViewController *hostingUpgradeVC = [[HostingUpgradeViewController alloc] initWithNibName:@"HostingUpgradeViewController" bundle:nil];
            [self.navigationController pushViewController:hostingUpgradeVC animated:TRUE];
        }]];
        
        // Present action sheet.
        [self presentViewController:actionSheet animated:YES completion:nil];
    });
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

@end
