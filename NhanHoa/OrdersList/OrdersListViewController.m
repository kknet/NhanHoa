//
//  OrdersListViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrdersListViewController.h"
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
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0;
}

@end
