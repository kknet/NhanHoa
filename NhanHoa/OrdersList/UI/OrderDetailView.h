//
//  OrderDetailView.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@property (weak, nonatomic) IBOutlet UILabel *lbOrderDetail;
@property (weak, nonatomic) IBOutlet UILabel *lbOrderDetailValue;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomer;
@property (weak, nonatomic) IBOutlet UILabel *lbCustomerValue;
@property (weak, nonatomic) IBOutlet UILabel *lbContractID;
@property (weak, nonatomic) IBOutlet UILabel *lbContractIDValue;
@property (weak, nonatomic) IBOutlet UILabel *lbInvoiceID;
@property (weak, nonatomic) IBOutlet UILabel *lbInvoiceIDValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDuration;
@property (weak, nonatomic) IBOutlet UILabel *lbDurationValue;
@property (weak, nonatomic) IBOutlet UILabel *lbSetupFee;
@property (weak, nonatomic) IBOutlet UILabel *lbSetupFeeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbRenewdFee;
@property (weak, nonatomic) IBOutlet UILabel *lbRenewedFeeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbVAT;
@property (weak, nonatomic) IBOutlet UILabel *lbFeeVATValue;
@property (weak, nonatomic) IBOutlet UILabel *lbVATSetupFee;
@property (weak, nonatomic) IBOutlet UILabel *lbVATSetupFeeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDiscount;
@property (weak, nonatomic) IBOutlet UILabel *lbDiscountValue;
@property (weak, nonatomic) IBOutlet UILabel *lbAmount;
@property (weak, nonatomic) IBOutlet UILabel *lbAmountValue;
@property (weak, nonatomic) IBOutlet UILabel *lbPayment;
@property (weak, nonatomic) IBOutlet UILabel *lbPaymentValue;
@property (weak, nonatomic) IBOutlet UILabel *lbPaymentMethod;
@property (weak, nonatomic) IBOutlet UILabel *lbPaymentMethodValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTime;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTimeValue;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
