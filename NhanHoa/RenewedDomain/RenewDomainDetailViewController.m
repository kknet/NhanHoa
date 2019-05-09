//
//  RenewDomainDetailViewController.m
//  NhanHoa
//
//  Created by admin on 5/1/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "RenewDomainDetailViewController.h"
#import "RenewDomainCartViewController.h"

@interface RenewDomainDetailViewController ()

@end

@implementation RenewDomainDetailViewController
@synthesize lbTopDomain, viewDetail, lbID, lbIDValue, lbDomain, lbDomainValue, lbServiceName, lbServiceNameValue, lbPrice, lbPriceValue, lbRegisterDate, lbRegisterDateValue, lbState, lbStateValue, btnRenewDomain, btnChangeDNS, btnUpdatePassport;
@synthesize domainObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Gia hạn tên miền";
    [self setupUIForView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    if (domainObj != nil) {
        lbTopDomain.text = domainObj.domainName;
        lbDomainValue.text = domainObj.domainName;
        lbStateValue.text = domainObj.state;
        lbRegisterDateValue.text = [NSString stringWithFormat:@"S:%@\nE:%@", domainObj.registerDate, domainObj.registerDate];
        if ([domainObj.state isEqualToString:@"Sắp hết hạn"]) {
            lbStateValue.textColor = NEW_PRICE_COLOR;
            
        }else if ([domainObj.state isEqualToString:@"Hết hạn"]) {
            lbStateValue.textColor = UIColor.grayColor;
            
        }else{
            lbStateValue.textColor = [UIColor colorWithRed:(28/255.0) green:(289/255.0) blue:(91/255.0) alpha:1.0];
        }
    }
}

- (IBAction)btnRenewDomainPress:(UIButton *)sender {
    RenewDomainCartViewController *renewCartVC = [[RenewDomainCartViewController alloc] initWithNibName:@"RenewDomainCartViewController" bundle:nil];
    [self.navigationController pushViewController:renewCartVC animated:TRUE];
}

- (IBAction)btnUpdatePassportPress:(UIButton *)sender {
}

- (IBAction)btnChangeDNSPress:(UIButton *)sender {
}


- (void)setupUIForView {
    float padding = 15.0;
    float hItem = 30.0;
    
    lbTopDomain.backgroundColor = UIColor.whiteColor;
    lbTopDomain.font = [UIFont fontWithName:RobotoBold size:17.0];
    lbTopDomain.textColor = BLUE_COLOR;
    [lbTopDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(padding);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(50.0);
    }];
    
    viewDetail.layer.cornerRadius = 5.0;
    viewDetail.layer.borderWidth = 1.0;
    viewDetail.layer.borderColor = [UIColor colorWithRed:(235/255.0) green:(235/255.0) blue:(235/255.0) alpha:1.0].CGColor;
    [viewDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTopDomain.mas_centerY);
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.height.mas_equalTo(270.0);
    }];
    
    //  ID
    lbID.font = [UIFont fontWithName:RobotoRegular size:16.0];
    lbID.textColor = TITLE_COLOR;
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewDetail).offset(padding);
        make.left.equalTo(self.viewDetail).offset(padding);
        make.right.equalTo(self.viewDetail.mas_centerX).offset(-30.0);
        make.height.mas_equalTo(hItem);
    }];
    
    lbIDValue.font = lbID.font;
    lbIDValue.textColor = lbID.textColor;
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lbID.mas_right).offset(10.0);
        make.top.bottom.equalTo(self.lbID);
        make.right.equalTo(self.viewDetail.mas_right).offset(-padding);
    }];
    
    //  domain name
    lbDomain.font = lbID.font;
    lbDomain.textColor = lbID.textColor;
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbID.mas_bottom);
        make.left.right.equalTo(self.lbID);
        make.height.mas_equalTo(hItem);
    }];
    
    lbDomainValue.font = lbID.font;
    lbDomainValue.textColor = lbID.textColor;
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbIDValue);
        make.top.bottom.equalTo(self.lbDomain);
    }];
    
    //  service name
    lbServiceName.font = lbID.font;
    lbServiceName.textColor = lbID.textColor;
    [lbServiceName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbDomain.mas_bottom);
        make.left.right.equalTo(self.lbDomain);
        make.height.mas_equalTo(hItem);
    }];
    
    lbServiceNameValue.font = lbID.font;
    lbServiceNameValue.textColor = lbID.textColor;
    [lbServiceNameValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbDomainValue);
        make.top.equalTo(self.lbServiceName);
        make.height.mas_equalTo(2*hItem);
    }];
    
    //  price
    lbPrice.font = lbID.font;
    lbPrice.textColor = lbID.textColor;
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbServiceNameValue.mas_bottom);
        make.left.right.equalTo(self.lbServiceName);
        make.height.mas_equalTo(hItem);
    }];
    
    lbPriceValue.font = lbID.font;
    lbPriceValue.textColor = lbID.textColor;
    [lbPriceValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbServiceNameValue);
        make.top.bottom.equalTo(self.lbPrice);
    }];
    
    //  registered date
    lbRegisterDate.font = lbID.font;
    lbRegisterDate.textColor = lbID.textColor;
    [lbRegisterDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbPrice.mas_bottom);
        make.left.right.equalTo(self.lbPrice);
        make.height.mas_equalTo(hItem);
    }];
    
    lbRegisterDateValue.font = lbID.font;
    lbRegisterDateValue.textColor = lbID.textColor;
    [lbRegisterDateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbPriceValue);
        make.top.equalTo(self.lbRegisterDate);
        make.height.mas_equalTo(2*hItem);
    }];
    
    //  state
    lbState.font = lbID.font;
    lbState.textColor = lbID.textColor;
    [lbState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbRegisterDateValue.mas_bottom);
        make.left.right.equalTo(self.lbRegisterDate);
        make.height.mas_equalTo(hItem);
    }];
    
    lbStateValue.font = lbID.font;
    lbStateValue.textColor = lbID.textColor;
    [lbStateValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.lbRegisterDateValue);
        make.top.bottom.equalTo(self.lbState);
    }];
    
    float hBTN = 40.0;
    
    btnChangeDNS.titleLabel.font = [UIFont fontWithName:RobotoRegular size:18.0];
    btnChangeDNS.backgroundColor = BLUE_COLOR;
    btnChangeDNS.layer.cornerRadius = hBTN/2;
    [btnChangeDNS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.right.equalTo(self.view).offset(-padding);
        make.bottom.equalTo(self.view).offset(-2*padding);
        make.height.mas_equalTo(hBTN);
    }];
    
    btnUpdatePassport.titleLabel.font = btnChangeDNS.titleLabel.font;
    btnUpdatePassport.backgroundColor = BLUE_COLOR;
    btnUpdatePassport.layer.cornerRadius = hBTN/2;
    [btnUpdatePassport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnChangeDNS);
        make.bottom.equalTo(self.btnChangeDNS.mas_top).offset(-padding);
        make.height.equalTo(self.btnChangeDNS.mas_height);
    }];
    
    btnRenewDomain.titleLabel.font = btnChangeDNS.titleLabel.font;
    btnRenewDomain.backgroundColor = BLUE_COLOR;
    btnRenewDomain.layer.cornerRadius = hBTN/2;
    [btnRenewDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnUpdatePassport);
        make.bottom.equalTo(self.btnUpdatePassport.mas_top).offset(-padding);
        make.height.equalTo(self.btnUpdatePassport.mas_height);
    }];
}

@end
