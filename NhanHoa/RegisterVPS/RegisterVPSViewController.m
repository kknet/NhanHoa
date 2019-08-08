//
//  RegisterVPSViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterVPSViewController.h"
#import "VPSTbvCell.h"

@interface RegisterVPSViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation RegisterVPSViewController
@synthesize tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký VPS";
    
    [self setupUIForView];
}

- (void)setupUIForView {
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.showsVerticalScrollIndicator = FALSE;
    [tbContent registerNib:[UINib nibWithNibName:@"VPSTbvCell" bundle:nil] forCellReuseIdentifier:@"VPSTbvCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
}

#pragma mark - UITableviewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VPSTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VPSTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setupAttrContent];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float paddingContent = 7.0;
    float mTop = 15.0;
    
    return paddingContent + 60.0 + 8*45.0 + 8*1.0 + mTop + [AppDelegate sharedInstance].hTextfield + mTop + paddingContent + mTop;
}

@end
