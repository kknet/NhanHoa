//
//  NotifyViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "NotifyViewController.h"
#import "NotificationCell.h"

@interface NotifyViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *listDemo;
}

@end

@implementation NotifyViewController
@synthesize tbNotify;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Thông báo";
    [self setupUIForView];
    [self createDataForDemo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createDataForDemo {
    listDemo = [[NSMutableArray alloc] init];
    
    NSDictionary *item1 = [[NSDictionary alloc] initWithObjectsAndKeys:@"menu_bonus.png", @"image", @"Tiền thưởng ", @"title", @"Bạn được cộng 50.000đ từ giao dịch thanh toán ID123456. Vào tài khoản để kiểm tra", @"content", @"10:25 | 01/05/2019", @"datetime", nil];
    [listDemo addObject: item1];
    
    NSDictionary *item2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"menu_support.png",@"image",@"Thanh toán thành công",@"title",@"Thanh toán thành công đơn hàng ID123456.\nCảm ơn quý khách!",@"content",@"14:25 | 01/05/2019",@"datetime", nil];
    [listDemo addObject: item2];
    
    NSDictionary *item3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"menu_domain.png",@"image",@"Gia hạn tên miền thành công",@"title",@"Gia hạn tên miền nhipdesign.com thành công.\nCảm ơn quý khác!",@"content",@"12:25 | 07/06/2019",@"datetime", nil];
    [listDemo addObject: item3];
    
    NSDictionary *item4 = [[NSDictionary alloc] initWithObjectsAndKeys:@"menu_search_domain.png",@"image",@"Tên miền sắp hết hạn",@"title",@"Tên miền nhim.design của bạn sẽ hết hạn vào lúc 12:00 20/08/2019. Gia hạn ngay hôm nay!",@"content",@"07:00 | 12/06/2019",@"datetime", nil];
    [listDemo addObject: item4];
    
    NSDictionary *item5 = [[NSDictionary alloc] initWithObjectsAndKeys:@"menu_withdrawal.png",@"image",@"Khuyến mãi",@"title",@"Bạn được cộng 50.000đ từ giao dịch thanh toán ID123456.",@"content",@"19:00 | 14/06/2019",@"datetime", nil];
    [listDemo addObject: item5];
    
    NSDictionary *item6 = [[NSDictionary alloc] initWithObjectsAndKeys:@"menu_profile.png",@"image",@"Nạp tiền thành công",@"title",@"Nạp tiền thành công 1.000.000đ từ thẻ Vietcombank. Cảm ơn quý khách!",@"content",@"07:00 | 14/06/2019",@"datetime", nil];
    [listDemo addObject: item6];
}

- (void)setupUIForView
{
    [tbNotify registerNib:[UINib nibWithNibName:@"NotificationCell" bundle:nil] forCellReuseIdentifier:@"NotificationCell"];
    tbNotify.delegate = self;
    tbNotify.dataSource = self;
    tbNotify.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbNotify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return listDemo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationCell *cell = (NotificationCell *)[tableView dequeueReusableCellWithIdentifier:@"NotificationCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [listDemo objectAtIndex: indexPath.row];
    NSString *image = [info objectForKey:@"image"];
    NSString *title = [info objectForKey:@"title"];
    NSString *content = [info objectForKey:@"content"];
    NSString *datetime = [info objectForKey:@"datetime"];
    
    cell.lbTitle.text = title;
    cell.lbValue.text = content;
    cell.lbDateTime.text = datetime;
    cell.imgType.image = [UIImage imageNamed: image];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 10 + 20 + 30 + 15+ 10;
}

@end
