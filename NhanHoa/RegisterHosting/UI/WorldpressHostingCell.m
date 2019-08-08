//
//  WorldpressHostingCell.m
//  NhanHoa
//
//  Created by OS on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "WorldpressHostingCell.h"

@implementation WorldpressHostingCell
@synthesize viewWrapper, viewHeader, lbName, lbPrice, lbAmount, tfAmount, btnAddCart, btnAmount, imgType, lbSepa, imgArr;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float padding = 15.0;
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
    
    //  Amount
    float hItem = 40.0;
    lbAmount.textColor = TITLE_COLOR;
    [lbAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.height.mas_equalTo(hItem);
    }];
    
    [AppUtils setBorderForTextfield:tfAmount borderColor:BORDER_COLOR];
    tfAmount.text = @"1";
    [tfAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAmount.mas_bottom);
        make.left.right.equalTo(lbAmount);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [btnAmount setTitle:@"" forState:UIControlStateNormal];
    [btnAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfAmount);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tfAmount.mas_centerY);
        make.right.equalTo(tfAmount).offset(-5.0);
        make.width.mas_equalTo(16.0);
        make.height.mas_equalTo(12.0);
    }];
    
    lbSepa.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    [lbSepa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfAmount.mas_bottom).offset(mTop);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    btnAddCart.backgroundColor = UIColorFromRGB(0xf16725);
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa.mas_bottom).offset(mTop);
        make.left.right.equalTo(tfAmount);
        make.height.mas_equalTo(45.0);
    }];
    
    lbName.textColor = BLUE_COLOR;
    
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
