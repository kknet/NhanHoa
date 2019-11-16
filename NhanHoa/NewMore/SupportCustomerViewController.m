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
@synthesize imgSupport, viewBackground, viewHeader, icBack, lbHeader, icCart, lbCount, scvContent, lbTop, lbTitle, lbDesc, lbYourQuestion, tvYourQuestion, btnSendQuestion, viewFooter, imgFooter, lbFooter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self showContentWithCurrentLanguage];
    [self updateCartCountForView];
    
    //  register observers
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
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
}

- (void)setupUIForView
{
    self.view.backgroundColor = GRAY_245;
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    padding = 15.0;
    hBTN = 53.0;
    float hLabel = 60.0;
    float hIMG = 140.0;
    
    textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        hLabel = 30.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        hBTN = 45.0;
        hIMG = 100.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        hLabel = 40.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        hBTN = 48.0;
        hIMG = 110.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        hLabel = 60.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
        hBTN = 53.0;
        hIMG = 140.0;
    }
    
    UITapGestureRecognizer *tapOnCallFooter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToCallCustomerSupportView)];
    [viewFooter addGestureRecognizer: tapOnCallFooter];
    
    viewFooter.backgroundColor = UIColor.whiteColor;
    [viewFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(hBTN + padding + appDelegate.safeAreaBottomPadding);
    }];
    
    lbFooter.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    lbFooter.textColor = [UIColor colorWithRed:(23/255.0) green:(191/255.0) blue:(101/255.0) alpha:1.0];
    [lbFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewFooter.mas_centerX).offset(28.0/2);
        make.top.equalTo(viewFooter);
        make.height.mas_equalTo(padding + hBTN);
    }];
    
    [imgFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lbFooter.mas_left).offset(-10.0);
        make.centerY.equalTo(lbFooter.mas_centerY);
        make.width.height.mas_equalTo(28.0);
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
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(viewFooter.mas_top).offset(-padding);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(0);
    }];
    
    //  header view
    viewHeader.backgroundColor = UIColor.clearColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent).offset(hStatus);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewHeader);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.width.mas_equalTo(250.0);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    [icCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(viewHeader).offset(-padding+5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    lbCount.textColor = UIColor.whiteColor;
    lbCount.backgroundColor = ORANGE_COLOR;
    lbCount.layer.cornerRadius = appDelegate.sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    float hBGView = hStatus + self.navigationController.navigationBar.frame.size.height + padding + 60.0 + padding + hIMG;
    [viewBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvContent);
        make.left.right.equalTo(lbTop);
        make.height.mas_equalTo(hBGView);
    }];
    [AppUtils addCurvePathForViewWithHeight:hBGView forView:viewBackground heightCurve:15.0 startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1) startColor:[UIColor colorWithRed:(27/255.0) green:(111/255.0) blue:(219/255.0) alpha:1.0] endColor:[UIColor colorWithRed:(26/255.0) green:(103/255.0) blue:(220/255.0) alpha:1.0]];
    
    lbTitle.textColor = UIColor.whiteColor;
    lbTitle.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding/2);
        make.left.equalTo(lbTop).offset(padding);
        make.right.equalTo(lbTop).offset(-padding);
        make.height.mas_equalTo(60.0);
    }];
    
    UIImage *supportIMG = [UIImage imageNamed:@"img_support"];
    float wSupportBg = hIMG * supportIMG.size.width / supportIMG.size.height;
    [imgSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTitle.mas_bottom).offset(padding);
        make.centerX.equalTo(lbTop.mas_centerX);
        make.width.mas_equalTo(wSupportBg);
        make.height.mas_equalTo(hIMG);
    }];
    
    lbDesc.textColor = GRAY_100;
    lbDesc.font = [UIFont fontWithName:RobotoMedium size:textFont.pointSize];
    if (SCREEN_WIDTH >= SCREEN_WIDTH_IPHONE_6PLUS) {
        [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewBackground.mas_bottom).offset(2*padding);
            make.left.equalTo(lbTop).offset(padding);
            make.right.equalTo(lbTop).offset(-padding);
            make.height.mas_equalTo(50.0);
        }];
    }else{
        [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(viewBackground.mas_bottom).offset(padding);
            make.left.equalTo(lbTop).offset(padding);
            make.right.equalTo(lbTop).offset(-padding);
        }];
    }
    
    
    //  email
    lbYourQuestion.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    tvYourQuestion.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize];
    lbYourQuestion.textColor = GRAY_100;
    tvYourQuestion.textColor = GRAY_50;
    
    [lbYourQuestion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDesc.mas_bottom).offset(padding);
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
        make.height.mas_equalTo(3*hBTN);
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
    
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - (hBTN + padding + appDelegate.safeAreaBottomPadding + padding));
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
