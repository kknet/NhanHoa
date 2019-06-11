//
//  PaymentResultView.m
//  NhanHoa
//
//  Created by lam quang quan on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "PaymentResultView.h"

@implementation PaymentResultView
@synthesize viewHeader, icBack, lbHeader, viewContent, viewTop, lbTypeTran, lbMoney, lbStatus, viewBottom, lbFee, lbFeeValue, lbID, lbIDValue, lbTime, lbTimeValue, btnSupport, btnTopupMore;

- (void)setupUIForView {
    float padding = 15.0;
    float hItem = 35.0;
    
    viewHeader.backgroundColor = BLUE_COLOR;
    [viewHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo([AppDelegate sharedInstance].hStatusBar + [AppDelegate sharedInstance].hNav);
    }];
    
    icBack.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [icBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader).offset([AppDelegate sharedInstance].hStatusBar);
        make.left.equalTo(self.viewHeader);
        make.width.height.mas_equalTo([AppDelegate sharedInstance].hNav);
    }];
    
    lbHeader.font = [AppDelegate sharedInstance].fontBTN;
    [lbHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.viewHeader.mas_centerX);
        make.top.bottom.equalTo(self.icBack);
        make.width.mas_equalTo(200);
    }];
    
    [viewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewHeader.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    
    float hTopView = padding + hItem + 50 + hItem + padding;
    [viewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.viewContent);
        make.height.mas_equalTo(hTopView);
    }];
    
    [lbTypeTran mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.viewTop).offset(padding);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbTypeTran.mas_bottom);
        make.left.right.equalTo(self.viewTop);
        make.height.mas_equalTo(50.0);
    }];
    
    [lbStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbMoney.mas_bottom);
        make.left.right.equalTo(self.viewTop);
        make.height.mas_equalTo(hItem);
    }];
    
    float hBottomView = padding + hItem + hItem + hItem + padding;
    [viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewTop.mas_bottom).offset(padding);
        make.left.right.equalTo(self.viewContent);
        make.height.mas_equalTo(hBottomView);
    }];
    
    [lbFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBottom).offset(padding);
        make.left.equalTo(self.viewBottom).offset(padding);
        make.right.equalTo(self.viewBottom.mas_centerX).offset(-padding/2);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbFeeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbFee);
        make.left.equalTo(self.lbFee).offset(padding);
        make.right.equalTo(self.viewBottom).offset(-padding);
    }];
    
    [lbID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbFee.mas_bottom);
        make.left.right.equalTo(self.lbFee);
        make.height.equalTo(self.lbFee.mas_height);
    }];
    
    [lbIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbID);
        make.left.right.equalTo(self.lbFeeValue);
    }];
    
    [lbTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lbID.mas_bottom);
        make.left.right.equalTo(self.lbID);
        make.height.equalTo(self.lbID.mas_height);
    }];
    
    [lbTimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.lbTime);
        make.left.right.equalTo(self.lbIDValue);
    }];
    
    btnTopupMore.layer.cornerRadius = 6.0;
    btnTopupMore.backgroundColor = UIColor.whiteColor;
    btnTopupMore.layer.borderWidth = 1.0;
    btnTopupMore.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    
    NSAttributedString *topupMoreTitle = [AppUtils generateTextWithContent:@" Nạp thêm" font:[AppDelegate sharedInstance].fontBTN color:BLUE_COLOR image:[UIImage imageNamed:@"ic_add"] size:20.0 imageFirst:TRUE];
    [btnTopupMore setAttributedTitle:topupMoreTitle forState:UIControlStateNormal];
    [btnTopupMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewBottom.mas_bottom).offset(padding);
        make.right.equalTo(self.viewContent.mas_centerX).offset(-padding/2);
        make.left.equalTo(self.viewContent).offset(padding);
        make.height.mas_equalTo(45.0);
    }];
    
    btnSupport.layer.cornerRadius = 6.0;
    btnSupport.backgroundColor = UIColor.whiteColor;
    btnSupport.layer.borderWidth = 1.0;
    btnSupport.layer.borderColor = OLD_PRICE_COLOR.CGColor;
    [btnSupport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.btnTopupMore);
        make.left.equalTo(self.btnTopupMore.mas_right).offset(padding);
        make.right.equalTo(self.viewContent).offset(-padding);
    }];
    NSAttributedString *supportTitle = [AppUtils generateTextWithContent:@" Hỗ trợ" font:[AppDelegate sharedInstance].fontBTN color:BLUE_COLOR image:[UIImage imageNamed:@"ic_headset"] size:20.0 imageFirst:TRUE];
    [btnSupport setAttributedTitle:supportTitle forState:UIControlStateNormal];
    
    
    lbTypeTran.font = [AppDelegate sharedInstance].fontRegular;
    lbFee.font = lbFeeValue.font = lbID.font = lbIDValue.font = lbTime.font = lbTimeValue.font = lbStatus.font = [AppDelegate sharedInstance].fontBTN;
    lbMoney.font = [UIFont fontWithName:RobotoRegular size:28.0];
    btnSupport.titleLabel.font = btnTopupMore.titleLabel.font = [AppDelegate sharedInstance].fontBTN;
    
    lbMoney.textColor = BLUE_COLOR;
    lbTypeTran.textColor = lbFee.textColor = lbFeeValue.textColor = lbID.textColor = lbIDValue.textColor = lbTime.textColor = lbTimeValue.textColor = TITLE_COLOR;
}

