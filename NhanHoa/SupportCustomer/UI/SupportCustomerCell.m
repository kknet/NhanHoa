//
//  SupportCustomerCell.m
//  NhanHoa
//
//  Created by Khai Leo on 7/20/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "SupportCustomerCell.h"

@implementation SupportCustomerCell
@synthesize lbName, lbExtension, lbSepa, btnCall;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    float padding = 15.0;
    float sizeIcon = 40.0;
    
    if (!IS_IPHONE && !IS_IPOD) {
        padding = 30.0;
        sizeIcon = 45.0;
    }
    
    btnCall.backgroundColor = LIGHT_GRAY_COLOR;
    btnCall.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    btnCall.layer.cornerRadius = sizeIcon/2;
    [btnCall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-padding);
        make.width.height.mas_equalTo(sizeIcon);
    }];
    
    lbName.font = [AppDelegate sharedInstance].fontMedium;
    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(padding);
        make.top.bottom.equalTo(btnCall);
        make.right.equalTo(btnCall).offset(-5.0);
    }];
    
    
//    lbName.font = [AppDelegate sharedInstance].fontMedium;
//    [lbName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(padding);
//        make.right.equalTo(self.btnCall).offset(-5.0);
//        make.bottom.equalTo(self.mas_centerY).offset(-2.0);
//    }];
    
    lbExtension.hidden = TRUE;
    lbExtension.font = [AppDelegate sharedInstance].fontRegular;
    [lbExtension mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbName);
        make.top.equalTo(self.mas_centerY).offset(2.0);
    }];
    
    lbSepa.text = @"";
    lbSepa.backgroundColor = BORDER_COLOR;
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1.0);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayContentWithInfo: (NSDictionary *)info {
    NSString *exten = [info objectForKey:@"exten"];
    if (![AppUtils isNullOrEmpty: exten]) {
        lbExtension.text = exten;
    }else{
        lbExtension.text = @"";
    }
    
    NSString *name = [info objectForKey:@"name"];
    if (![AppUtils isNullOrEmpty: name]) {
        lbName.text = name;
    }else{
        lbName.text = @"";
    }
    
}


@end
