//
//  DomainUnavailableTbvCell.m
//  NhanHoa
//
//  Created by OS on 11/4/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "DomainUnavailableTbvCell.h"
#import "DomainInfoRowTbvCell.h"

@implementation DomainUnavailableTbvCell
@synthesize viewWrap, imgBackground, lbTopDomain, lbDesc, tbSubs;
@synthesize domainInfo, fontForGetHeight, leftMaxSize, padding;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.clearColor;
    
    padding = 15.0;
    
    UIImage *bg = [UIImage imageNamed:@"domain-search-unavailable"];
    float hBG = (SCREEN_WIDTH - 2*padding) * bg.size.height / bg.size.width;
    
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    fontForGetHeight = [UIFont fontWithName:RobotoMedium size:16.0];
    
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        fontForGetHeight = [UIFont fontWithName:RobotoMedium size:14.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        fontForGetHeight = [UIFont fontWithName:RobotoMedium size:15.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
        fontForGetHeight = [UIFont fontWithName:RobotoMedium size:16.0];
    }
    leftMaxSize = [AppUtils getSizeWithText:[[AppDelegate sharedInstance].localization localizedStringForKey:@"Registration date"] withFont:fontForGetHeight andMaxWidth:SCREEN_WIDTH].width + 10.0;

    
    viewWrap.clipsToBounds = TRUE;
    viewWrap.layer.cornerRadius = 12.0;
    [viewWrap mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15.0);
    }];
    
    [imgBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrap);
        make.height.mas_equalTo(hBG);
    }];
    
    lbTopDomain.font = textFont;
    [lbTopDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBackground).offset(padding);
        make.right.equalTo(imgBackground).offset(-padding);
        make.bottom.equalTo(imgBackground.mas_centerY).offset(-10.0);
    }];
    
    lbDesc.font = [UIFont fontWithName:RobotoRegular size:textFont.pointSize-4.0];
    [lbDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTopDomain.mas_bottom).offset(2.0);
        make.left.right.equalTo(lbTopDomain);
    }];
    
    [tbSubs registerNib:[UINib nibWithNibName:@"DomainInfoRowTbvCell" bundle:nil] forCellReuseIdentifier:@"DomainInfoRowTbvCell"];
    tbSubs.scrollEnabled = FALSE;
    tbSubs.delegate = self;
    tbSubs.dataSource = self;
    tbSubs.separatorStyle = UITableViewCellSelectionStyleNone;
    [tbSubs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBackground.mas_bottom);
        make.left.right.bottom.equalTo(viewWrap);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayContentWithInfo: (NSDictionary *)info
{
    domainInfo = [[NSDictionary alloc] initWithDictionary:info];
    
    NSString *domain = [domainInfo objectForKey: @"domain"];
    lbTopDomain.text = domain;
    lbDesc.text = SFM(@"%@\n%@!", [[AppDelegate sharedInstance].localization localizedStringForKey:@"Sorry"], [[AppDelegate sharedInstance].localization localizedStringForKey:@"This domain has been registered"]);
    
    [tbSubs reloadData];
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
        return 45.0;
        
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
    if (height< 45.0) {
        height = 45.0;
    }
    return height;
}

@end
