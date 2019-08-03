//
//  SupportListViewController.m
//  NhanHoa
//
//  Created by Khai Leo on 7/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportListViewController.h"
#import "SupportCustomerCell.h"
#import "AppDelegate.h"

@interface SupportListViewController ()<UITextFieldDelegate, WebServiceUtilsDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *datas;
    NSString *extenCall;
    NSString *remoteName;
}

@end

@implementation SupportListViewController
@synthesize tbContent, lbNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Chăm sóc khách hàng";
    
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [WriteLogsUtils writeForGoToScreen:@"SupportListViewController"];
    
    [self registerObserveres];
    
    if (datas == nil) {
        datas = [[NSMutableArray alloc] init];
    }else{
        [datas removeAllObjects];
    }
    lbNoData.hidden = TRUE;
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang lấy danh sách" Interaction:NO];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] getListCustomersSupport];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [[NSNotificationCenter defaultCenter] removeObserver: self];
    //  [(AppDelegate *)[AppDelegate sharedInstance] removeAccount];
}

- (void)registerObserveres {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onRegStateChanged:)
                                                 name:notifRegStateChanged object:nil];
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
}

- (void)onRegStateChanged: (NSNotification *)notif
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [ProgressHUD dismiss];
        
        NSNumber *state = [notif object];
        if ([state isKindOfClass:[NSNumber class]]) {
            [WriteLogsUtils writeLogContent:SFM(@"[%s] VALUE >>>>>>>>>> %d", __FUNCTION__, [state intValue])];
            
            int value = [state intValue];
            if (value == 1) {
                if ([AppDelegate sharedInstance].accCallInfo != nil && ![AppUtils isNullOrEmpty: extenCall]) {
                    NSString *domain = [[AppDelegate sharedInstance].accCallInfo objectForKey:@"domain"];
                    NSString *port = [[AppDelegate sharedInstance].accCallInfo objectForKey:@"port"];
                    
                    NSString *stringForCall = [NSString stringWithFormat:@"sip:%@@%@:%@", extenCall, domain, port];
                    [WriteLogsUtils writeLogContent:SFM(@"YOU CALL TO STRING: %@", stringForCall)];
                    
                    //  stringForCall = @"sip:150@nhanhoa1.vfone.vn:51000";
                    [[AppDelegate sharedInstance] makeCallTo: stringForCall];
                    
                    [[AppDelegate sharedInstance] showCallViewWithDirection:OutgoingCall remote:remoteName];
                }else{
                    [self.view makeToast:@"Tài khoản SIP không được xác thực." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
                }
            }else{
                [self.view makeToast:@"Tài khoản SIP không được xác thực." duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
            }
        }
    });
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
        [ProgressHUD dismiss];
        [self.view makeToast:@"Không thể lấy được tài khoản gọi ngay lúc này. Vui lòng thử lại sau!" duration:3.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

-(void)failedToGetVoipAccount:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
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
        extenCall = [info objectForKey:@"exten"];
        
        if (![AppUtils isNullOrEmpty: extenCall]) {
            [ProgressHUD backgroundColor: ProgressHUD_BG];
            
            remoteName = [info objectForKey:@"name"];
            [[WebServiceUtils getInstance] getAccVoIPFree];
            
        }else{
            [self.view makeToast:@"Không tìm thấy số hỗ trợ. Vui lòng thực hiện lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        }
    }else{
        [self.view makeToast:@"Dữ liệu không hợp lệ. Vui lòng thực hiện lại sau!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    }
}

@end