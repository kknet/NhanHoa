//
//  SupportViewController.m
//  NhanHoa
//
//  Created by lam quang quan on 5/9/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportViewController.h"

@interface SupportViewController ()<WebServiceUtilsDelegate>
@end

@implementation SupportViewController
@synthesize btnCall, btnSendMsg, lbTitle, viewContent, sendMsgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Hỗ trợ khách hàng";
    [self setupUIForView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [WriteLogsUtils writeForGoToScreen:@"SupportViewController"];
    [WebServiceUtils getInstance].delegate = self;
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
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    if (sendMsgView == nil) {
        [self addSendMessageViewForMainView];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        self.sendMsgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

- (IBAction)btnCallPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link_support]];
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
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(2*padding + 60.0 + 45.0 + 2*padding);
    }];
    
    lbTitle.textColor = TITLE_COLOR;
    lbTitle.font = [AppDelegate sharedInstance].fontBold;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.equalTo(self.view).offset(2*padding);
        make.height.mas_equalTo(60.0);
    }];
    
    
    NSAttributedString *msgTitle = [AppUtils generateTextWithContent:@"Gửi tin nhắn" font:[AppDelegate sharedInstance].fontRegular color:BLUE_COLOR image:[UIImage imageNamed:@"support_message"] size:22.0 imageFirst:TRUE];
    btnSendMsg.layer.cornerRadius = 5.0;
    [btnSendMsg setAttributedTitle:msgTitle forState:UIControlStateNormal];
    
    btnSendMsg.backgroundColor = [UIColor colorWithRed:(42/255.0) green:(122/255.0) blue:(219/255.0) alpha:0.2];
    [btnSendMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTitle.mas_bottom);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(45.0);
    }];
    
    NSAttributedString *callTitle = [AppUtils generateTextWithContent:@"Gọi tổng đài" font:[AppDelegate sharedInstance].fontRegular color:BLUE_COLOR image:[UIImage imageNamed:@"support_call"] size:22.0 imageFirst:TRUE];
    btnCall.layer.cornerRadius = 5.0;
    [btnCall setAttributedTitle:callTitle forState:UIControlStateNormal];
    btnCall.backgroundColor = btnSendMsg.backgroundColor;
    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.btnSendMsg.mas_right).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.top.bottom.equalTo(self.btnSendMsg);
    }];
}

#pragma mark - SendMessageView Delegate
-(void)closeSendMessageView {
    [UIView animateWithDuration:0.25 animations:^{
        self.sendMsgView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 0);
    }];
}

-(void)startToSendMessageWithEmail:(NSString *)email content:(NSString *)content {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] email = %@, content = %@", __FUNCTION__, email, content) toFilePath:[AppDelegate sharedInstance].logFilePath];
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:@"Đang gửi tin nhắn..." Interaction:NO];
    
    [[WebServiceUtils getInstance] sendMessageWithEmail:email content:content];
}

#pragma mark - Webservice delegate

-(void)failedToSendMessage:(NSString *)error {
    [WriteLogsUtils writeLogContent:SFM(@"[%s] error = %@", __FUNCTION__, @[error]) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    [[AppDelegate sharedInstance].window makeToast:@"Đã có lỗi xảy ra. Vui lòng thử lại!" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
}

-(void)sendMessageToUserSuccessful {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [ProgressHUD dismiss];
    
    [[AppDelegate sharedInstance].window makeToast:@"Tin nhắn của bạn đã được gửi" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self performSelector:@selector(closeSendMessageView) withObject:nil afterDelay:2.0];
}

@end
