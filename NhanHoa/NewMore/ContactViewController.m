//
//  ContactViewController.m
//  NhanHoa
//
//  Created by OS on 10/28/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactTbvCell.h"

@interface ContactViewController ()<UITableViewDelegate, UITableViewDataSource>{
    float hCell;
    UIFont *textFont;
}
@end

@implementation ContactViewController
@synthesize viewHeader, icBack, lbHeader, icCart, lbCount, imgBanner, tbInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = TRUE;
    lbHeader.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Contact"];
    
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
    float padding = 15.0;
    hCell = 80.0;
    
    textFont = [UIFont fontWithName:RobotoMedium size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoMedium size:18.0];
        hCell = 60.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoMedium size:20.0];
        hCell = 70.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(6, 6, 6, 6);
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoMedium size:22.0];
        hCell = 80.0;
        icCart.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    
    float hStatus = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //  header view
    self.view.backgroundColor = GRAY_240;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hStatus + self.navigationController.navigationBar.frame.size.height);
    }];
    
    lbHeader.textColor = GRAY_50;
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(hStatus);
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
    lbCount.layer.cornerRadius = [AppDelegate sharedInstance].sizeCartCount/2;
    lbCount.clipsToBounds = TRUE;
    lbCount.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize - 5.0];
    [lbCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icCart).offset(-3.0);
        make.right.equalTo(icCart).offset(3.0);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].sizeCartCount);
    }];
    
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  content
    UIImage *banner = [UIImage imageNamed:@"contact_banner"];
    float hBanner = (SCREEN_WIDTH - 2*padding) * banner.size.height / banner.size.width;
    
    imgBanner.layer.cornerRadius = 10.0;
    imgBanner.clipsToBounds = TRUE;
    [imgBanner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(padding);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(hBanner);
    }];
    
    tbInfo.scrollEnabled = FALSE;
    tbInfo.separatorStyle = UITableViewCellSelectionStyleNone;
    tbInfo.delegate = self;
    tbInfo.dataSource = self;
    [tbInfo registerNib:[UINib nibWithNibName:@"ContactTbvCell" bundle:nil] forCellReuseIdentifier:@"ContactTbvCell"];
    [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBanner.mas_bottom).offset(padding);
        make.bottom.left.right.equalTo(self.view);
    }];
    
}

- (IBAction)icBackClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated: TRUE];
}

- (IBAction)icCartClick:(UIButton *)sender {
}

#pragma mark - UITableview Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:{
            cell.imgType.image = [UIImage imageNamed:@"more_contact"];
            cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Customer care switchboard"];
            [cell.btnValue setTitle:phone_support forState:UIControlStateNormal];
            
            [cell.btnValue addTarget:self
                              action:@selector(clickOnPhoneSupport)
                    forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case 1:{
            cell.imgType.image = [UIImage imageNamed:@"ic_email"];
            cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Email"];
            [cell.btnValue setTitle:email_support forState:UIControlStateNormal];
            
            [cell.btnValue addTarget:self
                              action:@selector(clickOnEmailSupport)
                    forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case 2:{
            cell.imgType.image = [UIImage imageNamed:@"ic_earth"];
            cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Website"];
            [cell.btnValue setTitle:nhanhoa_website_link forState:UIControlStateNormal];
            
            [cell.btnValue addTarget:self
                              action:@selector(clickOnWebSite)
                    forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
        case 3:{
            cell.lbSepa.hidden = TRUE;
            cell.imgType.image = [UIImage imageNamed:@"ic_facebook"];
            cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Facebook"];
            [cell.btnValue setTitle:@"nhanhoacom" forState:UIControlStateNormal];
            
            [cell.btnValue addTarget:self
                              action:@selector(clickOnFacebook)
                    forControlEvents:UIControlEventTouchUpInside];
            
            break;
        }
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return hCell;
}

- (void)clickOnPhoneSupport {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Do you want to call to customer care service?"]];
    
    [attrTitle addAttribute:NSFontAttributeName value:[UIFont fontWithName:RobotoRegular size:textFont.pointSize - 2] range:NSMakeRange(0, attrTitle.string.length)];
    [alertVC setValue:attrTitle forKey:@"attributedTitle"];
    
    UIAlertAction *btnClose = [UIAlertAction actionWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Close"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){}];
    [btnClose setValue:UIColor.redColor forKey:@"titleTextColor"];
    
    UIAlertAction *btnCall = [UIAlertAction actionWithTitle:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Call"] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SFM(@"tel:%@", phone_support)] options:[[NSDictionary alloc] init] completionHandler:nil];
    }];
    [btnCall setValue:BLUE_COLOR forKey:@"titleTextColor"];
    [alertVC addAction:btnClose];
    [alertVC addAction:btnCall];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)clickOnEmailSupport {
    
}

- (void)clickOnWebSite {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"googlechrome://"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SFM(@"googlechrome://%@", nhanhoa_link)] options:[[NSDictionary alloc] init] completionHandler:nil];
    }else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nhanhoa_website_link] options:[[NSDictionary alloc] init] completionHandler:nil];
    }
}

- (void)clickOnFacebook {
    // Check if FB app installed on device
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile/153416398092837"]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/153416398092837"] options:[[NSDictionary alloc] init] completionHandler:nil];
    }
    else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:nhanhoa_facebook_link] options:[[NSDictionary alloc] init] completionHandler:nil];
    }
}

@end
