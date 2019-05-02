//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "ProfileListViewController.h"
#import "DomainProfileCell.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource>{
    float hCell;
    float hSmallCell;
}

@end

@implementation PaymentViewController
@synthesize viewMenu, scvContent, tbContent, btnPayment;
@synthesize hMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký tên miền";
    [self setupUIForView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUIForView {
    float padding = 15.0;
    hMenu = 60.0;
    hCell = 115.0;  //  10 + 35 + 60 + 10
    hSmallCell = 55; //  10 + 35 + 10;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
    [self addStepMenuForView];
    
    float hTableView = 2 * hCell;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent registerNib:[UINib nibWithNibName:@"DomainProfileCell" bundle:nil] forCellReuseIdentifier:@"DomainProfileCell"];
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scvContent);
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(hTableView);
    }];
    
    float hScroll = SCREEN_HEIGHT - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height);
    
    btnPayment.layer.cornerRadius = 40.0/2;
    btnPayment.backgroundColor = BLUE_COLOR;
    btnPayment.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    
    float curHeight = hMenu + [self getHeightTableView];
    if (curHeight + 2*padding + 40.0 + 2*padding > hScroll) {
        
        [btnPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent).offset(padding);
            make.top.equalTo(self.tbContent.mas_bottom).offset(2*padding);
            make.width.mas_equalTo(SCREEN_WIDTH-padding*2);
            make.height.mas_equalTo(40.0);
        }];
        self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, curHeight + 2*padding + 40.0 + 2*padding);
    }else{
        float mTop = hScroll - (2*padding + 40.0);
        [btnPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent).offset(padding);
            make.top.equalTo(self.scvContent).offset(mTop);
            make.width.mas_equalTo(SCREEN_WIDTH-padding*2);
            make.height.mas_equalTo(40.0);
        }];
        self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hScroll);
    }
    
    [self addListProfileForChoose];
}

- (float)getHeightTableView {
    return hCell + hSmallCell;
}

- (void)addStepMenuForView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"PaymentStepView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[PaymentStepView class]]) {
            viewMenu = (PaymentStepView *) currentObject;
            break;
        }
    }
    [self.scvContent addSubview: viewMenu];
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hMenu);
    }];
    [viewMenu setupUIForView];
    [viewMenu updateUIForStep: ePaymentProfile];
}

- (void)chooseProfile: (UIButton *)sender {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.2;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    
    ProfileListViewController *profileListVC = [[ProfileListViewController alloc] initWithNibName:@"ProfileListViewController" bundle:nil];
    [self.navigationController pushViewController:profileListVC animated:NO];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DomainProfileCell *cell = (DomainProfileCell *)[tableView dequeueReusableCellWithIdentifier:@"DomainProfileCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbDomain.text = @"lanhquadi.com";
        //cell.lbProfileDesc.text = [NSString stringWithFormat:@"Loại tên miền: Cá nhân\nHồ sơ: Nguyễn Thị Hoa"];
        cell.lbProfileDesc.text = [NSString stringWithFormat:@"Loại tên miền: Doanh nghiệp\nTên công ty: Cơm trưa Anzi\nHồ sơ: Nguyễn Thị Hoa"];
        [cell.btnChooseProfile setTitle:@"Đã chọn" forState:UIControlStateNormal];
        [cell showProfileView: TRUE];
    }else{
        cell.lbDomain.text = @"lanhquadi.com.vn";
        cell.lbProfileDesc.text = [NSString stringWithFormat:@"Loại tên miền: Doanh nghiệp\nTên công ty: Cơm trưa Anzi\nHồ sơ: Nguyễn Thị Hoa"];
        [cell.btnChooseProfile setTitle:@"Chọn hồ sơ" forState:UIControlStateNormal];
        [cell showProfileView: FALSE];
    }
    cell.btnChooseProfile.tag = indexPath.row;
    [cell.btnChooseProfile addTarget:self
                              action:@selector(chooseProfile:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return hCell;
    }else{
        return hSmallCell;
    }
}



@end
