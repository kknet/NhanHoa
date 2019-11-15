//
//  DomainInfoPopupView.m
//  NhanHoa
//
//  Created by OS on 11/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainInfoPopupView.h"
#import "DomainInfoRowTbvCell.h"

@implementation DomainInfoPopupView
@synthesize lbHeader, icClose, tbInfo, icWaiting, domain, domainInfo, padding, leftMaxSize, fontForGetHeight, hCell;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        // Initialization code
        self.backgroundColor =  UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 12.0;
        padding = 15.0;
        hCell = 55.0;
        
        UIFont *textFont = [UIFont fontWithName:RobotoRegular size:22.0];
        fontForGetHeight = [UIFont fontWithName:RobotoMedium size:17.0];
        
        if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
            textFont = [UIFont fontWithName:RobotoRegular size:18.0];
            fontForGetHeight = [UIFont fontWithName:RobotoMedium size:14.0];
            hCell = 45.0;
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
            textFont = [UIFont fontWithName:RobotoRegular size:20.0];
            fontForGetHeight = [UIFont fontWithName:RobotoMedium size:15.0];
            hCell = 50.0;
            
        }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
            textFont = [UIFont fontWithName:RobotoRegular size:22.0];
            fontForGetHeight = [UIFont fontWithName:RobotoMedium size:17.0];
            hCell = 55.0;
        }
        leftMaxSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Registration date"] withFont:fontForGetHeight andMaxWidth:SCREEN_WIDTH].width + 10.0;
        
        lbHeader = [[UILabel alloc] init];
        lbHeader.font = textFont;
        lbHeader.textColor = GRAY_50;
        lbHeader.text = @"Thông tin tên miền";
        lbHeader.textAlignment = NSTextAlignmentCenter;
        [self addSubview: lbHeader];
        [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(200.0);
            make.height.mas_equalTo(50.0);
        }];

        icClose = [UIButton buttonWithType: UIButtonTypeCustom];
        icClose.imageEdgeInsets = UIEdgeInsetsMake(9, 9, 9, 9);
        [icClose setImage:[UIImage imageNamed:@"close_gray"] forState:UIControlStateNormal];
        [icClose addTarget:self
                    action:@selector(fadeOut)
          forControlEvents:UIControlEventTouchUpInside];
        [self addSubview: icClose];
        [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-5.0);
            make.centerY.equalTo(lbHeader.mas_centerY);
            make.width.height.mas_equalTo(40.0);
        }];
        
        tbInfo = [[UITableView alloc] init];
        tbInfo.delegate = self;
        tbInfo.dataSource = self;
        tbInfo.scrollEnabled = FALSE;
        [tbInfo registerNib:[UINib nibWithNibName:@"DomainInfoRowTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainInfoRowTbvCell"];
        tbInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview: tbInfo];
        [tbInfo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lbHeader.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
        }];

        icWaiting = [[UIActivityIndicatorView alloc] init];
        icWaiting.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        icWaiting.backgroundColor = UIColor.whiteColor;
        icWaiting.alpha = 0.5;
        icWaiting.hidden = TRUE;
        [self addSubview: icWaiting];

        [icWaiting mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.equalTo(self);
        }];
    }
    return self;
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated {
    //Add transparent
    UIView *viewBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    viewBackground.backgroundColor = UIColor.blackColor;
    viewBackground.alpha = 0.5;
    viewBackground.tag = 20;
    [aView addSubview:viewBackground];
    
    [aView addSubview:self];
    if (animated) {
        [self fadeIn];
    }
    
    [icWaiting startAnimating];
    icWaiting.hidden = FALSE;
    
    [self getWhoisInfoOfDomain: domain];
}

- (void)fadeIn {
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)fadeOut {
    for (UIView *subView in self.superview.subviews){
        if (subView.tag == 20){
            [subView removeFromSuperview];
        }
    }
    
    [UIView animateWithDuration:.35 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] removeObserver:self];
            [self removeFromSuperview];
        }
    }];
}

- (void)getWhoisInfoOfDomain: (NSString *)strDomain
{
    [WebServiceUtils getInstance].delegate = self;
    [[WebServiceUtils getInstance] searchDomainWithName:domain type:1];
}

#pragma mark - WebserviceUtilDelegate
-(void)failedToSearchDomainWithError:(NSString *)error {
    [icWaiting stopAnimating];
    icWaiting.hidden = TRUE;
    
    [[AppDelegate sharedInstance].window makeToast:@"Không thể lấy thông tin tên miền" duration:2.0 position:CSToastPositionCenter style:[AppDelegate sharedInstance].errorStyle];
    [self fadeOut];
}

