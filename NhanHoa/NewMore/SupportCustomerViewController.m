//
//  SupportCustomerViewController.m
//  NhanHoa
//
//  Created by OS on 11/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportCustomerViewController.h"
#import "SupportListViewController.h"

@interface SupportCustomerViewController ()<UIScrollViewDelegate, UITextViewDelegate, WebServiceUtilsDelegate>{
    AppDelegate *appDelegate;
    float padding;
    UIFont *textFont;
    float hBTN;
}

@end

@implementation SupportCustomerViewController
@synthesize imgBGSupport, imgBgTop, viewHeader, icBack, lbHeader, icCart, lbCount, scvContent, lbTop, lbTitle, lbDesc, lbYourQuestion, tvYourQuestion, btnSendQuestion, viewFooter, imgFooter, lbFooter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self showContentWithCurrentLanguage];
    
    //  register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notif {
    float keyboardHeight = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [viewFooter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-keyboardHeight+(hBTN + padding));
    }];
}

- (void)keyboardWillHide: (NSNotification *) notif{
    [viewFooter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}

- (void)showContentWithCurrentLanguage {
    lbHeader.text = [appDelegate.localization localizedStringForKey:@"Customer support"];
    lbTitle.text = [appDelegate.localization localizedStringForKey:@"What's can we help you?"];
    lbDesc.text = [appDelegate.localization localizedStringForKey:@"Send your question to us"];
    lbYourQuestion.text = [appDelegate.localization localizedStringForKey:@"Question content"];
    [btnSendQuestion setTitle:[appDelegate.localization localizedStringForKey:@"Send question"]
                     forState:UIControlStateNormal];
    
    lbFooter.text = [appDelegate.localization localizedStringForKey:@"Call to Nhan Hoa"];
    float size = [AppUtils getSizeWithText:lbFooter.text withFont:lbFooter.font andMaxWidth:SCREEN_WIDTH].width + 10.0;
    float originX = (SCREEN_WIDTH - (28.0 + 5.0 + size))/2;
    [imgFooter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter).offset(originX);
    }];
    
    [lbFooter mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(size);
    }];
}

- (void)setupUIForView
{
    self.view.backgroundColor = GRAY_245;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 45.0;
    float hLabel = 40.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hLabel = 30.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hLabel = 40.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hLabel = 40.0;
    }
    
    //  header view
    UIImage *topBg = [UIImage imageNamed:@"support_top_bg"];
    float hHeader = SCREEN_WIDTH * topBg.size.height / topBg.size.width;
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    [imgBgTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewHeader);
    }];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = 18.0/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(18.0);
    }];
    
    UITapGestureRecognizer *tapOnCallFooter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToCallCustomerSupportView)];
    [viewFooter addGestureRecognizer: tapOnCallFooter];
    
    viewFooter.backgroundColor = UIColor.whiteColor;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
        make.height.mas_equalTo(hBTN + padding);
    }];
    
    [imgFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewFooter);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.width.height.mas_equalTo(28.0);
    }];
    
    lbFooter.font = textFont;
    lbFooter.textColor = [UIColor colorWithRed:(23/255.0) green:(191/255.0) blue:(101/255.0) alpha:1.0];
    [lbFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgFooter.mas_right).offset(5.0);
        make.centerY.equalTo(viewFooter.mas_centerY);
        make.height.mas_equalTo(hBTN);
        make.width.mas_equalTo(0.0);
    }];
    
    //  scrollview content
    UITapGestureRecognizer *tapOnScreen = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard)];
    [scvContent addGestureRecognizer: tapOnScreen];
    
    
    if (@available(iOS 11.0, *)) {
        scvContent.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    scvContent.backgroundColor = UIColor.whiteColor;
    scvContent.delegate = self;
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top).offset(-padding);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
    
    //  background
    UIImage *supportBg = [UIImage imageNamed:@"support_bot_bg"];
    float hSupportBg = SCREEN_WIDTH * supportBg.size.height / supportBg.size.width;
    [imgBGSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(hSupportBg);
    }];
    
    lbTitle.textColor = UIColor.whiteColor;
    lbTitle.font = textFont;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(padding);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    
    lbDesc.textColor = GRAY_100;
    lbDesc.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBGSupport.mas_bottom);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(50.0);
    }];
    
    //  email
    lbYourQuestion.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    tvYourQuestion.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    lbYourQuestion.textColor = GRAY_100;
    tvYourQuestion.textColor = GRAY_50;
    
    
    [lbYourQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDesc.mas_bottom);
        make.left.right.equalTo(lbDesc);
        make.height.mas_equalTo(hLabel);
    }];
    
    tvYourQuestion.layer.cornerRadius = 5.0;
    tvYourQuestion.layer.borderWidth = 1.0;
    tvYourQuestion.layer.borderColor = GRAY_200.CGColor;
    tvYourQuestion.returnKeyType = UIReturnKeyGo;
    tvYourQuestion.delegate = self;
    [tvYourQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbYourQuestion.mas_bottom);
        make.left.right.equalTo(lbYourQuestion);
        make.height.mas_equalTo(3.0*hBTN);
    }];
    
    btnSendQuestion.titleLabel.font = textFont;
    [btnSendQuestion setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnSendQuestion.layer.cornerRadius = 8.0;
    btnSendQuestion.backgroundColor = GRAY_200;
    [btnSendQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tvYourQuestion.mas_bottom).offset(2*padding);
        make.left.right.equalTo(tvYourQuestion);
        make.height.mas_equalTo(hBTN);
    }];
    
    float hContent = hSupportBg + 50.0 + (hLabel + hBTN) + padding + (hLabel + 2.0*hBTN) + 2*padding + hBTN + padding;
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

