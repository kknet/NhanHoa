//
//  ProfileManagerViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ProfileManagerViewController.h"
#import "ProfileManagerCell.h"

@interface ProfileManagerViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
}

@end

@implementation ProfileManagerViewController
@synthesize tbProfiles;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Danh sách hồ sơ";
    [self setupUIForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    [tbProfiles registerNib:[UINib nibWithNibName:@"ProfileManagerCell" bundle:nil] forCellReuseIdentifier:@"ProfileManagerCell"];
    tbProfiles.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbProfiles.delegate = self;
    tbProfiles.dataSource = self;
    [tbProfiles mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProfileManagerCell *cell = (ProfileManagerCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileManagerCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbTypeValue.text = @"Cá nhân";
        cell.lbProfileValue.text = @"Lê Quang Khải";
        
        [cell setupUIForBusiness: FALSE];
        
    }else{
        cell.lbTypeValue.text = @"Công ty";
        cell.lbCompanyValue.text = @"Nhân Hoà Company";
        cell.lbProfileValue.text = @"Lê Quang Khải";
        
        [cell setupUIForBusiness: TRUE];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 75.0;
    }else{
        return 100.0;
    }
}

@end
