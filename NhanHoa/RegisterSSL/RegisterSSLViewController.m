//
//  RegisterSSLViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterSSLViewController.h"
#import "SSLTbvCell.h"

@interface RegisterSSLViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RegisterSSLViewController
@synthesize tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký SSL";
    [self setupUIForView];
}

- (void)setupUIForView
{
    [tbContent registerNib:[UINib nibWithNibName:@"SSLTbvCell" bundle:nil] forCellReuseIdentifier:@"SSLTbvCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSLTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float mTop = 15.0;
    float paddingContent = 7.0;
    return paddingContent + 60 + 11*40.0 + 11*1.0 + mTop + 45.0 + mTop + paddingContent + mTop;
}

@end