- (IBAction)btnSendQuestionPress:(UIButton *)sender {
    [self.view endEditing: TRUE];
    
    if (![AppUtils checkNetworkAvailable]) {
        [self.view makeToast:[[AppDelegate sharedInstance].localization localizedStringForKey:@"No network connection. Please check again!"] duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
        return;
    }
    
    if ([AppUtils isNullOrEmpty: tvYourQuestion.text]) {
        [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Please enter your question content"] duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
        return;
    }
    
    [ProgressHUD backgroundColor: ProgressHUD_BG];
    [ProgressHUD show:[appDelegate.localization localizedStringForKey:@"Sending..."] Interaction:FALSE];
    
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] sendMessageWithContent: tvYourQuestion.text];
    
}

- (void)goToCallCustomerSupportView {
    SupportListViewController *listVC = [[SupportListViewController alloc] initWithNibName:@"SupportListViewController" bundle:nil];
    [self.navigationController pushViewController:listVC animated:TRUE];
}

- (void)whenContentValueDidChanged {
    [self checkToEnableSendRequestButton];
}

- (void)closeKeyboard {
    [self.view endEditing: TRUE];
}

- (void)checkToEnableSendRequestButton {
    if (tvYourQuestion.text.length > 0) {
        btnSendQuestion.backgroundColor = BLUE_COLOR;
    }else{
        btnSendQuestion.backgroundColor = GRAY_200;
    }
}

#pragma mark - UITextview delegate
-(void)textViewDidChange:(UITextView *)textView {
    [self checkToEnableSendRequestButton];
}

#pragma mark - UIScrollview Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0) {
        scrollView.contentOffset = CGPointZero;
    }
}

#pragma mark - Webservice delegate
-(void)failedToSendMessage:(NSString *)error {
    [ProgressHUD dismiss];
    NSString *content = [AppUtils getErrorContentFromData: error];
    [self.view makeToast:content duration:2.0 position:CSToastPositionCenter style:appDelegate.errorStyle];
}

-(void)sendMessageToUserSuccessful {
    [ProgressHUD dismiss];
    
    [self.view makeToast:[appDelegate.localization localizedStringForKey:@"Your question has been sent"] duration:2.0 position:CSToastPositionCenter style:appDelegate.successStyle];
}

@end
