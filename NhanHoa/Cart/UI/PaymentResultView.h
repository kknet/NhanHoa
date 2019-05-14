//
//  PaymentResultView.h
//  NhanHoa
//
//  Created by lam quang quan on 5/14/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentResultView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imgResult;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;
- (void)setupUIForView;
@end
