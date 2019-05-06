//
//  ContactInfoViewController.m
//  NhanHoa
//
//  Created by admin on 5/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ContactInfoViewController.h"
#import "ContactInfoCell.h"

@interface ContactInfoViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSString *type;
    NSString *fullname;
    NSString *country;
    NSString *city;
    NSString *district;
    NSString *town;
    NSString *gender;
    NSString *address;
    NSString *phone;
}

@end

@implementation ContactInfoViewController
@synthesize tbContent, btnUpdateInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.title = @"Thông tin liên lạc";
    [self displayInformation];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    if (tbContent.contentSize.height > tbContent.frame.size.height) {
        tbContent.scrollEnabled = TRUE;
    }else{
        tbContent.scrollEnabled = FALSE;
    }
}

- (void)setupUIForView
{
    float padding = 15.0;
    
    btnUpdateInfo.backgroundColor = BLUE_COLOR;
    btnUpdateInfo.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    btnUpdateInfo.layer.cornerRadius = 45.0/2;
    [btnUpdateInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.height.mas_equalTo(45.0);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"ContactInfoCell" bundle:nil] forCellReuseIdentifier:@"ContactInfoCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.btnUpdateInfo.mas_bottom).offset(-2*padding);
    }];
}

- (void)displayInformation {
    type = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_type"];
    if ([AppUtils isNullOrEmpty: type]) {
        type = @"";
    }
    
    fullname = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_realname"];
    if ([AppUtils isNullOrEmpty: fullname]) {
        fullname = @"";
    }
    
    country = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_country"];
    if ([AppUtils isNullOrEmpty: country]) {
        country = @"";
    }
    
    city = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_city"];
    if ([AppUtils isNullOrEmpty: city]) {
        city = @"";
    }
    
    district = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_district"];
    if ([AppUtils isNullOrEmpty: district]) {
        district = @"";
    }
    
    town = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_town"];
    if ([AppUtils isNullOrEmpty: town]) {
        town = @"";
    }
    
    gender = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_gender"];
    if ([AppUtils isNullOrEmpty: gender]) {
        gender = @"";
    }
    
    address = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_address"];
    if ([AppUtils isNullOrEmpty: address]) {
        address = @"";
    }
    
    phone = [[AppDelegate sharedInstance].userInfo objectForKey:@"cus_phone"];
    if ([AppUtils isNullOrEmpty: phone]) {
        phone = @"";
    }
    [tbContent reloadData];
}

#pragma mark - UITableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactInfoCell *cell = (ContactInfoCell *)[tableView dequeueReusableCellWithIdentifier:@"ContactInfoCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case eContactType:{
            cell.lbTitle.text = @"Chủ thể:";
            cell.lbValue.text = type;
            break;
        }
        case eContactName:{
            cell.lbTitle.text = @"Họ tên:";
            cell.lbValue.text = fullname;
            break;
        }
        case eContactCountry:{
            cell.lbTitle.text = @"Quốc gia:";
            cell.lbValue.text = country;
            break;
        }
        case eContactCity:{
            cell.lbTitle.text = @"Thành phố";
            cell.lbValue.text = city;
            break;
        }
        case eContactDistrict:{
            cell.lbTitle.text = @"Quận/huyện:";
            cell.lbValue.text = district;
            break;
        }
        case eContactTown:{
            cell.lbTitle.text = @"Phường/xã:";
            cell.lbValue.text = town;
            break;
        }
        case eContactGender:{
            cell.lbTitle.text = @"Giới tính:";
            if ([gender isEqualToString:@"1"]) {
                cell.lbValue.text = @"Nam";
            }else if ([gender isEqualToString:@"0"]) {
                cell.lbValue.text = @"Nữ";
            }else{
                cell.lbValue.text = @"Chưa cung cấp";
            }
            
            break;
        }
        case eContactAddress:{
            cell.lbTitle.text = @"Địa chỉ:";
            cell.lbValue.text = address;
            break;
        }
        case eContactPhone:{
            cell.lbTitle.text = @"Điện thoại:";
            cell.lbValue.text = phone;
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (IBAction)btnUpdateInfoPress:(UIButton *)sender {
}
@end
