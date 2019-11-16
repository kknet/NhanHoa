//
//  SSLViewController.m
//  NhanHoa
//
//  Created by OS on 11/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SSLViewController.h"
#import "SSLTbvCell.h"
#import "AddCartResultPopupView.h"

@interface SSLViewController ()<UITableViewDelegate, UITableViewDataSource, AddCartResultPopupViewDelegate>{
    float hComodoSSLCell;
    AppDelegate *appDelegate;
    float padding;
}

@end

@implementation SSLViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, scvMenu, btnComodoSSL, btnGeotrustSSL, btnSymantecSSL, tbContent, lbMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    [self updateCartCountForView];
}

- (void)updateCartCountForView {
    if ([[CartModel getInstance] countItemInCart] == 0) {
        lbCount.hidden = TRUE;
    }else{
        lbCount.hidden = FALSE;
        lbCount.text = SFM(@"%d", [[CartModel getInstance] countItemInCart]);
    }
}

- (void)setupUIForView
{
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    float hMenu = 50.0;
    
    padding = 15.0;
    float hBTN = 45.0;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    hComodoSSLCell = padding + 40.0 + padding + 35.0*9 + padding + 1.0 + padding + hBTN + padding + 15.0;
    
    self.view.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset(hStatus);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
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
        make.top.equalTo(icCart);
        make.right.equalTo(icCart);
        make.width.height.mas_equalTo(appDelegate.sizeCartCount);
    }];
    
    //  scrollview menu
    [scvMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(hMenu);
    }];
    
    float sizeContent = 0;
    
    btnComodoSSL.titleLabel.font = btnGeotrustSSL.titleLabel.font = btnSymantecSSL.titleLabel.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-2];
    
    float sizeText = [AppUtils getSizeWithText:@"Comodo SSL" withFont:btnComodoSSL.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnComodoSSL setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnComodoSSL setTitleColor:GRAY_150 forState:UIControlStateNormal];
    btnComodoSSL.selected = TRUE;
    [btnComodoSSL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scvMenu).offset(padding);
        make.top.equalTo(scvMenu);
        make.width.mas_equalTo(sizeText);
        make.height.mas_equalTo(hMenu-5.0);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Geotrust SSL" withFont:btnGeotrustSSL.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText;
    
    [btnGeotrustSSL setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnGeotrustSSL setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnGeotrustSSL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnComodoSSL.mas_right).offset(padding);
        make.top.bottom.equalTo(btnComodoSSL);
        make.width.mas_equalTo(sizeText);
    }];
    
    sizeText = [AppUtils getSizeWithText:@"Symantec SSL" withFont:btnSymantecSSL.titleLabel.font andMaxWidth:SCREEN_WIDTH].width + 3.0;
    sizeContent += padding + sizeText + padding;
    
    [btnSymantecSSL setTitleColor:TITLE_COLOR forState:UIControlStateSelected];
    [btnSymantecSSL setTitleColor:GRAY_150 forState:UIControlStateNormal];
    [btnSymantecSSL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btnGeotrustSSL.mas_right).offset(padding);
        make.top.bottom.equalTo(btnGeotrustSSL);
        make.width.mas_equalTo(sizeText);
    }];
    
    lbMenu.backgroundColor = BLUE_COLOR;
    [lbMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnComodoSSL.mas_bottom);
        make.left.right.equalTo(btnComodoSSL);
        make.height.mas_equalTo(5.0);
    }];
    scvMenu.contentSize = CGSizeMake(sizeContent, hMenu);
    scvMenu.showsHorizontalScrollIndicator = FALSE;
    
    [AppUtils addBoxShadowForView:scvMenu color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  table content
    tbContent.showsVerticalScrollIndicator = FALSE;
    tbContent.backgroundColor = UIColor.clearColor;
    [tbContent registerNib:[UINib nibWithNibName:@"SSLTbvCell" bundle:nil] forCellReuseIdentifier:@"SSLTbvCell"];
    tbContent.delegate = self;
    tbContent.dataSource = self;
    tbContent.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scvMenu.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-appDelegate.safeAreaBottomPadding);
    }];
}


- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}


- (IBAction)btnComodoSSLPress:(UIButton *)sender {
}

- (IBAction)btnGeotrustSSLPress:(UIButton *)sender {
}

- (IBAction)btnSymantectPress:(UIButton *)sender {
}


#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSLTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.lbTitle.text = @"Positive SSL";
        cell.lbPrice.text = @"219.000 đ/Năm";
        
    }else if (indexPath.row == 1){
        cell.lbTitle.text = @"Positive SSL Multi-domain";
        cell.lbPrice.text = @"1.339.000 đ/Năm";
        
    }else if (indexPath.row == 2){
        cell.lbTitle.text = @"Positive SSL Wildcard";
        cell.lbPrice.text = @"2.219.000 đ/Năm";
        
    }else if (indexPath.row == 3){
        cell.lbTitle.text = @"Comodo EV SSL";
        cell.lbPrice.text = @"3.699.000 đ/Năm";
        
    }else if (indexPath.row == 4){
        cell.lbTitle.text = @"Premium SSL Wildcard";
        cell.lbPrice.text = @"5.399.000 đ/Năm";
        
    }else if (indexPath.row == 5){
        cell.lbTitle.text = @"Comodo EV Multi Domain SSL";
        cell.lbPrice.text = @"7.299.000 đ/Năm";
    }
    
    cell.btnBuy.tag = indexPath.row;
    [cell.btnBuy addTarget:self
                    action:@selector(onBuyButtonPress:)
          forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hComodoSSLCell;
}

- (void)onBuyButtonPress: (UIButton *)sender {
    float wPopup = 400.0;
    float hIMG = 80.0;
    float heightBTN = 50.0;
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        heightBTN = 45.0;
        hIMG = 60.0;
        wPopup = 300.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        heightBTN = 48.0;
        hIMG = 70.0;
        wPopup = 350.0;
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        heightBTN = 50.0;
        hIMG = 80.0;
        wPopup = 400.0;
    }
    
    float hPopup = 2*padding + hIMG + padding + 40.0 + padding + heightBTN + padding + heightBTN + padding;
    
    AddCartResultPopupView *popupView = [[AddCartResultPopupView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-wPopup)/2, (SCREEN_HEIGHT - hPopup)/2, wPopup, hPopup)];
    popupView.delegate = self;
    [popupView showInView:appDelegate.window animated:TRUE];
}

#pragma mark - AddCartResultPopupViewDelegate
-(void)selectedOnButtonPayment {
    [appDelegate showCartScreenContent];
}

@end
