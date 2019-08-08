//
//  WindowsHostingCell.m
//  NhanHoa
//
//  Created by OS on 8/5/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WindowsHostingCell.h"

@implementation WindowsHostingCell

@synthesize viewWrapper, viewHeader, imgType, lbName, lbPrice, lbMemory, lbMemoryValue, lbSepa1, lbBandwidth, lbBandwidthValue, lbSepa2, lbFTP, lbFTPValue, lbSepa3, lbMySQL, lbMySQLValue, lbSepa4, lbMSSQL, lbMSSQLValue, lbSepa5, lbDomain, lbDomainValue, lbSepa6, lbSubdomain, lbSubdomainValue, lbSepa7, lbAliasOrParkDomain, lbAliasOrParkDomainValue, lbSepa8, lbAmount, tfAmount, imgArrAmount, btnAmount, lbSepa9, btnAddCart;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 10.0;
    float mTop = 15.0;
    float paddingContent = 7.0;
    
    viewWrapper.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    viewWrapper.layer.borderWidth = 1.0;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(paddingContent);
        make.right.equalTo(self).offset(-paddingContent);
        make.bottom.equalTo(self).offset(-paddingContent - mTop);
    }];
    [AppUtils addBoxShadowForView:viewWrapper color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(60.0);
    }];
    
    [imgType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(padding);
        make.top.equalTo(viewHeader).offset(5.0);
        make.width.height.mas_equalTo(30.0);
    }];
    
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgType.mas_right).offset(padding);
        make.top.bottom.equalTo(imgType);
        make.right.equalTo(viewHeader).offset(-padding);
    }];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbName.mas_bottom);
        make.left.right.equalTo(lbName);
        make.height.mas_equalTo(20.0);
    }];
    
    //  content
    float hItem = 40.0;
    [lbMemory mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper.mas_centerX).offset(20.0);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbMemoryValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbMemory);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.left.equalTo(lbMemory.mas_right);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMemory.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  bandwidth
    [lbBandwidth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa1.mas_bottom);
        make.left.right.equalTo(lbMemory);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbBandwidthValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbBandwidth);
        make.left.right.equalTo(lbMemoryValue);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBandwidth.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  FTP account
    [lbFTP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa2.mas_bottom);
        make.left.right.equalTo(lbBandwidth);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbFTPValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbFTP);
        make.left.right.equalTo(lbBandwidthValue);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbFTP.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  MySQL
    [lbMySQL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa3.mas_bottom);
        make.left.right.equalTo(lbFTP);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbMySQLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbMySQL);
        make.left.right.equalTo(lbFTPValue);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMySQL.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  MSSQL 2005/2008
    [lbMSSQL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa4.mas_bottom);
        make.left.right.equalTo(lbMySQL);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbMSSQLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbMSSQL);
        make.left.right.equalTo(lbMySQLValue);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMSSQL.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Domain
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa5.mas_bottom);
        make.left.right.equalTo(lbMSSQL);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomain);
        make.left.right.equalTo(lbMySQLValue);
    }];
    
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Subdomain
    [lbSubdomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa6.mas_bottom);
        make.left.right.equalTo(lbDomain);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbSubdomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbSubdomain);
        make.left.right.equalTo(lbDomainValue);
    }];
    
    [lbSepa7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSubdomain.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Alias/ Park domain
    [lbAliasOrParkDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa7.mas_bottom);
        make.left.right.equalTo(lbSubdomain);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbAliasOrParkDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbAliasOrParkDomain);
        make.left.right.equalTo(lbSubdomainValue);
    }];
    
    [lbSepa8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAliasOrParkDomain.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  Amount
    [lbAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa8.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
    
    [tfAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAmount.mas_bottom);
        make.left.right.equalTo(lbAmount);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnAmount setTitle:@"" forState:UIControlStateNormal];
    [btnAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfAmount);
    }];
    
    [imgArrAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tfAmount.mas_centerY);
        make.right.equalTo(tfAmount).offset(-5.0);
        make.width.mas_equalTo(16.0);
        make.height.mas_equalTo(12.0);
    }];
    
    [lbSepa9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfAmount.mas_bottom).offset(15.0);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa9.mas_bottom).offset(15.0);
        make.left.right.equalTo(tfAmount);
        make.height.mas_equalTo(45.0);
    }];
    
    lbName.textColor = BLUE_COLOR;
    lbMemory.font = lbBandwidth.font = lbFTP.font = lbMySQL.font = lbDomain.font = lbSubdomain.font = lbAliasOrParkDomain.font = lbMSSQL.font = tfAmount.font = [AppDelegate sharedInstance].fontRegular;
    
    lbMemoryValue.font = lbBandwidthValue.font = lbFTPValue.font = lbMySQLValue.font = lbDomainValue.font = lbSubdomainValue.font = lbAliasOrParkDomainValue.font = lbMSSQLValue.font = lbAmount.font = [AppDelegate sharedInstance].fontMedium;
    
    lbMemory.textColor = lbBandwidth.textColor = lbFTP.textColor = lbMySQL.textColor = lbDomain.textColor = lbSubdomain.textColor = lbAliasOrParkDomain.textColor = lbMSSQL.textColor = tfAmount.textColor = TITLE_COLOR;
    
    lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = lbSepa7.backgroundColor = lbSepa8.backgroundColor = lbSepa9.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    btnAddCart.backgroundColor = UIColorFromRGB(0xf16725);
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    if ([DeviceUtils isScreen320]) {
        lbName.font = [UIFont fontWithName:RobotoMedium size:20.0];
        lbPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
        lbAmount.font = tfAmount.font = [AppDelegate sharedInstance].fontRegular;
        
    }else{
        lbName.font = [UIFont fontWithName:RobotoMedium size:24.0];
        lbPrice.font = [UIFont fontWithName:RobotoMedium size:18.0];
        lbAmount.font = tfAmount.font = [AppDelegate sharedInstance].fontRegular;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
