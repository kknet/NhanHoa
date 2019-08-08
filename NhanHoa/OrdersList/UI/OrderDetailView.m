//
//  OrderDetailView.m
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import "OrderDetailView.h"

@implementation OrderDetailView

@synthesize viewHeader, lbTitle, lbOrderDetail, lbOrderDetailValue, lbCustomer, lbCustomerValue, lbContractID, lbContractIDValue, lbInvoiceID, lbInvoiceIDValue, lbDuration, lbDurationValue, lbSetupFee, lbSetupFeeValue, lbRenewdFee, lbRenewedFeeValue, lbVAT, lbFeeVATValue, lbVATSetupFee, lbVATSetupFeeValue, lbDiscount, lbDiscountValue, lbAmount, lbAmountValue, lbPayment, lbPaymentValue, lbPaymentMethod, lbPaymentMethodValue, lbDateTime, lbDateTimeValue;

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
    
    lbTitle.font = [AppDelegate sharedInstance].fontBTN;
    [lbTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(viewHeader);
        make.left.equalTo(viewHeader).offset(padding);
        make.right.equalTo(viewHeader).offset(-padding);
    }];
    
    //  Chi tiết đơn hàng
    [lbOrderDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewHeader.mas_bottom);
        make.left.equalTo(self);
        make.width.mas_equalTo(leftSize);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbOrderDetailValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbOrderDetail);
        make.left.equalTo(lbOrderDetail.mas_right);
        make.right.equalTo(self).offset(-padding);
    }];
    
    //  Khách hàng
    [lbCustomer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbOrderDetail.mas_bottom);
        make.left.right.equalTo(lbOrderDetail);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbCustomerValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbCustomer);
        make.left.right.equalTo(lbOrderDetailValue);
    }];
    
    //  Mã hợp đồng
    [lbContractID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbCustomer.mas_bottom);
        make.left.right.equalTo(lbCustomer);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbContractIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbContractID);
        make.left.right.equalTo(lbCustomerValue);
    }];
    
    //  Mã hoá đơn
    [lbInvoiceID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbContractID.mas_bottom);
        make.left.right.equalTo(lbContractID);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbInvoiceIDValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbInvoiceID);
        make.left.right.equalTo(lbContractIDValue);
    }];
    
    //  Thời hạn
    [lbDuration mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbInvoiceID.mas_bottom);
        make.left.right.equalTo(lbInvoiceID);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDurationValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDuration);
        make.left.right.equalTo(lbInvoiceIDValue);
    }];
    
    //  Phí cài đặt
    [lbSetupFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDuration.mas_bottom);
        make.left.right.equalTo(lbDuration);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbSetupFeeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbSetupFee);
        make.left.right.equalTo(lbDurationValue);
    }];
    
    //  Phí duy trì
    [lbRenewdFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbSetupFee.mas_bottom);
        make.left.right.equalTo(lbSetupFee);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbRenewedFeeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbRenewdFee);
        make.left.right.equalTo(lbSetupFeeValue);
    }];
    
    //  VAT
    [lbVAT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbRenewdFee.mas_bottom);
        make.left.right.equalTo(lbRenewdFee);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbFeeVATValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbVAT);
        make.left.right.equalTo(lbRenewedFeeValue);
    }];
    
    //  VAT (Phí dịch vụ)
    [lbVATSetupFee mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVAT.mas_bottom);
        make.left.right.equalTo(lbVAT);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbVATSetupFeeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbVATSetupFee);
        make.left.right.equalTo(lbFeeVATValue);
    }];
    
    //  Chiết khấu
    [lbDiscount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbVATSetupFee.mas_bottom);
        make.left.right.equalTo(lbVATSetupFee);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDiscountValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDiscount);
        make.left.right.equalTo(lbVATSetupFeeValue);
    }];
    
    //  Thành tiền
    [lbAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbDiscount.mas_bottom);
        make.left.right.equalTo(lbDiscount);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbAmountValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbAmount);
        make.left.right.equalTo(lbDiscountValue);
    }];
    
    //  Thanh toán
    [lbPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbAmount.mas_bottom);
        make.left.right.equalTo(lbAmount);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbPaymentValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPayment);
        make.left.right.equalTo(lbAmountValue);
    }];
    
    //  Kiểu thanh toán
    [lbPaymentMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPayment.mas_bottom);
        make.left.right.equalTo(lbPayment);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbPaymentMethodValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbPaymentMethod);
        make.left.right.equalTo(lbPaymentValue);
    }];
    
    //  Thời gian
    [lbDateTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lbPaymentMethod.mas_bottom);
        make.left.right.equalTo(lbPaymentMethod);
        make.height.mas_equalTo(hItem);
    }];
    
    [lbDateTimeValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(lbDateTime);
        make.left.right.equalTo(lbPaymentMethodValue);
    }];
    
    lbOrderDetail.backgroundColor = lbCustomer.backgroundColor = lbContractID.backgroundColor = lbInvoiceID.backgroundColor = lbDuration.backgroundColor = lbSetupFee.backgroundColor = lbRenewdFee.backgroundColor = lbVAT.backgroundColor = lbVATSetupFee.backgroundColor = lbDiscount.backgroundColor = lbAmount.backgroundColor = lbPayment.backgroundColor = lbPaymentMethod.backgroundColor = lbDateTime.backgroundColor = UIColorFromRGB(0xeceff1);
    
    lbOrderDetailValue.backgroundColor = lbCustomerValue.backgroundColor = lbContractIDValue.backgroundColor = lbInvoiceIDValue.backgroundColor = lbDurationValue.backgroundColor = lbSetupFeeValue.backgroundColor = lbRenewedFeeValue.backgroundColor = lbFeeVATValue.backgroundColor = lbVATSetupFeeValue.backgroundColor = lbDiscountValue.backgroundColor = lbAmountValue.backgroundColor = lbPaymentValue.backgroundColor = lbPaymentMethodValue.backgroundColor = lbDateTimeValue.backgroundColor = UIColor.whiteColor;
    
    lbOrderDetail.font = lbCustomer.font = lbContractID.font = lbInvoiceID.font = lbDuration.font = lbSetupFee.font = lbRenewdFee.font = lbVAT.font = lbVATSetupFee.font = lbDiscount.font = lbAmount.font = lbPayment.font = lbPaymentMethod.font = lbDateTime.font = [AppDelegate sharedInstance].fontNormal;
    
    lbOrderDetailValue.font = lbCustomerValue.font = lbContractIDValue.font = lbInvoiceIDValue.font = lbDurationValue.font = lbSetupFeeValue.font = lbRenewedFeeValue.font = lbFeeVATValue.font = lbVATSetupFeeValue.font = lbDiscountValue.font = lbAmountValue.font = lbPaymentValue.font = lbPaymentMethodValue.font = lbDateTimeValue.font = [AppDelegate sharedInstance].fontNormal;
    
    lbOrderDetail.text = @"  Chi tiết đơn hàng";
    lbOrderDetailValue.text = @"  Nạp tiền Onepay qua APP";
    
    lbCustomer.text = @"  Khách hàng";
    lbCustomerValue.text = @"  Lê Hoàng Sơn (lehoangson@gmail.com)";
    
    lbContractID.text = @"  Mã hợp đồng";
    lbContractIDValue.text = @"  CTR516675";
    
    lbInvoiceID.text = @"  Mã hoá đơn";
    lbInvoiceIDValue.text = @"  INV618543";
    
    lbDuration.text = @"  Thời hạn";
    lbDurationValue.text = @"  Một lần";
    
    lbSetupFee.text = @"  Phí cài đặt";
    lbSetupFeeValue.text = @"  0đ";
    
    lbRenewdFee.text = @"  Phí duy trì";
    lbRenewedFeeValue.text = @"  10.000 đ/Một lần";
    
    lbVAT.text = @"  VAT";
    lbFeeVATValue.text = @"  0%";
    
    lbVATSetupFee.text = @"  VAT (Phí dịch vụ)";
    lbVATSetupFeeValue.text = @"  0%";
    
    lbDiscount.text = @"  Chiết khấu";
    lbDiscountValue.text = @"  0đ";
    
    lbAmount.text = @"  Thành tiền";
    lbAmountValue.text = @"  10.000 đ";
    
    lbPayment.text = @"  Thanh toán";
    lbPaymentValue.text = @"";
    
    lbPaymentMethod.text = @"  Kiểu thanh toán";
    lbPaymentMethodValue.text = @"  Nạp tiền vào tài khoản";
    
    lbDateTime.text = @"  Thời gian";
    lbDateTimeValue.text = @"  03/07/2019, 03:33 am";
}

@end
