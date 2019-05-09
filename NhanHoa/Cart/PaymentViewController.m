//
//  PaymentViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentViewController.h"
#import "DomainProfileCell.h"
#import "CartModel.h"

@interface PaymentViewController ()<UITableViewDelegate, UITableViewDataSource, SelectProfileViewDelegate>{
    float hCell;
    float hSmallCell;
}

@end

@implementation PaymentViewController
@synthesize viewMenu, scvContent, tbContent, btnPayment, chooseProfileView, tbConfirmProfile;
@synthesize hMenu, hTbConfirm;

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
    
    [self addStepMenuForView];
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.bottom.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    
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
    
    float hScroll = SCREEN_HEIGHT - ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height + hMenu);
    
    float hBTN = 45.0;
    btnPayment.layer.cornerRadius = hBTN/2;
    btnPayment.backgroundColor = BLUE_COLOR;
    btnPayment.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    
    float curHeight = [self getHeightTableView];
    if (curHeight + 2*padding + hBTN + 2*padding > hScroll) {
        
        [btnPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent).offset(padding);
            make.top.equalTo(self.tbContent.mas_bottom).offset(2*padding);
            make.width.mas_equalTo(SCREEN_WIDTH-padding*2);
            make.height.mas_equalTo(hBTN);
        }];
        self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, curHeight + 2*padding + hBTN + 2*padding);
    }else{
        float mTop = hScroll - (2*padding + hBTN);
        [btnPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.scvContent).offset(padding);
            make.top.equalTo(self.scvContent).offset(mTop);
            make.width.mas_equalTo(SCREEN_WIDTH-padding*2);
            make.height.mas_equalTo(hBTN);
        }];
        self.scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hScroll);
    }
    
    [self addListProfileForChoose];
    
    //  setup for confỉm profile table view
    hTbConfirm = SCREEN_HEIGHT - ([AppDelegate sharedInstance].hStatusBar + self.navigationController.navigationBar.frame.size.height + hMenu);
    
    tbConfirmProfile.hidden = TRUE;
    [tbConfirmProfile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.height.mas_equalTo(self.hTbConfirm);
    }];
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
    [self.view addSubview: viewMenu];
    [viewMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(self.hMenu);
    }];
    [viewMenu setupUIForView];
    [viewMenu updateUIForStep: ePaymentProfile];
}

#pragma mark - SelectProfileViewDelegate

- (void)showProfileList: (BOOL)show {
    if (show) {
        [chooseProfileView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self.view);
        }];
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }completion:^(BOOL finished) {
            self.navigationController.navigationBarHidden = show;
        }];
        
    }else{
        self.navigationController.navigationBarHidden = show;
        [chooseProfileView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
            make.left.bottom.right.equalTo(self.view);
        }];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)chooseProfile: (UIButton *)sender {
    if (chooseProfileView.frame.origin.y == 0) {
        [self showProfileList: FALSE];
    }else{
        [self showProfileList: TRUE];
    }
}

- (void)addListProfileForChoose {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"SelectProfileView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[SelectProfileView class]]) {
            chooseProfileView = (SelectProfileView *) currentObject;
            break;
        }
    }
    chooseProfileView.delegate = self;
    chooseProfileView.hHeader = [AppDelegate sharedInstance].hStatusBar + self.navigationController.navigationBar.frame.size.height;
    [self.view addSubview: chooseProfileView];
    [chooseProfileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(SCREEN_HEIGHT);
        make.left.bottom.right.equalTo(self.view);
    }];
    [chooseProfileView setupUIForView];
    
    float wPassport = (SCREEN_WIDTH-3*15.0)/2;
    float hPassport = wPassport * 2/3;
    float hScrollView = 40 + 9*10.0 + 9*30 + 8*38 + hPassport + 2*15 + 40 + 2*15;
    chooseProfileView.scvAddProfile.contentSize = CGSizeMake(SCREEN_WIDTH, hScrollView);
}

- (void)onIconCloseClicked {
    [self showProfileList: FALSE];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[CartModel getInstance] countItemInCart];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DomainProfileCell *cell = (DomainProfileCell *)[tableView dequeueReusableCellWithIdentifier:@"DomainProfileCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *domainInfo = [[CartModel getInstance].listDomain objectAtIndex: indexPath.row];
    NSString *domain = [domainInfo objectForKey:@"domain"];
    
    cell.lbDomain.text = domain;
    
    if (indexPath.row == 0) {
        cell.lbProfileDesc.text = [NSString stringWithFormat:@"Loại tên miền: Doanh nghiệp\nTên công ty: Cơm trưa Anzi\nHồ sơ: Nguyễn Thị Hoa"];
        [cell.btnChooseProfile setTitle:@"Đã chọn" forState:UIControlStateNormal];
        [cell showProfileView: TRUE];
    }else{
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



- (IBAction)btnPaymentPress:(UIButton *)sender {
    [viewMenu updateUIForStep: ePaymentConfirm];
    
    scvContent.hidden = TRUE;
    tbConfirmProfile.hidden = FALSE;
    tbConfirmProfile.backgroundColor = UIColor.redColor;
    [tbConfirmProfile mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewMenu.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.hTbConfirm);
    }];
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
}
@end
