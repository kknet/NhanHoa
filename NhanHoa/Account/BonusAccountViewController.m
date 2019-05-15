//
//  BonusAccountViewController.m
//  NhanHoa
//
//  Created by admin on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "BonusAccountViewController.h"
#import "BonusHistoryCell.h"

@interface BonusAccountViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BonusAccountViewController
@synthesize viewInfo, imgBackground, imgWallet, btnWallet, lbTitle, lbMoney, tbHistory, btnWithdrawal;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tài khoản thưởng";
    [self setupUIForView];
}

- (IBAction)btnWithdrawalPress:(UIButton *)sender {
}

- (void)setupUIForView {
    float hInfo = 140.0;
    float padding = 15.0;
    
    //  view info
    [viewInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hInfo);
    }];
    
    imgWallet.hidden = TRUE;
    imgWallet.layer.cornerRadius = 50.0/2;
    imgWallet.clipsToBounds = TRUE;
    [imgWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    btnWallet.imageEdgeInsets = UIEdgeInsetsMake(12, 12, 12, 12);
    btnWallet.layer.cornerRadius = 50.0/2;
    btnWallet.layer.borderWidth = 1.0;
    btnWallet.layer.borderColor = UIColor.whiteColor.CGColor;
    btnWallet.backgroundColor = GREEN_COLOR;
    [btnWallet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo).offset(padding);
        make.centerX.equalTo(self.viewInfo.mas_centerX);
        make.width.height.mas_equalTo(50.0);
    }];
    
    imgBackground.layer.cornerRadius = 7.0;
    imgBackground.backgroundColor = GREEN_COLOR;
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btnWallet.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.bottom.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    lbTitle.font = [UIFont fontWithName:RobotoRegular size:16.0];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imgBackground.mas_centerY);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
        make.height.mas_equalTo(25.0);
    }];
    
    lbMoney.font = [UIFont fontWithName:RobotoMedium size:22.0];
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.equalTo(self.viewInfo).offset(padding);
        make.right.equalTo(self.viewInfo).offset(-padding);
    }];
    
    btnWithdrawal.layer.cornerRadius = 50.0/2;
    btnWithdrawal.backgroundColor = BLUE_COLOR;;
    btnWithdrawal.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    [btnWithdrawal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.0)];
    UILabel *lbHeader = [[UILabel alloc] initWithFrame:CGRectMake(padding, 0, headerView.frame.size.width-padding, headerView.frame.size.height)];
    lbHeader.font = [UIFont fontWithName:RobotoMedium size:18.0];
    lbHeader.text = @"Lịch sử thưởng gần đây";
    lbHeader.textColor = TITLE_COLOR;
    lbHeader.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview: lbHeader];
    tbHistory.tableHeaderView = headerView;
    
    UIImageView *imgSepa = [[UIImageView alloc] initWithFrame:CGRectMake(lbHeader.frame.origin.x, headerView.frame.size.height-1, lbHeader.frame.size.width, 1.0)];
    imgSepa.image = [UIImage imageNamed:@"dashline"];
    [headerView addSubview: imgSepa];
    
    tbHistory.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbHistory.delegate = self;
    tbHistory.dataSource = self;
    [tbHistory registerNib:[UINib nibWithNibName:@"BonusHistoryCell" bundle:nil] forCellReuseIdentifier:@"BonusHistoryCell"];
    [tbHistory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewInfo.mas_bottom);
        make.bottom.equalTo(self.btnWithdrawal.mas_top).offset(-10.0);
        make.left.right.equalTo(self.view);
    }];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BonusHistoryCell *cell = (BonusHistoryCell *)[tableView dequeueReusableCellWithIdentifier:@"BonusHistoryCell" forIndexPath:indexPath];
    
    cell.lbActionName.text = @"Nạp tiền vào tài khoản";
    cell.lbDateTime.text = @"10:15 | 28/03/2019";
    cell.lbValue.text = @"+50.000Đ";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

@end