-(void)searchDomainSuccessfulWithData:(NSDictionary *)data {
    domainInfo = [[NSDictionary alloc] initWithDictionary: data];
    
    [icWaiting stopAnimating];
    icWaiting.hidden = TRUE;
    [tbInfo reloadData];
    
    float hTableView = [self getTotalHeightOfTableviewWithData: data];
  
    float marginX = self.frame.origin.x;
    [UIView animateWithDuration:0.1 animations:^{
        self.frame = CGRectMake(marginX, (SCREEN_HEIGHT-(hTableView + 40.0))/2, SCREEN_WIDTH-2*marginX, hTableView + 40.0);
    }];
}

- (float)getTotalHeightOfTableviewWithData: (NSDictionary *)info {
    float hTableView = hCell * 3;
    
    NSString *content = [info objectForKey:@"owner"];
    float height = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize] andMaxWidth:(SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize))].height + 5.0;
    if (height< hCell) {
        height = hCell;
    }
    hTableView += height;
    
    //  get status height
    content = [info objectForKey:@"status"];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    height = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize] andMaxWidth:(SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize))].height + 5.0;
    if (height< hCell) {
        height = hCell;
    }
    hTableView += height;
    
    //  get registrar height
    content = [info objectForKey:@"registrar"];
    height = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize] andMaxWidth:(SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize))].height + 5.0;
    if (height< hCell) {
        height = hCell;
    }
    hTableView += height;
    
    //  get dns height
    content = [info objectForKey:@"dns"];
    content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
    height = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize] andMaxWidth:(SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize))].height + 5.0;
    if (height< hCell) {
        height = hCell;
    }
    hTableView += height;
    
    //  get dnssec height
    content = [info objectForKey:@"dnssec"];
    height = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize] andMaxWidth:(SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize))].height + 5.0;
    if (height< hCell) {
        height = hCell;
    }
    hTableView += height;
    
    return hTableView;
}


#pragma mark - UITableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DomainInfoRowTbvCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DomainInfoRowTbvCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        //  show domain
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Domain"];
        
        NSString *domain = [domainInfo objectForKey:@"domain"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: domain]) ? domain : @"";
        
    }else if (indexPath.row == 1){
        //  show registration date
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Registration date"];
        
        NSString *registrationDate = [domainInfo objectForKey:@"start"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: registrationDate]) ? registrationDate : @"";
        
    }else if (indexPath.row == 2){
        //  show expiration date
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Expiration date"];
        
        NSString *expirationDate = [domainInfo objectForKey:@"expired"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: expirationDate]) ? expirationDate : @"";
        
    }else if (indexPath.row == 3){
        //  show owner
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Owner"];
        
        NSString *owner = [domainInfo objectForKey:@"owner"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: owner]) ? owner : @"";
        
    }else if (indexPath.row == 4){
        //  show status
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Status"];
        
        NSString *status = [domainInfo objectForKey:@"status"];
        status = [status stringByReplacingOccurrencesOfString:@" " withString:@""];
        status = [status stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: status]) ? status : @"";
        
    }else if (indexPath.row == 5){
        //  show registrar
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Registrar"];
        
        NSString *registrar = [domainInfo objectForKey:@"registrar"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: registrar]) ? registrar : @"";
        
    }else if (indexPath.row == 6){
        //  show dns
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"Name Servers"];
        
        NSString *dns = [domainInfo objectForKey:@"dns"];
        dns = [dns stringByReplacingOccurrencesOfString:@" " withString:@""];
        dns = [dns stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: dns]) ? dns : @"";
        
    }else{
        cell.lbTitle.text = [[AppDelegate sharedInstance].localization localizedStringForKey:@"DNSSEC"];
        
        NSString *dnssec = [domainInfo objectForKey:@"dnssec"];
        cell.lbContent.text = (![AppUtils isNullOrEmpty: dnssec]) ? dnssec : @"";
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getHeightForRowWithIndex: (int)indexPath.row];
}

- (float)getHeightForRowWithIndex: (int)row
{
    NSString *content = @"";
    if (row == 0 || row == 1 || row == 2) {
        return hCell;
        
    }else if (row == 3){
        content = [domainInfo objectForKey:@"owner"];
        
    }else if (row == 4){
        content = [domainInfo objectForKey:@"status"];
        content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        
    }else if (row == 5){
        content = [domainInfo objectForKey:@"registrar"];
        
    }else if (row == 6){
        content = [domainInfo objectForKey:@"dns"];
        content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
        content = [content stringByReplacingOccurrencesOfString:@"," withString:@"\n"];
        
    }else if (row == 7){
        content = [domainInfo objectForKey:@"dnssec"];
    }
    
    float height = [AppUtils getSizeWithText:content withFont:[UIFont fontWithName:RobotoRegular size:fontForGetHeight.pointSize] andMaxWidth:(SCREEN_WIDTH - (2*padding + 2*padding + leftMaxSize))].height + 5.0;
    if (height< hCell) {
        height = hCell;
    }
    return height;
}

@end
