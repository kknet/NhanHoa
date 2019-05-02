//
//  PaymentStepView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/2/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ePaymentProfile,
    ePaymentConfirm,
    ePaymentCharge,
    ePaymentDone,
}PaymentStep;

@interface PaymentStepView : UIView

@property (weak, nonatomic) IBOutlet UILabel *lbOne;
@property (weak, nonatomic) IBOutlet UILabel *lbTwo;
@property (weak, nonatomic) IBOutlet UILabel *lbThree;
@property (weak, nonatomic) IBOutlet UILabel *lbFour;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa1;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa2;
@property (weak, nonatomic) IBOutlet UILabel *lbSepa3;
@property (weak, nonatomic) IBOutlet UILabel *lbProfile;
@property (weak, nonatomic) IBOutlet UILabel *lbConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lbPayment;
@property (weak, nonatomic) IBOutlet UILabel *lbDone;

- (void)updateUIForStep: (PaymentStep)step;
- (void)setupUIForView;

@end
