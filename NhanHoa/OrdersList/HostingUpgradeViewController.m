//
//  HostingUpgradeViewController.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "HostingUpgradeViewController.h"
#import "HostingDetailTbvCell.h"
#import "HostingDetailSelectTbvCell.h"

@interface HostingUpgradeViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation HostingUpgradeViewController
@synthesize tbChoosePackage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

- (void)setupUIForView {
    [tbChoosePackage registerNib:[UINib nibWithNibName:@"HostingDetailTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingDetailTbvCell"];
    [tbChoosePackage registerNib:[UINib nibWithNibName:@"HostingDetailSelectTbvCell" bundle:nil] forCellReuseIdentifier:@"HostingDetailSelectTbvCell"];
    
    tbChoosePackage.separatorStyle = UITableViewCellSelectionStyleNone;
    tbChoosePackage.delegate = self;
    tbChoosePackage.dataSource = self;
    [tbChoosePackage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    UILabel *lbHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50.0)];
    lbHeader.textAlignment = NSTextAlignmentCenter;
    lbHeader.text = @"Vui lòng chọn dịch vụ mà bạn muốn chuyển đổi";
    lbHeader.font = [AppDelegate sharedInstance].fontRegular;
    lbHeader.textColor = TITLE_COLOR;
    tbChoosePackage.tableHeaderView = lbHeader;
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == tbChoosePackage) {
        return 1;
    }
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == tbChoosePackage) {
        return 4;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        HostingDetailTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbTitle.text = @"Dịch vụ hiện tại:";
        cell.lbValue.text = @"ĐK Email Hosting – BASIC 1 (Space:20GB;Email:50)";
        return cell;
        
    }else if (indexPath.row == 1) {
        HostingDetailSelectTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailSelectTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbTitle.text = @"Chọn dịch vụ muốn chuyển:";
        cell.tfValue.placeholder = @"--- GIỎ HÀNG ---";
        return cell;
        
    }else if (indexPath.row == 2) {
        HostingDetailSelectTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailSelectTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.lbTitle.text = @"Thời hạn:";
        cell.tfValue.placeholder = @"------";
        
        return cell;
    }else{
        HostingDetailTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HostingDetailTbvCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.lbTitle.text = @"";
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == tbChoosePackage) {
        if (indexPath.row == 0) {
            return 50.0;
        }
        return 70.0;
    }
    return 50.0;
}

@end
