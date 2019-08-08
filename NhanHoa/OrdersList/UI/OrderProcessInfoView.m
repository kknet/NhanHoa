//
//  OrderProcessInfoView.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderProcessInfoView.h"

@implementation OrderProcessInfoView

@synthesize viewHeader, lbHeader, lbPhoneSupport, lbPhoneSupportValue, lbTakeCareBy, lbTakeCareByValue, lbDateReceived, lbDateReceivedValue, lbDateFinish, lbDateFinishValue;

- (void)setupUIForView {
    float hHeader = 50.0;
    float padding = 5.0;
    float hItem = 45.0;
    float leftSize = 140.0;
    
    //  header view
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(hHeader);
    }];
    
    lbHeader.font = [AppDelegate sharedInstance].fontBTN;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewHeader);
        make.left.equalTo(viewHeader).offset(padding);
        make.right.equalTo(viewHeader).offset(-padding);
    }];
    
    //  Điện thoại hỗ trợ
    [lbPhoneSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo(leftSize);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbPhoneSupportValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPhoneSupport);
        make.left.equalTo(lbPhoneSupport.mas_right);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  Phụ trách bởi
    [lbTakeCareBy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPhoneSupport.mas_bottom);
        make.left.right.equalTo(lbPhoneSupport);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbTakeCareByValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbTakeCareBy);
        make.left.right.equalTo(lbPhoneSupportValue);
    }];
    
    //  Ngày nhận
    [lbDateReceived mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbTakeCareBy.mas_bottom);
        make.left.right.equalTo(lbTakeCareBy);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDateReceivedValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDateReceived);
        make.left.right.equalTo(lbTakeCareByValue);
    }];
    
    //  Ngày hoàn thành
    [lbDateFinish mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDateReceived.mas_bottom);
        make.left.right.equalTo(lbDateReceived);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDateFinishValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDateFinish);
        make.left.right.equalTo(lbDateReceivedValue);
    }];
    
    lbPhoneSupport.backgroundColor = lbTakeCareBy.backgroundColor = lbDateReceived.backgroundColor = lbDateFinish.backgroundColor = UIColorFromRGB(0xeceff1);
    lbPhoneSupport.font = lbTakeCareBy.font = lbDateReceived.font = lbDateFinish.font = [AppDelegate sharedInstance].fontNormal;
    
    lbPhoneSupportValue.backgroundColor = lbTakeCareByValue.backgroundColor = lbDateReceivedValue.backgroundColor = lbDateFinishValue.backgroundColor = UIColor.whiteColor;
    lbPhoneSupportValue.font = lbTakeCareByValue.font = lbDateReceivedValue.font = lbDateFinishValue.font = [AppDelegate sharedInstance].fontNormal;
    
    lbPhoneSupport.text = @"  Điện thoại hỗ trợ";
    lbPhoneSupportValue.text = @"  028 73086680";
    
    lbTakeCareBy.text = @"  Phụ trách bởi";
    lbTakeCareByValue.text = @"  Nguyễn Thị Lan Mơ";
    
    lbDateReceived.text = @"  Ngày nhận";
    lbDateReceivedValue.text = @"  03/07/2019, 03:33 am";
    
    lbDateFinish.text = @"  Ngày hoàn thành";
    lbDateFinishValue.text = @"  03/07/2019, 08:05 am";
}

@end
