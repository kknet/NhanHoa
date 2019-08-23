//
//  SupportViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportViewController.h"
#import "SupportListViewController.h"

@interface SupportViewController ()<WebServiceUtilsDelegate>
@end

@implementation SupportViewController
@synthesize btnCall, btnSendMsg, lbTitle, viewContent, sendMsgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = text_customers_support;
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"SupportViewController"];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    sendMsgView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSendMsgPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if (sendMsgView == nil) {
        [self addSendMessageViewForMainView];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        sendMsgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (IBAction)btnCallPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    
    if ([AppDelegate sharedInstance].supportCall) {
        SupportListViewController *listVC = [[SupportListViewController alloc] initWithNibName:@"SupportListViewController" bundle:nil];
        [self.navigationController pushViewController:listVC animated:TRUE];
        
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phone_support]] options:[[NSDictionary alloc] init] completionHandler:nil];
    }
}

- (void)addSendMessageViewForMainView {
    NSArray *toplevelObject = [[NSBundle mainBundle] loadNibNamed:@"SendMessageView" owner:nil options:nil];
    for(id currentObject in toplevelObject){
        if ([currentObject isKindOfClass:[SendMessageView class]]) {
            sendMsgView = (SendMessageView *) currentObject;
            break;
        }
    }
    sendMsgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    sendMsgView.delegate = self;
    [sendMsgView setupUIForView];
    [[AppDelegate sharedInstance].window addSubview: sendMsgView];
}

- (void)setupUIForView {
    float padding = 15.0;
    float hBTN = 45.0;
    float sizeIcon = 20.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        hBTN = 55.0;
        sizeIcon = 24.0;
    }
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(2*padding + 60.0 + hBTN + 2*padding);
    }];
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [AppDelegate sharedInstance].fontBold;
    lbTitle.text = have_not_found_issue_yet;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.view).offset(2*padding);
        make.height.mas_equalTo(60.0);
    }];
    
    
    NSAttributedString *msgTitle = [AppUtils generateTextWithContent:text_send_message font:[AppDelegate sharedInstance].fontRegular color:BLUE_COLOR image:[UIImage imageNamed:@"support_message"] size:sizeIcon imageFirst:TRUE];
    btnSendMsg.layer.cornerRadius = 5.0;
    [btnSendMsg setAttributedTitle:msgTitle forState:UIControlStateNormal];
    
    btnSendMsg.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:0.2];
    [btnSendMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hBTN);
    }];
    
    NSAttributedString *callTitle = [AppUtils generateTextWithContent:text_call_hotline font:[AppDelegate sharedInstance].fontRegular color:BLUE_COLOR image:[UIImage imageNamed:@"support_call"] size:sizeIcon imageFirst:TRUE];
    btnCall.layer.cornerRadius = 5.0;
    [btnCall setAttributedTitle:callTitle forState:UIControlStateNormal];
    btnCall.backgroundColor = btnSendMsg.backgroundColor;
    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnSendMsg.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.bottom.equalTo(btnSendMsg);
    }];
}

#pragma mark - SendMessageView Delegate
-(void)closeSendMessageView {
    [UIView animateWithDuration:0.25 animations:^{
        sendMsgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    }completion:^(BOOL finished) {
        sendMsgView = nil;
    }];
}

-(void)startToSendMessageWithEmail:(NSString *)email content:(NSString *)content {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] email = %@, content = %@", __FUNCTION__, email, content)];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:text_sending Interaction:FALSE];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] sendMessageWithEmail:email content:content];
}

#pragma mark - Webservice delegate

-(void)failedToSendMessage:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error])];
    [ProgressHUD dismiss];
    
    NSString *content = [AppUtils getErrorContentFromData: error];
    [[AppDelegate sharedInstance].window makeToast:content duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)sendMessageToUserSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__)];
    [ProgressHUD dismiss];
    
    [[AppDelegate sharedInstance].window makeToast:your_message_was_sent duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self performSelector:@selector(closeSendMessageView) withObject:nil afterDelay:2.0];
}

@end
