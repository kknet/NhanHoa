//
//  OrderDetailDescriptionView.h
//  NhanHoa
//
//  Created by OS on 8/8/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderDetailDescriptionView : UIView

@property (weak, nonatomic) IBOutlet UIView *viewHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbHeader;

@property (weak, nonatomic) IBOutlet UILabel *lbDomain;
@property (weak, nonatomic) IBOutlet UILabel *lbDomainValue;
@property (weak, nonatomic) IBOutlet UILabel *lbServer;
@property (weak, nonatomic) IBOutlet UILabel *lbServerValue;
@property (weak, nonatomic) IBOutlet UILabel *lbStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lbStartTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbEndTime;
@property (weak, nonatomic) IBOutlet UILabel *lbEndTimeValue;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbStatusValue;

- (void)setupUIForView;

@end

NS_ASSUME_NONNULL_END
