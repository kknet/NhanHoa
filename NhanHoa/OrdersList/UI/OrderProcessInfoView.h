//
//  OrderProcessInfoView.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderProcessInfoView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UILabel *lbPhoneSupport;
@property (weak, nonatomic) IBOutlet UILabel *lbPhoneSupportValue;
@property (weak, nonatomic) IBOutlet UILabel *lbTakeCareBy;
@property (weak, nonatomic) IBOutlet UILabel *lbTakeCareByValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDateReceived;
@property (weak, nonatomic) IBOutlet UILabel *lbDateReceivedValue;
@property (weak, nonatomic) IBOutlet UILabel *lbDateFinish;
@property (weak, nonatomic) IBOutlet UILabel *lbDateFinishValue;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
