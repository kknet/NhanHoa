//
//  VPSTbvCell.m
//  NhanHoa
//
//  Created by OS on 8/6/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "VPSTbvCell.h"
#import "CustomTextAttachment.h"

@implementation VPSTbvCell

@synthesize viewWrapper, viewHeader, lbHeader, lbPrice, lbCPU, imgTickCPU, lbSepa1, lbCore, lbSepa2, lbSSD, lbSepa3, lbRAM, lbSepa4, lbIP, lbSepa5, lbBandwidth, lbSepa6, lbBonusDirectAdmin, lbBonusRAM, lbSepa7, tfTime, imgArr, btnChooseTime, btnAddCart, lbSepa8, imgTickCore, imgTickSSD, imgTickRAM, imgTickIP, imgTickBonus1, imgTickBonus2, imgTickBandwidth;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    float paddingContent = 7.0;
    float padding = 10.0;
    float mTop = 15.0;
    
    viewWrapper.layer.borderColor = [UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0].CGColor;
    viewWrapper.layer.borderWidth = 1.0;
    [viewWrapper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).offset(paddingContent);
        make.right.equalTo(self).offset(-paddingContent);
        make.bottom.equalTo(self).offset(-paddingContent - mTop);
    }];
    [AppUtils addBoxShadowForView:viewWrapper color:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1.0] opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header view
    viewHeader.backgroundColor = UIColorFromRGB(0xECEFF1);
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(60.0);
    }];
    
    lbHeader.textColor = BLUE_COLOR;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(padding);
        make.right.equalTo(viewHeader).offset(-padding);
        make.top.equalTo(viewHeader).offset(5.0);
        make.height.mas_equalTo(30.0);
    }];
    
    [lbPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lbHeader);
        make.top.equalTo(lbHeader.mas_bottom);
        make.height.mas_equalTo(20.0);
    }];
    
    //  content
    float hItem = 45.0;
    
    //  cpu
    [lbCPU mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrapper).offset(padding + 17.0 + 5.0);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.top.equalTo(viewHeader.mas_bottom);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickCPU mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewWrapper).offset(padding);
        make.centerY.equalTo(lbCPU.mas_centerY);
        make.width.height.mas_equalTo(16.0);
    }];
    
    [lbSepa1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCPU.mas_bottom);
        make.left.right.equalTo(viewWrapper);
        make.height.mas_equalTo(1.0);
    }];
    
    //  CORE
    [lbCore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa1.mas_bottom);
        make.left.right.equalTo(lbCPU);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickCore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbCore.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCore.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  SSD
    [lbSSD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa2.mas_bottom);
        make.left.right.equalTo(lbCore);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickSSD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbSSD.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSSD.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  RAM
    [lbRAM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa3.mas_bottom);
        make.left.right.equalTo(lbSSD);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickRAM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbRAM.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRAM.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  IP
    [lbIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa4.mas_bottom);
        make.left.right.equalTo(lbRAM);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickIP mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbIP.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbIP.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Bandwidth
    [lbBandwidth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa5.mas_bottom);
        make.left.right.equalTo(lbIP);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickBandwidth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbBandwidth.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBandwidth.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Bonus direct admin
    [lbBonusDirectAdmin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa6.mas_bottom);
        make.left.right.equalTo(lbBandwidth);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickBonus1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbBonusDirectAdmin.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBonusDirectAdmin.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    //  Bonus RAM
    [lbBonusRAM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa7.mas_bottom);
        make.left.right.equalTo(lbBonusDirectAdmin);
        make.height.mas_equalTo(hItem);
    }];
    
    [imgTickBonus2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgTickCPU);
        make.centerY.equalTo(lbBonusRAM.mas_centerY);
        make.height.equalTo(imgTickCPU.mas_height);
    }];
    
    [lbSepa8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbBonusRAM.mas_bottom);
        make.left.right.equalTo(lbSepa1);
        make.height.equalTo(lbSepa1.mas_height);
    }];
    
    float sizeBTN = [AppUtils getSizeWithText:btnAddCart.currentTitle withFont:[AppDelegate sharedInstance].fontBTN].width + 20.0;
    [btnAddCart setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [btnAddCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSepa8.mas_bottom).offset(mTop);
        make.right.equalTo(viewWrapper).offset(-padding);
        make.width.mas_equalTo(sizeBTN);
        make.height.mas_equalTo([AppDelegate sharedInstance].hTextfield);
    }];
    
    [AppUtils setBorderForTextfield:tfTime borderColor:BORDER_COLOR];
    [tfTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnAddCart);
        make.left.equalTo(viewWrapper).offset(padding);
        make.right.equalTo(btnAddCart.mas_left).offset(-padding);
    }];
    
    [btnChooseTime setTitle:@"" forState:UIControlStateNormal];
    [btnChooseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfTime);
    }];
    
    [imgArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(tfTime.mas_centerY);
        make.right.equalTo(tfTime).offset(-5.0);
        make.width.mas_equalTo(16.0);
        make.height.mas_equalTo(12.0);
    }];
    
    btnAddCart.layer.cornerRadius = [AppDelegate sharedInstance].radius;
    btnAddCart.backgroundColor = ORANGE_BUTTON;
    btnAddCart.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbSepa1.backgroundColor = lbSepa2.backgroundColor = lbSepa3.backgroundColor = lbSepa4.backgroundColor = lbSepa5.backgroundColor = lbSepa6.backgroundColor = lbSepa7.backgroundColor = lbSepa8.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(240/255.0) blue:(240/255.0) alpha:1.0];
    
    lbCPU.font = lbCore.font = lbSSD.font = lbRAM.font = lbIP.font = lbBandwidth.font = lbBonusDirectAdmin.font = lbBonusRAM.font = [AppDelegate sharedInstance].fontRegular;
    
    if ([DeviceUtils isScreen320]) {
        lbHeader.font = [UIFont fontWithName:RobotoMedium size:18.0];
        lbPrice.font = [UIFont fontWithName:RobotoMedium size:14.0];
        
    }else{
        lbHeader.font = [UIFont fontWithName:RobotoMedium size:22.0];
        lbPrice.font = [UIFont fontWithName:RobotoMedium size:16.0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupAttrContent {
    NSString *text = lbCPU.text;
    
    NSMutableAttributedString *contentString = [[NSMutableAttributedString alloc] initWithString:text];
    [contentString addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontMedium range:NSMakeRange(0, contentString.length)];
    [contentString addAttribute:NSForegroundColorAttributeName value:UIColor.blackColor range:NSMakeRange(0, contentString.length)];
    
    NSRange rangeCPU = [text rangeOfString:@"CPU : "];
    if (rangeCPU.location != NSNotFound) {
        [contentString addAttribute:NSFontAttributeName value:[AppDelegate sharedInstance].fontRegular range:rangeCPU];
    }
    lbCPU.attributedText = contentString;
}

@end
