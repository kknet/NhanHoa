//
//  OrderDetailDescriptionView.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderDetailDescriptionView.h"

@implementation OrderDetailDescriptionView

@synthesize viewHeader, lbHeader, lbDomain, lbDomainValue, lbServer, lbServerValue, lbStartTime, lbStartTimeValue, lbEndTime, lbEndTimeValue, lbStatus, lbStatusValue;

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
    
    //  Tên miền
    [lbDomain mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo(leftSize);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDomainValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDomain);
        make.left.equalTo(lbDomain.mas_right);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  Máy chủ
    [lbServer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDomain.mas_bottom);
        make.left.right.equalTo(lbDomain);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbServerValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbServer);
        make.left.right.equalTo(lbDomainValue);
    }];
    
    //  Thời gian bắt đầu
    [lbStartTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbServer.mas_bottom);
        make.left.right.equalTo(lbServer);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbStartTimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbStartTime);
        make.left.right.equalTo(lbServerValue);
    }];
    
    //  Thời gian kết thúc
    [lbEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbStartTime.mas_bottom);
        make.left.right.equalTo(lbStartTime);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbEndTimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbEndTime);
        make.left.right.equalTo(lbStartTimeValue);
    }];
    
    //  Trạng thái
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbEndTime.mas_bottom);
        make.left.right.equalTo(lbEndTime);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbStatusValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbStatus);
        make.left.right.equalTo(lbEndTimeValue);
    }];
    
    lbDomain.backgroundColor = lbServer.backgroundColor = lbStartTime.backgroundColor = lbEndTime.backgroundColor = lbStatus.backgroundColor = UIColorFromRGB(0xeceff1);
    lbDomain.font = lbServer.font = lbStartTime.font = lbEndTime.font = lbStatus.font = [AppDelegate sharedInstance].fontNormal;
    
    lbDomainValue.backgroundColor = lbServerValue.backgroundColor = lbStartTimeValue.backgroundColor = lbEndTimeValue.backgroundColor = lbStatusValue.backgroundColor = UIColor.whiteColor;
    lbDomainValue.font = lbServerValue.font = lbStartTimeValue.font = lbEndTimeValue.font = lbStatusValue.font = [AppDelegate sharedInstance].fontNormal;
    
    lbDomain.text = @"  Tên miền";
    lbDomainValue.text = @"";
    
    lbServer.text = @"  Máy chủ";
    lbServerValue.text = @"";
    
    lbStartTime.text = @"  Thời gian bắt đầu";
    lbStartTimeValue.text = @"  03/07/2019";
    
    lbEndTime.text = @"  Thời gian kết thúc";
    lbEndTimeValue.text = @"  03/07/2029";
    
    lbStatus.text = @"  Trạng thái";
    lbStatusValue.text = @"  Đã kích hoạt";
}

@end
