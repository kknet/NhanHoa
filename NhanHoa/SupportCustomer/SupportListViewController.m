//
//  SupportListViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 7/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportListViewController.h"
#import "CallViewController.h"
#import "SupportCustomerCell.h"
#import "AppDelegate.h"

@interface SupportListViewController ()<UITextFieldDelegate, WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *datas;
}

@end

@implementation SupportListViewController
@synthesize tbContent, lbNoData;
@synthesize tfNumber, btnCall, btnClear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Chăm sóc khách hàng";
    
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"SupportListViewController"];
    
    if (datas == nil) {
        datas = [[NSMutableArray alloc] init];
    }else{
        [datas removeAllObjects];
    }
    lbNoData.hidden = TRUE;
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy danh sách" Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getAccVoIPFree];
    [[WebServiceUtils getInstance] getListCustomersSupport];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    //  [(AppDelegate *)[AppDelegate sharedInstance] removeAccount];
}

- (IBAction)btnClearPress:(UIButton *)sender {
}

- (IBAction)btnCallPress:(UIButton *)sender {
    if (tfNumber.text.length == 0) {
        [self.view makeToast:@"Vui lòng nhập số điện thoại muốn gọi" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    CallViewController *callVC = [[CallViewController alloc] initWithNibName:@"CallViewController" bundle:nil];
    callVC.phoneNumber = @"150";
    [self.navigationController pushViewController:callVC animated:TRUE];
}

- (void)setupUIForView {
    [tbContent registerNib:[UINib nibWithNibName:@"SupportCustomerCell" bundle:nil] forCellReuseIdentifier:@"SupportCustomerCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    lbNoData.font = [AppDelegate sharedInstance].fontBTN;
    lbNoData.textColor = TITLE_COLOR;
    lbNoData.text = @"Không có dữ liệu";
    [lbNoData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    [AppUtils setBorderForTextfield:tfNumber borderColor:BORDER_COLOR];
    tfNumber.returnKeyType = UIReturnKeyDone;
    tfNumber.delegate = self;
    tfNumber.font = [AppDelegate sharedInstance].fontRegular;
    tfNumber.textColor = TITLE_COLOR;
    [tfNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(50.0);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    btnClear.backgroundColor = OLD_PRICE_COLOR;
    [btnClear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tfNumber);
        make.top.equalTo(self.tfNumber.mas_bottom).offset(20.0);
        make.right.equalTo(self.tfNumber.mas_centerX).offset(-7.5);
        make.height.mas_equalTo(45.0);
    }];
    
    btnCall.backgroundColor = BLUE_COLOR;
    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tfNumber.mas_centerX).offset(7.5);
        make.top.bottom.equalTo(self.btnClear);
        make.right.equalTo(self.tfNumber);
    }];
    
    btnClear.layer.cornerRadius = btnCall.layer.cornerRadius = [AppDelegate sharedInstance].hTextfield/2;
    btnClear.titleLabel.font = btnCall.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
}

#pragma mark - UITextfield delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing: TRUE];
    return TRUE;
}

#pragma mark - WebServiceUtil Delegate

-(void)getVoipAccountSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    if (data != nil && [data isKindOfClass:[NSDictionary class]]) {
        [AppDelegate sharedInstance].accCallInfo = [[NSDictionary alloc] initWithDictionary: data];
        [[AppDelegate sharedInstance] registerSIPAccountWithInfo: data];
        
    }else{
        [self.view makeToast:@"Không thể lấy được tài khoản gọi ngay lúc này. Vui lòng thử lại sau!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)failedToGetVoipAccount:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [self.view makeToast:@"Không thể lấy được tài khoản gọi ngay lúc này. Vui lòng thử lại sau!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)getCustomersSupportListSuccessfulWithData:(NSDictionary *)data {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] data = %@", __FUNCTION__, @[data])];
    
    [ProgressHUD dismiss];
    
    if ([data isKindOfClass:[NSArray class]]) {
        [datas addObjectsFromArray: (NSArray *)data];
        
    }else if ([data isKindOfClass:[NSDictionary class]]) {
        id dataArr = [data objectForKey:@"data"];
        if (dataArr != nil && [dataArr isKindOfClass:[NSArray class]]) {
            [datas addObjectsFromArray: dataArr];
        }
    }
    [self displayInfoAfterGetData];
}

-(void)failedToGetCustomersSupportList:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    
    [ProgressHUD dismiss];
    [self.view makeToast:@"Không thể lấy được danh sách hỗ trợ khách hàng. Vui lòng thử lại sau!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

- (void)displayInfoAfterGetData {
    if (datas.count == 0) {
        lbNoData.hidden = FALSE;
        tbContent.hidden = TRUE;
    }else{
        lbNoData.hidden = TRUE;
        tbContent.hidden = FALSE;
        [tbContent reloadData];
    }
}

/*
{
    data =     (
                {
                    exten = domain;
                    name = "Domain + Hosting";
                },
                {
                    exten = web;
                    name = Web4s;
                },
                {
                    exten = vfone;
                    name = "T\U1ed5ng \U0111\U00e0i s\U1ed1 vfone";
                },
                {
                    exten = server;
                    name = "M\U00e1y ch\U1ee7";
                },
                {
                    exten = acc;
                    name = "K\U1ebf to\U00e1n";
                },
                {
                    exten = support;
                    name = "H\U1ed7 tr\U1ee3 chung";
                }
                );
    success = 1;
}
*/

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SupportCustomerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SupportCustomerCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *info = [datas objectAtIndex: indexPath.row];
    [cell displayContentWithInfo: info];
    
    cell.btnCall.tag = indexPath.row;
    [cell.btnCall addTarget:self
                     action:@selector(onCallCustomerSupport:)
           forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)onCallCustomerSupport: (UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] index = %d", __FUNCTION__, (int)sender.tag)];
    
    if (datas.count > sender.tag) {
        NSDictionary *info = [datas objectAtIndex: sender.tag];
        
        NSString *exten = [info objectForKey:@"exten"];
        if (![AppUtils isNullOrEmpty: exten]) {
            exten = @"150";
            //  [[AppDelegate sharedInstance] makeCallTo: exten];
            
            NSString *name = [info objectForKey:@"name"];
            
            CallViewController *callVC = [[CallViewController alloc] initWithNibName:@"CallViewController" bundle:nil];
            callVC.phoneNumber = exten;
            callVC.calleeName = name;
            [self.navigationController pushViewController:callVC animated:TRUE];
        }else{
            [self.view makeToast:@"Không tìm thấy số hỗ trợ. Vui lòng thực hiện lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }else{
        [self.view makeToast:@"Dữ liệu không hợp lệ. Vui lòng thực hiện lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

/*
account = ap1astapp;
domain = "asapp.vfone.vn";
password = yovU5lmlEA6WPcliwZwPLf1RT;
port = 51000;
*/

@end
