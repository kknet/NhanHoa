//
//  RegisterSSLViewController.m
//  NhanHoa
//
//  Created by OS on 8/3/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RegisterSSLViewController.h"
#import "SSLTbvCell.h"

typedef enum TypeSSL{
    eComodoSSL,
    eGeoTrustSSL,
    eSymantecSSL,
}TypeSSL;

@interface RegisterSSLViewController ()<UITableViewDelegate, UITableViewDataSource> {
    float hHeader;
    TypeSSL currentSSL;
    float paddingContent;
}

@end

@implementation RegisterSSLViewController
@synthesize viewHeader, btnComodo, btnGeoTrust, btnSymantic, tbContent;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Đăng ký SSL";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    currentSSL = eComodoSSL;
    [self setSelectedMenu: currentSSL];
}

- (void)setupUIForView
{
    paddingContent = 7.0;
    hHeader = 70.0;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(hHeader);
    }];
    
    float wButton = (SCREEN_WIDTH - 2*paddingContent)/3;
    [btnGeoTrust mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.centerY.equalTo(viewHeader.mas_centerY);
        make.width.mas_equalTo(wButton);
        make.height.mas_equalTo(45.0);
    }];
    
    [btnSymantic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnGeoTrust);
        make.left.equalTo(btnGeoTrust.mas_right);
        make.width.mas_equalTo(wButton);
    }];
    
    [btnComodo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnGeoTrust);
        make.right.equalTo(btnGeoTrust.mas_left);
        make.width.mas_equalTo(wButton);
    }];
    
    [tbContent registerNib:[UINib nibWithNibName:@"SSLTbvCell" bundle:nil] forCellReuseIdentifier:@"SSLTbvCell"];
    tbContent.separatorStyle = UITableViewCellSelectionStyleNone;
    tbContent.delegate = self;
    tbContent.dataSource = self;
    [tbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)setSelectedMenu: (TypeSSL)ssl
{
    UIFont *textFont = [AppDelegate sharedInstance].fontDesc;
    UIColor *grayCOLOR = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0];
    float sizeIcon = 20.0;
    
    NSString *deviceMode = [DeviceUtils getModelsOfCurrentDevice];
    if ([deviceMode isEqualToString: Iphone5_1] || [deviceMode isEqualToString: Iphone5_2] || [deviceMode isEqualToString: Iphone5c_1] || [deviceMode isEqualToString: Iphone5c_2] || [deviceMode isEqualToString: Iphone5s_1] || [deviceMode isEqualToString: Iphone5s_2] || [deviceMode isEqualToString: IphoneSE])
    {
        textFont = [UIFont fontWithName:RobotoMedium size:12.0];
        sizeIcon = 16.0;
        
    }else if ([deviceMode isEqualToString: Iphone6] || [deviceMode isEqualToString: Iphone6s] || [deviceMode isEqualToString: Iphone7_1] || [deviceMode isEqualToString: Iphone7_2] || [deviceMode isEqualToString: Iphone8_1] || [deviceMode isEqualToString: Iphone8_2])
    {
        textFont = [UIFont fontWithName:RobotoMedium size:12.5];
        
    }else if ([deviceMode isEqualToString: Iphone6_Plus] || [deviceMode isEqualToString: Iphone6s_Plus] || [deviceMode isEqualToString: Iphone7_Plus1] || [deviceMode isEqualToString: Iphone7_Plus2] || [deviceMode isEqualToString: Iphone8_Plus1] || [deviceMode isEqualToString: Iphone8_Plus2])
    {
        
        
    }else if ([deviceMode isEqualToString: IphoneX_1] || [deviceMode isEqualToString: IphoneX_2] || [deviceMode isEqualToString: IphoneXR] || [deviceMode isEqualToString: IphoneXS] || [deviceMode isEqualToString: IphoneXS_Max1] || [deviceMode isEqualToString: IphoneXS_Max2] || [deviceMode isEqualToString: simulator]){
        
    }else{
        
    }
    
    
    if (ssl == eComodoSSL) {
        btnComodo.backgroundColor = BLUE_COLOR;
        btnGeoTrust.backgroundColor = btnSymantic.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *comodoAttr = [AppUtils generateTextWithContent:@"COMODO SSL" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"windows_act"] size:sizeIcon imageFirst:TRUE];
        [btnComodo setAttributedTitle:comodoAttr forState:UIControlStateNormal];
        
        NSAttributedString *geotrustAttr = [AppUtils generateTextWithContent:@"GEOTRUST SSL" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnGeoTrust setAttributedTitle:geotrustAttr forState:UIControlStateNormal];
        
        NSAttributedString *symanticAttr = [AppUtils generateTextWithContent:@"SYMANTEC SSL" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnSymantic setAttributedTitle:symanticAttr forState:UIControlStateNormal];
        
    }else if (ssl == eGeoTrustSSL) {
        btnGeoTrust.backgroundColor = BLUE_COLOR;
        btnComodo.backgroundColor = btnSymantic.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *comodoAttr = [AppUtils generateTextWithContent:@"COMODO SSL" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnComodo setAttributedTitle:comodoAttr forState:UIControlStateNormal];
        
        NSAttributedString *geotrustAttr = [AppUtils generateTextWithContent:@"GEOTRUST SSL" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"windows_act"] size:sizeIcon imageFirst:TRUE];
        [btnGeoTrust setAttributedTitle:geotrustAttr forState:UIControlStateNormal];
        
        NSAttributedString *symanticAttr = [AppUtils generateTextWithContent:@"SYMANTEC SSL" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnSymantic setAttributedTitle:symanticAttr forState:UIControlStateNormal];
        
    }else{
        btnSymantic.backgroundColor = BLUE_COLOR;
        btnComodo.backgroundColor = btnGeoTrust.backgroundColor = UIColor.whiteColor;
        
        NSAttributedString *comodoAttr = [AppUtils generateTextWithContent:@"COMODO SSL" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnComodo setAttributedTitle:comodoAttr forState:UIControlStateNormal];
        
        NSAttributedString *geotrustAttr = [AppUtils generateTextWithContent:@"GEOTRUST SSL" font:textFont color:grayCOLOR image:[UIImage imageNamed:@"windows"] size:sizeIcon imageFirst:TRUE];
        [btnGeoTrust setAttributedTitle:geotrustAttr forState:UIControlStateNormal];
        
        NSAttributedString *symanticAttr = [AppUtils generateTextWithContent:@"SYMANTEC SSL" font:textFont color:UIColor.whiteColor image:[UIImage imageNamed:@"windows_act"] size:sizeIcon imageFirst:TRUE];
        [btnSymantic setAttributedTitle:symanticAttr forState:UIControlStateNormal];
    }
}

#pragma mark - UITableview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSLTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SSLTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float mTop = 15.0;
    return paddingContent + 60 + 11*40.0 + 11*1.0 + mTop + 45.0 + mTop + paddingContent + mTop;
}

- (IBAction)btnComodoSSLPress:(UIButton *)sender {
    currentSSL = eComodoSSL;
    [self setSelectedMenu: currentSSL];
}

- (IBAction)btnGeoTrustSSLPress:(UIButton *)sender {
    currentSSL = eGeoTrustSSL;
    [self setSelectedMenu: currentSSL];
}

- (IBAction)btnSymanticSSLPress:(UIButton *)sender {
    currentSSL = eSymantecSSL;
    [self setSelectedMenu: currentSSL];
}
@end