- (IBAction)icBackClick:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (IBAction)btnTopupMorePress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
}

- (IBAction)btnSupportPress:(UIButton *)sender {
    [WriteLogsUtils writeLogContent:SFM(@"[%s]", __FUNCTION__) toFilePath:[AppDelegate sharedInstance].logFilePath];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: link_support]];
}

- (void)showContentWithInfo: (NSDictionary *)info {
    NSString *vpc_TxnResponseCode = [info objectForKey:@"vpc_TxnResponseCode"];
    if (![AppUtils isNullOrEmpty: vpc_TxnResponseCode]) {
        NSString *vpc_Amount = [info objectForKey:@"vpc_Amount"];
        NSString *vpc_OrderInfo = [info objectForKey:@"vpc_OrderInfo"];
        NSString *vpc_TransactionNo = [info objectForKey:@"vpc_TransactionNo"];
        
        if (![AppUtils isNullOrEmpty: vpc_Amount]) {
            if ([vpc_Amount hasSuffix:@"00"]) {
                vpc_Amount = [vpc_Amount stringByReplacingOccurrencesOfString:@"00" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(vpc_Amount.length-2, 2)];
            }
            
            NSString *amount = [AppUtils convertStringToCurrencyFormat: vpc_Amount];
            lbMoney.text = [NSString stringWithFormat:@"+%@VNĐ", amount];
        }else{
            lbMoney.text = @"";
        }
        
        if (![AppUtils isNullOrEmpty: vpc_TransactionNo]) {
            lbIDValue.text = vpc_TransactionNo;
        }else{
            lbIDValue.text = @"";
        }
        
        lbTimeValue.text = [AppUtils getDateTimeStringNotHaveSecondsFromDate:[NSDate date]];
        
        if ([vpc_TxnResponseCode isEqualToString: Approved_Code]) {
            lbStatus.textColor = GREEN_COLOR;
            lbStatus.text = @"Thành công";
        }else{
            lbStatus.textColor = NEW_PRICE_COLOR;
            lbStatus.text = @"Thất bại";
        }
    }
    /*
    "vpc_AdditionData" = 970423;
    "vpc_Amount" = 1000000;
    "vpc_Command" = pay;
    "vpc_CurrencyCode" = VND;
    "vpc_Locale" = vn;
    "vpc_MerchTxnRef" = 5e241f18c66c3d5cdff7af9eb0852013;
    "vpc_Merchant" = NHANHOA;
    "vpc_OrderInfo" = "App_Addfun_127115";
    "vpc_SecureHash" = A4C0DEDD9AC1788BCC07B382CE5B2E838DD59F64A9D96CE30F12F03E86A93F30;
    "vpc_TransactionNo" = 27174696;
    "vpc_TxnResponseCode" = 0;
    "vpc_Version" = 2;
    */
}

@end
