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

#pragma mark - UITableview Delegate & Data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [actionSheet addAction:[UIAlertAction actionWithTitle:@"Đóng" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
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
