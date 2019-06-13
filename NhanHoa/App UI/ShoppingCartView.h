//
//  ShoppingCartView.h
//  NhanHoa
//
//  Created by lam quang quan on 6/13/19.
//  Copyright © 2019 Nhan Hoa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShoppingCartView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnCart;
@property (weak, nonatomic) IBOutlet UILabel *lbCount;

- (void)setupUIForView;
- (IBAction)btnCartPress:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
