//
//  AddDNSRecordsView.m
//  NhanHoa
//
//  Created by OS on 10/31/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "AddDNSRecordsView.h"

@implementation AddDNSRecordsView

@synthesize viewHeader, lbHeader, icClose, scvContent, viewTop, lbTop, lbRecordName, tfRecordName, lbRecordType, tfRecordType, btnRecordType, imgRecordType, lbRecordValue, tfRecordValue, lbMX, tfMX, lbTTLValue, tfTTLValue, lbDesc, btnReset, btnSaveRecords;

- (void)setupUIForViewWithHeighNav: (float)hNav
{
    UIFont *textFont = [UIFont fontWithName:RobotoBold size:22.0];
    if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_5) {
        textFont = [UIFont fontWithName:RobotoBold size:18.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6){
        textFont = [UIFont fontWithName:RobotoBold size:20.0];
        
    }else if (SCREEN_WIDTH <= SCREEN_WIDTH_IPHONE_6PLUS){
        textFont = [UIFont fontWithName:RobotoBold size:22.0];
    }
    
    //  header view
    viewHeader.backgroundColor = UIColor.whiteColor;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo([UIApplication sharedApplication].statusBarFrame.size.height + hNav);
    }];
    [AppUtils addBoxShadowForView:viewHeader color:GRAY_200 opacity:0.8 offsetX:1.0 offsetY:1.0];
    
    //  header
    lbHeader.font = textFont;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader).offset([UIApplication sharedApplication].statusBarFrame.size.height);
        make.centerX.equalTo(viewHeader.mas_centerX);
        make.bottom.equalTo(viewHeader);
        make.width.mas_equalTo(250.0);
    }];
    
    icClose.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [icClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viewHeader).offset(5.0);
        make.centerY.equalTo(lbHeader.mas_centerY);
        make.width.height.mas_equalTo(40.0);
    }];
    
    //  scrollview content
    float padding = 15.0;
    float hLabel = 25.0;
    float hTextfield = 42.0;
    
    [scvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom).offset(5.0);
        make.left.right.bottom.equalTo(self);
    }];
    
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(scvContent);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(80.0);
    }];
    
    [lbTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(viewTop);
    }];
    
    //  record name
    [lbRecordName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [tfRecordName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRecordName.mas_bottom);
        make.left.right.equalTo(lbRecordName);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  record type
    [lbRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewTop.mas_bottom).offset(padding);
        make.left.equalTo(viewTop).offset(padding);
        make.right.equalTo(viewTop).offset(-padding);
        make.height.mas_equalTo(hLabel);
    }];
    
    [tfRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRecordType.mas_bottom);
        make.left.right.equalTo(lbRecordType);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [imgRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(tfRecordType).offset(-padding);
        make.centerY.equalTo(tfRecordType.mas_centerY);
        make.width.height.mas_equalTo(14.0);
    }];
    
    [btnRecordType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(tfRecordType);
    }];
    
    //  MX Value
    [lbMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnRecordType.mas_bottom).offset(padding);
        make.left.right.equalTo(btnRecordType);
        make.height.mas_equalTo(hLabel);
    }];
    
    [tfMX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbMX.mas_bottom);
        make.left.right.equalTo(lbMX);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  Record value
    [lbRecordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfMX.mas_bottom).offset(padding);
        make.left.right.equalTo(tfMX);
        make.height.mas_equalTo(hLabel);
    }];
    
    [tfRecordValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRecordValue.mas_bottom);
        make.left.right.equalTo(lbRecordValue);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  TTL value
    [lbTTLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfRecordValue.mas_bottom).offset(padding);
        make.left.right.equalTo(tfRecordValue);
        make.height.mas_equalTo(hLabel);
    }];
    
    [tfTTLValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTTLValue.mas_bottom);
        make.left.right.equalTo(lbTTLValue);
        make.height.mas_equalTo(hTextfield);
    }];
    
    //  footer
    [btnReset mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tfTTLValue.mas_bottom).offset(padding);
        make.left.equalTo(tfTTLValue);
        make.right.equalTo(viewTop.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hTextfield);
    }];
    
    [btnSaveRecords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(btnReset);
        make.left.equalTo(viewTop.mas_centerX).offset(padding/2);
        make.right.equalTo(tfTTLValue);
    }];
    
    float hContent = 80.0 + (padding + hLabel + hTextfield) + (padding + hLabel + hTextfield) + (padding + hLabel + hTextfield) + (padding + hLabel + hTextfield) + (padding + hLabel + hTextfield) + (padding + hLabel + hTextfield);
    scvContent.contentSize = CGSizeMake(SCREEN_WIDTH, hContent);
}

- (IBAction)icCloseClick:(UIButton *)sender {
}

- (IBAction)btnRecordTypePress:(UIButton *)sender {
}

- (IBAction)btnResetPress:(UIButton *)sender {
}

- (IBAction)btnSaveRecordsPress:(UIButton *)sender {
}
@end
